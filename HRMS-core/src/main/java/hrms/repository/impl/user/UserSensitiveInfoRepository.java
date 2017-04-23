package hrms.repository.impl.user;

import hrms.entity.UserSensitiveInfo;
import hrms.repository.RepositorySupport;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

/**
 * Created by 谢益文 on 2017/3/20.
 */
@Repository("userSensitiveInfoRepository")
public class UserSensitiveInfoRepository extends RepositorySupport<UserSensitiveInfo> {

    public UserSensitiveInfo findByID(Integer userID){
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(UserSensitiveInfo.class);
        detachedCriteria.add(Restrictions.eq("userId",userID));
        return this.findOne(detachedCriteria);
    }


}
