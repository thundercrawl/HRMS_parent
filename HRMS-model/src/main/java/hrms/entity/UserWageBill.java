package hrms.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.math.BigDecimal;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * Created by 谢益文 on 2017/5/5.
 */
@Entity
@Table(name = "user_wage_bill")
public class UserWageBill implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer billId;
    private Integer userId;
    private String billDate;
    private BigDecimal baseWage;
    private BigDecimal subsidy;
    private BigDecimal subsidyIns;
    private BigDecimal leaveDeduction;
    private BigDecimal businessSubsidy;
    private BigDecimal signDeduction;
    private BigDecimal subBill;

    public UserWageBill() {
    }

    public UserWageBill(Integer billId, Integer userId, String billDate, BigDecimal baseWage, BigDecimal subsidy, BigDecimal subsidyIns, BigDecimal leaveDeduction, BigDecimal businessSubsidy, BigDecimal signDeduction, BigDecimal subBill) {
        this.billId = billId;
        this.userId = userId;
        this.billDate = billDate;
        this.baseWage = baseWage;
        this.subsidy = subsidy;
        this.subsidyIns = subsidyIns;
        this.leaveDeduction = leaveDeduction;
        this.businessSubsidy = businessSubsidy;
        this.signDeduction = signDeduction;
        this.subBill = subBill;
    }

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "BILL_ID", unique = true, nullable = false)
    public Integer getBillId() {
        return billId;
    }

    public void setBillId(Integer billId) {
        this.billId = billId;
    }

    @Column(name = "USER_ID", length = 10)
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }
    @Column(name = "BILL_DATE", length = 7)
    public String getBillDate() {
        return billDate;
    }

    public void setBillDate(String billDate) {
        this.billDate = billDate;
    }
    @Column(name = "BASE_WAGE", precision = 12)
    public BigDecimal getBaseWage() {
        return baseWage;
    }

    public void setBaseWage(BigDecimal baseWage) {
        this.baseWage = baseWage;
    }

    @Column(name = "SUBSIDY", precision = 12)
    public BigDecimal getSubsidy() {
        return subsidy;
    }

    public void setSubsidy(BigDecimal subsidy) {
        this.subsidy = subsidy;
    }


    @Column(name = "SUBSIDY_INS", precision = 12)
    public BigDecimal getSubsidyIns() {
        return subsidyIns;
    }

    public void setSubsidyIns(BigDecimal subsidyIns) {
        this.subsidyIns = subsidyIns;
    }

    @Column(name = "LEAVE_DEDUCTION", precision = 12)
    public BigDecimal getLeaveDeduction() {
        return leaveDeduction;
    }

    public void setLeaveDeduction(BigDecimal leaveDeduction) {
        this.leaveDeduction = leaveDeduction;
    }
    @Column(name = "BUSINESS_SUBSIDY", precision = 12)
    public BigDecimal getBusinessSubsidy() {
        return businessSubsidy;
    }

    public void setBusinessSubsidy(BigDecimal businessSubsidy) {
        this.businessSubsidy = businessSubsidy;
    }
    @Column(name = "SIGN_DEDUCTION", precision = 12)
    public BigDecimal getSignDeduction() {
        return signDeduction;
    }

    public void setSignDeduction(BigDecimal signDeduction) {
        this.signDeduction = signDeduction;
    }

    @Column(name = "SUB_BILL", precision = 12)
    public BigDecimal getSubBill() {
        return subBill;
    }

    public void setSubBill(BigDecimal subBill) {
        this.subBill = subBill;
    }

    @Override
    public String toString() {
        return "UserWageBill{" +
                "billId=" + billId +
                ", userId=" + userId +
                ", billDate='" + billDate + '\'' +
                ", baseWage=" + baseWage +
                ", subsidy=" + subsidy +
                ", subsidyIns=" + subsidyIns +
                ", leaveDeduction=" + leaveDeduction +
                ", businessSubsidy=" + businessSubsidy +
                ", signDeduction=" + signDeduction +
                ", subBill=" + subBill +
                '}';
    }
}





