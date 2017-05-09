package hrms.repository.impl.org;

import hrms.common.Constant;
import hrms.entity.OrgInfo;
import hrms.model.OrgBaseInfo;
import hrms.po.FindOrgParam;
import hrms.repository.RepositorySupport;
import hrms.util.ParseUtil;
import hrms.util.StringUtil;
import hrms.vo.OrgInfoVo;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by 谢益文 on 2017/3/20.
 */
@Repository("orgInfoRepository")
public class OrgInfoRepository extends RepositorySupport<OrgInfo> {

    /**
     * @describe 根据部门名字查找
     * @author xieyw
     * @param param
     * @return
     */
    public List<OrgInfoVo> findAllByChose(FindOrgParam param,int page,int pageSize){
        String sql = "select a.ORG_ID,a.PARENT_ORG_ID,a.ORG_NAME,a.CREATE_TIME,c.USER_NAME,a.ORG_DESC, b.ORG_NAME as parentOrgName " +
                " from org_info a " +
                " left join org_info b on a.PARENT_ORG_ID = b.ORG_ID AND b.ORG_STATUS = ?" +
                " left join user_info c on a.CREATE_USER_ID=c.USER_ID and c.USER_STATUS = ?" +
                " where a.ORG_STATUS = ? ";

        if(param != null){
            if(! StringUtil.isEmpty(param.getOrgName())){
                sql += " AND a.ORG_NAME LIKE '"+param.getOrgName()+"'";
            }
            if(! StringUtil.isEmpty(param.getParentOrgName())){
                sql += " AND b.ORG_NAME LIKE '"+param.getParentOrgName()+"'";
            }
            if(! StringUtil.isEmpty(param.getOrgId())){
                sql += " AND a.ORG_ID LIKE '"+param.getOrgId()+"'";
            }
            if(! StringUtil.isEmpty(param.getParentOrgId())){
                sql += " AND a.PARENT_ORG_ID LIKE '"+param.getParentOrgId()+"'";
            }
        }

        List<Object> objects = this.executeSqlPage(sql,page,pageSize, Constant.STATUS_ABLE, Constant.STATUS_ABLE, Constant.STATUS_ABLE);
        if(objects == null || objects.size() < 1){
            return null;
        }
        List<OrgInfoVo> list = new ArrayList<>();
        for(Object object:objects){
            Object[] o = (Object[]) object;
            OrgInfoVo orgInfoVo = new OrgInfoVo();
            orgInfoVo.setOrgId(ParseUtil.parseInt(o[0]));
            orgInfoVo.setParentOrgId(ParseUtil.parseInt(o[1]));
            orgInfoVo.setOrgName(ParseUtil.parseString(o[2]));
            orgInfoVo.setCreateTime(ParseUtil.parseString(o[3]));
            orgInfoVo.setCreateUserName(ParseUtil.parseString(o[4]));
            orgInfoVo.setOrgDesc(ParseUtil.parseString(o[5]));
            orgInfoVo.setParentOrgName(ParseUtil.parseString(o[6]));
            list.add(orgInfoVo);
        }
        return list;
    }
    public int countAllByChose(FindOrgParam param){
        String sql = "select count(a.ORG_ID) " +
                " from org_info a " +
                " left join org_info b on a.PARENT_ORG_ID = b.ORG_ID AND b.ORG_STATUS = ? " +
                " left join user_info c on a.CREATE_USER_ID=c.USER_ID AND c.USER_STATUS = ? " +
                " where a.ORG_STATUS = ? ";

        if(param != null){
            if(! StringUtil.isEmpty(param.getOrgName())){
                sql += " AND a.ORG_NAME LIKE '"+param.getOrgName()+"'";
            }
            if(! StringUtil.isEmpty(param.getParentOrgName())){
                sql += " AND b.ORG_NAME LIKE '"+param.getParentOrgName()+"'";
            }
            if(! StringUtil.isEmpty(param.getOrgId())){
                sql += " AND a.ORG_ID LIKE '"+param.getOrgId()+"'";
            }
            if(! StringUtil.isEmpty(param.getParentOrgId())){
                sql += " AND a.PARENT_ORG_ID LIKE '"+param.getParentOrgId()+"'";
            }
        }

        List<Object> objects = this.executeSql(sql, Constant.STATUS_ABLE, Constant.STATUS_ABLE, Constant.STATUS_ABLE);
        if(objects == null || objects.size() < 1){
            return 0;
        }
        return ParseUtil.parseInt(objects.get(0));
    }
    public OrgInfo findByName(String orgName){
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(OrgInfo.class);
        detachedCriteria.add(Restrictions.eq("orgName",orgName))
                .add(Restrictions.eq("orgStatus", Constant.STATUS_ABLE));
        OrgInfo one = this.findOne(detachedCriteria);
        if(one == null){
            return null;
        }
        return one;
    }

    public List<OrgInfo> findAllOrg(){
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(OrgInfo.class);
        detachedCriteria.add(Restrictions.eq("orgStatus", Constant.STATUS_ABLE));
        List<OrgInfo> all = this.findAll(detachedCriteria);
        if(all == null || all.size() < 1){
            return null;
        }
        return all;
    }

    public List<OrgBaseInfo> findBaseAllOrg(){
        List<OrgBaseInfo> list = new ArrayList<>();

        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(OrgInfo.class);
        detachedCriteria.add(Restrictions.eq("orgStatus", Constant.STATUS_ABLE));
        List<OrgInfo> all = this.findAll(detachedCriteria);
        if(all == null || all.size() < 1){
            return null;
        }
        for(OrgInfo orgInfo:all){
            OrgBaseInfo orgBaseInfo= new OrgBaseInfo();
            orgBaseInfo.setOrgName(orgInfo.getOrgName());
            orgBaseInfo.setOrgId(orgInfo.getOrgId()+"");
            list.add(orgBaseInfo);
        }
        return list;
    }

    /**
     * @describe 通过名称查找部门
     * @param orgName
     * @return
     */
    public OrgInfo findOrgByName(String orgName){
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(OrgInfo.class);
        detachedCriteria.add(Restrictions.eq("orgStatus", Constant.STATUS_ABLE))
            .add(Restrictions.eq("orgName",orgName));
        return this.findOne(detachedCriteria);
    }

    public OrgInfo findById(Integer orgID){
        DetachedCriteria d = DetachedCriteria.forClass(OrgInfo.class);
        d.add(Restrictions.eq("orgId",orgID));
        return this.findOne(d);
    }
}
