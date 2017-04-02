package hrms.entity;

import javax.persistence.*;

import java.io.Serializable;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * Created by 谢益文 on 2017/3/14.
 */
@Entity
@Table(name = "role_info")
public class RoleInfo implements Serializable{
    private static final long serialVersionUID = 1L;

    private Integer roleId;
    private String roleName;
    private String roleDescribe;
    private Integer createUserId;
    private String createTime;

    public RoleInfo(){}

    public RoleInfo(Integer roleId, String roleName, String roleDescribe, Integer createUserId, String createTime) {
        this.roleId = roleId;
        this.roleName = roleName;
        this.roleDescribe = roleDescribe;
        this.createUserId = createUserId;
        this.createTime = createTime;
    }

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "ROLE_ID", unique = true, nullable = false)
    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    @Column(name = "ROLE_NAME", length = 50)
    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    @Column(name = "ROLE_DESCRIBE", length = 255)
    public String getRoleDescribe() {
        return roleDescribe;
    }

    public void setRoleDescribe(String roleDescribe) {
        this.roleDescribe = roleDescribe;
    }

    @Column(name = "CREATE_USER_ID", length = 10)
    public Integer getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Integer createUserId) {
        this.createUserId = createUserId;
    }

    @Column(name = "CREATE_TIME", length = 20)
    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    @Override
    public String toString() {
        return "RoleInfo{" +
                "roleId=" + roleId +
                ", roleName='" + roleName + '\'' +
                ", roleDescribe='" + roleDescribe + '\'' +
                ", createUserId=" + createUserId +
                ", createTime='" + createTime + '\'' +
                '}';
    }
}
