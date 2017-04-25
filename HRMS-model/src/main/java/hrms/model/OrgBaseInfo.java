package hrms.model;

import java.io.Serializable;

/**
 * Created by 谢益文 on 2017/4/24.
 */
public class OrgBaseInfo implements Serializable{
    private String orgId;
    private String orgName;

    public String getOrgId() {
        return orgId;
    }

    public void setOrgId(String orgId) {
        this.orgId = orgId;
    }

    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }
}
