package hrms.po;

import java.io.Serializable;

/**
 * Created by 谢益文 on 2017/5/6.
 */
public class FindBillParam implements Serializable{
    private Integer billId;

    public Integer getBillId() {
        return billId;
    }

    public void setBillId(Integer billId) {
        this.billId = billId;
    }
}
