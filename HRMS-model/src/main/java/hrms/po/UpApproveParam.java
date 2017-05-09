package hrms.po;

import java.io.Serializable;

/**
 * Created by 谢益文 on 2017/5/3.
 */
public class UpApproveParam implements Serializable{
    private Byte leaveType;
    private String startTime;
    private String endTime;
    private String leaveContent;

    public Byte getLeaveType() {
        return leaveType;
    }

    public void setLeaveType(Byte leaveType) {
        this.leaveType = leaveType;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getLeaveContent() {
        return leaveContent;
    }

    public void setLeaveContent(String leaveContent) {
        this.leaveContent = leaveContent;
    }
}
