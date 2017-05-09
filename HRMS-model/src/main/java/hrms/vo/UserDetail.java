package hrms.vo;

import java.util.List;

/**
 * Created by 谢益文 on 2017/4/2.
 */
public class UserDetail {

    private Integer userID;
    private String userName;
    private String userPhone;
    private Integer userAge;
    private Byte userSex;
    private String userSexMessage;
    private String userPhoto;

    private String userEamil;

    private Byte workStatus;
    private String workStatusMessage;

    private Integer orgID;
    private String orgName;
    private String jobName;

    private Byte isManager;

    //sensitive
    private String userCardNumber;
    private String dataOfBirth;
    private String workTime;

    private Byte isMine;
    private Byte hasRole;  //0:没有操作权限  1：有

    private List<String> workMessages;

    public List<String> getWorkMessages() {
        return workMessages;
    }

    public void setWorkMessages(List<String> workMessages) {
        this.workMessages = workMessages;
    }

    public UserDetail() {
        this.userName = "";
        this.userPhone = "";
        this.userSexMessage = "";
        this.userPhoto = "";
        this.workStatusMessage = "";
        this.orgID = 0;
        this.orgName = "";
        this.jobName = "";
        this.isManager = 0;
        this.userCardNumber = "";
        this.dataOfBirth = "";
        this.workTime = "";
        this.isMine = 0;
        this.hasRole = 0;
        this.userEamil = "";
    }

    public String getUserEamil() {
        return userEamil;
    }

    public void setUserEamil(String userEamil) {
        this.userEamil = userEamil;
    }

    public Byte getHasRole() {
        return hasRole;
    }

    public void setHasRole(Byte hasRole) {
        this.hasRole = hasRole;
    }

    public Byte getIsMine() {
        return isMine;
    }

    public void setIsMine(Byte isMine) {
        this.isMine = isMine;
    }

    public String getUserPhoto() {
        return userPhoto;
    }

    public void setUserPhoto(String userPhoto) {
        this.userPhoto = userPhoto;
    }

    public Byte getWorkStatus() {
        return workStatus;
    }

    public void setWorkStatus(Byte workStatus) {
        this.workStatus = workStatus;
    }

    public String getWorkStatusMessage() {
        return workStatusMessage;
    }

    public void setWorkStatusMessage(String workStatusMessage) {
        this.workStatusMessage = workStatusMessage;
    }

    public String getDataOfBirth() {
        return dataOfBirth;
    }

    public void setDataOfBirth(String dataOfBirth) {
        this.dataOfBirth = dataOfBirth;
    }

    public String getWorkTime() {
        return workTime;
    }

    public void setWorkTime(String workTime) {
        this.workTime = workTime;
    }

    public String getUserCardNumber() {
        return userCardNumber;
    }

    public void setUserCardNumber(String userCardNumber) {
        this.userCardNumber = userCardNumber;
    }

    public Integer getUserID() {
        return userID;
    }

    public void setUserID(Integer userID) {
        this.userID = userID;
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

    public Integer getUserAge() {
        return userAge;
    }

    public void setUserAge(Integer userAge) {
        this.userAge = userAge;
    }

    public Byte getUserSex() {
        return userSex;
    }

    public void setUserSex(Byte userSex) {
        this.userSex = userSex;
    }

    public String getUserSexMessage() {
        return userSexMessage;
    }

    public void setUserSexMessage(String userSexMessage) {
        this.userSexMessage = userSexMessage;
    }

    public Integer getOrgID() {
        return orgID;
    }

    public void setOrgID(Integer orgID) {
        this.orgID = orgID;
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

    public Byte getIsManager() {
        return isManager;
    }

    public void setIsManager(Byte isManager) {
        this.isManager = isManager;
    }
}
