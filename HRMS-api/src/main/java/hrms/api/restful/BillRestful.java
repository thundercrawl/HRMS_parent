/**
 * 
 */
package hrms.api.restful;

import hrms.annotation.HRMSParam;
import hrms.common.CommonParams;
import hrms.common.ErrorCode;
import hrms.exception.InvalidException;
import hrms.po.FindBillParam;
import hrms.po.SearchBillParam;
import hrms.service.wage.BillSearchService;
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

@Path("/bill")
@Produces(MediaType.APPLICATION_JSON)
public class BillRestful {
	private static final Log log = LogFactory.getLog(BillRestful.class);
	
	@Autowired
	private BillSearchService billSearchService;

	@POST
	@Path("/searchBill")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo searchBill(@HRMSParam("object")SearchBillParam param, CommonParams commonParam){
		try {
			if(commonParam.getOrgId() == null || commonParam.getUserId() == null){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			LoggerWriter.addWrite(log, " 查询用户账单列表",param,commonParam);
			MsgVo msgVo = billSearchService.searchBill(param,commonParam);
			LoggerWriter.addWrite(log, " 查询用户账单列表 成功",param,commonParam);

			return msgVo;
		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			e.printStackTrace();
			log.error(" 查询用户账单列表 失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}

	@POST
	@Path("/findBillDetail")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo findBillDetail(@HRMSParam("object")FindBillParam param, CommonParams commonParam){
		try {
			if(param == null || param.getBillId() == null ||
					commonParam.getOrgId() == null || commonParam.getUserId() == null){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			LoggerWriter.addWrite(log, " 查询用户账单详情",param,commonParam);
			MsgVo msgVo = billSearchService.findBillDetail(param);
			LoggerWriter.addWrite(log, " 查询用户账单详情 成功",param,commonParam);

			return msgVo;
		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			e.printStackTrace();
			log.error(" 查询用户账单详情 失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}


}
