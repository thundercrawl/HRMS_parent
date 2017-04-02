package hrms.repository.impl.org;

import hrms.common.Constant;
import hrms.entity.OrgMemberInfo;
import hrms.model.OrgMemberDetail;
import hrms.repository.RepositorySupport;
import hrms.util.ParseUtil;
import hrms.vo.LoginInfo;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by 谢益文 on 2017/3/20.
 */
@Repository("orgMemberInfoRepository")
public class OrgMemberInfoRepository extends RepositorySupport<OrgMemberInfo> {

    /**
     * @describe 获取用户部门信息
     * @param userID
     * @return
     */
    public LoginInfo findByUserID(Integer userID){
        String sql = "SELECT a.ORG_ID,a.ORG_NAME,b.JOB_NAME,b.JOIN_TIME FROM org_info a,org_member_info b " +
                " WHERE a.ORG_ID = b.ORG_ID AND b.USER_ID = ? AND b.STATUS = ?" +
                " AND a.ORG_STATUS = ?";

        List<Object> objects = this.executeSql(sql, userID, Constant.STATUS_ABLE, Constant.STATUS_ABLE);

        LoginInfo param = new LoginInfo();
        if(objects == null || objects.size() < 1){
            return param;
        }
        //一个人只有一个在职部门
        Object[] o = (Object[]) objects.get(0);
        param.setOrgId(ParseUtil.parseInt(o[0]));
        param.setOrgName(ParseUtil.parseString(o[1]));
        param.setJobName(ParseUtil.parseString(o[2]));
        param.setJoinTime(ParseUtil.parseString(o[3]));
        return param;
    }

    /**
     * @describe 查询用户是否有部门了
     * @param userID
     * @return
     */
    public boolean hasOrg(Integer userID){
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(OrgMemberInfo.class);
        detachedCriteria.add(Restrictions.eq("userId",userID))
                .add(Restrictions.eq("status",Constant.STATUS_ABLE));
        OrgMemberInfo one = this.findOne(detachedCriteria);
        if(one == null){
            return false;
        }
        return true;
    }

    /**
     * @describe 查询用户的部门编号、部门名称和职称
     * @param userID
     * @return
     */
    public OrgMemberDetail findOrg(Integer userID){
        String sql = "select a.ORG_ID,a.ORG_NAME,b.JOB_NAME FROM org_info a,org_member_info b " +
                " WHERE a.ORG_ID = b.ORG_ID AND b.USER_ID = ? AND b.STATUS = ? ";
        List<Object> objects = this.executeSql(sql, userID, Constant.STATUS_ABLE);
        if(objects == null || objects.size() < 1){
            return null;
        }
        Object[] o = (Object[]) objects.get(0);
        OrgMemberDetail detail = new OrgMemberDetail();
        detail.setUserID(userID);
        detail.setOrgID(ParseUtil.parseInt(o[0]));
        detail.setOrgName(ParseUtil.parseString(o[1]));
        detail.setJobName(ParseUtil.parseString(o[2]));
        return detail;
    }
}
