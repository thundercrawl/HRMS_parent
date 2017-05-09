package hrms.vo;

import java.io.Serializable;
import java.util.List;

/**
 * Created by 谢益文 on 2017/5/3.
 */
public class FindAllLeaveVo implements Serializable{
    private List<LeaveDetail> leaveDetails;
    private Integer count;

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public List<LeaveDetail> getLeaveDetails() {
        return leaveDetails;
    }

    public void setLeaveDetails(List<LeaveDetail> leaveDetails) {
        this.leaveDetails = leaveDetails;
    }
}
