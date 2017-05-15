package hrms.service.org.impl;

import hrms.common.CommonParams;
import hrms.common.Constant;
import hrms.common.ErrorCode;
import hrms.entity.OrgInfo;
import hrms.entity.OrgManagerInfo;
import hrms.entity.OrgMemberInfo;
import hrms.entity.UserInfo;
import hrms.entity.UserRoleInfo;
import hrms.model.OrgBaseInfo;
import hrms.model.OrgMemberDetail;
import hrms.po.AddOrgMember;
import hrms.po.FindOrgParam;
import hrms.po.SaveOrgParam;
import hrms.po.UpdateOrgParam;
import hrms.repository.impl.org.OrgInfoRepository;
import hrms.repository.impl.org.OrgManagerInfoRepository;
import hrms.repository.impl.org.OrgMemberInfoRepository;
import hrms.repository.impl.role.UserRoleInfoRepository;
import hrms.repository.impl.user.UserInfoRepository;
import hrms.service.org.OrgInfoService;
import hrms.util.DateUtil;
import hrms.util.StringUtil;
import hrms.vo.FindOrgVo;
import hrms.vo.MsgVo;
import hrms.vo.OrgInfoVo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 谢益文 on 2017/4/5.
 */
@Service("orgInfoService")
public class OrgInfoServiceImpl implements OrgInfoService {

    @Resource
    private OrgInfoRepository orgInfoRepository;
    @Resource
    private UserInfoRepository userInfoRepository;
    @Resource
    private UserRoleInfoRepository userRoleInfoRepository;
    @Resource
    private OrgManagerInfoRepository orgManagerInfoRepository;
    @Resource
    private OrgMemberInfoRepository orgMemberInfoRepository;

    @Override
    public MsgVo findAllOrg(FindOrgParam param,CommonParams commonParams) {

        Integer userID = commonParams.getUserId();
        UserInfo oper = userInfoRepository.findByUserId(userID);

        boolean isOrgManager = false;
        boolean isHR = false;
        boolean isSM = false;

        if(oper == null){
            return MsgVo.fail(ErrorCode.USER_EMPTY);
        }

        List<UserRoleInfo> userRoles = userRoleInfoRepository.findUserRole(userID);

        for(UserRoleInfo userRole:userRoles){
            if(userRole.getRoleId() == Constant.ROLE_SYSTEM_MANAGER_VALUE ){
                isSM = true;
                break;
            }
            if(userRole.getRoleId() == Constant.ROLE_HR_VALUE){
                isHR = true;
            }
        }

        if(!isSM && ! isHR){
            OrgMemberDetail orgDetail = orgMemberInfoRepository.findOrg(oper.getUserId());
            isOrgManager = orgManagerInfoRepository.isManager(oper.getUserId(), orgDetail.getOrgID());
        }


        Map<String,Object> map = new HashMap<>();
        List<OrgInfoVo> orgInfos = orgInfoRepository.findAllByChose(param,commonParams.getPage(),commonParams.getPagesize());

        boolean hrOrSM = userRoleInfoRepository.isHROrSM(userID);

        //设置权限
        if(hrOrSM){
            for(OrgInfoVo orgInfoVo:orgInfos){
                orgInfoVo.setHasRole((byte) 1);
            }
        }


        map.put("count",orgInfoRepository.countAllByChose(param));

        List<OrgBaseInfo> allOrg = orgInfoRepository.findBaseAllOrg();

        FindOrgVo vo = new FindOrgVo();
        vo.setOrgTables(orgInfos);
        vo.setOrgInfos(allOrg);

        map.put("result",vo);

        return MsgVo.success(map);
    }

    @Override
    public MsgVo save(SaveOrgParam orgParam, CommonParams commonParams) {

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
        OrgInfo orgByName = orgInfoRepository.findOrgByName(orgParam.getOrgName());
        if(orgByName != null){
            return MsgVo.fail(ErrorCode.NAME_REPEAT);
        }
        if(orgParam.getParentOrgId().intValue() != 0){
            OrgInfo parentOrg = orgInfoRepository.findById(orgParam.getParentOrgId());
            if(parentOrg == null || parentOrg.getOrgStatus() == Constant.STATUS_DISABLE){
                return MsgVo.fail(ErrorCode.PARENT_ORG_EMPTY);
            }
        }

        OrgInfo orgInfo = new OrgInfo();
        orgInfo.setOrgName(orgParam.getOrgName());
        orgInfo.setParentOrgId(orgParam.getParentOrgId());
        orgInfo.setDesc(orgParam.getDesc());
        orgInfo.setCreateUserId(oper);
        orgInfo.setCreateTime(DateUtil.formatDate());
        orgInfo.setOrgStatus(Constant.STATUS_ABLE);

        orgInfoRepository.save(orgInfo);

        return MsgVo.success(null);
    }

    @Override
    public MsgVo update(UpdateOrgParam orgParam, CommonParams commonParams) {
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

        OrgInfo orgInfo = orgInfoRepository.findById(orgParam.getOrgId());
        if(orgInfo == null || orgInfo.getOrgStatus() == Constant.STATUS_DISABLE){
            return MsgVo.fail(ErrorCode.PARENT_ORG_EMPTY);
        }

        if(! StringUtil.isEmpty(orgParam.getOrgName()) && orgParam.getOrgName().equals(orgInfo.getOrgName())){
            OrgInfo orgByName = orgInfoRepository.findOrgByName(orgParam.getOrgName());
            if(orgByName != null){
                return MsgVo.fail(ErrorCode.NAME_REPEAT);
            }
        }

        if(orgParam.getParentOrgId() != null && orgParam.getParentOrgId().intValue() == orgInfo.getOrgId().intValue()){
            return MsgVo.fail(ErrorCode.PARENT_ORG_ERROR);
        }
        if(orgParam.getParentOrgId() != null && orgParam.getParentOrgId().intValue() == 0){
            return MsgVo.fail(ErrorCode.PARENT_ORG_NOT_TOP);
        }

        if(orgParam.getParentOrgId() != null){
            orgInfo.setParentOrgId(orgParam.getParentOrgId());
        }
        orgInfo.setOrgName(orgParam.getOrgName());
        orgInfo.setDesc(orgParam.getDesc());
        orgInfo.setCreateUserId(oper);
        orgInfo.setCreateTime(DateUtil.formatDate());

        orgInfoRepository.save(orgInfo);

        return MsgVo.success(null);
    }

    @Override
    public MsgVo listOrg() {
        List<OrgBaseInfo> allOrg = orgInfoRepository.findBaseAllOrg();
        Map map = new HashMap();
        map.put("result",allOrg);
        return MsgVo.success(map);
    }

    @Override
    public MsgVo addMember(AddOrgMember param, CommonParams commonParams) {

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

        OrgInfo orgInfo = orgInfoRepository.findById(param.getOrgId());
        if(orgInfo == null || orgInfo.getOrgStatus().byteValue() == Constant.STATUS_DISABLE){
            return MsgVo.error(ErrorCode.ORG_EMPTY);
        }
        if(orgMemberInfoRepository.hasOrg(param.getUserId())){
            return MsgVo.error(ErrorCode.REGISTER_ORG_MANAGER_REPEAT);
        }
        if("1".equals(param.getIsManager())){
            Integer manager = orgManagerInfoRepository.getManager(param.getOrgId());
            if(manager != null){
                return MsgVo.error(ErrorCode.REGISTER_ORG_MANAGER_FAIL);
            }
            OrgManagerInfo orgManagerInfo = new OrgManagerInfo();
            orgManagerInfo.setStatus(Constant.STATUS_ABLE);
            orgManagerInfo.setUserId(param.getUserId());
            orgManagerInfo.setOrgId(param.getOrgId());
            orgManagerInfoRepository.save(orgManagerInfo);
        }
        OrgMemberInfo orgMemberInfo = new OrgMemberInfo();
        orgMemberInfo.setOrgId(param.getOrgId());
        orgMemberInfo.setStatus(Constant.STATUS_ABLE);
        orgMemberInfo.setUserId(param.getUserId());
        orgMemberInfo.setJoinTime(DateUtil.formatDate());
        orgMemberInfo.setJobName(param.getJobName().trim());
        orgMemberInfo.setOperId(oper);

        orgMemberInfoRepository.save(orgMemberInfo);
        return MsgVo.success(null);
    }

    @Override
    public MsgVo deleteOrg(Integer orgId, CommonParams commonParams) {
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

        OrgInfo orgInfo = orgInfoRepository.findById(orgId);
        if(orgInfo == null || orgInfo.getOrgStatus().byteValue() == Constant.STATUS_DISABLE){
            return MsgVo.error(ErrorCode.ORG_EMPTY);
        }
        orgInfo.setOrgStatus(Constant.STATUS_DISABLE);

        List<OrgMemberInfo> orgMembers = orgMemberInfoRepository.findOrgMembers(orgId);
        if(orgMembers != null){
            List<OrgMemberInfo> batch = new ArrayList<>();
            for(OrgMemberInfo orgMemberInfo:orgMembers){
                orgMemberInfo.setStatus(Constant.STATUS_DISABLE);
                batch.add(orgMemberInfo);
            }
            orgMemberInfoRepository.batchSave(batch);
        }

        OrgManagerInfo orgManager = orgManagerInfoRepository.getOrgManager(orgId);
        if(orgManager != null){
            orgManager.setStatus(Constant.STATUS_DISABLE);
            orgManagerInfoRepository.save(orgManager);
        }

        orgInfoRepository.save(orgInfo);

        return MsgVo.success(null);
    }

}
