package hrms.vo;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * Created by 谢益文 on 2017/5/5.
 */
public class WageDetail implements Serializable{
    private String userName;
    private String orgName;
    private String userPhone;

    private Integer wageId;
    private Integer userId;
    private BigDecimal baseWage;
    private BigDecimal subsidyPhone;
    private BigDecimal subsidyIns;
    private BigDecimal subsidyOther;
    private String subsidyOtherDesc;
    private String createTime;
    private String createUserName;

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    public Integer getWageId() {
        return wageId;
    }

    public void setWageId(Integer wageId) {
        this.wageId = wageId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
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

    public BigDecimal getSubsidyIns() {
        return subsidyIns;
    }

    public void setSubsidyIns(BigDecimal subsidyIns) {
        this.subsidyIns = subsidyIns;
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

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getCreateUserName() {
        return createUserName;
    }

    public void setCreateUserName(String createUserName) {
        this.createUserName = createUserName;
    }
}
