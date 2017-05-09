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
@Table(name = "user_wage_info")
public class UserWageInfo implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer wageId;
    private Integer userId;
    private BigDecimal baseWage;
    private BigDecimal subsidyPhone;
    private BigDecimal subsidyIns;
    private BigDecimal subsidyOther;
    private String subsidyOtherDesc;
    private String createTime;
    private Integer createUserId;

    public UserWageInfo() {
    }

    public UserWageInfo(Integer wageId, Integer userId, BigDecimal baseWage, BigDecimal subsidyPhone, BigDecimal subsidyIns, BigDecimal subsidyOther, String subsidyOtherDesc, String createTime, Integer createUserId) {
        this.wageId = wageId;
        this.userId = userId;
        this.baseWage = baseWage;
        this.subsidyPhone = subsidyPhone;
        this.subsidyIns = subsidyIns;
        this.subsidyOther = subsidyOther;
        this.subsidyOtherDesc = subsidyOtherDesc;
        this.createTime = createTime;
        this.createUserId = createUserId;
    }

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "WAGE_ID", unique = true, nullable = false)
    public Integer getWageId() {
        return wageId;
    }

    public void setWageId(Integer wageId) {
        this.wageId = wageId;
    }

    @Column(name = "BASE_WAGE", precision = 12)
    public BigDecimal getBaseWage() {
        return baseWage;
    }

    public void setBaseWage(BigDecimal baseWage) {
        this.baseWage = baseWage;
    }

    @Column(name = "SUBSIDY_PHONE", precision = 12)
    public BigDecimal getSubsidyPhone() {
        return subsidyPhone;
    }

    public void setSubsidyPhone(BigDecimal subsidyPhone) {
        this.subsidyPhone = subsidyPhone;
    }

    @Column(name = "SUBSIDY_INS", precision = 12)
    public BigDecimal getSubsidyIns() {
        return subsidyIns;
    }

    public void setSubsidyIns(BigDecimal subsidyIns) {
        this.subsidyIns = subsidyIns;
    }

    @Column(name = "SUBSIDY_OTHER", precision = 12)
    public BigDecimal getSubsidyOther() {
        return subsidyOther;
    }

    public void setSubsidyOther(BigDecimal subsidyOther) {
        this.subsidyOther = subsidyOther;
    }

    @Column(name = "SUBSIDY_OTHER_DESC", length = 1024)
    public String getSubsidyOtherDesc() {
        return subsidyOtherDesc;
    }

    public void setSubsidyOtherDesc(String subsidyOtherDesc) {
        this.subsidyOtherDesc = subsidyOtherDesc;
    }

    @Column(name = "CREATE_TIME", length = 20)
    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    @Column(name = "CREATE_USER_ID", length = 10)
    public Integer getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Integer createUserId) {
        this.createUserId = createUserId;
    }

    @Column(name = "USER_ID", length = 10)
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    @Override
    public String toString() {
        return "UserWageInfo{" +
                "wageId=" + wageId +
                ", userId=" + userId +
                ", baseWage=" + baseWage +
                ", subsidyPhone=" + subsidyPhone +
                ", subsidyIns=" + subsidyIns +
                ", subsidyOther=" + subsidyOther +
                ", subsidyOtherDesc=" + subsidyOtherDesc +
                ", createTime='" + createTime + '\'' +
                ", createUserId=" + createUserId +
                '}';
    }
}





