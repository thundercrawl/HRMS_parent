package hrms.service.wage;

import hrms.common.CommonParams;
import hrms.po.FindBillParam;
import hrms.po.SearchBillParam;
import hrms.vo.MsgVo;

/**
 * Created by 谢益文 on 2017/5/6.
 */
public interface BillSearchService {
    public MsgVo searchBill(SearchBillParam param, CommonParams commonParams);

    public MsgVo findBillDetail(FindBillParam param);

    public int generateBill(int page,int pageSize);
}
