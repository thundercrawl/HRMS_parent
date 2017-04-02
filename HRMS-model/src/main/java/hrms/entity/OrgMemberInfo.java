package hrms.entity;

import javax.persistence.*;
import java.io.Serializable;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * Created by 谢益文 on 2017/3/14.
 */
@Entity
@Table(name = "org_member_info")
public class OrgMemberInfo implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer orgMemberId;
    private Integer userId;
    private Integer orgId;
    private Byte status;
    private Integer operId;
    private String joinTime;
    private String jobName;

    public OrgMemberInfo() {
    }

    public OrgMemberInfo(Integer orgMemberId, Integer userId, Integer orgId, Byte status, Integer operId, String joinTime, String jobName) {
        this.orgMemberId = orgMemberId;
        this.userId = userId;
        this.orgId = orgId;
        this.status = status;
        this.operId = operId;
        this.joinTime = joinTime;
        this.jobName = jobName;
    }

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "ORG_MEMBER_ID", unique = true, nullable = false)
    public Integer getOrgMemberId() {
        return orgMemberId;
    }

    public void setOrgMemberId(Integer orgMemberId) {
        this.orgMemberId = orgMemberId;
    }

    @Column(name = "USER_ID", length = 10)
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    @Column(name = "ORG_ID", length = 10)
    public Integer getOrgId() {
        return orgId;
    }

    public void setOrgId(Integer orgId) {
        this.orgId = orgId;
    }

    @Column(name = "STATUS", length = 1)
    public Byte getStatus() {
        return status;
    }

    public void setStatus(Byte status) {
        this.status = status;
    }

    @Column(name = "OPER_ID", length = 10)
    public Integer getOperId() {
        return operId;
    }

    public void setOperId(Integer operId) {
        this.operId = operId;
    }

    @Column(name = "JOIN_TIME", length = 20)
    public String getJoinTime() {
        return joinTime;
    }

    public void setJoinTime(String joinTime) {
        this.joinTime = joinTime;
    }

    @Column(name = "JOB_NAME", length = 20)
    public String getJobName() {
        return jobName;
    }

    public void setJobName(String jobName) {
        this.jobName = jobName;
    }

    @Override
    public String toString() {
        return "OrgMemberDetail{" +
                "orgMemberId=" + orgMemberId +
                ", userId=" + userId +
                ", orgId=" + orgId +
                ", status=" + status +
                ", operId=" + operId +
                ", joinTime='" + joinTime + '\'' +
                ", jobName='" + jobName + '\'' +
                '}';
    }
}