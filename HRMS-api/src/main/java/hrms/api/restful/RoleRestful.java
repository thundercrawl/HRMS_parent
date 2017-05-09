/**
 * 
 */
package hrms.api.restful;


import hrms.annotation.HRMSParam;
import hrms.common.CommonParams;
import hrms.common.ErrorCode;
import hrms.exception.InvalidException;
import hrms.model.NullParam;
import hrms.service.role.RoleInfoService;
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

@Path("/roleInfo")
@Produces(MediaType.APPLICATION_JSON)
public class RoleRestful {
	private static final Log log = LogFactory.getLog(RoleRestful.class);
	
	@Autowired
	private RoleInfoService roleInfoService;
	@POST
	@Path("/listRole")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo findAllOrg(@HRMSParam("object")NullParam param,CommonParams commonParam){
		try {
			if(commonParam.getOrgId() == null || commonParam.getUserId() == null){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			LoggerWriter.addWrite(log, " 获取所有权限",commonParam);
			MsgVo msgVo = roleInfoService.listRole();
			LoggerWriter.addWrite(log, " 获取所有权限成功",commonParam);

			return msgVo;
		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			e.printStackTrace();
			log.error(" 获取所有权限失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}
}
