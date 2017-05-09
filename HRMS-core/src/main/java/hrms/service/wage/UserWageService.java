package hrms.service.wage;

import hrms.common.CommonParams;
import hrms.po.FindAllWageParam;
import hrms.po.SaveWageParam;
import hrms.po.UpdateUserWageParam;
import hrms.vo.MsgVo;

/**
 * Created by 谢益文 on 2017/5/5.
 */
public interface UserWageService {

    public MsgVo batchSave(SaveWageParam param, CommonParams commonParams);

    /**
     * @describe 财务查询所有会员的薪资列表
     * @author xieyw
     * @param param
     * @param commonParams
     * @return
     */

    public MsgVo findAllWages(FindAllWageParam param, CommonParams commonParams);

    /**
     * @describe 查询会员工资详情
     * @author xieyw
     * @param userId
     * @param isFinance
     * @param commonParams
     * @return
     */
    public MsgVo findWageDetail(Integer userId,Byte isFinance,CommonParams commonParams);

    /**
     * @describe 更新基础工资、话费补贴、其他福利、其他福利描述
     * @author xieyw
     * @param param
     * @param commonParams
     * @return
     */
    public MsgVo updateUserWage(UpdateUserWageParam param, CommonParams commonParams);
}
