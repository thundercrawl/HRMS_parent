package hrms.service.role.impl;

import hrms.model.RoleBaseInfo;
import hrms.repository.impl.role.RoleInfoRepository;
import hrms.service.role.RoleInfoService;
import hrms.vo.MsgVo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 谢益文 on 2017/4/5.
 */
@Service("roleInfoService")
public class RoleInfoServiceImpl implements RoleInfoService {

    @Resource
    private RoleInfoRepository roleInfoRepository;

    @Override
    public MsgVo listRole() {
        List<RoleBaseInfo> list = roleInfoRepository.findBaseAll();
        Map<String,List<RoleBaseInfo>> roleMap = new HashMap<>();
        roleMap.put("result",list);
        return MsgVo.success(roleMap);
    }
}
