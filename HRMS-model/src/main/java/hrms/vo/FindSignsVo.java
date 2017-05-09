package hrms.vo;

import java.io.Serializable;
import java.util.List;

/**
 * Created by 谢益文 on 2017/5/2.
 */
public class FindSignsVo implements Serializable{
    private List<SignInfoDetail> signInfoDetails;

    public List<SignInfoDetail> getSignInfoDetails() {
        return signInfoDetails;
    }

    public void setSignInfoDetails(List<SignInfoDetail> signInfoDetails) {
        this.signInfoDetails = signInfoDetails;
    }
}
