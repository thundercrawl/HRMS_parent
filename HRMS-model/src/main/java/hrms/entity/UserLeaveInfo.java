package hrms.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * Created by 谢益文 on 2017/5/2.
 */
@Entity
@Table(name = "user_leave_info")
public class UserLeaveInfo {
    private Integer leaveId;
    private Integer userId;
    private Byte leaveType;
    private String startTime;
    private String endTime;
    private Integer approveUserId;
    private String upTime;
    private String approveTime;
    private Byte leaveStatus;
    private String leaveContent;
    private String leaveCode;


    public UserLeaveInfo() {

    }

    public UserLeaveInfo(Integer leaveId, Integer userId, Byte leaveType, String startTime, String endTime, Integer approveUserId, String upTime, String approveTime, Byte leaveStatus, String leaveContent, String leaveCode) {
        this.leaveId = leaveId;
        this.userId = userId;
        this.leaveType = leaveType;
        this.startTime = startTime;
        this.endTime = endTime;
        this.approveUserId = approveUserId;
        this.upTime = upTime;
        this.approveTime = approveTime;
        this.leaveStatus = leaveStatus;
        this.leaveContent = leaveContent;
        this.leaveCode = leaveCode;
    }

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "LEAVE_ID", unique = true, nullable = false)
    public Integer getLeaveId() {
        return leaveId;
    }

    public void setLeaveId(Integer leaveId) {
        this.leaveId = leaveId;
    }
    @Column(name = "USER_ID", length = 10)
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }
    @Column(name = "LEAVE_TYPE", length = 1)
    public Byte getLeaveType() {
        return leaveType;
    }

    public void setLeaveType(Byte leaveType) {
        this.leaveType = leaveType;
    }
    @Column(name = "START_TIME", length = 20)
    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }
    @Column(name = "END_TIME", length = 20)
    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }
    @Column(name = "APPROVE_USER_ID", length = 10)
    public Integer getApproveUserId() {
        return approveUserId;
    }

    public void setApproveUserId(Integer approveUserId) {
        this.approveUserId = approveUserId;
    }
    @Column(name = "UP_TIME", length = 20)
    public String getUpTime() {
        return upTime;
    }

    public void setUpTime(String upTime) {
        this.upTime = upTime;
    }
    @Column(name = "APPROVE_TIME", length = 20)
    public String getApproveTime() {
        return approveTime;
    }

    public void setApproveTime(String approveTime) {
        this.approveTime = approveTime;
    }
    @Column(name = "LEAVE_STATUS", length = 1)
    public Byte getLeaveStatus() {
        return leaveStatus;
    }

    public void setLeaveStatus(Byte leaveStatus) {
        this.leaveStatus = leaveStatus;
    }
    @Column(name = "LEAVE_CONTENT", length = 256)
    public String getLeaveContent() {
        return leaveContent;
    }

    public void setLeaveContent(String leaveContent) {
        this.leaveContent = leaveContent;
    }

    @Column(name = "LEAVE_CODE", length = 16)
    public String getLeaveCode() {
        return leaveCode;
    }

    public void setLeaveCode(String leaveCode) {
        this.leaveCode = leaveCode;
    }

    @Override
    public String toString() {
        return "UserLeaveInfo{" +
                "leaveId=" + leaveId +
                ", userId=" + userId +
                ", leaveType=" + leaveType +
                ", startTime='" + startTime + '\'' +
                ", endTime='" + endTime + '\'' +
                ", approveUserId=" + approveUserId +
                ", upTime='" + upTime + '\'' +
                ", approveTime='" + approveTime + '\'' +
                ", leaveStatus=" + leaveStatus +
                ", leaveContent='" + leaveContent + '\'' +
                ", leaveCode='" + leaveCode + '\'' +
                '}';
    }
}
