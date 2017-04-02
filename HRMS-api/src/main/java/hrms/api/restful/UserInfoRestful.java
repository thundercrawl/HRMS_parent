/**
 * 
 */
package hrms.api.restful;

import hrms.annotation.HRMSParam;
import hrms.common.CommonParams;
import hrms.common.ErrorCode;
import hrms.exception.InvalidException;
import hrms.po.SaveUserParam;
import hrms.service.impl.user.UserInfoService;
import hrms.util.LoggerWriter;
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
	
}
