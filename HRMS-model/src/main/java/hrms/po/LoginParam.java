package hrms.po;

/**
 * Created by 谢益文 on 2017/3/22.
 */
public class LoginParam {

    private String userPhone;
    private String userPasswd;

    public LoginParam(){}

    public LoginParam(String userPhone, String userPasswd) {
        this.userPhone = userPhone;
        this.userPasswd = userPasswd;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public String getUserPasswd() {
        return userPasswd;
    }

    public void setUserPasswd(String userPasswd) {
        this.userPasswd = userPasswd;
    }

    @Override
    public String toString() {
        return "LoginParam{" +
                "userPhone='" + userPhone + '\'' +
                ", userPasswd='" + userPasswd + '\'' +
                '}';
    }
}
