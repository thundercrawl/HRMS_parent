package hrms.po;

import java.io.Serializable;
import java.util.List;

/**
 * Created by 谢益文 on 2017/5/5.
 */
public class SaveWageParam implements Serializable{
    private List<SaveWageInfo>  wageInfos;

    public List<SaveWageInfo> getWageInfos() {
        return wageInfos;
    }

    public void setWageInfos(List<SaveWageInfo> wageInfos) {
        this.wageInfos = wageInfos;
    }
}
