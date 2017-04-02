package hrms.entity;

import javax.persistence.*;
import java.io.Serializable;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * Created by 谢益文 on 2017/3/14.
 */
@Entity
@Table(name = "picture_info")
public class PictureInfo implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer picId;
    private Integer relId;
    private Integer relType;
    private String picUrl;
    private Byte picStatus;
    private String createTime;
    private Integer createUserId;
    private String desc;

    public PictureInfo(){}

    public PictureInfo(Integer picId, Integer relId, Integer relType, String picUrl, Byte picStatus, String createTime, Integer createUserId, String desc) {
        this.picId = picId;
        this.relId = relId;
        this.relType = relType;
        this.picUrl = picUrl;
        this.picStatus = picStatus;
        this.createTime = createTime;
        this.createUserId = createUserId;
        this.desc = desc;
    }

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "PIC_ID", unique = true, nullable = false)
    public Integer getPicId() {
        return picId;
    }

    public void setPicId(Integer picId) {
        this.picId = picId;
    }

    @Column(name = "REL_ID", length = 10)
    public Integer getRelId() {
        return relId;
    }

    public void setRelId(Integer relId) {
        this.relId = relId;
    }

    @Column(name = "REL_TYPE", length = 4)
    public Integer getRelType() {
        return relType;
    }

    public void setRelType(Integer relType) {
        this.relType = relType;
    }

    @Column(name = "PIC_URL", length = 255)
    public String getPicUrl() {
        return picUrl;
    }

    public void setPicUrl(String picUrl) {
        this.picUrl = picUrl;
    }

    @Column(name = "PIC_STATUS", length = 1)
    public Byte getPicStatus() {
        return picStatus;
    }

    public void setPicStatus(Byte picStatus) {
        this.picStatus = picStatus;
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

    @Column(name = "DESC", length = 255)
    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    @Override
    public String toString() {
        return "PictureInfo{" +
                "picId=" + picId +
                ", relId=" + relId +
                ", relType=" + relType +
                ", picUrl='" + picUrl + '\'' +
                ", picStatus=" + picStatus +
                ", createTime='" + createTime + '\'' +
                ", createUserId=" + createUserId +
                ", desc='" + desc + '\'' +
                '}';
    }
}
