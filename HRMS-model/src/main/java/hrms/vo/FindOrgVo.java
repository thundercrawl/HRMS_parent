package hrms.vo;

import hrms.model.OrgBaseInfo;

import java.io.Serializable;
import java.util.List;

/**
 * Created by 谢益文 on 2017/4/27.
 */
public class FindOrgVo implements Serializable{

    private  List<OrgInfoVo> orgTables;
    private List<OrgBaseInfo> orgInfos;

    public List<OrgInfoVo> getOrgTables() {
        return orgTables;
    }

    public void setOrgTables(List<OrgInfoVo> orgTables) {
        this.orgTables = orgTables;
    }

    public List<OrgBaseInfo> getOrgInfos() {
        return orgInfos;
    }

    public void setOrgInfos(List<OrgBaseInfo> orgInfos) {
        this.orgInfos = orgInfos;
    }
}
