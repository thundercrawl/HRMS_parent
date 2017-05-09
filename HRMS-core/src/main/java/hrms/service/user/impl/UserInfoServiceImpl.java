package hrms.service.user.impl;

import hrms.common.CommonParams;
import hrms.common.Constant;
import hrms.common.ErrorCode;
import hrms.entity.OrgInfo;
import hrms.entity.OrgManagerInfo;
import hrms.entity.OrgMemberInfo;
import hrms.entity.PictureInfo;
import hrms.entity.RoleInfo;
import hrms.entity.SysParamConfig;
import hrms.entity.UserInfo;
import hrms.entity.UserRoleInfo;
import hrms.entity.UserSensitiveInfo;
import hrms.model.OrgBaseInfo;
import hrms.model.OrgMemberDetail;
import hrms.model.RoleBaseInfo;
import hrms.model.UserBaseInfo;
import hrms.po.ChangeUserStatusParam;
import hrms.po.FindUserParam;
import hrms.po.LoginParam;
import hrms.po.RegisterUserInfo;
import hrms.po.UpdateUserParam;
import hrms.po.UpdateUserPwd;
import hrms.po.UploadUserPhoto;
import hrms.repository.impl.org.OrgInfoRepository;
import hrms.repository.impl.org.OrgManagerInfoRepository;
import hrms.repository.impl.org.OrgMemberInfoRepository;
import hrms.repository.impl.picture.PictureInfoRepository;
import hrms.repository.impl.role.RoleInfoRepository;
import hrms.repository.impl.role.UserRoleInfoRepository;
import hrms.repository.impl.sys.SysParamConfigRepository;
import hrms.repository.impl.user.UserInfoRepository;
import hrms.repository.impl.user.UserSensitiveInfoRepository;
import hrms.service.user.UserInfoService;
import hrms.util.DateUtil;
import hrms.util.EnumerateUtil;
import hrms.util.Md5Util;
import hrms.util.ParseUtil;
import hrms.util.StringUtil;
import hrms.util.Validator;
import hrms.vo.LoginInfo;
import hrms.vo.MsgVo;
import hrms.vo.ShowUserVo;
import hrms.vo.UserDetail;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
    private PictureInfoRepository pictureInfoRepository;

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

        if(! (isHR || isSM) ){
            return MsgVo.fail(ErrorCode.ONLY_HR);
        }

        Set<String> phoneSet = new HashSet<>();

        for(RegisterUserInfo registerUserInfo:registerUserInfos){
            //参数校验
            if(registerUserInfo == null ||
                     StringUtil.isEmpty(registerUserInfo.getOrgName()) ||
                    StringUtil.isEmpty(registerUserInfo.getUserName()) ||
                    ! Validator.isIDCard(registerUserInfo.getUserCardNumber()) ||
                    ! Validator.isEmail(registerUserInfo.getUserEmail()) ||
                    ! Validator.isMobile(registerUserInfo.getUserPhone()) ||
                    registerUserInfo.getIsOrgManager() == null
                    || registerUserInfo.getSex() == null ||
                    (registerUserInfo.getSex() != 2 && registerUserInfo.getSex() != 1)||
                    (registerUserInfo.getIsOrgManager() != 0 && registerUserInfo.getIsOrgManager() != 1) ||
                    ! Validator.isTimeNoSecond(registerUserInfo.getDataOfBirth()) ||
                    ! Validator.isTimeNoSecond(registerUserInfo.getWorkTime())
                    ){
                return MsgVo.error(ErrorCode.PARAMERROR);
            }

            phoneSet.add(registerUserInfo.getUserPhone());

            //验证手机号码
            UserInfo byPhone = userInfoRepository.findWorkerByPhone(registerUserInfo.getUserPhone());
            if(byPhone != null){
                return MsgVo.error(ErrorCode.REGISTER_REPEAT);
            }

            UserInfo userInfo = new UserInfo();

            //密码为身份证号后6位
            String userCardNumber = registerUserInfo.getUserCardNumber();
            userInfo.setUserPasswd(Md5Util.md5(userCardNumber.substring(userCardNumber.length()-6)));

            userInfo.setCreateTime(DateUtil.formatDate());
            userInfo.setCreateUserId(operId);

            userInfo.setUserAge(DateUtil.yearBetweenTwoDate(registerUserInfo.getDataOfBirth(),DateUtil.formatDate()));
            userInfo.setUserStatus(Constant.STATUS_ABLE);
            userInfo.setWorkStatus(Constant.STATUS_ABLE);

            userInfo.setUserPhone(registerUserInfo.getUserPhone());
            userInfo.setUserEmail(registerUserInfo.getUserEmail());
            userInfo.setSex(ParseUtil.parseString(registerUserInfo.getSex()));
            userInfo.setUserName(registerUserInfo.getUserName());
            userInfoBatch.add(userInfo);
        }

        if(phoneSet.size() != registerUserInfos.size()){
            return MsgVo.error(ErrorCode.REGISTER_REPEAT);
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
            userSensitiveInfo.setDataOfBirth(DateUtil.formatDate(DateUtil.BASE_DATE_FORMAT,date));
            userSensitiveInfo.setUserCardNumber(registerUserInfo.getUserCardNumber());
            userSensitiveInfo.setUserId(userId);
            userSensitiveInfo.setWorkTime(registerUserInfo.getWorkTime());
            userSensitiveBatch.add(userSensitiveInfo);

            //注册用户头像
            String paramId = Constant.DEFAULT_USER_PHOTO_HEAD+(int)(Math.random()*7);
            SysParamConfig defaultPhoto = sysParamConfigRepository.findByID(paramId);
            PictureInfo pictureInfo = new PictureInfo();
            pictureInfo.setCreateTime(DateUtil.formatDate());
            pictureInfo.setCreateUserId(operId);
            pictureInfo.setPicDesc(registerUserInfo.getUserName()+" 默认头像");
            pictureInfo.setPicStatus(Constant.STATUS_ABLE);
            pictureInfo.setPicUrl(defaultPhoto.getParamValue());
            pictureInfo.setRelId(userId);
            pictureInfo.setRelType(Constant.REL_TYPE_USER_PHOTO);
            userPictureBatch.add(pictureInfo);
        }
        userSensitiveInfoRepository.batchSave(userSensitiveBatch);
        pictureInfoRepository.batchSave(userPictureBatch);

        //注册权限
        List<UserRoleInfo> userRoleBatch = new ArrayList<>();
        for(RegisterUserInfo registerUserInfo:registerUserInfos){
            //验证是否可以授予该权限
            if(! isSM && Constant.ROLE_WORKER_VALUE != registerUserInfo.getRoleID().intValue() ){
                return MsgVo.fail(ErrorCode.REGISTER_PERMISSION_DENIED);
            }
            //验证权限是否存在
            RoleInfo roleInfo = roleInfoRepository.findById(registerUserInfo.getRoleID());
            if(roleInfo == null){
                return MsgVo.error(ErrorCode.PERMISSION_NOT_DEFINED);
            }
            UserRoleInfo userRoleInfo = new UserRoleInfo();
            userRoleInfo.setUserId(phoneMap.get(registerUserInfo.getUserPhone()).getUserId());
            userRoleInfo.setCreateUserId(operId);
            userRoleInfo.setStatus(Constant.ROLE_ABLE);
            userRoleInfo.setCreateTime(DateUtil.formatDate());
            userRoleInfo.setRoleId(registerUserInfo.getRoleID());
            userRoleBatch.add(userRoleInfo);
        }
        userRoleInfoRepository.batchSave(userRoleBatch);

        //注册经理和部门
        List<OrgMemberInfo> orgMemberBatch = new ArrayList<>();
        for(RegisterUserInfo registerUserInfo:registerUserInfos){
            Integer userID = phoneMap.get(registerUserInfo.getUserPhone()).getUserId();

            OrgInfo orgInfo = orgInfoRepository.findByName(registerUserInfo.getOrgName());

            if(orgInfo == null){
                OrgInfo newOrg = new OrgInfo();
                newOrg.setOrgStatus(Constant.STATUS_ABLE);
                newOrg.setCreateTime(DateUtil.formatDate());
                newOrg.setCreateUserId(commonParams.getUserId());
                newOrg.setDesc(registerUserInfo.getOrgName());
                newOrg.setOrgName(registerUserInfo.getOrgName());
                newOrg.setParentOrgId(0);
                orgInfo = orgInfoRepository.save(newOrg);
            }

            if(1 == registerUserInfo.getIsOrgManager().byteValue()){
                //验证是否可以授予经理权限
                Integer managerID = orgManagerInfoRepository.getManager(orgInfo.getOrgId());
                if(managerID == null){
                    //部门没有经理，可以设置为经理
                    OrgManagerInfo orgManagerInfo = new OrgManagerInfo();
                    orgManagerInfo.setStatus(Constant.STATUS_ABLE);
                    orgManagerInfo.setUserId(userID);
                    orgManagerInfo.setOrgId(orgInfo.getOrgId());
                    orgManagerBatch.add(orgManagerInfo);
                }else{
                    return MsgVo.fail(ErrorCode.REGISTER_ORG_MANAGER_FAIL);
                }
            }
            OrgMemberInfo orgMemberInfo = new OrgMemberInfo();
            orgMemberInfo.setOrgId(orgInfo.getOrgId());
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
        String userPasswd = param.getUserPasswd().trim();
        String userPhone = param.getUserPhone().trim();

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
        UserSensitiveInfo one = userSensitiveInfoRepository.findByID(userInfo.getUserId());
        int betweenTwoDate = DateUtil.yearBetweenTwoDate(one.getDataOfBirth(), DateUtil.formatDate());
        if(betweenTwoDate != userInfo.getUserAge()){
            userInfo.setUserAge(betweenTwoDate);
            userInfoRepository.save(userInfo);
        }

        //获取登录所需信息
        LoginInfo loginInfo = new LoginInfo();
        loginInfo = orgMemberInfoRepository.findByUserID(userInfo.getUserId());
        if(loginInfo != null){
            if(orgManagerInfoRepository.isManager(userInfo.getUserId(),loginInfo.getOrgId())){
                loginInfo.setIsManager((byte) 1);
            }else{
                loginInfo.setIsManager((byte) 0);
            }
        }else{
            loginInfo.setIsManager((byte) 0);
        }


        List<UserRoleInfo> userRoles = userRoleInfoRepository.findUserRole(userInfo.getUserId());
        if(userRoles != null && userRoles.size() > 0){
            for(UserRoleInfo userRoleInfo:userRoles){
                if(Constant.ROLE_SYSTEM_MANAGER_VALUE == userRoleInfo.getRoleId().intValue()){
                    loginInfo.setIsSM((byte) 1);
                    loginInfo.setIsHR((byte) 1);
                    loginInfo.setIsFINANCE((byte) 1);
                }
                if(Constant.ROLE_HR_VALUE == userRoleInfo.getRoleId().intValue()){
                    loginInfo.setIsHR((byte) 1);
                }
                if(Constant.ROLE_FINANCE_VALUE == userRoleInfo.getRoleId().intValue()){
                    loginInfo.setIsFINANCE((byte) 1);
                }
            }
        }

        PictureInfo userPhoto = pictureInfoRepository.findUserPhoto(userInfo.getUserId());
        //信息设置
        loginInfo.setJoinTime(one.getWorkTime());

        loginInfo.setUserId(userInfo.getUserId());
        loginInfo.setUserName(userInfo.getUserName());
        loginInfo.setUserPhoto(userPhoto.getPicUrl());
        loginInfo.setUserSex(userInfo.getSex());

        Map<String,LoginInfo> map = new HashMap();
        map.put("result",loginInfo);
        return MsgVo.success(map);
    }

    @Override
    public MsgVo findUsers(FindUserParam param, CommonParams commonParams) {
        Integer userID = commonParams.getUserId();
        UserInfo oper = userInfoRepository.findByUserId(userID);
        OrgMemberDetail memberDetail = orgMemberInfoRepository.findOrg(oper.getUserId());
        if(memberDetail != null && memberDetail.getOrgID().intValue() != commonParams.getOrgId()){
            return MsgVo.fail(ErrorCode.NO_AUTH);
        }

//        boolean isOrgManager = false;

        if(oper == null){
            return MsgVo.fail(ErrorCode.USER_EMPTY);
        }

        boolean isSMOrHR= userRoleInfoRepository.isHROrSM(userID);

       /* if(! isSMOrHR ){
            OrgMemberDetail orgDetail = orgMemberInfoRepository.findOrg(oper.getUserId());
            if(orgDetail != null){
                isOrgManager = orgManagerInfoRepository.isManager(oper.getUserId(), orgDetail.getOrgID());
            }
        }*/

        //获取数据
        List<UserDetail> userDetails = new ArrayList<>();
        userDetails = userInfoRepository.findUserBaseInfos(param, commonParams.getPage(), commonParams.getPagesize());
        int count = userInfoRepository.findUserBaseInfoCount(param);

        Map<String, Object> map = new HashMap<>();
        map.put("count",count);

        ShowUserVo voParam = new ShowUserVo();
        voParam.setUserInfos(userDetails);

        List<OrgBaseInfo> baseAllOrg = orgInfoRepository.findBaseAllOrg();
        voParam.setOrgInfos(baseAllOrg);

        List<RoleBaseInfo> baseAllRole = roleInfoRepository.findBaseAll();
        voParam.setRoleInfos(baseAllRole);
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
        if(isSMOrHR){
            for(UserDetail userDetail:voParam.getUserInfos()){
                userDetail.setHasRole((byte) 1);
            }
        }
        /*else{
            if(isOrgManager){
                for(UserDetail userDetail:voParam.getUserInfos()){
                    if(userDetail.getOrgID().intValue() == memberDetail.getOrgID().intValue()){
                        userDetail.setHasRole((byte) 1);
                    }
                }
            }
        }
*/
        map.put("result",voParam);
        return MsgVo.success(map);
    }

    @Override
    public MsgVo findUserDetail(Integer userID, CommonParams commonParams) {

        Integer operId = commonParams.getUserId();
        UserInfo oper = userInfoRepository.findByUserId(operId);

        if(oper == null){
            return MsgVo.fail(ErrorCode.USER_EMPTY);
        }

        UserInfo searchUserInfo = userInfoRepository.findByUserId(userID);
        if(searchUserInfo == null || searchUserInfo.getUserStatus().byteValue() == Constant.STATUS_DISABLE){
            return MsgVo.fail(ErrorCode.USER_EMPTY);
        }

        boolean isSMOrHR= userRoleInfoRepository.isHROrSM(operId);

        UserDetail userDetail = new UserDetail();
        if(userID.intValue() == commonParams.getUserId()){
            userDetail = userInfoRepository.findUserDetail(userID,true);
            userDetail.setIsMine((byte) 1);
            userDetail.setHasRole((byte) 1);
        }else{
            if(isSMOrHR){
                userDetail = userInfoRepository.findUserDetail(userID,true);
                userDetail.setHasRole((byte) 1);
            }else{
                userDetail = userInfoRepository.findUserDetail(userID,false);
                userDetail.setHasRole((byte) 0);
            }
            userDetail.setIsMine((byte) 0);
        }

        /*职业信息*/

        UserSensitiveInfo sensitiveInfo = userSensitiveInfoRepository.findByID(userID);
        UserInfo createUser = userInfoRepository.findByUserId(searchUserInfo.getCreateUserId());

        List<String> workMessages = new ArrayList<>();
        workMessages.add(searchUserInfo.getUserName()+",您于"+searchUserInfo.getCreateTime()+"加入"+Constant.COMPANY_NAME+",您的实际入职时间为："+sensitiveInfo.getWorkTime()+"操作员为："+createUser.getUserName());

        List<String> userWorkMessage = orgMemberInfoRepository.getUserWorkMessage(userID);
        workMessages.addAll(userWorkMessage);
        userDetail.setWorkMessages(workMessages);

        Map<String,UserDetail> map = new HashMap<>();
        map.put("result",userDetail);
        return MsgVo.success(map);
    }

    @Override
    public MsgVo updateUser(UpdateUserParam param, CommonParams commonParams) {
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

        UserInfo userInfo = userInfoRepository.findByUserId(param.getUserID());
        if(userInfo == null){
            return MsgVo.fail(ErrorCode.USER_EMPTY);
        }
        if(! StringUtil.isEmpty(param.getUserName())){
            userInfo.setUserName(param.getUserName());
        }
        if(! StringUtil.isEmpty(param.getUserPhone()) &&
                Validator.isMobile(param.getUserPhone())){
            UserInfo byPhone = userInfoRepository.findByPhone(param.getUserPhone());
            if(byPhone != null){
                return MsgVo.fail(ErrorCode.REGISTER_REPEAT);
            }
            userInfo.setUserPhone(param.getUserPhone());
        }
        if(! StringUtil.isEmpty(param.getUserSex()) &&
                (param.getUserSex() ==1 ||param.getUserSex() ==0 )){
            userInfo.setSex(param.getUserSex().toString());
        }
        if(! StringUtil.isEmpty(param.getUserEmail()) &&
                Validator.isEmail(param.getUserEmail())){
            userInfo.setUserEmail(param.getUserEmail());
        }
        if(! StringUtil.isEmpty(param.getBirthOfDate()) &&
                DateUtil.now().after(DateUtil.parse(param.getBirthOfDate(),DateUtil.BASE_DATE_FORMAT))){
            UserSensitiveInfo userSensitiveInfo = userSensitiveInfoRepository.findByID(param.getUserID());
            userSensitiveInfo.setDataOfBirth(param.getBirthOfDate());
            userSensitiveInfoRepository.save(userSensitiveInfo);

            //更新年龄
            UserSensitiveInfo one = userSensitiveInfoRepository.findByID(userInfo.getUserId());
            int betweenTwoDate = DateUtil.yearBetweenTwoDate(one.getDataOfBirth(), DateUtil.formatDate());
            if(betweenTwoDate != userInfo.getUserAge()){
                userInfo.setUserAge(betweenTwoDate);
            }
        }

        userInfoRepository.save(userInfo);

        return MsgVo.success(null);
    }

    @Override
    public MsgVo uploadUserPhoto(UploadUserPhoto param, CommonParams commonParams) {
        Integer oper = commonParams.getUserId();
        UserInfo operInfo = userInfoRepository.findByUserId(oper);
        if(operInfo == null || operInfo.getUserStatus() == Constant.STATUS_DISABLE){
            return MsgVo.fail(ErrorCode.USER_EMPTY);
        }
        if(operInfo.getWorkStatus() == Constant.STATUS_DISABLE){
            return MsgVo.fail(ErrorCode.USER_WORK_DISABLE);
        }

        Integer relId = param.getRelId();
        Integer relType = param.getRelType();

        if(relType == Constant.REL_TYPE_USER_PHOTO && oper.intValue() != relId.intValue()){
            boolean hrOrSM = userRoleInfoRepository.isHROrSM(oper);
            if(! hrOrSM){
                return MsgVo.fail(ErrorCode.ROLE_ERROR);
            }

            UserInfo byUserId = userInfoRepository.findByUserId(relId);
            if(byUserId == null || byUserId.getUserStatus() == Constant.STATUS_DISABLE){
                return MsgVo.fail(ErrorCode.USER_EMPTY);
            }
        }

        PictureInfo photo = pictureInfoRepository.findUPhotoByType(relId,relType);
        if(photo != null){
            photo.setPicStatus(Constant.STATUS_DISABLE);
            pictureInfoRepository.save(photo);
        }
        PictureInfo pictureInfo = new PictureInfo();
        pictureInfo.setRelId(relId);
        pictureInfo.setRelType(Constant.REL_TYPE_USER_PHOTO);
        pictureInfo.setCreateTime(DateUtil.formatDate());
        pictureInfo.setPicUrl(param.getPicName());
        pictureInfo.setPicStatus(Constant.STATUS_ABLE);
        pictureInfo.setPicDesc(relId+"的"+EnumerateUtil.translator("picture_info-REL_TYPE-"+relType));
        pictureInfo.setCreateUserId(oper);

        pictureInfoRepository.save(pictureInfo);

        return MsgVo.success(null);
    }

    @Override
    public MsgVo resetPwd(Integer userID, CommonParams commonParams) {

        boolean hrOrSM = userRoleInfoRepository.isHROrSM(commonParams.getUserId());
        if(!hrOrSM){
            return MsgVo.error(ErrorCode.ONLY_HR);
        }
        UserInfo userInfo = userInfoRepository.findByUserId(userID);
        if(userInfo == null){
            return MsgVo.error(ErrorCode.USER_EMPTY);
        }
        UserSensitiveInfo userSensitiveInfo = userSensitiveInfoRepository.findByID(userID);
        userInfo.setUserPasswd(Md5Util.md5(userSensitiveInfo.getUserCardNumber().substring(userSensitiveInfo.getUserCardNumber().length()-6)));
        userInfoRepository.save(userInfo);

        return MsgVo.success(null);
    }

    @Override
    public MsgVo changeStatus(ChangeUserStatusParam param, CommonParams commonParams) {
        boolean hrOrSM = userRoleInfoRepository.isHROrSM(commonParams.getUserId());
        if(!hrOrSM){
            return MsgVo.error(ErrorCode.ONLY_HR);
        }
        UserInfo userInfo = userInfoRepository.findByUserId(param.getUserID());
        if(userInfo == null){
            return MsgVo.error(ErrorCode.USER_EMPTY);
        }
        if(! StringUtil.isEmpty(param.getWorkStatus())){
            userInfo.setWorkStatus(ParseUtil.parseByte(param.getWorkStatus()));
        }
        if(! StringUtil.isEmpty(param.getUserStatus())){
            userInfo.setUserStatus(ParseUtil.parseByte(param.getUserStatus()));
        }

        userInfoRepository.save(userInfo);
        return MsgVo.success(null);
    }

    @Override
    public MsgVo updatePwd(UpdateUserPwd param, CommonParams commonParams) {
        UserInfo userInfo = userInfoRepository.findByUserId(commonParams.getUserId());
        if(userInfo == null){
            return MsgVo.error(ErrorCode.USER_EMPTY);
        }
        if(! userInfo.getUserPasswd().equals(Md5Util.md5(param.getOldPwd()))){
            return MsgVo.error(ErrorCode.USER_PASSWORD_ERROR);
        }
        userInfo.setUserPasswd(Md5Util.md5(param.getNewPwd()));
        userInfoRepository.save(userInfo);
        return MsgVo.success(null);
    }

    @Override
    public MsgVo findAllUserName(String userName) {
        List<UserBaseInfo> allUserName = userInfoRepository.findAllUserName(userName);
        Map map = new HashMap();

        if(allUserName == null){
            return MsgVo.error(ErrorCode.RESULT_EMPTY);
        }
        map.put("result",allUserName);
        return MsgVo.success(map);
    }
}
