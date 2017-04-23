package hrms.entity;

import javax.persistence.*;
import java.io.Serializable;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * Created by 谢益文 on 2017/3/14.
 */
@Entity
@Table(name = "user_info")
public class UserInfo implements Serializable{
    private static final long serialVersionUID = 1L;

    private Integer userId;
    private String userName;
    private String userPhone;
    private String sex;
    private String userEmail;
    private String createTime;
    private Integer createUserId;
    private Byte workStatus;
    private Byte userStatus;

    private String userPasswd;
    private Integer userAge;

    public UserInfo(){}

    public UserInfo(Integer userId, String userName, String userPhone, String sex, String userEmail, String createTime, Integer createUserId, Byte workStatus, Byte userStatus, String userPasswd, Integer userAge) {
        this.userId = userId;
        this.userName = userName;
        this.userPhone = userPhone;
        this.sex = sex;
        this.userEmail = userEmail;
        this.createTime = createTime;
        this.createUserId = createUserId;
        this.workStatus = workStatus;
        this.userStatus = userStatus;
        this.userPasswd = userPasswd;
        this.userAge = userAge;
    }

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "USER_ID", unique = true, nullable = false)
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }
    @Column(name = "USER_NAME", length = 50)
    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    @Column(name = "USER_PHONE", length = 15)
    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    @Column(name = "USER_SEX", length = 1)
    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    @Column(name = "USER_EMAIL", length = 30)
    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    @Column(name = "USER_PASSWD", length = 32)
    public String getUserPasswd() {
        return userPasswd;
    }

    public void setUserPasswd(String userPasswd) {
        this.userPasswd = userPasswd;
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

    @Column(name = "WORK_STATUS", length = 1)
    public Byte getWorkStatus() {
        return workStatus;
    }

    public void setWorkStatus(Byte workStatus) {
        this.workStatus = workStatus;
    }

    @Column(name = "USER_STATUS", length = 1)
    public Byte getUserStatus() {
        return userStatus;
    }

    public void setUserStatus(Byte userStatus) {
        this.userStatus = userStatus;
    }

    @Column(name = "USER_AGE", length = 3)
    public Integer getUserAge() {
        return userAge;
    }

    public void setUserAge(Integer userAge) {
        this.userAge = userAge;
    }

    @Override
    public String toString() {
        return "UserInfo{" +
                "userId=" + userId +
                ", userName='" + userName + '\'' +
                ", userPhone='" + userPhone + '\'' +
                ", sex=" + sex +
                ", userEmail='" + userEmail + '\'' +
                ", createTime='" + createTime + '\'' +
                ", createUserId=" + createUserId +
                ", workStatus=" + workStatus +
                ", userStatus=" + userStatus +
                ", userPasswd='" + userPasswd + '\'' +
                ", userAge=" + userAge +
                '}';
    }
}
