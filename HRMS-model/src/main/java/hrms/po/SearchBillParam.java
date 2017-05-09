package hrms.po;

import java.io.Serializable;

/**
 * Created by 谢益文 on 2017/5/6.
 */
public class SearchBillParam implements Serializable{
    private String userName;
    private String userPhone;
    private String orgName;
    private String date;
    private Byte isFinance;

    public Byte getIsFinance() {
        return isFinance;
    }

    public void setIsFinance(Byte isFinance) {
        this.isFinance = isFinance;
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

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
}
