/**
 * 
 */
package hrms.api.restful;

import hrms.annotation.HRMSParam;
import hrms.common.CommonParams;
import hrms.common.ErrorCode;
import hrms.exception.InvalidException;
import hrms.model.UserBaseInfo;
import hrms.po.*;
import hrms.service.user.UserInfoService;
import hrms.util.LoggerWriter;
import hrms.util.StringUtil;
import hrms.util.Validator;
import hrms.vo.MsgVo;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

@Path("/userInfo")
@Produces(MediaType.APPLICATION_JSON)
public class UserInfoRestful {
	private static final Log log = LogFactory.getLog(UserInfoRestful.class);
	
	@Autowired
	private UserInfoService userInfoService;

	/**
	 * 
	 * @describe 批量注册用户
	 */
	@POST
	@Path("/saveUser")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo saveUser (@HRMSParam("object")SaveUserParam param, CommonParams commonParam){
		try {
			Integer orgId = commonParam.getOrgId();
			Integer userId = commonParam.getUserId();
			if(orgId == null || userId == null || param == null ||
					param.getRegisterUserInfos() == null ||
					param.getRegisterUserInfos().size() < 1){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			LoggerWriter.addWrite(log, " 批量注册用户",param.getRegisterUserInfos(), userId,orgId);
			MsgVo msgVo = userInfoService.save(param.getRegisterUserInfos(), commonParam);
			LoggerWriter.addWrite(log, " 批量注册用户成功",param.getRegisterUserInfos(), userId,orgId);
			return msgVo;

		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			e.printStackTrace();
			log.error(" 批量注册用户失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}

	@POST
	@Path("/login")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo login (@HRMSParam("object")LoginParam loginParam, CommonParams commonParam){
		try {
			if(loginParam == null ||
					StringUtil.isEmpty(loginParam.getUserPasswd()) ||
					StringUtil.isEmpty(loginParam.getUserPhone())){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			LoggerWriter.addWrite(log, " 用户登录",loginParam, commonParam);
			MsgVo msgVo = userInfoService.login(loginParam);
			LoggerWriter.addWrite(log, " 用户登录成功",loginParam, commonParam);

			return msgVo;

		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			log.error(" 用户登录失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}

	@POST
	@Path("/findUsers")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo findUsers(@HRMSParam("object")FindUserParam param, CommonParams commonParam){
		try {
			if(commonParam == null || commonParam.getPage() == null ||
					commonParam.getPagesize() == null || commonParam.getUserId() == null){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			LoggerWriter.addWrite(log, " 查询用户", commonParam);
			MsgVo msgVo = userInfoService.findUsers(param, commonParam);
			LoggerWriter.addWrite(log, " 查询用户成功", commonParam);

			return msgVo;

		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			e.printStackTrace();
			log.error(" 查询用户失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}

	@POST
	@Path("/findUserDetail")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo findUserDetail(@HRMSParam("object")FindUserDetailParam param, CommonParams commonParam){
		try {
			if(param == null || param.getUserID() == null || commonParam.getOrgId() == null || commonParam.getUserId() == null){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			LoggerWriter.addWrite(log, " 查询用户详情",param.getUserID(), commonParam);
			MsgVo msgVo = userInfoService.findUserDetail(param.getUserID(), commonParam);
			LoggerWriter.addWrite(log, " 查询用户详情成功",param.getUserID(), commonParam);

			return msgVo;

		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			e.printStackTrace();
			log.error(" 查询用户详情失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}

	@POST
	@Path("/updateUser")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo updateUser(@HRMSParam("object")UpdateUserParam param, CommonParams commonParam){
		try {
			if(commonParam.getOrgId() == null || commonParam.getUserId() == null){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			LoggerWriter.addWrite(log, " 更新用户资料",param, commonParam);
			MsgVo msgVo = userInfoService.updateUser(param, commonParam);
			LoggerWriter.addWrite(log, " 更新用户资料成功",param, commonParam);

			return msgVo;
		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			e.printStackTrace();
			log.error(" 批量注册用户失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}

	@POST
	@Path("/uploadUserPhoto")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo uploadUserPhoto(@HRMSParam("object")UploadUserPhoto param, CommonParams commonParam){
		try {
			if(param == null || StringUtil.isEmpty(param.getPicName())
					|| param.getRelId() == null || param.getRelType() == null
					|| commonParam.getOrgId() == null || commonParam.getUserId() == null){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			String picName = param.getPicName();
			LoggerWriter.addWrite(log, " 上传图片",picName,commonParam);
			MsgVo msgVo = userInfoService.uploadUserPhoto(param,commonParam);
			LoggerWriter.addWrite(log, " 上传图片成功",picName,commonParam);

			return msgVo;
		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			e.printStackTrace();
			log.error(" 上传图片失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}

	@POST
	@Path("/resetPwd")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo resetPwd(@HRMSParam("object")Integer userID, CommonParams commonParam){
		try {
			if(userID == null || commonParam.getOrgId() == null || commonParam.getUserId() == null){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			LoggerWriter.addWrite(log, " 重置用户密码",userID,commonParam);
			MsgVo msgVo = userInfoService.resetPwd(userID, commonParam);
			LoggerWriter.addWrite(log, " 重置用户密码成功",userID,commonParam);

			return msgVo;
		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			e.printStackTrace();
			log.error(" 重置用户密码失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}

	@POST
	@Path("/changeStatus")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo changeStatus(@HRMSParam("object")ChangeUserStatusParam param, CommonParams commonParam){
		try {
			if(param == null ||param.getUserID() == null ||
					(StringUtil.isEmpty(param.getUserStatus()) && StringUtil.isEmpty(param.getWorkStatus()))
					|| commonParam.getOrgId() == null || commonParam.getUserId() == null){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			if(! StringUtil.isEmpty(param.getUserStatus())){
				if(!("0".equals(param.getUserStatus()) || "1".equals(param.getUserStatus()))){
					return MsgVo.error(ErrorCode.PARAMERROR);
				}
			}
			if(! StringUtil.isEmpty(param.getWorkStatus())){
				if(!("0".equals(param.getWorkStatus()) || "1".equals(param.getWorkStatus()))){
					return MsgVo.error(ErrorCode.PARAMERROR);
				}
			}
			LoggerWriter.addWrite(log, " 修改用户状态",param,commonParam);
			MsgVo msgVo = userInfoService.changeStatus(param, commonParam);
			LoggerWriter.addWrite(log, " 修改用户状态成功",param,commonParam);

			return msgVo;
		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			e.printStackTrace();
			log.error(" 修改用户状态失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}

	@POST
	@Path("/updatePwd")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo updatePwd(@HRMSParam("object")UpdateUserPwd param, CommonParams commonParam){
		try {
			if(param == null ||
					StringUtil.isEmpty(param.getOldPwd()) || StringUtil.isEmpty(param.getNewPwd())
					|| commonParam.getOrgId() == null || commonParam.getUserId() == null){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			if(! Validator.isPassword(param.getOldPwd()) || ! Validator.isPassword(param.getNewPwd())){
				return MsgVo.error(ErrorCode.PARAMERROR);
			}
			LoggerWriter.addWrite(log, " 修改用户密码",param,commonParam);
			MsgVo msgVo = userInfoService.updatePwd(param, commonParam);
			LoggerWriter.addWrite(log, " 修改用户密码成功",param,commonParam);

			return msgVo;
		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			e.printStackTrace();
			log.error(" 修改用户密码失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}

	@POST
	@Path("/findAllUserName")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo findAllUserName(@HRMSParam("object")UserBaseInfo param, CommonParams commonParam){
		try {
			if(param == null || commonParam.getOrgId() == null || commonParam.getUserId() == null){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			LoggerWriter.addWrite(log, " 查询用户名称",param,commonParam);
			MsgVo msgVo = userInfoService.findAllUserName(param.getUserName());
			LoggerWriter.addWrite(log, " 查询用户名称成功",param,commonParam);

			return msgVo;
		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			e.printStackTrace();
			log.error(" 查询用户名称失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}

}
