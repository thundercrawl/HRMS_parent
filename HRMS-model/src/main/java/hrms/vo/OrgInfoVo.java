package hrms.vo;

/**
 * Created by 谢益文 on 2017/4/25.
 */
public class OrgInfoVo {
    private Integer orgId;
    private String orgName;
    private String orgManagerName;
    private String createTime;
    private String createUserName;
    private Integer parentOrgId;
    private String parentOrgName;
    private String orgDesc;
    private Byte hasRole;


    public OrgInfoVo() {
        hasRole = 0;
    }

    public Byte getHasRole() {
        return hasRole;
    }

    public void setHasRole(Byte hasRole) {
        this.hasRole = hasRole;
    }

    public String getOrgManagerName() {
        return orgManagerName;
    }

    public void setOrgManagerName(String orgManagerName) {
        this.orgManagerName = orgManagerName;
    }

    public String getOrgDesc() {
        return orgDesc;
    }

    public void setOrgDesc(String orgDesc) {
        this.orgDesc = orgDesc;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public Integer getOrgId() {
        return orgId;
    }

    public void setOrgId(Integer orgId) {
        this.orgId = orgId;
    }

    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    public String getCreateUserName() {
        return createUserName;
    }

    public void setCreateUserName(String createUserName) {
        this.createUserName = createUserName;
    }

    public Integer getParentOrgId() {
        return parentOrgId;
    }

    public void setParentOrgId(Integer parentOrgId) {
        this.parentOrgId = parentOrgId;
    }

    public String getParentOrgName() {
        return parentOrgName;
    }

    public void setParentOrgName(String parentOrgName) {
        this.parentOrgName = parentOrgName;
    }
}
