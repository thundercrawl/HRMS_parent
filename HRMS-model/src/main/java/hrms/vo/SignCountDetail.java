package hrms.vo;

import java.io.Serializable;

/**
 * Created by 谢益文 on 2017/5/7.
 */
public class SignCountDetail implements Serializable{
//    正常 迟到 早退  缺勤
    private Integer normalCount;
    private Integer laterCount;
    private Integer earlyCount;
    private Integer noSignCount;
    private Integer leaveCount;
    private Integer businessCount;

    private Byte hasBill;

    public SignCountDetail() {
        normalCount = 0;
        laterCount = 0;
        earlyCount = 0;
        noSignCount = 0;
        hasBill = 0;
        leaveCount = 0;
        businessCount = 0;
    }

    public Integer getLeaveCount() {
        return leaveCount;
    }

    public void setLeaveCount(Integer leaveCount) {
        this.leaveCount = leaveCount;
    }

    public Integer getBusinessCount() {
        return businessCount;
    }

    public void setBusinessCount(Integer businessCount) {
        this.businessCount = businessCount;
    }

    public Byte getHasBill() {
        return hasBill;
    }

    public void setHasBill(Byte hasBill) {
        this.hasBill = hasBill;
    }

    public Integer getNormalCount() {
        return normalCount;
    }

    public void setNormalCount(Integer normalCount) {
        this.normalCount = normalCount;
    }

    public Integer getLaterCount() {
        return laterCount;
    }

    public void setLaterCount(Integer laterCount) {
        this.laterCount = laterCount;
    }

    public Integer getEarlyCount() {
        return earlyCount;
    }

    public void setEarlyCount(Integer earlyCount) {
        this.earlyCount = earlyCount;
    }

    public Integer getNoSignCount() {
        return noSignCount;
    }

    public void setNoSignCount(Integer noSignCount) {
        this.noSignCount = noSignCount;
    }

}
