package hrms.service.sign.impl;

import hrms.common.CommonParams;
import hrms.common.Constant;
import hrms.common.ErrorCode;
import hrms.entity.SignInfo;
import hrms.entity.UserInfo;
import hrms.po.FindSignParam;
import hrms.po.FindUserParam;
import hrms.po.SaveSignInfo;
import hrms.po.SaveSignParam;
import hrms.repository.impl.role.UserRoleInfoRepository;
import hrms.repository.impl.sign.SignInfoRepository;
import hrms.repository.impl.user.UserInfoRepository;
import hrms.service.sign.SignInfoService;
import hrms.util.DateUtil;
import hrms.util.EnumerateUtil;
import hrms.util.StringUtil;
import hrms.util.Validator;
import hrms.vo.FindSignsVo;
import hrms.vo.MsgVo;
import hrms.vo.SignInfoDetail;
import hrms.vo.UserDetail;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created by 谢益文 on 2017/5/2.
 */
@Service("signInfoService")
public class SignInfoServiceImpl implements SignInfoService {

    @Resource
    private UserInfoRepository userInfoRepository;
    @Resource
    private UserRoleInfoRepository userRoleInfoRepository;
    @Resource
    private SignInfoRepository signInfoRepository;

    @Override
    public MsgVo batchSave(SaveSignParam param, CommonParams commonParams) {
        //权限验证
        Integer oper = commonParams.getUserId();
        UserInfo operInfo = userInfoRepository.findByUserId(oper);
        if(operInfo == null || operInfo.getUserStatus() == Constant.STATUS_DISABLE){
            return MsgVo.fail(ErrorCode.USER_EMPTY);
        }
        if(operInfo.getWorkStatus() == Constant.STATUS_DISABLE){
            return MsgVo.fail(ErrorCode.USER_WORK_DISABLE);
        }
        boolean hrOrSM = userRoleInfoRepository.isHROrSM(oper);
        if(! hrOrSM){
            return MsgVo.fail(ErrorCode.ROLE_ERROR);
        }


        List<SaveSignInfo> signInfos = param.getSignInfos();


        Set<String> userPhones = new HashSet<>();

        for(SaveSignInfo saveSignInfo:signInfos){
            if(StringUtil.isEmpty(saveSignInfo.getSignInTime()) ||
                    ! Validator.isTime(saveSignInfo.getSignInTime()) ||
                    StringUtil.isEmpty(saveSignInfo.getSignOutTime()) ||
                    ! Validator.isTime(saveSignInfo.getSignOutTime()) ||
                    ! Validator.isMobile(saveSignInfo.getUserPhone())){
                return MsgVo.error(ErrorCode.PARAMERROR);
            }
            userPhones.add(saveSignInfo.getUserPhone());
        }
        if(userPhones == null || userPhones.size() < 1){
            return MsgVo.error(ErrorCode.PHONE_EMPTY);
        }

        Map<String, UserInfo> byPhones = userInfoRepository.findByPhones(userPhones);
        if(byPhones == null || byPhones.size() != userPhones.size()){
            return MsgVo.error(ErrorCode.USER_PART_ERROR);
        }

        List<SignInfo> batchList = new ArrayList<>();
        for(SaveSignInfo saveSignInfo:signInfos){
            SignInfo signInfo = new SignInfo();
            signInfo.setUserId(byPhones.get(saveSignInfo.getUserPhone()).getUserId());
            signInfo.setCreateTime(DateUtil.formatDate());
            signInfo.setCreateUserId(oper);
            if(saveSignInfo.getSignInStatus() != null && ! StringUtil.isEmpty(saveSignInfo.getSignInTime())){
                signInfo.setSignTime(saveSignInfo.getSignInTime());
                signInfo.setSignType(Constant.SING_TYPE_IN);

                if(saveSignInfo.getSignInStatus().byteValue() == Constant.SIGN_STATUS_NORMAL){
                    signInfo.setSignStatus(Constant.SIGN_STATUS_NORMAL);
                }
                else if(saveSignInfo.getSignInStatus().byteValue() == Constant.SIGN_STATUS_LATER){
                    signInfo.setSignStatus(Constant.SIGN_STATUS_LATER);
                }else{
                    return MsgVo.error(ErrorCode.PARAM_TYPE_ERROR);
                }

                if(! signInfoRepository.isRepeatSign(signInfo.getUserId(),DateUtil.formatDate(DateUtil.SHORT_FORMAT,DateUtil.now()),signInfo.getSignType())){
                    batchList.add(signInfo);
                }else{
                    return MsgVo.error(ErrorCode.SIGN_REPEAT);
                }
            }
            signInfo = new SignInfo();
            signInfo.setUserId(byPhones.get(saveSignInfo.getUserPhone()).getUserId());
            signInfo.setCreateTime(DateUtil.formatDate());
            signInfo.setCreateUserId(oper);
            if(saveSignInfo.getSignOutStatus() != null && ! StringUtil.isEmpty(saveSignInfo.getSignOutTime())){
                signInfo.setSignTime(saveSignInfo.getSignOutTime());
                signInfo.setSignType(Constant.SING_TYPE_OUT);

                if(saveSignInfo.getSignOutStatus().byteValue() == Constant.SIGN_STATUS_NORMAL){
                    signInfo.setSignStatus(Constant.SIGN_STATUS_NORMAL);
                }
                else if(saveSignInfo.getSignOutStatus().byteValue() == Constant.SIGN_STATUS_EARLY){
                    signInfo.setSignStatus(Constant.SIGN_STATUS_EARLY);
                }else{
                    return MsgVo.error(ErrorCode.PARAM_TYPE_ERROR);
                }

                if(! signInfoRepository.isRepeatSign(signInfo.getUserId(),DateUtil.formatDate(DateUtil.SHORT_FORMAT,DateUtil.now()),signInfo.getSignType())){
                    batchList.add(signInfo);
                }else{
                    return MsgVo.error(ErrorCode.SIGN_REPEAT);
                }
            }

        }

        signInfoRepository.batchSave(batchList);

        return MsgVo.success(null);
    }

    @Override
    public MsgVo findSigns(FindSignParam param, CommonParams commonParams) {
        if(param == null){
            param = new FindSignParam();
        }
        if(StringUtil.isEmpty(param.getStartTime()) ){
            param.setStartTime(DateUtil.formatDate(DateUtil.startOfDay(DateUtil.now())));
        }
        if(StringUtil.isEmpty(param.getEndTime()) ){
            param.setEndTime(DateUtil.formatDate(DateUtil.endOfDay(DateUtil.now())));
        }

        Map result = new HashMap();

        FindUserParam findUserParam = new FindUserParam();
        Set<Integer> userIds = userInfoRepository.findUsers(param);
        if(userIds == null ){
            return MsgVo.fail(ErrorCode.RESULT_EMPTY);
        }

        Map<Integer,UserDetail> userDetailMap = new HashMap<>();

        Set<Integer> allUserIds = new HashSet<>();
        allUserIds.addAll(userIds);

        List<SignInfo> signs = signInfoRepository.findSigns(userIds, param,commonParams.getPage(),commonParams.getPagesize());
        for(SignInfo signInfo:signs){
            allUserIds.add(signInfo.getCreateUserId());
        }

        List<UserInfo> byUserIds = userInfoRepository.findByUserIds(allUserIds);
        Map<Integer,UserInfo> userMap = new HashMap<>();
        for(UserInfo userInfo:byUserIds){
            userMap.put(userInfo.getUserId(),userInfo);
        }

        List<SignInfoDetail> signInfoDetails = new ArrayList<>();
        for(SignInfo signInfo:signs){
            SignInfoDetail detail = new SignInfoDetail();
            detail.setSignTime(signInfo.getSignTime());
            detail.setSignType(EnumerateUtil.translator("sign_info-SIGN_TYPE-"+ signInfo.getSignType()));
            detail.setSignStatus(EnumerateUtil.translator("sign_info-SIGN_STATUS-"+signInfo.getSignStatus()));
            detail.setUserName(userMap.get(signInfo.getUserId()).getUserName());
            detail.setCreateUserName(userMap.get(signInfo.getCreateUserId()).getUserName());
            signInfoDetails.add(detail);
        }
        FindSignsVo vo = new FindSignsVo();
        vo.setSignInfoDetails(signInfoDetails);

        result.put("result",vo);
        result.put("count",signInfoRepository.countFindSigns(userIds, param));

        return MsgVo.success(result);
    }
}
