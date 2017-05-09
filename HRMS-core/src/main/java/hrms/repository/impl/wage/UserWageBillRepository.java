package hrms.repository.impl.wage;

import hrms.entity.UserWageBill;
import hrms.repository.RepositorySupport;
import hrms.util.ParseUtil;
import hrms.util.StringUtil;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 谢益文 on 2017/3/20.
 */
@Repository("userWageBillRepository")
public class UserWageBillRepository extends RepositorySupport<UserWageBill> {

    public UserWageBill findById(Integer wageId){
        DetachedCriteria d = DetachedCriteria.forClass(UserWageBill.class);
        d.add(Restrictions.eq("wageId",wageId));
        return this.findOne(d);
    }

    public Map<Integer,List<UserWageBill>> findAll(Collection<Long> userIds,String date,int page,int pageSize){

        String sql = " select * from user_wage_bill " +
                " where user_id in (:ids) ";

        if(! StringUtil.isEmpty(date)){
            sql += " and bill_date like  '"+date+"'";
        }
        sql += " order by bill_date desc limit "+page*pageSize+","+pageSize;

        List<UserWageBill> all = this.executeSqlEntity(sql,userIds);
        if(all == null || all.size() < 1){
            return null;
        }
        Map<Integer,List<UserWageBill>> map = new HashMap<>();
        for(UserWageBill bill:all){
            if(map.containsKey(bill.getUserId())){
                map.get(bill.getUserId()).add(bill);
            }else{
                List<UserWageBill> list = new ArrayList<>();
                list.add(bill);
                map.put(bill.getUserId(),list);
            }
        }
        return map;
    }

    public int countAll(Collection<Long> userIds,String date){
        String sql = " select count(bill_id) from user_wage_bill " +
                " where user_id in (:ids) ";

        if(! StringUtil.isEmpty(date)){
            sql += " and bill_date like  '"+date+"'";
        }
        sql += " group by bill_date " +
                " order by bill_date desc ";

        List<Object> all = this.executeSql(sql,userIds);
        if(all == null || all.size() < 1){
            return 0;
        }
        return ParseUtil.parseInt(all.get(0));
    }

    public List<UserWageBill> findAllByYear(String startTime, String endTime){
        DetachedCriteria d = DetachedCriteria.forClass(UserWageBill.class);
        d.add(Restrictions.ge("billDate",startTime))
                .add(Restrictions.le("billDate",endTime));
        return this.findAll(d);
    }

}
