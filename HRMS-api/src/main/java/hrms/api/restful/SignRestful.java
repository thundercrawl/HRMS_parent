/**
 * 
 */
package hrms.api.restful;


import hrms.annotation.HRMSParam;
import hrms.common.CommonParams;
import hrms.common.ErrorCode;
import hrms.exception.InvalidException;
import hrms.po.FindSignParam;
import hrms.po.SaveSignParam;
import hrms.service.sign.SignInfoService;
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

@Path("/sign")
@Produces(MediaType.APPLICATION_JSON)
public class SignRestful {
	private static final Log log = LogFactory.getLog(SignRestful.class);
	
	@Autowired
	private SignInfoService signInfoService;
	@POST
	@Path("/batchSave")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo batchSave(@HRMSParam("object")SaveSignParam param, CommonParams commonParam){
		try {
			if(param == null || param.getSignInfos() == null ||
					param.getSignInfos().size() < 1 ||
					commonParam.getOrgId() == null || commonParam.getUserId() == null){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			LoggerWriter.addWrite(log, " 导入考勤记录",param,commonParam);
			MsgVo msgVo = signInfoService.batchSave(param,commonParam);
			LoggerWriter.addWrite(log, " 导入考勤记录成功",param,commonParam);

			return msgVo;
		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			e.printStackTrace();
			log.error(" 导入考勤记录失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}

	@POST
	@Path("/findSigns")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo findSigns(@HRMSParam("object")FindSignParam param, CommonParams commonParam){
		try {
			if(commonParam.getOrgId() == null || commonParam.getUserId() == null ||
					commonParam.getPage() == null || commonParam.getPagesize() == null){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			LoggerWriter.addWrite(log, " 查询考勤记录",param,commonParam);
			MsgVo msgVo = signInfoService.findSigns(param,commonParam);
			LoggerWriter.addWrite(log, " 查询考勤记录成功",param,commonParam);

			return msgVo;
		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			e.printStackTrace();
			log.error(" 查询考勤记录失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}
}
