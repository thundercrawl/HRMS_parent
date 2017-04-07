package hrms.po;

/**
 * Created by 谢益文 on 2017/4/5.
 */
public class SaveOrgParam {
    private Integer parentOrgId;
    private String orgName;
    private String desc;

    public Integer getParentOrgId() {
        return parentOrgId;
    }

    public void setParentOrgId(Integer parentOrgId) {
        this.parentOrgId = parentOrgId;
    }

    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    public String getDesc() {
        return desc;
    }
}
