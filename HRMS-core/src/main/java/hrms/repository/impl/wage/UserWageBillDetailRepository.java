package hrms.repository.impl.wage;

import hrms.entity.UserWageBillDetail;
import hrms.repository.RepositorySupport;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;

/**
 * Created by 谢益文 on 2017/3/20.
 */
@Repository("userWageBillDetailRepository")
public class UserWageBillDetailRepository extends RepositorySupport<UserWageBillDetail> {

    public UserWageBillDetail findById(Integer billId){
        DetachedCriteria d = DetachedCriteria.forClass(UserWageBillDetail.class);
        d.add(Restrictions.eq("billId",billId));
        return this.findOne(d);
    }

    public List<UserWageBillDetail> findAllByYear(String startTime,String endTime){
        DetachedCriteria d = DetachedCriteria.forClass(UserWageBillDetail.class);
        d.add(Restrictions.ge("billDate",startTime))
                .add(Restrictions.le("billDate",endTime));
        return this.findAll(d);
    }

    public List<UserWageBillDetail> findByIds(Collection<Integer> billIds){
        DetachedCriteria d = DetachedCriteria.forClass(UserWageBillDetail.class);
        d.add(Restrictions.in("billId",billIds));
        return this.findAll(d);
    }




}
