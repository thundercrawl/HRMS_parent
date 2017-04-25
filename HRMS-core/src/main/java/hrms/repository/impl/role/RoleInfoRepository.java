package hrms.repository.impl.role;

import hrms.entity.RoleInfo;
import hrms.model.RoleBaseInfo;
import hrms.repository.RepositorySupport;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

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

    public RoleInfo findById(Integer roleID){
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(RoleInfo.class);
        detachedCriteria.add(Restrictions.eq("roleId",roleID));
        return this.findOne(detachedCriteria);
    }
    public List<RoleBaseInfo> findBaseAll(){
        List<RoleInfo> all = this.findAll();
        if(all == null || all.size() < 1){
            return null;
        }
        List<RoleBaseInfo> list = new ArrayList<>();
        for(RoleInfo roleInfo:all){
            RoleBaseInfo roleBaseInfo = new RoleBaseInfo();
            roleBaseInfo.setRoleId(roleInfo.getRoleId()+"");
            roleBaseInfo.setRoleName(roleInfo.getRoleName());
            list.add(roleBaseInfo);
        }
        return list;
    }
}
