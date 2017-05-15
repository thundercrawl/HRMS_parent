package hrms.po;

import java.io.Serializable;

/**
 * Created by 谢益文 on 2017/5/2.
 */
public class FindSignParam implements Serializable{
    private String startTime;
    private String endTime;
    private String orgName;
    private String userName;
    private Byte isLater;
    private Byte isEarly;

    public FindSignParam() {
        isLater = 0;
        isEarly = 0;
    }

    public FindSignParam(String startTime, String endTime, String orgName, String userName, Byte isLater, Byte isEarly) {
        this.startTime = startTime;
        this.endTime = endTime;
        this.orgName = orgName;
        this.userName = userName;
        this.isLater = isLater;
        this.isEarly = isEarly;
    }

    public Byte getIsLater() {
        return isLater;
    }

    public void setIsLater(Byte isLater) {
        this.isLater = isLater;
    }

    public Byte getIsEarly() {
        return isEarly;
    }

    public void setIsEarly(Byte isEarly) {
        this.isEarly = isEarly;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    @Override
    public String toString() {
        return "FindSignParam{" +
                "startTime='" + startTime + '\'' +
                ", endTime='" + endTime + '\'' +
                ", orgName='" + orgName + '\'' +
                ", userName='" + userName + '\'' +
                ", isLater=" + isLater +
                ", isEarly=" + isEarly +
                '}';
    }
}
