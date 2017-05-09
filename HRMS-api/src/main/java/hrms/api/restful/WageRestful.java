/**
 * 
 */
package hrms.api.restful;

import hrms.annotation.HRMSParam;
import hrms.common.CommonParams;
import hrms.common.ErrorCode;
import hrms.exception.InvalidException;
import hrms.po.FindAllWageParam;
import hrms.po.FindWageDetail;
import hrms.po.SaveWageParam;
import hrms.po.UpdateUserWageParam;
import hrms.service.wage.UserWageService;
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

@Path("/wage")
@Produces(MediaType.APPLICATION_JSON)
public class WageRestful {
	private static final Log log = LogFactory.getLog(WageRestful.class);
	
	@Autowired
	private UserWageService userWageService;

	@POST
	@Path("/batchSave")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo batchSave(@HRMSParam("object")SaveWageParam param, CommonParams commonParam){
		try {
			if(param == null ||
					param.getWageInfos() == null ||
					param.getWageInfos().size() < 1 ||
					commonParam.getOrgId() == null || commonParam.getUserId() == null){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			LoggerWriter.addWrite(log, " 批量新建用户工资单",param,commonParam);
			MsgVo msgVo = userWageService.batchSave(param,commonParam);
			LoggerWriter.addWrite(log, " 批量新建用户工资单成功",param,commonParam);

			return msgVo;
		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			e.printStackTrace();
			log.error(" 批量新建用户工资单失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}

	@POST
	@Path("/findAllWages")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo findAllWages(@HRMSParam("object")FindAllWageParam param, CommonParams commonParam){
		try {
			if(commonParam.getOrgId() == null || commonParam.getUserId() == null ||
					commonParam.getPage() == null || commonParam.getPagesize() == null){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			LoggerWriter.addWrite(log, " 查询用户工资单",param,commonParam);
			MsgVo msgVo = userWageService.findAllWages(param,commonParam);
			LoggerWriter.addWrite(log, " 查询用户工资单成功",param,commonParam);

			return msgVo;
		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			e.printStackTrace();
			log.error(" 查询用户工资单失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}
	@POST
	@Path("/findWageDetail")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo findWageDetail(@HRMSParam("object")FindWageDetail param, CommonParams commonParam){
		try {
			if(param == null ||
					param.getUserId() == null || param.getIsFinance() == null ||
					commonParam.getOrgId() == null || commonParam.getUserId() == null ){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			LoggerWriter.addWrite(log, " 查询用户工资详单",param,commonParam);
			MsgVo msgVo = userWageService.findWageDetail(param.getUserId(),param.getIsFinance(),commonParam);
			LoggerWriter.addWrite(log, " 查询用户工资详单成功",param,commonParam);

			return msgVo;
		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			e.printStackTrace();
			log.error(" 查询用户工资详单失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}

	@POST
	@Path("/updateUserWage")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo updateUserWage(@HRMSParam("object")UpdateUserWageParam param, CommonParams commonParam){
		try {
			if(param == null ||
					param.getWageId() == null ||
					commonParam.getOrgId() == null || commonParam.getUserId() == null ){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			LoggerWriter.addWrite(log, " 更新用户工资单",param,commonParam);
			MsgVo msgVo = userWageService.updateUserWage(param,commonParam);
			LoggerWriter.addWrite(log, " 更新用户工资单成功",param,commonParam);

			return msgVo;
		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			e.printStackTrace();
			log.error(" 更新用户工资单失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}

}
