/**
 * 
 */
package hrms.api.restful;

import hrms.annotation.HRMSParam;
import hrms.common.CommonParams;
import hrms.common.ErrorCode;
import hrms.exception.InvalidException;
import hrms.po.FindUserParam;
import hrms.po.LoginParam;
import hrms.po.SaveUserParam;
import hrms.service.user.UserInfoService;
import hrms.util.LoggerWriter;
import hrms.util.StringUtil;
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
	 * busi_code:10001
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
			LoggerWriter.addWrite(log, "busi_code:10001 批量注册用户",param.getRegisterUserInfos(), userId,orgId);
			userInfoService.save(param.getRegisterUserInfos(),commonParam);
			LoggerWriter.addWrite(log, "busi_code:10001 批量注册用户成功",param.getRegisterUserInfos(), userId,orgId);
			return MsgVo.success(null);

		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			log.error("busi_code:10001 批量注册用户失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}

	@POST
	@Path("/test")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo test (@HRMSParam("object")SaveUserParam param, CommonParams commonParam){
		try {
			LoggerWriter.addWrite(log, "busi_code:10001 批量注册用户");
		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
		return null;
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
			LoggerWriter.addWrite(log, "busi_code:10001 批量注册用户",loginParam, commonParam);
			userInfoService.login(loginParam);
			LoggerWriter.addWrite(log, "busi_code:10001 批量注册用户成功",loginParam, commonParam);
			return MsgVo.success(null);

		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			log.error("busi_code:10001 批量注册用户失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}

	@POST
	@Path("/findUsers")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo findUsers(@HRMSParam("object")FindUserParam param, CommonParams commonParam){
		try {
			if(commonParam.getPage() == null ||
					commonParam.getPagesize() == null ||
					commonParam.getOrgId() == null || commonParam.getUserId() == null){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			LoggerWriter.addWrite(log, "busi_code:10001 批量注册用户", commonParam);
			userInfoService.findUsers(param,commonParam);
			LoggerWriter.addWrite(log, "busi_code:10001 批量注册用户成功", commonParam);
			return MsgVo.success(null);

		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			log.error("busi_code:10001 批量注册用户失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}

	@POST
	@Path("/findUserDetail")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo findUserDetail(@HRMSParam("object")Integer userID, CommonParams commonParam){
		try {
			if(commonParam.getOrgId() == null || commonParam.getUserId() == null){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			LoggerWriter.addWrite(log, "busi_code:10001 批量注册用户",userID, commonParam);
			userInfoService.findUserDetail(userID,commonParam);
			LoggerWriter.addWrite(log, "busi_code:10001 批量注册用户成功",userID, commonParam);
			return MsgVo.success(null);

		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			log.error("busi_code:10001 批量注册用户失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}
	
}
