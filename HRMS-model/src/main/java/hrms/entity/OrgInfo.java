package hrms.entity;

import javax.persistence.*;
import java.io.Serializable;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * Created by 谢益文 on 2017/3/14.
 */
@Entity
@Table(name = "org_info")
public class OrgInfo implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer orgId;
    private Integer parentOrgId;
    private String orgName;
    private String createTime;
    private Integer createUserId;
    private Byte orgStatus;
    private String desc;

    public OrgInfo(){}

    public OrgInfo(Integer orgId, Integer parentOrgId, String orgName, String createTime, Integer createUserId, Byte orgStatus, String desc) {
        this.orgId = orgId;
        this.parentOrgId = parentOrgId;
        this.orgName = orgName;
        this.createTime = createTime;
        this.createUserId = createUserId;
        this.orgStatus = orgStatus;
        this.desc = desc;
    }

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "ORG_ID", unique = true, nullable = false)
    public Integer getOrgId() {
        return orgId;
    }

    public void setOrgId(Integer orgId) {
        this.orgId = orgId;
    }

    @Column(name = "PARENT_ORG_ID", length = 10)
    public Integer getParentOrgId() {
        return parentOrgId;
    }

    public void setParentOrgId(Integer parentOrgId) {
        this.parentOrgId = parentOrgId;
    }

    @Column(name = "ORG_NAME", length = 20)
    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    @Column(name = "CREATE_TIME", length = 20)
    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    @Column(name = "CREATE_USER_ID", length = 20)
    public Integer getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Integer createUserId) {
        this.createUserId = createUserId;
    }

    @Column(name = "ORG_STATUS", length = 1)
    public Byte getOrgStatus() {
        return orgStatus;
    }

    public void setOrgStatus(Byte orgStatus) {
        this.orgStatus = orgStatus;
    }

    @Column(name = "ORG_DESC", length = 255)
    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    @Override
    public String toString() {
        return "OrgInfo{" +
                "orgId=" + orgId +
                ", parentOrgId=" + parentOrgId +
                ", orgName='" + orgName + '\'' +
                ", createTime='" + createTime + '\'' +
                ", createUserId=" + createUserId +
                ", orgStatus=" + orgStatus +
                ", desc='" + desc + '\'' +
                '}';
    }
}
