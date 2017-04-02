package hrms.entity;

import javax.persistence.*;

import java.io.Serializable;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * Created by 谢益文 on 2017/3/14.
 */
@Entity
@Table(name = "user_role_info")
public class UserRoleInfo implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer userRoleId;
    private Integer userId;
    private Integer roleId;
    private Integer createUserId;
    private String createTime;
    private Byte status;


    public UserRoleInfo(){}

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "USER_ROLE_ID", unique = true, nullable = false)
    public Integer getUserRoleId() {
        return userRoleId;
    }

    public void setUserRoleId(Integer userRoleId) {
        this.userRoleId = userRoleId;
    }

    @Column(name = "USER_ID", length = 10)
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    @Column(name = "ROLE_ID", length = 4)
    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
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

    @Column(name = "STATUS", length = 1)
    public Byte getStatus() {
        return status;
    }

    public void setStatus(Byte status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "UserRoleInfo{" +
                "userRoleId=" + userRoleId +
                ", userId=" + userId +
                ", roleId=" + roleId +
                ", createUserId=" + createUserId +
                ", createTime='" + createTime + '\'' +
                '}';
    }
}

