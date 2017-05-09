package hrms.repository.impl.sign;

import hrms.common.Constant;
import hrms.entity.SignInfo;
import hrms.po.FindSignParam;
import hrms.repository.RepositorySupport;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 谢益文 on 2017/4/2.
 */
@Repository("signInfoRepository")
public class SignInfoRepository extends RepositorySupport<SignInfo> {

    public List<SignInfo> findSigns(Collection<Integer> userIds, FindSignParam param,int page,int pageSize){
        DetachedCriteria d = DetachedCriteria.forClass(SignInfo.class);
        d.add(Restrictions.in("userId",userIds))
                .add(Restrictions.le("signTime", param.getEndTime()))
                .add(Restrictions.ge("signTime",param.getStartTime()));

        if(param != null){
            List<Byte> statusList = new ArrayList<>();
            if(param.getIsEarly() != null && param.getIsEarly() == 1){
                statusList.add(Constant.SIGN_STATUS_EARLY);
            }
            if(param.getIsLater() != null && param.getIsLater() == 1){
                statusList.add(Constant.SIGN_STATUS_LATER);
            }
            if(statusList != null && statusList.size() > 0){
                d.add(Restrictions.in("signStatus",statusList));
            }
        }
        d.addOrder(Order.asc("signTime"));

        return this.findAll(d,page,pageSize);
    }

    public int countFindSigns(Collection<Integer> userIds, FindSignParam param){
        DetachedCriteria d = DetachedCriteria.forClass(SignInfo.class);
        d.add(Restrictions.in("userId",userIds))
                .add(Restrictions.le("signTime", param.getEndTime()))
                .add(Restrictions.ge("signTime",param.getStartTime()));

        if(param != null){
            List<Byte> statusList = new ArrayList<>();
            if(param.getIsEarly() != null && param.getIsEarly() == 1){
                statusList.add(Constant.SIGN_STATUS_EARLY);
            }
            if(param.getIsLater() != null && param.getIsLater() == 1){
                statusList.add(Constant.SIGN_STATUS_LATER);
            }
            if(statusList != null && statusList.size() > 1){
                d.add(Restrictions.in("signStatus",statusList));
            }
        }

        return this.count(d);
    }

    public boolean isRepeatSign(Integer userId,String date,Byte signType){
        DetachedCriteria d = DetachedCriteria.forClass(SignInfo.class);
        d.add(Restrictions.eq("userId",userId))
                .add(Restrictions.eq("signType",signType))
                .add(Restrictions.like("signTime",date,MatchMode.START));
        SignInfo one = this.findOne(d);
        if(one == null){
            return false;
        }
        return true;

    }

    public Map<Integer,List<SignInfo>> findAll(Collection<Integer> userIds,String startTime,String endTime){
        DetachedCriteria d = DetachedCriteria.forClass(SignInfo.class);
        d.add(Restrictions.in("userId",userIds))
                .add(Restrictions.lt("signTime",endTime))
                .add(Restrictions.ge("signTime",startTime));
        List<SignInfo> all = this.findAll(d);
        if(all == null || all.size() < 1){
            return null;
        }
        Map<Integer,List<SignInfo>> map = new HashMap<>();
        for(SignInfo signInfo:all){
            if(map.containsKey(signInfo.getUserId())){
                map.get(signInfo.getUserId()).add(signInfo);
            }else{
                List<SignInfo> list = new ArrayList<>();
                list.add(signInfo);
                map.put(signInfo.getUserId(),list);
            }
        }
        return map;
    }

    public List<SignInfo> findAll(String startTime,String endTime){
        DetachedCriteria d = DetachedCriteria.forClass(SignInfo.class);
        d.add(Restrictions.ge("signTime",startTime))
                .add(Restrictions.le("signTime",endTime));
        return this.findAll(d);

    }
}
