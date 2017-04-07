package hrms.service.sys.impl;

import hrms.repository.impl.sys.SysEnumDataRepository;
import hrms.service.sys.SysEnumDataService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Map;

/**
 * Created by 谢益文 on 2017/3/20.
 */
@Service("sysEnumDataService")
public class SysEnumDataServiceImpl implements SysEnumDataService {

    @Resource
    private SysEnumDataRepository sysEnumDataRepository;

    @Override
    public Map<String, String> loadAllEnum() {
        Map<String, String> allSysEnum = sysEnumDataRepository.findAllSysEnum();
        return allSysEnum;
    }
}
