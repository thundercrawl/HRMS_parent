package hrms.po;

import java.io.Serializable;

/**
 * Created by 谢益文 on 2017/4/19.
 */
public class DeleteFromOrg implements Serializable{
    private Integer orgID;
    private Integer userID;

    public Integer getOrgID() {
        return orgID;
    }

    public void setOrgID(Integer orgID) {
        this.orgID = orgID;
    }

    public Integer getUserID() {
        return userID;
    }

    public void setUserID(Integer userID) {
        this.userID = userID;
    }

    @Override
    public String toString() {
        return "DeleteFromOrg{" +
                "orgID=" + orgID +
                ", userID=" + userID +
                '}';
    }
}
