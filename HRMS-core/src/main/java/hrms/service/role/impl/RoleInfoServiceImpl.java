package hrms.service.role.impl;

import hrms.common.ErrorCode;
import hrms.entity.RoleInfo;
import hrms.repository.impl.role.RoleInfoRepository;
import hrms.service.role.RoleInfoService;
import hrms.vo.MsgVo;
import org.hibernate.annotations.Source;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 谢益文 on 2017/4/5.
 */
@Service("roleInfoService")
public class RoleInfoServiceImpl implements RoleInfoService {

    @Source
    private RoleInfoRepository roleInfoRepository;

    @Override
    public MsgVo listRole() {
        List<RoleInfo> roleInfos = roleInfoRepository.findAll();
        if(roleInfos == null || roleInfos.size() < 1){
            return MsgVo.fail(ErrorCode.RESULT_EMPTY);
        }
        Map<String,List<RoleInfo>> roleMap = new HashMap<>();
        roleMap.put("result",roleInfos);
        return MsgVo.success(roleMap);
    }
}
