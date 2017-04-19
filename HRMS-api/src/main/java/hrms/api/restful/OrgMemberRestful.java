/**
 * 
 */
package hrms.api.restful;

import hrms.annotation.HRMSParam;
import hrms.common.CommonParams;
import hrms.common.ErrorCode;
import hrms.exception.InvalidException;
import hrms.po.AddOrg;
import hrms.po.DeleteFromOrg;
import hrms.service.org.OrgMemberService;
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

@Path("/orgMember")
@Produces(MediaType.APPLICATION_JSON)
public class OrgMemberRestful {
	private static final Log log = LogFactory.getLog(OrgMemberRestful.class);
	
	@Autowired
	private OrgMemberService orgMemberService;


	@POST
	@Path("/addOrg")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo addOrg(@HRMSParam("object")AddOrg param, CommonParams commonParam){
		try {
			if(param == null || param.getIsManager() == null ||
					StringUtil.isEmpty(param.getJobName()) || param.getOrgID() == null ||
					param.getUserID() == null ||
					commonParam.getOrgId() == null || commonParam.getUserId() == null){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			LoggerWriter.addWrite(log, " 用户加入部门",param,commonParam);
			MsgVo msgVo = orgMemberService.addOrg(param, commonParam);
			LoggerWriter.addWrite(log, " 用户加入部门 成功",param,commonParam);

			return msgVo;
		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			log.error(" 用户加入部门 失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}
	@POST
	@Path("/deleteFromOrg")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo deleteFromOrg(@HRMSParam("object")DeleteFromOrg param, CommonParams commonParam){
		try {
			if(param == null || param.getOrgID() == null ||
					param.getUserID() == null ||
					commonParam.getOrgId() == null || commonParam.getUserId() == null){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			LoggerWriter.addWrite(log, " 用户退出部门",param,commonParam);
			MsgVo msgVo = orgMemberService.deleteFromOrg(param, commonParam);
			LoggerWriter.addWrite(log, " 用户退出部门 成功",param,commonParam);

			return msgVo;
		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			log.error(" 用户退出部门 失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}
	
}
