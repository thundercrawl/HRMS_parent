package hrms.po;

import java.io.Serializable;
import java.util.List;

/**
 * Created by 谢益文 on 2017/5/2.
 */
public class SaveSignParam implements Serializable{
    private List<SaveSignInfo> signInfos;

    public List<SaveSignInfo> getSignInfos() {
        return signInfos;
    }

    public void setSignInfos(List<SaveSignInfo> signInfos) {
        this.signInfos = signInfos;
    }
}
