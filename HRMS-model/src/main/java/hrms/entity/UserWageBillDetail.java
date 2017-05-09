package hrms.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.math.BigDecimal;

/**
 * Created by 谢益文 on 2017/5/5.
 */
@Entity
@Table(name = "user_wage_bill_detail")
public class UserWageBillDetail implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer billId;
    private Integer signLaterCount;
    private Integer signEarlyCount;
    private Integer signNoDays;
    private Integer leaveDays;
    private Integer businessDays;
    private BigDecimal signDeduction;
    private BigDecimal leaveDeduction;
    private BigDecimal businessSubsidy;
    private BigDecimal oldIns;
    private BigDecimal medicalIns;
    private BigDecimal unWorkIns;
    private BigDecimal injuryIns;
    private BigDecimal maternityIns;
    private BigDecimal houseIns;

    private Integer signNormalDays;

    public UserWageBillDetail() {
        signLaterCount =0;
        signEarlyCount =0;
        signNoDays     =0;
        leaveDays      =0;
        businessDays   =0;
        signNormalDays = 0;
        signDeduction  = new BigDecimal(0);
        leaveDeduction= new BigDecimal(0);
        businessSubsidy= new BigDecimal(0);
        oldIns		= new BigDecimal(0);
        medicalIns = new BigDecimal(0);
        unWorkIns	= new BigDecimal(0);
        injuryIns	= new BigDecimal(0);
        maternityIns= new BigDecimal(0);
        houseIns   	= new BigDecimal(0);
    }

    public UserWageBillDetail(Integer signNormalDays,Integer billId, Integer signLaterCount, Integer signEarlyCount, Integer signNoDays, Integer leaveDays, Integer businessDays, BigDecimal signDeduction, BigDecimal leaveDeduction, BigDecimal businessSubsidy, BigDecimal oldIns, BigDecimal medicalIns, BigDecimal unWorkIns, BigDecimal injuryIns, BigDecimal maternityIns, BigDecimal houseIns) {
        this.billId = billId;
        this.signLaterCount = signLaterCount;
        this.signEarlyCount = signEarlyCount;
        this.signNoDays = signNoDays;
        this.leaveDays = leaveDays;
        this.businessDays = businessDays;
        this.signDeduction = signDeduction;
        this.leaveDeduction = leaveDeduction;
        this.businessSubsidy = businessSubsidy;
        this.oldIns = oldIns;
        this.medicalIns = medicalIns;
        this.unWorkIns = unWorkIns;
        this.injuryIns = injuryIns;
        this.maternityIns = maternityIns;
        this.houseIns = houseIns;
        this.signNormalDays = signNormalDays;
    }

    @Id
    @Column(name = "BILL_ID", unique = true, nullable = false)
    public Integer getBillId() {
        return billId;
    }

    public void setBillId(Integer billId) {
        this.billId = billId;
    }

    @Column(name = "SIGN_DEDUCTION", precision = 12)
    public BigDecimal getSignDeduction() {
        return signDeduction;
    }

    public void setSignDeduction(BigDecimal signDeduction) {
        this.signDeduction = signDeduction;
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

    @Column(name = "SIGN_LATER_COUNT", length = 3)
    public Integer getSignLaterCount() {
        return signLaterCount;
    }

    public void setSignLaterCount(Integer signLaterCount) {
        this.signLaterCount = signLaterCount;
    }

    @Column(name = "SIGN_EARLY_COUNT", length = 3)
    public Integer getSignEarlyCount() {
        return signEarlyCount;
    }

    public void setSignEarlyCount(Integer signEarlyCount) {
        this.signEarlyCount = signEarlyCount;
    }

    @Column(name = "SIGN_NO_DAYS", length = 2)
    public Integer getSignNoDays() {
        return signNoDays;
    }

    public void setSignNoDays(Integer signNoDays) {
        this.signNoDays = signNoDays;
    }

    @Column(name = "LEAVE_DAYS", length = 2)
    public Integer getLeaveDays() {
        return leaveDays;
    }

    public void setLeaveDays(Integer leaveDays) {
        this.leaveDays = leaveDays;
    }

    @Column(name = "BUSINESS_DAYS", length = 2)
    public Integer getBusinessDays() {
        return businessDays;
    }

    public void setBusinessDays(Integer businessDays) {
        this.businessDays = businessDays;
    }

    @Column(name = "OLD_INS", precision = 12)
    public BigDecimal getOldIns() {
        return oldIns;
    }

    public void setOldIns(BigDecimal oldIns) {
        this.oldIns = oldIns;
    }

    @Column(name = "MEDICAL_INS", precision = 12)
    public BigDecimal getMedicalIns() {
        return medicalIns;
    }

    public void setMedicalIns(BigDecimal medicalIns) {
        this.medicalIns = medicalIns;
    }

    @Column(name = "UNWORK_INS", precision = 12)
    public BigDecimal getUnWorkIns() {
        return unWorkIns;
    }

    public void setUnWorkIns(BigDecimal unWorkIns) {
        this.unWorkIns = unWorkIns;
    }

    @Column(name = "INJURY_INS", precision = 12)
    public BigDecimal getInjuryIns() {
        return injuryIns;
    }

    public void setInjuryIns(BigDecimal injuryIns) {
        this.injuryIns = injuryIns;
    }

    @Column(name = "MATERNITY_INS", precision = 12)
    public BigDecimal getMaternityIns() {
        return maternityIns;
    }

    public void setMaternityIns(BigDecimal maternityIns) {
        this.maternityIns = maternityIns;
    }

    @Column(name = "HOUSE_INS", precision = 12)
    public BigDecimal getHouseIns() {
        return houseIns;
    }

    public void setHouseIns(BigDecimal houseIns) {
        this.houseIns = houseIns;
    }

    @Column(name = "SIGN_NORMAL_DAYS", length = 2)
    public Integer getSignNormalDays() {
        return signNormalDays;
    }

    public void setSignNormalDays(Integer signNormalDays) {
        this.signNormalDays = signNormalDays;
    }

    @Override
    public String toString() {
        return "UserWageBillDetail{" +
                "billId=" + billId +
                ", signLaterCount=" + signLaterCount +
                ", signEarlyCount=" + signEarlyCount +
                ", signNoDays=" + signNoDays +
                ", leaveDays=" + leaveDays +
                ", businessDays=" + businessDays +
                ", signDeduction=" + signDeduction +
                ", leaveDeduction=" + leaveDeduction +
                ", businessSubsidy=" + businessSubsidy +
                ", oldIns=" + oldIns +
                ", medicalIns=" + medicalIns +
                ", unWorkIns=" + unWorkIns +
                ", injuryIns=" + injuryIns +
                ", maternityIns=" + maternityIns +
                ", houseIns=" + houseIns +
                ", signNormalDays=" + signNormalDays +
                '}';
    }
}





