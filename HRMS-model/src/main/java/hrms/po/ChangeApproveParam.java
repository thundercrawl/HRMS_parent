package hrms.po;

import java.io.Serializable;

/**
 * Created by 谢益文 on 2017/5/4.
 */
public class ChangeApproveParam implements Serializable{
    private Integer leaveId;
    private Byte leaveStatus;

    public Integer getLeaveId() {
        return leaveId;
    }

    public void setLeaveId(Integer leaveId) {
        this.leaveId = leaveId;
    }

    public Byte getLeaveStatus() {
        return leaveStatus;
    }

    public void setLeaveStatus(Byte leaveStatus) {
        this.leaveStatus = leaveStatus;
    }
}
