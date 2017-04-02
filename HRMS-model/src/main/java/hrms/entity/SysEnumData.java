package hrms.entity;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by 谢益文 on 2017/3/14.
 */
@Entity
@Table(name = "sys_enum_data")
public class SysEnumData implements Serializable {
    private static final long serialVersionUID = 1L;

    private SysEnumDataId id;

    public SysEnumData() {
    }

    public SysEnumData(SysEnumDataId id) {
        this.id = id;
    }

    private String tableName;
    private String columnName;
    private String enumType;
    private String enumValue;
    private String enumName;
    private Integer sortId;
    private String dispName;
    private Byte status;
    private String remark;

    @EmbeddedId
    @AttributeOverrides({
            @AttributeOverride(name = "tableName", column = @Column(name = "TABLE_NAME", length = 20)),
            @AttributeOverride(name = "columnName", column = @Column(name = "COLUMN_NAME", length = 20)),
            @AttributeOverride(name = "enumType", column = @Column(name = "ENUM_TYPE")),
            @AttributeOverride(name = "enumValue", column = @Column(name = "ENUM_VALUE")),
            @AttributeOverride(name = "enumName", column = @Column(name = "ENUM_NAME", length = 50)),
            @AttributeOverride(name = "sortId", column = @Column(name = "SORT_ID")),
            @AttributeOverride(name = "dispName", column = @Column(name = "DISP_NAME", length = 50)),
            @AttributeOverride(name = "status", column = @Column(name = "STATUS")),
            @AttributeOverride(name = "remark", column = @Column(name = "REMARK", length = 50)) })
    public SysEnumDataId getId() {
        return this.id;
    }

    public void setId(SysEnumDataId id) {
        this.id = id;
    }
}