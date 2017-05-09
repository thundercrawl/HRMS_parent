package hrms.vo;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * Created by 谢益文 on 2017/5/7.
 */
public class BillCountDetail implements Serializable{
    private BigDecimal baseWage;
    private BigDecimal subsidy;
    private BigDecimal subsidyIns;
    private BigDecimal leaveDeduction;
    private BigDecimal businessSubsidy;
    private BigDecimal signSubsidy;
    private BigDecimal subBill;
    private Byte hasBill;

    public BigDecimal getSubBill() {
        return subBill;
    }

    public void setSubBill(BigDecimal subBill) {
        this.subBill = subBill;
    }

    public BigDecimal getBaseWage() {
        return baseWage;
    }

    public void setBaseWage(BigDecimal baseWage) {
        this.baseWage = baseWage;
    }

    public BigDecimal getSubsidyIns() {
        return subsidyIns;
    }

    public void setSubsidyIns(BigDecimal subsidyIns) {
        this.subsidyIns = subsidyIns;
    }

    public BigDecimal getSubsidy() {
        return subsidy;
    }

    public void setSubsidy(BigDecimal subsidy) {
        this.subsidy = subsidy;
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

    public BigDecimal getSignSubsidy() {
        return signSubsidy;
    }

    public void setSignSubsidy(BigDecimal signSubsidy) {
        this.signSubsidy = signSubsidy;
    }

    public Byte getHasBill() {
        return hasBill;
    }

    public void setHasBill(Byte hasBill) {
        this.hasBill = hasBill;
    }
}
