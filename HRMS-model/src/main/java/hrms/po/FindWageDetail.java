package hrms.po;

import java.io.Serializable;

/**
 * Created by 谢益文 on 2017/5/6.
 */
public class FindWageDetail implements Serializable{
    private Integer userId;
    private Byte isFinance;

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Byte getIsFinance() {
        return isFinance;
    }

    public void setIsFinance(Byte isFinance) {
        this.isFinance = isFinance;
    }
}
