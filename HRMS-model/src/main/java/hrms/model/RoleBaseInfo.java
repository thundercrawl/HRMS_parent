package hrms.model;

import java.io.Serializable;

/**
 * Created by 谢益文 on 2017/4/24.
 */
public class RoleBaseInfo implements Serializable{
    private String roleId;
    private String roleName;

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getRoleId() {

        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }
}
