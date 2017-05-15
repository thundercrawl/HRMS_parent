package hrms.vo;

import java.io.Serializable;

/**
 * Created by 谢益文 on 2017/5/7.
 */
public class BillCountDetail implements Serializable{
    private String baseWage;
    private String subsidy;
    private String subsidyIns;
    private String leaveDeduction;
    private String businessSubsidy;
    private String signDeduction;
    private String subBill;
    private Byte hasBill;

    public BillCountDetail() {
        baseWage = "0";
        subsidy = "0";
        subsidyIns = "0";
        leaveDeduction = "0";
        businessSubsidy = "0";
        signDeduction = "0";
        subBill = "0";
        hasBill = 0;
    }

    public String getSubBill() {
        return subBill;
    }

    public void setSubBill(String subBill) {
        this.subBill = subBill;
    }

    public String getBaseWage() {
        return baseWage;
    }

    public void setBaseWage(String baseWage) {
        this.baseWage = baseWage;
    }

    public String getSubsidyIns() {
        return subsidyIns;
    }

    public void setSubsidyIns(String subsidyIns) {
        this.subsidyIns = subsidyIns;
    }

    public String getSubsidy() {
        return subsidy;
    }

    public void setSubsidy(String subsidy) {
        this.subsidy = subsidy;
    }

    public String getLeaveDeduction() {
        return leaveDeduction;
    }

    public void setLeaveDeduction(String leaveDeduction) {
        this.leaveDeduction = leaveDeduction;
    }

    public String getBusinessSubsidy() {
        return businessSubsidy;
    }

    public void setBusinessSubsidy(String businessSubsidy) {
        this.businessSubsidy = businessSubsidy;
    }

    public String getSignDeduction() {
        return signDeduction;
    }

    public void setSignDeduction(String signDeduction) {
        this.signDeduction = signDeduction;
    }

    public Byte getHasBill() {
        return hasBill;
    }

    public void setHasBill(Byte hasBill) {
        this.hasBill = hasBill;
    }

    @Override
    public String toString() {
        return "BillCountDetail{" +
                "baseWage=" + baseWage +
                ", subsidy=" + subsidy +
                ", subsidyIns=" + subsidyIns +
                ", leaveDeduction=" + leaveDeduction +
                ", businessSubsidy=" + businessSubsidy +
                ", signDeduction=" + signDeduction +
                ", subBill=" + subBill +
                ", hasBill=" + hasBill +
                '}';
    }
}
