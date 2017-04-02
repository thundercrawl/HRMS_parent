package hrms.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

/**
 * Created by 谢益文 on 2017/3/14.
 */
@Entity
@Table(name = "user_sensitive_info")
public class UserSensitiveInfo implements Serializable{
    private static final long serialVersionUID = 1L;

    private Integer userId;
    private String userCardNumber;
    private String dataOfBirth;
    private String workTime;

    public UserSensitiveInfo(){}

    public UserSensitiveInfo(Integer userId, String userCardNumber, String dataOfBirth, String workTime) {
        this.userId = userId;
        this.userCardNumber = userCardNumber;
        this.dataOfBirth = dataOfBirth;
        this.workTime = workTime;
    }

    @Id
    @Column(name = "USER_ID", unique = true, nullable = false)
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    @Column(name = "USER_CARD_NUMBER", length = 20)
    public String getUserCardNumber() {
        return userCardNumber;
    }

    public void setUserCardNumber(String userCardNumber) {
        this.userCardNumber = userCardNumber;
    }

    @Column(name = "DATA_OF_BIRTH", length = 10)
    public String getDataOfBirth() {
        return dataOfBirth;
    }

    public void setDataOfBirth(String dataOfBirth) {
        this.dataOfBirth = dataOfBirth;
    }

    @Column(name = "WORK_TIME", length = 10)
    public String getWorkTime() {
        return workTime;
    }

    public void setWorkTime(String workTime) {
        this.workTime = workTime;
    }

    @Override
    public String toString() {
        return "UserSensitiveInfo{" +
                "userId=" + userId +
                ", userCardNumber='" + userCardNumber + '\'' +
                ", dataOfBirth='" + dataOfBirth + '\'' +
                ", workTime='" + workTime + '\'' +
                '}';
    }
}
