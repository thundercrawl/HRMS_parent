package hrms.repository.impl.org;

import hrms.common.Constant;
import hrms.entity.OrgManagerInfo;
import hrms.model.UserBaseInfo;
import hrms.repository.RepositorySupport;
import hrms.util.ParseUtil;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import java.util.List;

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
     * @describe 查询部门经理的编号和姓名
     * @author xieyw
     * @param orgId
     * @return
     */
    public UserBaseInfo getManagerDetail(Integer orgId){
        String sql  = "select a.USER_ID,a.USER_NAME from user_info a ,org_manager_info b " +
                " where a.USER_ID = b.USER_ID and b.STATUS = ? limit 1";
        List<Object> objects = this.executeSql(sql, Constant.STATUS_ABLE);
        if(objects == null || objects.size() < 1){
            return null;
        }
        UserBaseInfo userBaseInfo = new UserBaseInfo();
        Object[] o = (Object[]) objects.get(0);
        userBaseInfo.setUserId(ParseUtil.parseInt(o[0]));
        userBaseInfo.setUserName(ParseUtil.parseString(o[1]));
        return userBaseInfo;
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


    /**
     * @describe 查找部门经理记录
     * @author xieyw
     * @param orgId
     * @return
     */
    public OrgManagerInfo getOrgManager(Integer orgId){
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(OrgManagerInfo.class);
        detachedCriteria.add(Restrictions.eq("orgId",orgId))
                    .add(Restrictions.eq("status",Constant.STATUS_ABLE));
        return this.findOne(detachedCriteria);
    }
}
