package hrms.po;

/**
 * Created by 谢益文 on 2017/3/20.
 */
public class RegisterUserInfo {

    private String userName;
    private String userPhone;
    private Byte sex;
    private String userEmail;
    private String userCardNumber;
    private String dataOfBirth;
    private String workTime;
    private Integer roleID;

    private Byte isOrgManager;
    private String orgName;
    private String jobName;

    public RegisterUserInfo() {
    }

    public String getJobName() {
        return jobName;
    }

    public void setJobName(String jobName) {
        this.jobName = jobName;
    }

    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    public Byte getIsOrgManager() {
        return isOrgManager;
    }

    public void setIsOrgManager(Byte isOrgManager) {
        this.isOrgManager = isOrgManager;
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

    public Byte getSex() {
        return sex;
    }

    public void setSex(Byte sex) {
        this.sex = sex;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserCardNumber() {
        return userCardNumber;
    }

    public void setUserCardNumber(String userCardNumber) {
        this.userCardNumber = userCardNumber;
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

    public Integer getRoleID() {
        return roleID;
    }

    public void setRoleID(Integer roleID) {
        this.roleID = roleID;
    }
}
