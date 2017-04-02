package hrms.vo;

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

    private Byte workStatus;
    private String workStatusMessage;

    private Integer orgID;
    private String orgName;
    private String jobName;

    private Integer roleId;
    private Byte isManager;

    //sensitive
    private String userCardNumber;
    private String dataOfBirth;
    private String workTime;

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

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public Byte getIsManager() {
        return isManager;
    }

    public void setIsManager(Byte isManager) {
        this.isManager = isManager;
    }
}
