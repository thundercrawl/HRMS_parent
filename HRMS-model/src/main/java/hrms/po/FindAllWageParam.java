package hrms.po;

import java.io.Serializable;

/**
 * Created by 谢益文 on 2017/5/5.
 */
public class FindAllWageParam implements Serializable{
    private String userId;
    private String userName;
    private String userPhone;
    private String orgName;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }
}
