package hrms.vo;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * Created by 谢益文 on 2017/5/6.
 */
public class BillDetail implements Serializable{
    private Integer userId;
    private String userName;
    private String userPhone;
    private String orgName;
    private String jobName;

    private Integer billId;
    private String billDate;
    private BigDecimal baseWage;
    private BigDecimal subsidy;
    private BigDecimal subsidyIns;
    private BigDecimal leaveDeduction;
    private BigDecimal businessSubsidy;
    private BigDecimal signDeduction;
    private BigDecimal subBill;

    public Integer getBillId() {
        return billId;
    }

    public void setBillId(Integer billId) {
        this.billId = billId;
    }

    public String getBillDate() {
        return billDate;
    }

    public void setBillDate(String billDate) {
        this.billDate = billDate;
    }

    public BigDecimal getBaseWage() {
        return baseWage;
    }

    public void setBaseWage(BigDecimal baseWage) {
        this.baseWage = baseWage;
    }

    public BigDecimal getSubsidy() {
        return subsidy;
    }

    public void setSubsidy(BigDecimal subsidy) {
        this.subsidy = subsidy;
    }

    public BigDecimal getSubsidyIns() {
        return subsidyIns;
    }

    public void setSubsidyIns(BigDecimal subsidyIns) {
        this.subsidyIns = subsidyIns;
    }

    public BigDecimal getLeaveDeduction() {
        return leaveDeduction;
    }

    public void setLeaveDeduction(BigDecimal leaveDeduction) {
        this.leaveDeduction = leaveDeduction;
    }

    public BigDecimal getBusinessSubsidy() {
        return businessSubsidy;
    }

    public void setBusinessSubsidy(BigDecimal businessSubsidy) {
        this.businessSubsidy = businessSubsidy;
    }

    public BigDecimal getSignDeduction() {
        return signDeduction;
    }

    public void setSignDeduction(BigDecimal signDeduction) {
        this.signDeduction = signDeduction;
    }

    public BigDecimal getSubBill() {
        return subBill;
    }

    public void setSubBill(BigDecimal subBill) {
        this.subBill = subBill;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
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

    public String getJobName() {
        return jobName;
    }

    public void setJobName(String jobName) {
        this.jobName = jobName;
    }
}
