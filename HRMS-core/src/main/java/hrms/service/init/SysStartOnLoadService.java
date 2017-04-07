package hrms.service.init;

import hrms.service.sys.SysEnumDataService;
import hrms.util.EnumerateUtil;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Map;

/**
 * Created by 谢益文 on 2017/3/20.
 */
@Component
public class SysStartOnLoadService implements InitializingBean{

    @Autowired
    private SysEnumDataService sysEnumDataService;

    @Override
    public void afterPropertiesSet() throws Exception {
        System.out.println("-----------加载enum数据-----------");
        Map<String, String> map = sysEnumDataService.loadAllEnum();
        if(map != null){
            EnumerateUtil.setMap(map);
        }
        System.out.println("-----------加载enum完毕-----------");
    }
}
