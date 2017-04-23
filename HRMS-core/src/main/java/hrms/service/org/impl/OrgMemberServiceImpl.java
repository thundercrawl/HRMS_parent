package hrms.service.org.impl;

import hrms.common.CommonParams;
import hrms.common.Constant;
import hrms.common.ErrorCode;
import hrms.entity.OrgInfo;
import hrms.entity.OrgManagerInfo;
import hrms.entity.OrgMemberInfo;
import hrms.entity.UserInfo;
import hrms.po.AddOrg;
import hrms.po.DeleteFromOrg;
import hrms.repository.impl.org.OrgInfoRepository;
import hrms.repository.impl.org.OrgManagerInfoRepository;
import hrms.repository.impl.org.OrgMemberInfoRepository;
import hrms.repository.impl.role.UserRoleInfoRepository;
import hrms.repository.impl.user.UserInfoRepository;
import hrms.service.org.OrgMemberService;
import hrms.util.DateUtil;
import hrms.vo.MsgVo;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by 谢益文 on 2017/4/19.
 */
@Service("orgMemberService")
public class OrgMemberServiceImpl implements OrgMemberService {
    @Resource
    private UserInfoRepository userInfoRepository;
    @Resource
    private UserRoleInfoRepository userRoleInfoRepository;
    @Resource
    private OrgInfoRepository orgInfoRepository;
    @Resource
    private OrgMemberInfoRepository orgMemberInfoRepository;
    @Resource
    private OrgManagerInfoRepository orgManagerInfoRepository;



    @Override
    public MsgVo addOrg(AddOrg param, CommonParams commonParams) {
        Integer operID = commonParams.getUserId();

        UserInfo oper = userInfoRepository.findByUserId(operID);
        if(oper == null){
            return MsgVo.error(ErrorCode.USER_EMPTY);
        }
        if(oper.getUserStatus() == Constant.STATUS_DISABLE){
            return MsgVo.error(ErrorCode.USER_DISABLE);
        }
        /*
        if(oper.getWorkStatus() == Constant.STATUS_DISABLE){
            return MsgVo.error(ErrorCode.USER_WORK_DISABLE);
        }*/
        boolean hrOrSM = userRoleInfoRepository.isHROrSM(operID);
        if(! hrOrSM){
            return MsgVo.error(ErrorCode.ONLY_HR);
        }

        Integer orgID = param.getOrgID();
        Integer userID = param.getUserID();

        OrgInfo orgInfo = orgInfoRepository.findById(orgID);
        if(orgInfo == null){
            return MsgVo.error(ErrorCode.ORG_EMPTY);
        }
        if(orgInfo.getOrgStatus() == Constant.STATUS_DISABLE){
            return MsgVo.error(ErrorCode.ORG_DELETE);
        }

        UserInfo userInfo = userInfoRepository.findByUserId(userID);
        if(userInfo == null){
            return MsgVo.error(ErrorCode.USER_EMPTY);
        }


        boolean hasOrg = orgMemberInfoRepository.hasOrg(userID);
        if(hasOrg){
            return MsgVo.error(ErrorCode.REGISTER_ORG_MANAGER_REPEAT);
        }

        if(param.getIsManager().byteValue() == 1){
            Integer managerID = orgManagerInfoRepository.getManager(orgID);
            if(managerID == null){
                OrgManagerInfo orgManagerInfo  = new OrgManagerInfo();
                orgManagerInfo.setOrgId(orgID);
                orgManagerInfo.setUserId(userID);
                orgManagerInfo.setStatus(Constant.STATUS_ABLE);

                orgManagerInfoRepository.save(orgManagerInfo);
            }else{
                return MsgVo.error(ErrorCode.REGISTER_ORG_MANAGER_FAIL);
            }

        }

        OrgMemberInfo orgMemberInfo = new OrgMemberInfo();
        orgMemberInfo.setOperId(operID);
        orgMemberInfo.setJobName(param.getJobName());
        orgMemberInfo.setJoinTime(DateUtil.formatDate());
        orgMemberInfo.setStatus(Constant.STATUS_ABLE);
        orgMemberInfo.setOrgId(orgID);
        orgMemberInfo.setUserId(userID);

        orgMemberInfoRepository.save(orgMemberInfo);

        return MsgVo.success(null);
    }

    @Override
    public MsgVo deleteFromOrg(DeleteFromOrg param, CommonParams commonParams) {
        Integer operID = commonParams.getUserId();

        Integer orgID = param.getOrgID();
        Integer userID = param.getUserID();

        UserInfo oper = userInfoRepository.findByUserId(operID);
        if(oper == null){
            return MsgVo.error(ErrorCode.USER_EMPTY);
        }
        if(oper.getUserStatus() == Constant.STATUS_DISABLE){
            return MsgVo.error(ErrorCode.USER_DISABLE);
        }
        if(! userRoleInfoRepository.isHROrSM(operID)){
            return MsgVo.error(ErrorCode.ONLY_HR);
        }

        OrgInfo orgInfo = orgInfoRepository.findById(orgID);
        if(orgInfo == null){
            return MsgVo.error(ErrorCode.ORG_EMPTY);
        }
        if(orgInfo.getOrgStatus() == Constant.STATUS_DISABLE){
            return MsgVo.error(ErrorCode.ORG_DELETE);
        }

        UserInfo userInfo = userInfoRepository.findByUserId(userID);
        if(userInfo == null){
            return MsgVo.error(ErrorCode.USER_EMPTY);
        }

        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(OrgMemberInfo.class);
        detachedCriteria.add(Restrictions.eq("userId",userID))
                .add(Restrictions.eq("orgId",orgID))
                .add(Restrictions.eq("status",Constant.STATUS_ABLE));

        OrgMemberInfo orgMemberInfo = orgMemberInfoRepository.findOne(detachedCriteria);
        if(orgMemberInfo == null || orgMemberInfo.getStatus() == Constant.STATUS_DISABLE){
            return MsgVo.error(ErrorCode.ORG_MEMBER_EMPTY);
        }

        orgMemberInfo.setStatus(Constant.STATUS_DISABLE);

        orgMemberInfoRepository.save(orgMemberInfo);

        return MsgVo.success(null);
    }

}
