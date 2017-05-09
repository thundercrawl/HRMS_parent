package hrms.po;

import java.io.Serializable;

/**
 * Created by 谢益文 on 2017/4/25.
 */
public class ChangeUserStatusParam implements Serializable{

    private Integer userID;
    private String workStatus;
    private String userStatus;

    public Integer getUserID() {
        return userID;
    }

    public void setUserID(Integer userID) {
        this.userID = userID;
    }

    public String getWorkStatus() {
        return workStatus;
    }

    public void setWorkStatus(String workStatus) {
        this.workStatus = workStatus;
    }

    public String getUserStatus() {
        return userStatus;
    }

    public void setUserStatus(String userStatus) {
        this.userStatus = userStatus;
    }
}
