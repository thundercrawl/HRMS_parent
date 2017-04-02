package hrms.service.impl.user.impl;

import hrms.common.CommonParams;
import hrms.common.Constant;
import hrms.common.ErrorCode;
import hrms.entity.*;
import hrms.po.LoginParam;
import hrms.po.RegisterUserInfo;
import hrms.repository.impl.org.OrgInfoRepository;
import hrms.repository.impl.org.OrgManagerInfoRepository;
import hrms.repository.impl.org.OrgMemberInfoRepository;
import hrms.repository.impl.role.RoleInfoRepository;
import hrms.repository.impl.role.UserRoleInfoRepository;
import hrms.repository.impl.sys.SysParamConfigRepository;
import hrms.repository.impl.user.UserInfoRepository;
import hrms.repository.impl.user.UserSensitiveInfoRepository;
import hrms.service.impl.user.UserInfoService;
import hrms.util.*;
import hrms.vo.LoginInfo;
import hrms.vo.MsgVo;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 谢益文 on 2017/3/20.
 */
@Service("userInfoService")
public class UserInfoServiceImpl implements UserInfoService {

    private static final int DEFAULT_SM_ROLE_ID = 1;
    private static final int DEFAULT_HR_ROLE_ID = 2;
    private static final int DEFAULT_WORKER_ROLE_ID = 5;

    @Resource
    private UserInfoRepository userInfoRepository;
    @Resource
    private RoleInfoRepository roleInfoRepository;
    @Resource
    private UserRoleInfoRepository userRoleInfoRepository;
    @Resource
    private OrgInfoRepository orgInfoRepository;
    @Resource
    private OrgManagerInfoRepository orgManagerInfoRepository;
    @Resource
    private OrgMemberInfoRepository orgMemberInfoRepository;
    @Resource
    private SysParamConfigRepository sysParamConfigRepository;
    @Resource
    private UserSensitiveInfoRepository userSensitiveInfoRepository;

    @Override
    public MsgVo save(List<RegisterUserInfo> registerUserInfos, CommonParams commonParams) {
        //操作员编号
        Integer operId = commonParams.getUserId();

        //验证操作员权限
        boolean isSM = false;
        boolean isHR = false;

        int hrRoleId = DEFAULT_HR_ROLE_ID;
        int smRoleId = DEFAULT_SM_ROLE_ID;
        int workerRoleID = DEFAULT_WORKER_ROLE_ID;

        //获取配置的系统管理员和hr的权限编号
        SysParamConfig hrConfig = sysParamConfigRepository.findByID(Constant.ROLE_HR);
        if(hrConfig != null){
            hrRoleId = ParseUtil.parseInt(hrConfig.getParamValue());
        }
        SysParamConfig smConfig = sysParamConfigRepository.findByID(Constant.ROLE_SYSTEM_MANAGER);
        if(smConfig != null){
            smRoleId = ParseUtil.parseInt(smConfig.getParamValue());
        }
        SysParamConfig workerConfig = sysParamConfigRepository.findByID(Constant.ROLE_WORKER);
        if(workerConfig != null){
            workerRoleID = ParseUtil.parseInt(workerConfig.getParamValue());
        }


        List<OrgManagerInfo> orgManagerBatch = new ArrayList<>();
        List<UserInfo> userInfoBatch = new ArrayList<>();

        //查询用户所拥有的权限，进行权限判断
        List<UserRoleInfo> userRoleInfos = userRoleInfoRepository.findUserRole(operId);
        if(userRoleInfos == null){
            return MsgVo.fail(ErrorCode.ONLY_HR);
        }
        for(UserRoleInfo userRoleInfo:userRoleInfos){
              if(hrRoleId == userRoleInfo.getRoleId().intValue()){
                  isHR = true;
              }
              if(smRoleId == userRoleInfo.getRoleId().intValue()){
                  isSM = true;
              }
        }

        if(! (isHR && isSM) ){
            return MsgVo.fail(ErrorCode.ONLY_HR);
        }
        for(RegisterUserInfo registerUserInfo:registerUserInfos){
            //参数校验
            if(registerUserInfo == null ||
                    StringUtils.isEmpty(registerUserInfo.getDataOfBirth()) ||
                    registerUserInfo.getRoleID() == null ||
                    ! Validator.isIDCard(registerUserInfo.getUserCardNumber()) ||
                    ! Validator.isEmail(registerUserInfo.getUserEmail()) ||
                    ! Validator.isUsername(registerUserInfo.getUserName()) ||
                    StringUtils.isEmpty(registerUserInfo.getUserPasswd()) ||
                    ! Validator.isMobile(registerUserInfo.getUserPhone()) ||
                    ! Validator.isAge(registerUserInfo.getUserAge().toString()) ||
                    registerUserInfo.getSex() == null ||
                    (registerUserInfo.getSex() != 2 && registerUserInfo.getSex() != 1) ||
                    registerUserInfo.getWorkStatus() == null ||
                    (registerUserInfo.getWorkStatus() != 0 && registerUserInfo.getWorkStatus() != 1) ||
                    registerUserInfo.getUserStatus() == null ||
                    (registerUserInfo.getUserStatus() != 0 && registerUserInfo.getUserStatus() != 1) ||
                    registerUserInfo.getIsOrgManager() == null ||
                    (registerUserInfo.getIsOrgManager() != 0 && registerUserInfo.getIsOrgManager() != 1) ||
                    ! Validator.isTimeNoSecond(registerUserInfo.getDataOfBirth()) ||
                    ! Validator.isTimeNoSecond(registerUserInfo.getWorkTime())
                    ){
                return MsgVo.error(ErrorCode.PARAMERROR);
            }

            //验证手机号码
            UserInfo byPhone = userInfoRepository.findWorkerByPhone(registerUserInfo.getUserPhone());
            if(byPhone != null){
                return MsgVo.error(ErrorCode.REGISTER_REPEAT);
            }

            UserInfo userInfo = new UserInfo();

            //密码为身份证号后6位
            String userCardNumber = registerUserInfo.getUserCardNumber();
            userInfo.setUserPasswd(Md5Util.md5(userCardNumber.substring(userCardNumber.length()-7)));

            userInfo.setCreateTime(DateUtil.formatDate());
            userInfo.setCreateUserId(operId);

            try {
                CopyEntityUtil.Copy(registerUserInfo,userInfo);
            } catch (Exception e) {
                e.printStackTrace();
                return MsgVo.error(ErrorCode.ENTITY_COPY_ERROR);
            }
            userInfoBatch.add(userInfo);
        }

        List<UserInfo> userInfos = userInfoRepository.batchSave(userInfoBatch);

        //将注册的用户信息按phone为key保存在map中
        Map<String,UserInfo> phoneMap = new HashMap<>();
        for(UserInfo userInfo:userInfos){
            phoneMap.put(userInfo.getUserPhone(),userInfo);
        }

        //注册敏感信息 和 用户头像
        List<UserSensitiveInfo> userSensitiveBatch = new ArrayList<>();
        for(RegisterUserInfo registerUserInfo:registerUserInfos){
            //注册敏感信息
            UserSensitiveInfo userSensitiveInfo = new UserSensitiveInfo();
            userSensitiveInfo.setDataOfBirth(registerUserInfo.getDataOfBirth());
            userSensitiveInfo.setUserCardNumber(registerUserInfo.getUserCardNumber());
            userSensitiveInfo.setUserId(phoneMap.get(registerUserInfo.getUserPhone()).getUserId());
            userSensitiveInfo.setWorkTime(registerUserInfo.getWorkTime());
            userSensitiveBatch.add(userSensitiveInfo);
            //注册用户头像
            String paramId = Constant.DEFAULT_USER_PHOTO_HEAD;
        }
        userSensitiveInfoRepository.batchSave(userSensitiveBatch);

        //注册权限
        List<UserRoleInfo> userRoleBatch = new ArrayList<>();
        for(RegisterUserInfo registerUserInfo:registerUserInfos){
            //验证是否可以授予该权限
            if(! isSM && workerRoleID != registerUserInfo.getRoleID().intValue() ){
                return MsgVo.fail(ErrorCode.REGISTER_PERMISSION_DENIED);
            }
            //验证权限是否存在
            RoleInfo roleInfo = roleInfoRepository.findOne(ParseUtil.parseLong(registerUserInfo.getRoleID()));
            if(roleInfo == null){
                return MsgVo.error(ErrorCode.PERMISSION_NOT_DEFINED);
            }
            UserRoleInfo userRoleInfo = new UserRoleInfo();
            userRoleInfo.setUserId(phoneMap.get(registerUserInfo.getUserPhone()).getUserId());
            userRoleInfo.setCreateUserId(operId);
            userRoleInfo.setStatus(Constant.ROLE_ABLE);
            userRoleInfo.setRoleId(registerUserInfo.getRoleID());
            userRoleBatch.add(userRoleInfo);
        }
        userRoleInfoRepository.batchSave(userRoleBatch);

        //注册经理和部门
        List<OrgMemberInfo> orgMemberBatch = new ArrayList<>();
        for(RegisterUserInfo registerUserInfo:registerUserInfos){
            Integer userID = phoneMap.get(registerUserInfo.getUserPhone()).getUserId();
            if(1 == registerUserInfo.getIsOrgManager().byteValue()){
                //验证是否可以授予经理权限
                Integer managerID = orgManagerInfoRepository.getManager(registerUserInfo.getOrgId());
                if(managerID == null){
                    //部门没有经理，可以设置为经理
                    OrgManagerInfo orgManagerInfo = new OrgManagerInfo();
                    orgManagerInfo.setStatus(Constant.STATUS_ABLE);
                    orgManagerInfo.setUserId(userID);
                    orgManagerInfo.setOrgId(registerUserInfo.getOrgId());
                    orgManagerBatch.add(orgManagerInfo);
                }else{
                    return MsgVo.fail(ErrorCode.REGISTER_ORG_MANAGER_FAIL);
                }
            }
            boolean hasOrg = orgMemberInfoRepository.hasOrg(registerUserInfo.getOrgId());
            if(hasOrg){
                return MsgVo.fail(ErrorCode.REGISTER_ORG_MANAGER_REPEAT);
            }
            OrgMemberInfo orgMemberInfo = new OrgMemberInfo();
            orgMemberInfo.setOrgId(registerUserInfo.getOrgId());
            orgMemberInfo.setUserId(userID);
            orgMemberInfo.setStatus(Constant.STATUS_ABLE);
            orgMemberInfo.setJoinTime(DateUtil.formatDate());
            orgMemberInfo.setJobName(registerUserInfo.getJobName());
            orgMemberInfo.setOperId(operId);
            orgMemberBatch.add(orgMemberInfo);
        }
        orgMemberInfoRepository.batchSave(orgMemberBatch);

        return MsgVo.success(null);
    }

    @Override
    public MsgVo login(LoginParam param) {
        String userPasswd = param.getUserPasswd();
        String userPhone = param.getUserPhone();

        UserInfo userInfo = userInfoRepository.findByPhone(userPhone);

        //安全验证
        if(userInfo == null){
            return MsgVo.error(ErrorCode.USER_EMPTY);
        }
        if(userInfo.getUserStatus() == Constant.STATUS_DISABLE){
            return MsgVo.error(ErrorCode.USER_DISABLE);
        }
        if(userInfo.getWorkStatus() == Constant.STATUS_DISABLE){
            return MsgVo.error(ErrorCode.USER_WORK_DISABLE);
        }
        if(! userInfo.getUserPasswd().equals(Md5Util.md5(userPasswd))){
            return MsgVo.error(ErrorCode.USER_PASSWORD_ERROR);
        }

        //获取登录所需信息
        LoginInfo loginInfo = orgMemberInfoRepository.findByUserID(userInfo.getUserId());
        if(loginInfo != null){
            if(orgManagerInfoRepository.isManager(userInfo.getUserId(),loginInfo.getOrgId())){
                loginInfo.setIsManager((byte) 1);
            }else{
                loginInfo.setIsManager((byte) 0);
            }
        }else{
            loginInfo.setIsManager((byte) 0);
        }

        //信息设置
        try {
            CopyEntityUtil.Copy(userInfo,loginInfo);
        } catch (Exception e) {
            e.printStackTrace();
            return MsgVo.error(ErrorCode.ENTITY_COPY_ERROR);
        }




        return null;
    }
}
