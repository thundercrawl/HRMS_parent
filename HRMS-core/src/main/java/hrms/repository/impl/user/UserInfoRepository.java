package hrms.repository.impl.user;

import hrms.common.Constant;
import hrms.entity.UserInfo;
import hrms.repository.RepositorySupport;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

/**
 * Created by 谢益文 on 2017/3/20.
 */
@Repository("userInfoRepository")
public class UserInfoRepository extends RepositorySupport<UserInfo> {


    /**
     * @describe  通过用户手机号码查找用户
     * @param phone
     * @return
     */
    public UserInfo findByPhone(String phone){
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(UserInfo.class);
        detachedCriteria.add(Restrictions.eq("userPhone",phone));
        return this.findOne(detachedCriteria);
    }

    /**
     * @describe 查找已注册未删除的用户
     * @param phone
     * @return
     */
    public UserInfo findWorkerByPhone(String phone){
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(UserInfo.class);
        detachedCriteria.add(Restrictions.eq("userPhone",phone))
                .add(Restrictions.eq("userStatus", Constant.STATUS_ABLE));
        return this.findOne(detachedCriteria);
    }


}
