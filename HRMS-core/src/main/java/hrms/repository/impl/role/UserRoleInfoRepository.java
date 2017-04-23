package hrms.repository.impl.role;

import hrms.common.Constant;
import hrms.entity.UserRoleInfo;
import hrms.repository.RepositorySupport;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    /**
     * @describe 查询一组用户的权限
     * @param userIds
     * @return
     */
    public Map findUserRole(Collection<Integer> userIds){
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(UserRoleInfo.class);
        detachedCriteria.add(Restrictions.in("userId",userIds))
                .add(Restrictions.eq("status",Constant.ROLE_ABLE));
        List<UserRoleInfo> all = this.findAll(detachedCriteria);
        Map<Integer,Integer> resultMap = new HashMap<>();

        if(all == null || all.size() < 1){
            for(UserRoleInfo userRoleInfo:all){
                resultMap.put(userRoleInfo.getUserId(),Constant.ROLE_WORKER_VALUE);
            }
        }else{
            for(UserRoleInfo userRoleInfo:all){
                resultMap.put(userRoleInfo.getUserId(),userRoleInfo.getRoleId());
            }
        }
        return resultMap;

    }

    /**
     * @describe 查询是否拥有指定权限
     * @param roleID
     * @param userID
     * @return
     */
    public UserRoleInfo findByRole(Integer roleID,Integer userID){
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(UserRoleInfo.class);
        detachedCriteria.add(Restrictions.eq("userId",userID))
                .add(Restrictions.eq("roleId",roleID))
                .add(Restrictions.eq("status",Constant.ROLE_ABLE));
        return findOne(detachedCriteria);
    }

    /**
     * @describe 是否有hr或系统管理员权限
     * @param userID
     * @return
     */
    public boolean isHROrSM(Integer userID){
        String sql = "select USER_ROLE_ID ,CREATE_TIME ,CREATE_USER_ID ,ROLE_ID ,STATUS,USER_ID " +
                " from user_role_info " +
                " where USER_ID=? and ROLE_ID in ( "+Constant.ROLE_HR_VALUE+", "+Constant.ROLE_SYSTEM_MANAGER_VALUE+" )  and STATUS=?";

        List<Object> objects = executeSql(sql, userID, Constant.ROLE_ABLE);
        if(objects != null && objects.size() > 0){
            return true;
        }else{
            return false;
        }
    }
}
