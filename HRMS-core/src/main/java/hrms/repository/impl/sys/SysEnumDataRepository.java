package hrms.repository.impl.sys;

import hrms.common.Constant;
import hrms.entity.SysEnumData;
import hrms.repository.RepositorySupport;
import hrms.util.ParseUtil;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 谢益文 on 2017/3/20.
 */
@Repository("sysEnumDataRepository")
public class SysEnumDataRepository extends RepositorySupport<SysEnumData> {

    /**
     * @describe 查询所有的枚举量，key = tableName-columnName-enumName
     * @return  List<SysEnumData>
     */
    public Map<String,String> findAllSysEnum(){
        String sql = "select TABLE_NAME,COLUMN_NAME,ENUM_NAME,ENUM_VALUE FROM SYS_ENUM_DATA WHERE STATUS = ?";
        List<Object> all = this.executeSql(sql, Constant.ENUM_ABLE);
        if(all == null || all.size() < 1){
            return null;
        }

        Map result = new HashMap();
        for(Object object:all){
            Object[] objects = (Object[]) object;
            String key = ParseUtil.parseString(objects[0])+"-"+ParseUtil.parseString(objects[1])+"-"+ParseUtil.parseString(objects[2]);
            String value = ParseUtil.parseString(objects[3]);
            result.put(key,value);
        }
        return result;

    }
}
