package hrms.po;

import java.io.Serializable;

/**
 * Created by 谢益文 on 2017/5/2.
 */
public class SaveSignInfo implements Serializable{
    private String userPhone;
    private String date;
    private Byte signInStatus;
    private String signInTime;
    private Byte signOutStatus;
    private String signOutTime;

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public Byte getSignInStatus() {
        return signInStatus;
    }

    public void setSignInStatus(Byte signInStatus) {
        this.signInStatus = signInStatus;
    }

    public String getSignInTime() {
        return signInTime;
    }

    public void setSignInTime(String signInTime) {
        this.signInTime = signInTime;
    }

    public Byte getSignOutStatus() {
        return signOutStatus;
    }

    public void setSignOutStatus(Byte signOutStatus) {
        this.signOutStatus = signOutStatus;
    }

    public String getSignOutTime() {
        return signOutTime;
    }

    public void setSignOutTime(String signOutTime) {
        this.signOutTime = signOutTime;
    }
}
