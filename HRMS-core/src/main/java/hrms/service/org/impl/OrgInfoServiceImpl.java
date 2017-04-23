package hrms.service.org.impl;

import hrms.common.CommonParams;
import hrms.common.Constant;
import hrms.common.ErrorCode;
import hrms.entity.OrgInfo;
import hrms.entity.UserInfo;
import hrms.po.SaveOrgParam;
import hrms.po.UpdateOrgParam;
import hrms.repository.impl.org.OrgInfoRepository;
import hrms.repository.impl.role.UserRoleInfoRepository;
import hrms.repository.impl.user.UserInfoRepository;
import hrms.service.org.OrgInfoService;
import hrms.util.DateUtil;
import hrms.util.StringUtil;
import hrms.vo.MsgVo;
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


    @Override
    public MsgVo findAllOrg(String orgName) {

        Map<String,List<OrgInfo>> map = new HashMap<>();
        List<OrgInfo> orgInfos = new ArrayList<>();

        if(StringUtil.isEmpty(orgName)){
            orgInfos = orgInfoRepository.findAllOrg();
        }else {
            orgInfos = orgInfoRepository.findAllByName(orgName);
        }
        if(orgInfos == null || orgInfos.size() < 1){
            return MsgVo.fail(ErrorCode.RESULT_EMPTY);
        }
        map.put("result",orgInfos);
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
            return MsgVo.fail(ErrorCode.TOKEN_TIMEOUT);
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
            return MsgVo.fail(ErrorCode.TOKEN_TIMEOUT);
        }
        boolean hrOrSM = userRoleInfoRepository.isHROrSM(oper);
        if(! hrOrSM){
            return MsgVo.fail(ErrorCode.ROLE_ERROR);
        }

        OrgInfo orgInfo = orgInfoRepository.findById(orgParam.getOrgId());
        if(orgInfo == null || orgInfo.getOrgStatus() == Constant.STATUS_DISABLE){
            return MsgVo.fail(ErrorCode.PARENT_ORG_EMPTY);
        }
        OrgInfo orgByName = orgInfoRepository.findOrgByName(orgParam.getOrgName());
        if(orgByName != null){
            return MsgVo.fail(ErrorCode.NAME_REPEAT);
        }
        orgInfo.setOrgName(orgParam.getOrgName());
        orgInfo.setDesc(orgParam.getDesc());
        orgInfo.setCreateUserId(oper);
        orgInfo.setCreateTime(DateUtil.formatDate());

        orgInfoRepository.save(orgInfo);

        return MsgVo.success(null);
    }

}
