package hrms.po;

import java.io.Serializable;

/**
 * Created by 谢益文 on 2017/4/25.
 */
public class FindOrgParam implements Serializable {
    private String orgId;
    private String parentOrgId;
    private String orgName;
    private String parentOrgName;

    public FindOrgParam() {
        orgId = "";
        parentOrgId = "";
        orgName = "";
        parentOrgName = "";
    }

    public FindOrgParam(String orgId, String parentOrgId, String orgName, String parentOrgName) {
        this.orgId = orgId;
        this.parentOrgId = parentOrgId;
        this.orgName = orgName;
        this.parentOrgName = parentOrgName;
    }

    public String getOrgId() {
        return orgId;
    }

    public void setOrgId(String orgId) {
        this.orgId = orgId;
    }

    public String getParentOrgId() {
        return parentOrgId;
    }

    public void setParentOrgId(String parentOrgId) {
        this.parentOrgId = parentOrgId;
    }

    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    public String getParentOrgName() {
        return parentOrgName;
    }

    public void setParentOrgName(String parentOrgName) {
        this.parentOrgName = parentOrgName;
    }
}
