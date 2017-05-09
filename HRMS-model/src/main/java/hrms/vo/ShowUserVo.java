package hrms.vo;

import hrms.model.OrgBaseInfo;
import hrms.model.RoleBaseInfo;

import java.util.List;

/**
 * Created by 谢益文 on 2017/4/2.
 */
public class ShowUserVo {
    private List<UserDetail> userInfos;
    private List<OrgBaseInfo> orgInfos;
    private List<RoleBaseInfo> roleInfos;

    public List<OrgBaseInfo> getOrgInfos() {
        return orgInfos;
    }

    public void setOrgInfos(List<OrgBaseInfo> orgInfos) {
        this.orgInfos = orgInfos;
    }

    public List<RoleBaseInfo> getRoleInfos() {
        return roleInfos;
    }

    public void setRoleInfos(List<RoleBaseInfo> roleInfos) {
        this.roleInfos = roleInfos;
    }

    public List<UserDetail> getUserInfos() {
        return userInfos;
    }

    public void setUserInfos(List<UserDetail> userInfos) {
        this.userInfos = userInfos;
    }
}
