package hrms.entity;

import javax.persistence.*;
import java.io.Serializable;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * Created by 谢益文 on 2017/3/14.
 */
@Entity
@Table(name = "org_manager_info")
public class OrgManagerInfo implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer orgManagerId;
    private Integer userId;
    private Integer orgId;
    private Byte status;

    public OrgManagerInfo() {}

    public OrgManagerInfo(Integer orgManagerId, Integer userId, Integer orgId, Byte status) {
        this.orgManagerId = orgManagerId;
        this.userId = userId;
        this.orgId = orgId;
        this.status = status;
    }

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "ORG_MENAGER_ID", unique = true, nullable = false)
    public Integer getOrgManagerId() {
        return orgManagerId;
    }

    public void setOrgManagerId(Integer orgManagerId) {
        this.orgManagerId = orgManagerId;
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

    @Override
    public String toString() {
        return "OrgManagerInfo{" +
                "orgManagerId=" + orgManagerId +
                ", userId=" + userId +
                ", orgId=" + orgId +
                ", status=" + status +
                '}';
    }
}
