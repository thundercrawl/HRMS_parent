package hrms.vo;

import java.io.Serializable;
import java.util.List;

/**
 * Created by 谢益文 on 2017/5/6.
 */
public class FindAllWageVo implements Serializable {
    private List<WageDetail> wageDetails ;
    private Integer count;

    public List<WageDetail> getWageDetails() {
        return wageDetails;
    }

    public void setWageDetails(List<WageDetail> wageDetails) {
        this.wageDetails = wageDetails;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }
}
