package hrms.service.org;

import hrms.common.CommonParams;
import hrms.po.SaveOrgParam;
import hrms.po.UpdateOrgParam;
import hrms.vo.MsgVo;

/**
 * Created by 谢益文 on 2017/4/5.
 */
public interface OrgInfoService {

    /**
     * @describe 查找所有部门
     * @param orgName
     * @return
     */
    public MsgVo findAllOrg(String orgName);

    /**
     * @describe 新增部门
     * @param orgParam
     * @param commonParams
     * @return
     */
    public MsgVo save(SaveOrgParam orgParam, CommonParams commonParams);

    /**
     * @describe 更新部门名称、描述
     * @param orgParam
     * @param commonParams
     * @return
     */
    public MsgVo update(UpdateOrgParam orgParam, CommonParams commonParams);
}
