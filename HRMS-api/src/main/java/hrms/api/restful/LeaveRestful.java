/**
 * 
 */
package hrms.api.restful;

import hrms.annotation.HRMSParam;
import hrms.common.CommonParams;
import hrms.common.ErrorCode;
import hrms.exception.InvalidException;
import hrms.po.FindApproveParam;
import hrms.po.FindLeavesParam;
import hrms.po.UpApproveParam;
import hrms.service.leave.UserLeaveService;
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

@Path("/leave")
@Produces(MediaType.APPLICATION_JSON)
public class LeaveRestful {
	private static final Log log = LogFactory.getLog(LeaveRestful.class);
	
	@Autowired
	private UserLeaveService userLeaveService;

	@POST
	@Path("/upApprove")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo upApprove(@HRMSParam("object")UpApproveParam param, CommonParams commonParam){
		try {
			if(param == null || param.getLeaveType() == null ||
					StringUtil.isEmpty(param.getStartTime()) ||StringUtil.isEmpty(param.getEndTime()) ||
					commonParam.getOrgId() == null || commonParam.getUserId() == null){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			LoggerWriter.addWrite(log, " 提交请假或出差审批",param,commonParam);
			MsgVo msgVo = userLeaveService.upApprove(param,commonParam);
			LoggerWriter.addWrite(log, " 提交请假或出差审批成功",param,commonParam);

			return msgVo;
		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			e.printStackTrace();
			log.error(" 提交请假或出差审批失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}

	@POST
	@Path("/findAllLeaves")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo findAllLeaves(@HRMSParam("object")FindLeavesParam param, CommonParams commonParam){
		try {
			if(param == null || param.getLeaveType() == null ||
					commonParam.getOrgId() == null || commonParam.getUserId() == null ||
					commonParam.getPage() == null || commonParam.getPagesize() == null){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			LoggerWriter.addWrite(log, " 查询会员的审批记录",param,commonParam);
			MsgVo msgVo = userLeaveService.findAllLeaves(param,commonParam);
			LoggerWriter.addWrite(log, " 查询会员的审批记录成功",param,commonParam);

			return msgVo;
		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			e.printStackTrace();
			log.error(" 查询会员的审批记录失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}

	@POST
	@Path("/findAllApproves")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo findAllApproves(@HRMSParam("object")FindApproveParam param, CommonParams commonParam){
		try {
			if(commonParam.getOrgId() == null || commonParam.getUserId() == null ||
					commonParam.getPage() == null || commonParam.getPagesize() == null){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			LoggerWriter.addWrite(log, " 查询会员的需要审批的记录",param,commonParam);
			MsgVo msgVo = userLeaveService.findAllApproves(param,commonParam);
			LoggerWriter.addWrite(log, " 查询会员的需要审批的记录成功",param,commonParam);

			return msgVo;
		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			e.printStackTrace();
			log.error(" 查询会员的需要审批的记录失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}

	@POST
	@Path("/findApproveDetail")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo findApproveDetail(@HRMSParam("object")FindApproveParam param, CommonParams commonParam){
		try {
			if(param == null || param.getLeaveId() == null ||
					commonParam.getOrgId() == null || commonParam.getUserId() == null ||
					commonParam.getPage() == null || commonParam.getPagesize() == null){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			LoggerWriter.addWrite(log, " 查询审批条目详情",param,commonParam);
			MsgVo msgVo = userLeaveService.findApproveDetail(param.getLeaveId());
			LoggerWriter.addWrite(log, " 查询审批条目详情成功",param,commonParam);

			return msgVo;
		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			e.printStackTrace();
			log.error(" 查询审批条目详情失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}

	@POST
	@Path("/passApprove")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo passApprove(@HRMSParam("object")FindApproveParam param, CommonParams commonParam){
		try {
			if(param == null || param.getLeaveId() == null ||
					commonParam.getOrgId() == null || commonParam.getUserId() == null ||
					commonParam.getPage() == null || commonParam.getPagesize() == null){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			LoggerWriter.addWrite(log, " 批准会员的审批请求",param,commonParam);
			MsgVo msgVo = userLeaveService.passApprove(param.getLeaveId(),commonParam);
			LoggerWriter.addWrite(log, " 批准会员的审批请求成功",param,commonParam);

			return msgVo;
		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			e.printStackTrace();
			log.error(" 批准会员的审批请求失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}

	@POST
	@Path("/rejectApprove")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo rejectApprove(@HRMSParam("object")FindApproveParam param, CommonParams commonParam){
		try {
			if(param == null || param.getLeaveId() == null ||
					commonParam.getOrgId() == null || commonParam.getUserId() == null ||
					commonParam.getPage() == null || commonParam.getPagesize() == null){
				return MsgVo.error(ErrorCode.PARAM_EMPTY);
			}
			LoggerWriter.addWrite(log, " 拒绝会员的审批请求",param,commonParam);
			MsgVo msgVo = userLeaveService.rejectApprove(param.getLeaveId(),commonParam);
			LoggerWriter.addWrite(log, " 拒绝会员的审批请求成功",param,commonParam);

			return msgVo;
		}catch (InvalidException e1){
			return MsgVo.error(e1.getErrorCode());
		}catch (Exception e) {
			e.printStackTrace();
			log.error(" 拒绝会员的审批请求失败 Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}
}
