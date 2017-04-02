/**
 * 
 */
package hrms.api.restful;

import hrms.annotation.HRMSParam;
import hrms.common.CommonParams;
import hrms.common.ErrorCode;
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
import java.util.HashMap;
import java.util.Map;

@Path("/task")
@Produces(MediaType.APPLICATION_JSON)
public class TaskRestful {
	private static final Log log = LogFactory.getLog(TaskRestful.class);
	
	@Autowired

	/**
	 * 发布任务
	 * busi_code:8008
	 * @author liuguoling  
	 * @param rtp
	 * @param commonParam
	 * @return
	 */
	@POST
	@Path("/releaseTask")
	@Consumes(MediaType.APPLICATION_JSON)
	public MsgVo addMsgRecord (@HRMSParam("object")String rtp, CommonParams commonParam){
		try {
			Integer orgId = commonParam.getOrgId();
			Integer userId = commonParam.getUserId();
			LoggerWriter.addWrite(log, "busi_code:8008新增数据库表ofc_task_info ofc_user_task",rtp, userId,orgId);
			try {
				Map<String, Object> map = new HashMap<>();
				LoggerWriter.addWrite(log, "busi_code:8008新增成功数据库表ofc_task_info ofc_user_task",rtp, userId,orgId);
				return MsgVo.success(map);
			} catch (Exception e) {
				log.error("busi_code:8008新增失败Catch Exception:" + e.getMessage());
				return MsgVo.fail(ErrorCode.UNKNOW);
			}

		} catch (Exception e) {
			log.error("busi_code:8008新增失败Catch Exception:" + e.getMessage());
			return MsgVo.fail(ErrorCode.UNKNOW);
		}
	}
	
}
