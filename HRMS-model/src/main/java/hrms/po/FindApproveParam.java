package hrms.po;

import java.io.Serializable;

/**
 * Created by 谢益文 on 2017/5/4.
 */
public class FindApproveParam implements Serializable{
    private String leaveCode;
    private Integer leaveId;

    public Integer getLeaveId() {
        return leaveId;
    }

    public void setLeaveId(Integer leaveId) {
        this.leaveId = leaveId;
    }

    public String getLeaveCode() {
        return leaveCode;
    }

    public void setLeaveCode(String leaveCode) {
        this.leaveCode = leaveCode;
    }
}
