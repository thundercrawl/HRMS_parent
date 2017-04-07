package hrms.repository.impl.org;

import hrms.common.Constant;
import hrms.entity.OrgInfo;
import hrms.repository.RepositorySupport;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by 谢益文 on 2017/3/20.
 */
@Repository("orgInfoRepository")
public class OrgInfoRepository extends RepositorySupport<OrgInfo> {

    public List<OrgInfo> findAllByName(String orgName){
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(OrgInfo.class);
        detachedCriteria.add(Restrictions.like("orgName",orgName, MatchMode.ANYWHERE))
            .add(Restrictions.eq("orgStatus", Constant.STATUS_ABLE));
        List<OrgInfo> all = this.findAll(detachedCriteria);
        if(all == null || all.size() < 1){
            return null;
        }
        return all;
    }
    public List<OrgInfo> findAllOrg(){
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(OrgInfo.class);
        detachedCriteria.add(Restrictions.eq("orgStatus", Constant.STATUS_ABLE));
        List<OrgInfo> all = this.findAll(detachedCriteria);
        if(all == null || all.size() < 1){
            return null;
        }
        return all;
    }

    /**
     * @describe 通过名称查找部门
     * @param orgName
     * @return
     */
    public OrgInfo findOrgByName(String orgName){
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(OrgInfo.class);
        detachedCriteria.add(Restrictions.eq("orgStatus", Constant.STATUS_ABLE))
            .add(Restrictions.eq("orgName",orgName));
        return this.findOne(detachedCriteria);
    }

}
