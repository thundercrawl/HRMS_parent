package hrms.po;

import java.io.Serializable;

/**
 * Created by 谢益文 on 2017/4/25.
 */
public class AddOrgMember implements Serializable{

    private Integer orgId;
    private Integer userId;
    private String jobName;
    private Byte isManager;

    public Byte getIsManager() {
        return isManager;
    }

    public void setIsManager(Byte isManager) {
        this.isManager = isManager;
    }

    public Integer getOrgId() {
        return orgId;
    }

    public void setOrgId(Integer orgId) {
        this.orgId = orgId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getJobName() {
        return jobName;
    }

    public void setJobName(String jobName) {
        this.jobName = jobName;
    }
}
