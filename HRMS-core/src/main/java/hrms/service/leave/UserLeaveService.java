package hrms.service.leave;

import hrms.common.CommonParams;
import hrms.po.FindApproveParam;
import hrms.po.FindLeavesParam;
import hrms.po.UpApproveParam;
import hrms.vo.MsgVo;

/**
 * Created by 谢益文 on 2017/5/3.
 */
public interface UserLeaveService {

    public MsgVo upApprove(UpApproveParam param, CommonParams commonParams);

    public MsgVo findAllLeaves(FindLeavesParam param, CommonParams commonParams);

    public MsgVo findAllApproves(FindApproveParam param, CommonParams commonParams);

    public MsgVo findApproveDetail(Integer leaveId);

    public MsgVo passApprove(Integer leaveId, CommonParams commonParams);

    public MsgVo rejectApprove(Integer leaveId, CommonParams commonParams);
}
