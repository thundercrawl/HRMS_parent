/**
 * 
 */
package hrms.api.restful;

import hrms.annotation.HRMSParam;
import hrms.common.CommonParams;
import hrms.common.ErrorCode;
import hrms.exception.InvalidException;
import hrms.po.SaveOrgParam;
import hrms.po.UpdateOrgParam;
import hrms.service.org.OrgInfoService;
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

@Path("/orgInfo")
@Produces(MediaType.APPLICATION_JSON)
public class OrgRestful {
	private static final Log log = LogFactory.getLog(OrgRestful.class);
	
	@Autowired
	private OrgInfoService orgInfoService;

	@POST
	@Path("/findAllOrg")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo findAllOrg(@HRMSParam("object")String orgName, CommonParams commonParam){
		try {
			if(StringUtil.isEmpty(orgName) || commonParam.getOrgId() == null || commonParam.getUserId() == null){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			LoggerWriter.addWrite(log, " 查找所有部门",orgName,commonParam);
			MsgVo msgVo = orgInfoService.findAllOrg(orgName);
			LoggerWriter.addWrite(log, " 查找所有部门成功",orgName,commonParam);

			return msgVo;
		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			log.error(" 查找所有部门失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}

	@POST
	@Path("/save")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo save(@HRMSParam("object")SaveOrgParam orgParam, CommonParams commonParam){
		try {
			if(orgParam == null || orgParam.getParentOrgId() == null ||
				StringUtil.isEmpty(orgParam.getOrgName())||
					commonParam.getOrgId() == null || commonParam.getUserId() == null){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			LoggerWriter.addWrite(log, " 新增部门",orgParam,commonParam);
			MsgVo msgVo = orgInfoService.save(orgParam, commonParam);
			LoggerWriter.addWrite(log, " 新增部门成功",orgParam,commonParam);

			return msgVo;
		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			log.error(" 新增部门失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}

	@POST
	@Path("/update")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo update(@HRMSParam("object")UpdateOrgParam orgParam, CommonParams commonParam){
		try {
			if(orgParam == null || orgParam.getOrgId() == null ||
					commonParam.getOrgId() == null || commonParam.getUserId() == null){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			LoggerWriter.addWrite(log, " 更新部门名称、描述",orgParam,commonParam);
			MsgVo msgVo = orgInfoService.update(orgParam, commonParam);
			LoggerWriter.addWrite(log, " 更新部门名称、描述 成功",orgParam,commonParam);

			return msgVo;
		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			log.error(" 更新部门名称、描述 失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}
	
}
