package hrms.vo;

import java.io.Serializable;

/**
 * Created by 谢益文 on 2017/3/22.
 */
public class LoginInfo implements Serializable{

    private Integer userId;
    private String userName;
    private String userSex;
    private String userPhoto;
    private Integer orgId;
    private String orgName;
    private String jobName;

    private Byte isManager;
    private Byte isHR;
    private Byte isFINANCE;
    private Byte isSM;

    private String joinTime;


    public LoginInfo() {
        isFINANCE = 0;
        isHR = 0;
        isManager = 0;
        isSM = 0;
    }

    public Byte getIsHR() {
        return isHR;
    }

    public void setIsHR(Byte isHR) {
        this.isHR = isHR;
    }

    public Byte getIsFINANCE() {
        return isFINANCE;
    }

    public void setIsFINANCE(Byte isFINANCE) {
        this.isFINANCE = isFINANCE;
    }

    public Byte getIsSM() {
        return isSM;
    }

    public void setIsSM(Byte isSM) {
        this.isSM = isSM;
    }

    public String getJoinTime() {
        return joinTime;
    }

    public void setJoinTime(String joinTime) {
        this.joinTime = joinTime;
    }

    public Byte getIsManager() {
        return isManager;
    }

    public void setIsManager(Byte isManager) {
        this.isManager = isManager;
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

    public String getUserSex() {
        return userSex;
    }

    public void setUserSex(String userSex) {
        this.userSex = userSex;
    }

    public String getUserPhoto() {
        return userPhoto;
    }

    public void setUserPhoto(String userPhoto) {
        this.userPhoto = userPhoto;
    }

    public Integer getOrgId() {
        return orgId;
    }

    public void setOrgId(Integer orgId) {
        this.orgId = orgId;
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
