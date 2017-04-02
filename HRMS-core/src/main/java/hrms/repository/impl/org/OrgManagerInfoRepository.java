package hrms.repository.impl.org;

import hrms.common.Constant;
import hrms.entity.OrgManagerInfo;
import hrms.repository.RepositorySupport;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

/**
 * Created by 谢益文 on 2017/3/20.
 */
@Repository("orgManagerInfoRepository")
public class OrgManagerInfoRepository extends RepositorySupport<OrgManagerInfo> {

    /**
     * @describe 获取部门经理编号
     * @param orgId
     * @return
     */
    public Integer getManager(Integer orgId){
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(OrgManagerInfo.class);
        detachedCriteria.add(Restrictions.eq("orgId",orgId))
        .add(Restrictions.eq("status", Constant.STATUS_ABLE));
        OrgManagerInfo one = this.findOne(detachedCriteria);
        if(one == null){
            return null;
        }
        return one.getUserId();
    }

    /**
     * @describe 判断用户是否是该部门的部门经理
     * @param userID
     * @param orgID
     * @return
     */
    public boolean isManager(Integer userID,Integer orgID){
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(OrgManagerInfo.class);
        detachedCriteria.add(Restrictions.eq("orgId",orgID))
                .add(Restrictions.eq("userId",userID))
                .add(Restrictions.eq("status", Constant.STATUS_ABLE));
        OrgManagerInfo one = this.findOne(detachedCriteria);
        if(one == null){
            return false;
        }
        return true;
    }

}
