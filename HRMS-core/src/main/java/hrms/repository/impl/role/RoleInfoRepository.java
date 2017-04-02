package hrms.repository.impl.role;

import hrms.entity.RoleInfo;
import hrms.repository.RepositorySupport;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

/**
 * Created by 谢益文 on 2017/3/20.
 */
@Repository("roleInfoRepository")
public class RoleInfoRepository extends RepositorySupport<RoleInfo> {

    /**
     * @describe 通过权限名称查找权限
     * @param roleName
     * @return
     */
    public RoleInfo findByName(String roleName){
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(RoleInfo.class);
        detachedCriteria.add(Restrictions.eq("roleName",roleName));
        return this.findOne(detachedCriteria);
    }

}