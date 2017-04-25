package hrms.po;

/**
 * Created by 谢益文 on 2017/4/21.
 */
public class UploadUserPhoto {
    private String picName;
    private Integer relId;
    private Integer relType;

    public Integer getRelId() {
        return relId;
    }

    public void setRelId(Integer relId) {
        this.relId = relId;
    }

    public Integer getRelType() {
        return relType;
    }

    public void setRelType(Integer relType) {
        this.relType = relType;
    }

    public String getPicName() {
        return picName;
    }

    public void setPicName(String picName) {
        this.picName = picName;
    }
}
