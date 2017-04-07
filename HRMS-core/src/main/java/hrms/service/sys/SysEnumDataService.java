package hrms.service.sys;

import java.util.Map;

/**
 * Created by 谢益文 on 2017/3/20.
 */

public interface SysEnumDataService {

    /**
     * @describe 加载数据库中的枚举到EnumerateUtil中
     */
    public Map<String, String> loadAllEnum();
}
