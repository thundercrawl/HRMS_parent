package hrms.vo;

import java.io.Serializable;
import java.util.List;

/**
 * Created by 谢益文 on 2017/5/4.
 */
public class FindAllApproveVo implements Serializable{
    private List<LeaveDetail> approves;
    private int count;

    public List<LeaveDetail> getApproves() {
        return approves;
    }

    public void setApproves(List<LeaveDetail> approves) {
        this.approves = approves;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }
}
