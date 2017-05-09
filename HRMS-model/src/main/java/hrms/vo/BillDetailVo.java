package hrms.vo;

import java.io.Serializable;
import java.util.List;

/**
 * Created by 谢益文 on 2017/5/6.
 */
public class BillDetailVo implements Serializable{
    private List<BillDetail> billDetails;
    private Integer count;

    public List<BillDetail> getBillDetails() {
        return billDetails;
    }

    public void setBillDetails(List<BillDetail> billDetails) {
        this.billDetails = billDetails;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }
}
