package hrms.po;

import java.io.Serializable;

/**
 * Created by 谢益文 on 2017/5/3.
 */
public class FindLeavesParam implements Serializable{
    private String leaveCode;
    private Byte leaveType;
    private Byte leaveStatus;

    public Byte getLeaveStatus() {
        return leaveStatus;
    }

    public void setLeaveStatus(Byte leaveStatus) {
        this.leaveStatus = leaveStatus;
    }

    public Byte getLeaveType() {
        return leaveType;
    }

    public void setLeaveType(Byte leaveType) {
        this.leaveType = leaveType;
    }

    public String getLeaveCode() {
        return leaveCode;
    }

    public void setLeaveCode(String leaveCode) {
        this.leaveCode = leaveCode;
    }
}
