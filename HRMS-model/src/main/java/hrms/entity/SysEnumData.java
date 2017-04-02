package hrms.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.io.Serializable;

/**
 * Created by 谢益文 on 2017/3/14.
 */
@Entity
@Table(name = "sys_enum_data")
public class SysEnumData implements Serializable {
    private static final long serialVersionUID = 1L;

    private String tableName;
    private String columnName;
    private String enumType;
    private String enumValue;
    private String enumName;
    private Integer sortId;
    private String dispName;
    private Byte status;
    private String remark;


    public SysEnumData() {
    }

    public SysEnumData(String tableName, String columnName, String enumType, String enumValue, String enumName, Integer sortId, String dispName, Byte status, String remark) {
        this.tableName = tableName;
        this.columnName = columnName;
        this.enumType = enumType;
        this.enumValue = enumValue;
        this.enumName = enumName;
        this.sortId = sortId;
        this.dispName = dispName;
        this.status = status;
        this.remark = remark;
    }

    @Column(name = "TABLE_NAME", length = 20)
    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    @Column(name = "COLUMN_NAME", length = 20)
    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    @Column(name = "ENUM_TYPE", length = 10)
    public String getEnumType() {
        return enumType;
    }

    public void setEnumType(String enumType) {
        this.enumType = enumType;
    }

    @Column(name = "ENUM_VALUE", length = 255)
    public String getEnumValue() {
        return enumValue;
    }

    public void setEnumValue(String enumValue) {
        this.enumValue = enumValue;
    }

    @Column(name = "ENUM_NAME", length = 50)
    public String getEnumName() {
        return enumName;
    }

    public void setEnumName(String enumName) {
        this.enumName = enumName;
    }

    @Column(name = "SORT_ID", length = 3)
    public Integer getSortId() {
        return sortId;
    }

    public void setSortId(Integer sortId) {
        this.sortId = sortId;
    }

    @Column(name = "DISP_NAME", length = 50)
    public String getDispName() {
        return dispName;
    }

    public void setDispName(String dispName) {
        this.dispName = dispName;
    }

    @Column(name = "STATUS", length = 1)
    public Byte getStatus() {
        return status;
    }

    public void setStatus(Byte status) {
        this.status = status;
    }

    @Column(name = "REMARK", length = 50)
    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    @Override
    public String toString() {
        return "SysEnumData{" +
                "tableName='" + tableName + '\'' +
                ", columnName='" + columnName + '\'' +
                ", enumType='" + enumType + '\'' +
                ", enumValue='" + enumValue + '\'' +
                ", enumName='" + enumName + '\'' +
                ", sortId=" + sortId +
                ", dispName='" + dispName + '\'' +
                ", status=" + status +
                ", remark='" + remark + '\'' +
                '}';
    }
}