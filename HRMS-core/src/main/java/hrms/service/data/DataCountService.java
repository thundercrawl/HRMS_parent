package hrms.service.data;

import hrms.common.CommonParams;
import hrms.vo.MsgVo;

/**
 * Created by 谢益文 on 2017/5/7.
 */
public interface DataCountService {
    /**
     * @describe 考勤统计
     * @author xieyw
     * @param date
     * @param commonParams
     * @return
     */
    public MsgVo signCount(String date, CommonParams commonParams);

    /**
     * @describe 账单统计
     * @author xieyw
     * @param date
     * @param commonParams
     * @return
     */
    public MsgVo billCount(String date,CommonParams commonParams);
}
