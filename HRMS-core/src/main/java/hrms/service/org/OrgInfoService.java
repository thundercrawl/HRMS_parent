package hrms.service.org;

import hrms.common.CommonParams;
import hrms.po.AddOrgMember;
import hrms.po.FindOrgParam;
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
    public MsgVo findAllOrg(FindOrgParam orgName,CommonParams commonParams);

    /**
     * @describe 新增部门
     * @param orgParam
     * @param commonParams
     * @return
     */
    public MsgVo save(SaveOrgParam orgParam, CommonParams commonParams);

    /**
     * @describe 更新部门名称、描述、上级部门
     * @param orgParam
     * @param commonParams
     * @return
     */
    public MsgVo update(UpdateOrgParam orgParam, CommonParams commonParams);

    /**
     * @author xieyw
     * @return
     */
    public MsgVo listOrg();

    /**
     * @describe 添加成员到部门
     * @author xieyw
     * @param param
     * @param commonParams
     * @return
     */
    public MsgVo addMember(AddOrgMember param, CommonParams commonParams);

    /**
     * @describe 刪除部門，并级联删除部门成员依赖关系
     * @author xieyw
     * @param orgId
     * @param commonParams
     * @return
     */
    public MsgVo deleteOrg(Integer orgId,CommonParams commonParams);
}
