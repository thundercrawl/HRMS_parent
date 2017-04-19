package hrms.service.org;

import hrms.common.CommonParams;
import hrms.po.AddOrg;
import hrms.po.DeleteFromOrg;
import hrms.vo.MsgVo;

/**
 * Created by 谢益文 on 2017/4/19.
 */
public interface OrgMemberService {

    /**
     * @describe 用户加入部门
     * @author xieyw
     * @param param
     * @param commonParams
     * @return
     */
    public MsgVo addOrg(AddOrg param, CommonParams commonParams);


    /**
     * @describe 用户退出部门
     * @author xieyw
     * @param param
     * @param commonParams
     * @return
     */
    public MsgVo deleteFromOrg(DeleteFromOrg param, CommonParams commonParams);
}
