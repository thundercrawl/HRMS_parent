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
@Table(name = "sys_param_config")
public class SysParamConfig implements Serializable {
    private static final long serialVersionUID = 1L;

    private String paramId;
    private String paramName;
    private String paramValue;
    private String paramDescribe;
    private String createTime;
    private String updateTime;
    private Integer operId;


    public SysParamConfig(){}

    public SysParamConfig(String paramId, String paramName, String paramValue, String paramDescribe, String createTime, String updateTime, Integer operId) {
        this.paramId = paramId;
        this.paramName = paramName;
        this.paramValue = paramValue;
        this.paramDescribe = paramDescribe;
        this.createTime = createTime;
        this.updateTime = updateTime;
        this.operId = operId;
    }

    @Id
    @Column(name = "PARAM_ID", length = 50)
    public String getParamId() {
        return paramId;
    }

    public void setParamId(String paramId) {
        this.paramId = paramId;
    }

    @Column(name = "PARAM_NAME", length = 50)
    public String getParamName() {
        return paramName;
    }

    public void setParamName(String paramName) {
        this.paramName = paramName;
    }

    @Column(name = "PARAM_VALUE", length = 50)
    public String getParamValue() {
        return paramValue;
    }

    public void setParamValue(String paramValue) {
        this.paramValue = paramValue;
    }

    @Column(name = "PARAM_DESCRIBE", length = 255)
    public String getParamDescribe() {
        return paramDescribe;
    }

    public void setParamDescribe(String paramDescribe) {
        this.paramDescribe = paramDescribe;
    }

    @Column(name = "CREATE_TIME", length = 20)
    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    @Column(name = "UPDATE_TIME", length = 20)
    public String getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(String updateTime) {
        this.updateTime = updateTime;
    }

    @Column(name = "OPER_ID", length = 10)
    public Integer getOperId() {
        return operId;
    }

    public void setOperId(Integer operId) {
        this.operId = operId;
    }

    @Override
    public String toString() {
        return "SysParamConfig{" +
                "paramId='" + paramId + '\'' +
                ", paramName='" + paramName + '\'' +
                ", paramValue='" + paramValue + '\'' +
                ", paramDescribe='" + paramDescribe + '\'' +
                ", createTime='" + createTime + '\'' +
                ", updateTime='" + updateTime + '\'' +
                ", operId=" + operId +
                '}';
    }
}
