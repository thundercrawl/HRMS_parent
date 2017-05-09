package hrms.service.wage.impl;

import hrms.common.CommonParams;
import hrms.common.Constant;
import hrms.common.ErrorCode;
import hrms.entity.UserInfo;
import hrms.entity.UserWageInfo;
import hrms.po.FindAllWageParam;
import hrms.po.SaveWageInfo;
import hrms.po.SaveWageParam;
import hrms.po.UpdateUserWageParam;
import hrms.repository.impl.role.UserRoleInfoRepository;
import hrms.repository.impl.user.UserInfoRepository;
import hrms.repository.impl.wage.UserWageInfoRepository;
import hrms.service.wage.UserWageService;
import hrms.util.DateUtil;
import hrms.util.ParseUtil;
import hrms.util.StringUtil;
import hrms.util.Validator;
import hrms.vo.FindAllWageVo;
import hrms.vo.MsgVo;
import hrms.vo.WageDetail;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 谢益文 on 2017/5/5.
 */
@Service("userWageService")
public class UserWageServiceImpl implements UserWageService {

    @Resource
    private UserInfoRepository userInfoRepository;
    @Resource
    private UserRoleInfoRepository userRoleInfoRepository;
    @Resource
    private UserWageInfoRepository userWageInfoRepository;

    @Override
    public MsgVo batchSave(SaveWageParam param, CommonParams commonParams) {

        Integer operId = commonParams.getUserId();
        UserInfo oper = userInfoRepository.findByUserId(operId);
        if(oper == null || oper.getUserStatus().byteValue() == Constant.STATUS_DISABLE){
            return MsgVo.error(ErrorCode.USER_EMPTY);
        }
        if(oper.getWorkStatus().byteValue() ==Constant.STATUS_DISABLE){
            return MsgVo.error(ErrorCode.USER_WORK_DISABLE);
        }
        boolean financeOrSM = userRoleInfoRepository.isFinanceOrSM(operId);
        if(! financeOrSM){
            return MsgVo.error(ErrorCode.ONLY_FINANCE);
        }

        List<UserWageInfo> batchList = new ArrayList<>();
        List<SaveWageInfo> wageInfos = param.getWageInfos();
       /* Set<String> userPhones = new HashSet<>();
        for(SaveWageInfo wageInfo:wageInfos){
            if(!Validator.isMobile(wageInfo.getUserPhone())){

            }
            userPhones.add(wageInfo.getUserPhone());
        }
        if(userPhones.size() != wageInfos.size()){
            return MsgVo.error(ErrorCode.WAGE_ONLY_ONE);
        }

        List<UserInfo> byUserIds = userInfoRepository.findNormalByPhones(userPhones);
        if(byUserIds == null || byUserIds.size() != userPhones.size()){
            return MsgVo.error(ErrorCode.USER_NOT_ENOUGH);
        }
        Map<String,UserInfo> phoneMap = new HashMap<>();
        for(UserInfo userInfo:byUserIds){
            phoneMap.put(userInfo.getUserPhone(),userInfo);
        }*/

        for(SaveWageInfo wageInfo:wageInfos){
            UserInfo userInfo = null;
            if(wageInfo.getUserId() == null && ( !Validator.isMobile(wageInfo.getUserPhone()))){
                return MsgVo.error(ErrorCode.NONE);
            }
            if(wageInfo.getUserId()== null){
                userInfo = userInfoRepository.findByPhone(wageInfo.getUserPhone());
                if(userInfo == null || userInfo.getUserStatus().byteValue() == Constant.STATUS_DISABLE ){
                    return MsgVo.error(ErrorCode.USER_EMPTY);
                }
            }else{
                userInfo = userInfoRepository.findByUserId(wageInfo.getUserId());
                if(userInfo == null || userInfo.getUserStatus().byteValue() == Constant.STATUS_DISABLE ){
                    return MsgVo.error(ErrorCode.USER_EMPTY);
                }
            }

            UserWageInfo userWageInfo = new UserWageInfo();
            userWageInfo.setCreateTime(DateUtil.formatDate());
            userWageInfo.setCreateUserId(operId);

            userWageInfo.setUserId(userInfo.getUserId());
            userWageInfo.setBaseWage(wageInfo.getBaseWage());

            BigDecimal subsidyIns = wageInfo.getBaseWage().multiply(
                    ParseUtil.parseBigDecimal(Constant.INS_OLD+Constant.INS_UNWORK+Constant.INS_MEDICAL+
                    Constant.INS_MATERNITY+Constant.INS_INJURY+Constant.INS_HOUSE) );
            subsidyIns.setScale(2,BigDecimal.ROUND_UP);

            userWageInfo.setSubsidyIns(subsidyIns);
            userWageInfo.setSubsidyOther(wageInfo.getSubsidyOther());
            userWageInfo.setSubsidyOtherDesc(wageInfo.getSubsidyOtherDesc());
            userWageInfo.setSubsidyPhone(wageInfo.getSubsidyPhone());

            batchList.add(userWageInfo);
        }

        userWageInfoRepository.batchSave(batchList);

        return MsgVo.success(null);
    }

    @Override
    public MsgVo findAllWages(FindAllWageParam param, CommonParams commonParams) {

        //权限验证
        Integer operId = commonParams.getUserId();
        UserInfo oper = userInfoRepository.findByUserId(operId);
        if(oper == null || oper.getUserStatus().byteValue() == Constant.STATUS_DISABLE){
            return MsgVo.error(ErrorCode.USER_EMPTY);
        }
        if(oper.getWorkStatus().byteValue() ==Constant.STATUS_DISABLE){
            return MsgVo.error(ErrorCode.USER_WORK_DISABLE);
        }
        boolean financeOrSM = userRoleInfoRepository.isFinanceOrSM(operId);
        if(! financeOrSM){
            return MsgVo.error(ErrorCode.ONLY_FINANCE);
        }


        FindAllWageVo vo =new FindAllWageVo();

        List<WageDetail> allWage = userWageInfoRepository.findAllWage(param, commonParams.getPage(), commonParams.getPagesize());


        vo.setWageDetails(allWage);
        vo.setCount(userWageInfoRepository.countAllWage(param));
        Map map = new HashMap();
        map.put("result",vo);

        return MsgVo.success(map);
    }

    @Override
    public MsgVo findWageDetail(Integer userId, Byte isFinance, CommonParams commonParams) {
        if(isFinance.byteValue() == 0){
            //是会员自己操作
            userId = commonParams.getUserId();
        }else{
            //权限验证
            Integer operId = commonParams.getUserId();
            UserInfo oper = userInfoRepository.findByUserId(operId);
            if(oper == null || oper.getUserStatus().byteValue() == Constant.STATUS_DISABLE){
                return MsgVo.error(ErrorCode.USER_EMPTY);
            }
            if(oper.getWorkStatus().byteValue() ==Constant.STATUS_DISABLE){
                return MsgVo.error(ErrorCode.USER_WORK_DISABLE);
            }
            boolean financeOrSM = userRoleInfoRepository.isFinanceOrSM(operId);
            if(! financeOrSM){
                return MsgVo.error(ErrorCode.ONLY_FINANCE);
            }
        }

        //查询userId的会员的工资单详情
        WageDetail userWage = userWageInfoRepository.findUserWage(userId);
        Map map = new HashMap();
        map.put("result",userWage);

        return MsgVo.success(map);
    }

    @Override
    public MsgVo updateUserWage(UpdateUserWageParam param, CommonParams commonParams) {

        Integer operId = commonParams.getUserId();
        UserInfo oper = userInfoRepository.findByUserId(operId);
        if(oper == null || oper.getUserStatus().byteValue() == Constant.STATUS_DISABLE){
            return MsgVo.error(ErrorCode.USER_EMPTY);
        }
        if(oper.getWorkStatus().byteValue() ==Constant.STATUS_DISABLE){
            return MsgVo.error(ErrorCode.USER_WORK_DISABLE);
        }
        boolean financeOrSM = userRoleInfoRepository.isFinanceOrSM(operId);
        if(! financeOrSM){
            return MsgVo.error(ErrorCode.ONLY_FINANCE);
        }

        UserWageInfo wageInfo = userWageInfoRepository.findById(param.getWageId());
        wageInfo.setSubsidyPhone(param.getSubsidyPhone());
        if(StringUtil.isEmpty(param.getSubsidyOtherDesc())){
            wageInfo.setSubsidyOtherDesc("");
        }else {
            wageInfo.setSubsidyOtherDesc(param.getSubsidyOtherDesc());
        }
        wageInfo.setBaseWage(param.getBaseWage());
        wageInfo.setSubsidyOther(param.getSubsidyOther());

        BigDecimal subsidyIns = wageInfo.getBaseWage().multiply(
                ParseUtil.parseBigDecimal(Constant.INS_OLD+Constant.INS_UNWORK+Constant.INS_MEDICAL+
                        Constant.INS_MATERNITY+Constant.INS_INJURY+Constant.INS_HOUSE) );
        subsidyIns.setScale(2,BigDecimal.ROUND_UP);

        wageInfo.setSubsidyIns(subsidyIns);

        userWageInfoRepository.save(wageInfo);

        return MsgVo.success(null);
    }


}
