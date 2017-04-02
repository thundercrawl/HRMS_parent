package hrms.repository.impl.role;

import hrms.common.Constant;
import hrms.entity.UserRoleInfo;
import hrms.repository.RepositorySupport;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by 谢益文 on 2017/3/20.
 */
@Repository("userRoleInfoRepository")
public class UserRoleInfoRepository extends RepositorySupport<UserRoleInfo> {

    /**
     * @describe 查找用户对应的权限
     * @param userId
     * @return
     */
    public List<UserRoleInfo> findUserRole(Integer userId){
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(UserRoleInfo.class);
        detachedCriteria.add(Restrictions.eq("userId",userId))
        .add(Restrictions.eq("status",Constant.ROLE_ABLE));
        List<UserRoleInfo> roles = findAll(detachedCriteria);
        if(roles == null || roles.size() < 1){
            return null;
        }
        return roles;
    }
}
