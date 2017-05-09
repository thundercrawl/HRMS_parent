package hrms.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * Created by 谢益文 on 2017/5/2.
 */
@Entity
@Table(name = "sign_info")
public class SignInfo {
    private Integer signId;
    private Integer userId;
    private Byte signType;
    private String signTime;
    private String createTime;
    private Integer createUserId;

    private Byte signStatus;

    public SignInfo() { }

    public SignInfo(Integer signId, Integer userId, Byte signType, String signTime, String createTime, Integer createUserId, Byte signStatus) {
        this.signId = signId;
        this.userId = userId;
        this.signType = signType;
        this.signTime = signTime;
        this.createTime = createTime;
        this.createUserId = createUserId;
        this.signStatus = signStatus;
    }

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "SIGN_ID", unique = true, nullable = false)
    public Integer getSignId() {
        return signId;
    }

    public void setSignId(Integer signId) {
        this.signId = signId;
    }
    @Column(name = "USER_ID", length = 10)
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }
    @Column(name = "SIGN_TYPE", length = 1)
    public Byte getSignType() {
        return signType;
    }

    public void setSignType(Byte signType) {
        this.signType = signType;
    }
    @Column(name = "SIGN_TIME", length = 20)
    public String getSignTime() {
        return signTime;
    }

    public void setSignTime(String signTime) {
        this.signTime = signTime;
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

    @Column(name = "SIGN_STATUS", length = 1)
    public Byte getSignStatus() {
        return signStatus;
    }

    public void setSignStatus(Byte signStatus) {
        this.signStatus = signStatus;
    }

    @Override
    public String toString() {
        return "SignInfo{" +
                "signId=" + signId +
                ", userId=" + userId +
                ", signType=" + signType +
                ", signTime='" + signTime + '\'' +
                ", createTime='" + createTime + '\'' +
                ", createUserId=" + createUserId +
                ", signStatus=" + signStatus +
                '}';
    }
}
