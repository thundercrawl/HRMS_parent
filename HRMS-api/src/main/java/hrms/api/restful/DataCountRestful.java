/**
 * 
 */
package hrms.api.restful;

import hrms.annotation.HRMSParam;
import hrms.common.CommonParams;
import hrms.common.ErrorCode;
import hrms.exception.InvalidException;
import hrms.po.DataCountParam;
import hrms.service.data.DataCountService;
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

@Path("/data")
@Produces(MediaType.APPLICATION_JSON)
public class DataCountRestful {
	private static final Log log = LogFactory.getLog(DataCountRestful.class);
	
	@Autowired
	private DataCountService dataCountService;

	@POST
	@Path("/signCount")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo signCount(@HRMSParam("object")DataCountParam param, CommonParams commonParam){
		try {
			if(commonParam.getOrgId() == null || commonParam.getUserId() == null){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			if(param == null){
				param = new DataCountParam();
			}
			LoggerWriter.addWrite(log, " 查询考勤统计数据",param,commonParam);
			MsgVo msgVo = dataCountService.signCount(param.getYear(),commonParam);
			LoggerWriter.addWrite(log, " 查询考勤统计数据 成功",param,commonParam);

			return msgVo;
		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			e.printStackTrace();
			log.error(" 查询考勤统计数据 失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}

	@POST
	@Path("/billCount")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo billCount(@HRMSParam("object")DataCountParam param, CommonParams commonParam){
		try {
			if(commonParam.getOrgId() == null || commonParam.getUserId() == null){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			if(param == null){
				param = new DataCountParam();
			}
			LoggerWriter.addWrite(log, " 查询账单统计数据",param,commonParam);
			MsgVo msgVo = dataCountService.billCount(param.getYear(),commonParam);
			LoggerWriter.addWrite(log, " 查询账单统计数据 成功",param,commonParam);

			return msgVo;
		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			e.printStackTrace();
			log.error(" 查询账单统计数据 失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}

}
