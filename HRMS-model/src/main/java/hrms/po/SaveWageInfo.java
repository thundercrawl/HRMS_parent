package hrms.po;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * Created by 谢益文 on 2017/5/5.
 */
public class SaveWageInfo implements Serializable {

    private Integer userId;
    private String userPhone;
    private BigDecimal baseWage;
    private BigDecimal subsidyPhone;
    private BigDecimal subsidyOther;
    private String subsidyOtherDesc;

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public BigDecimal getBaseWage() {
        return baseWage;
    }

    public void setBaseWage(BigDecimal baseWage) {
        this.baseWage = baseWage;
    }

    public BigDecimal getSubsidyPhone() {
        return subsidyPhone;
    }

    public void setSubsidyPhone(BigDecimal subsidyPhone) {
        this.subsidyPhone = subsidyPhone;
    }

    public BigDecimal getSubsidyOther() {
        return subsidyOther;
    }

    public void setSubsidyOther(BigDecimal subsidyOther) {
        this.subsidyOther = subsidyOther;
    }

    public String getSubsidyOtherDesc() {
        return subsidyOtherDesc;
    }

    public void setSubsidyOtherDesc(String subsidyOtherDesc) {
        this.subsidyOtherDesc = subsidyOtherDesc;
    }
}
