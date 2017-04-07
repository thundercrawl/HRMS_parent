package hrms.service.role;

import hrms.vo.MsgVo;

/**
 * Created by 谢益文 on 2017/4/5.
 */
public interface RoleInfoService {

    /**
     * @describe 查询所有权限 NAME - VALUE
     * @return
     */
    public MsgVo listRole();
}
