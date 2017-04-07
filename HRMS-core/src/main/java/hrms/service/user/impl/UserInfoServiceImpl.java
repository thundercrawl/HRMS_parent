package hrms.service.user.impl;

import hrms.common.CommonParams;
import hrms.common.Constant;
import hrms.common.ErrorCode;
import hrms.entity.*;
import hrms.model.OrgMemberDetail;
import hrms.po.FindUserParam;
import hrms.po.LoginParam;
import hrms.po.RegisterUserInfo;
import hrms.po.UpdateUserParam;
import hrms.repository.impl.org.OrgInfoRepository;
import hrms.repository.impl.org.OrgManagerInfoRepository;
import hrms.repository.impl.org.OrgMemberInfoRepository;
import hrms.repository.impl.picture.PictureInfoReposity;
import hrms.repository.impl.role.RoleInfoRepository;
import hrms.repository.impl.role.UserRoleInfoRepository;
import hrms.repository.impl.sys.SysParamConfigRepository;
import hrms.repository.impl.user.UserInfoRepository;
import hrms.repository.impl.user.UserSensitiveInfoRepository;
import hrms.service.user.UserInfoService;
import hrms.util.*;
import hrms.vo.LoginInfo;
import hrms.vo.MsgVo;
import hrms.vo.ShowUserVo;
import hrms.vo.UserDetail;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

/**
 * Created by 谢益文 on 2017/3/20.
 */
@Service("userInfoService")
public class UserInfoServiceImpl implements UserInfoService {
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
    @Resource
    private PictureInfoReposity pictureInfoReposity;

    @Override
    public MsgVo save(List<RegisterUserInfo> registerUserInfos, CommonParams commonParams) {
        //操作员编号
        Integer operId = commonParams.getUserId();

        //验证操作员权限
        boolean isSM = false;
        boolean isHR = false;

        List<OrgManagerInfo> orgManagerBatch = new ArrayList<>();
        List<UserInfo> userInfoBatch = new ArrayList<>();

        //查询用户所拥有的权限，进行权限判断
        List<UserRoleInfo> userRoleInfos = userRoleInfoRepository.findUserRole(operId);
        if(userRoleInfos == null){
            return MsgVo.fail(ErrorCode.ONLY_HR);
        }
        for(UserRoleInfo userRoleInfo:userRoleInfos){
              if(Constant.ROLE_HR_VALUE == userRoleInfo.getRoleId().intValue()){
                  isHR = true;
              }
              if(Constant.ROLE_SYSTEM_MANAGER_VALUE == userRoleInfo.getRoleId().intValue()){
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
        List<PictureInfo> userPictureBatch = new ArrayList<>();
        for(RegisterUserInfo registerUserInfo:registerUserInfos){
            Integer userId = phoneMap.get(registerUserInfo.getUserPhone()).getUserId();

            //注册敏感信息
            UserSensitiveInfo userSensitiveInfo = new UserSensitiveInfo();
            Date date = DateUtil.parse(registerUserInfo.getDataOfBirth(), DateUtil.BASE_DATE_FORMAT);
            if(DateUtil.now().before(date)){
                return MsgVo.error(ErrorCode.DATE_ERROR);
            }
            userSensitiveInfo.setDataOfBirth(registerUserInfo.getDataOfBirth());
            userSensitiveInfo.setUserCardNumber(registerUserInfo.getUserCardNumber());
            userSensitiveInfo.setUserId(userId);
            userSensitiveInfo.setWorkTime(registerUserInfo.getWorkTime());
            userSensitiveBatch.add(userSensitiveInfo);

            //注册用户头像
            String paramId = Constant.DEFAULT_USER_PHOTO_HEAD+(int)(Math.random()*8);
            SysParamConfig defaultPhoto = sysParamConfigRepository.findByID(paramId);
            PictureInfo pictureInfo = new PictureInfo();
            pictureInfo.setCreateTime(DateUtil.formatDate());
            pictureInfo.setCreateUserId(operId);
            pictureInfo.setDesc(registerUserInfo.getUserName()+" 默认头像");
            pictureInfo.setPicStatus(Constant.STATUS_ABLE);
            pictureInfo.setPicUrl(defaultPhoto.getParamValue());
            pictureInfo.setRelId(userId);
            pictureInfo.setRelType(Constant.REL_TYPE_USER_PHOTO);
            userPictureBatch.add(pictureInfo);
        }
        userSensitiveInfoRepository.batchSave(userSensitiveBatch);
        pictureInfoReposity.batchSave(userPictureBatch);

        //注册权限
        List<UserRoleInfo> userRoleBatch = new ArrayList<>();
        for(RegisterUserInfo registerUserInfo:registerUserInfos){
            //验证是否可以授予该权限
            if(! isSM && Constant.ROLE_WORKER_VALUE != registerUserInfo.getRoleID().intValue() ){
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

        //更新年龄
        UserSensitiveInfo one = userSensitiveInfoRepository.findOne(ParseUtil.parseLong(userInfo.getUserId()));
        int betweenTwoDate = DateUtil.yearBetweenTwoDate(one.getDataOfBirth(), DateUtil.formatDate());
        if(betweenTwoDate != userInfo.getUserAge()){
            userInfo.setUserAge(betweenTwoDate);
            userInfoRepository.save(userInfo);
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

    @Override
    public MsgVo findUsers(FindUserParam param, CommonParams commonParams) {
        Integer userID = commonParams.getUserId();
        UserInfo oper = userInfoRepository.findOne(ParseUtil.parseLong(userID));

        boolean isOrgManager = false;
        boolean isManager = false;
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
                isManager = true;
            }
        }

        if(!isSM && ! isManager){
            OrgMemberDetail orgDetail = orgMemberInfoRepository.findOrg(oper.getUserId());
            isOrgManager = orgManagerInfoRepository.isManager(oper.getUserId(), orgDetail.getOrgID());
            if(! orgDetail.getOrgID().equals(commonParams.getOrgId())){
                return MsgVo.error(ErrorCode.NO_AUTH);
            }
        }


        //获取数据
        List<UserDetail> userDetails = new ArrayList<>();
        userDetails = userInfoRepository.findUserBaseInfos(param, commonParams.getPage(), commonParams.getPagesize());

        Map<String, ShowUserVo> map = new HashMap<>();
        ShowUserVo voParam = new ShowUserVo();
        voParam.setUserInfos(userDetails);
        //没有结果集
        if(userDetails == null || userDetails.size() < 1){
            map.put("result",voParam);
            return MsgVo.success(map);
        }
        Set<Integer> userIds = new HashSet<>();
        for(UserDetail userDetail:voParam.getUserInfos()){
            userIds.add(userDetail.getUserID());
        }

        //设置权限
        Map<Integer,Integer> userRole = userRoleInfoRepository.findUserRole(userIds);
        if(userRole == null){
            for(UserDetail userDetail:voParam.getUserInfos()){
                userDetail.setRoleId(userRole.get(userDetail.getUserID()));
                if(userDetail.getRoleId().intValue() == Constant.ROLE_SYSTEM_MANAGER_VALUE){
                    userDetail.setHasRole((byte) 0);
                }
                else if(userDetail.getRoleId().intValue() == Constant.ROLE_HR_VALUE){
                    if(isSM ){
                        userDetail.setHasRole((byte) 1);
                    }else{
                        userDetail.setHasRole((byte) 0);
                    }
                }
                else if(userDetail.getRoleId().intValue() == Constant.ROLE_WORKER_VALUE ||
                        userDetail.getRoleId().intValue() == Constant.ROLE_FINANCE_VALUE){
                    if(isManager || isSM){
                        userDetail.setHasRole((byte) 1);
                    }else{
                        userDetail.setHasRole((byte) 0);
                    }
                }else{
                    userDetail.setHasRole((byte) 0);
                }
            }
        }

        map.put("result",voParam);
        return MsgVo.success(map);
    }

    @Override
    public MsgVo findUserDetail(Integer userID, CommonParams commonParams) {
        UserDetail userDetail = new UserDetail();
        if(userID.intValue() == commonParams.getUserId()){
            userDetail.setIsMine((byte) 1);
            userDetail = userInfoRepository.findUserDetail(userID,true);
        }else{
            userDetail.setIsMine((byte) 0);
            userDetail = userInfoRepository.findUserDetail(userID,false);
        }

        Map<String,UserDetail> map = new HashMap<>();
        map.put("result",userDetail);
        return MsgVo.success(map);
    }

    @Override
    public MsgVo updateUser(UpdateUserParam param, CommonParams commonParams) {
        //权限验证
        Integer oper = commonParams.getUserId();
        UserInfo operInfo = userInfoRepository.findOne(ParseUtil.parseLong(oper));
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

        UserInfo userInfo = userInfoRepository.findOne(ParseUtil.parseLong(param.getUserID()));
        if(! StringUtil.isEmpty(param.getUserName())){
            userInfo.setUserName(param.getUserName());
        }
        if(! StringUtil.isEmpty(param.getUserPhone()) &&
                Validator.isMobile(param.getUserPhone())){
            userInfo.setUserPhone(param.getUserPhone());
        }
        if(! StringUtil.isEmpty(param.getUserSex()) &&
                (param.getUserSex() ==1 ||param.getUserSex() ==0 )){
            userInfo.setSex(param.getUserSex());
        }
        if(! StringUtil.isEmpty(param.getUserEmail()) &&
                Validator.isEmail(param.getUserEmail())){
            userInfo.setUserEmail(param.getUserEmail());
        }
        if(! StringUtil.isEmpty(param.getBirthOfDate()) &&
                DateUtil.now().after(DateUtil.parse(param.getBirthOfDate(),DateUtil.BASE_DATE_FORMAT))){
            UserSensitiveInfo userSensitiveInfo = userSensitiveInfoRepository.findOne(ParseUtil.parseLong(param.getUserID()));
            userSensitiveInfo.setDataOfBirth(param.getBirthOfDate());
            userSensitiveInfoRepository.save(userSensitiveInfo);

            //更新年龄
            UserSensitiveInfo one = userSensitiveInfoRepository.findOne(ParseUtil.parseLong(userInfo.getUserId()));
            int betweenTwoDate = DateUtil.yearBetweenTwoDate(one.getDataOfBirth(), DateUtil.formatDate());
            if(betweenTwoDate != userInfo.getUserAge()){
                userInfo.setUserAge(betweenTwoDate);
            }
        }

        userInfoRepository.save(userInfo);

        return MsgVo.success(null);
    }
}
