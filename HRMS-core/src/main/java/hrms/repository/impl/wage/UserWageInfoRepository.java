package hrms.repository.impl.wage;

import hrms.common.Constant;
import hrms.entity.UserWageInfo;
import hrms.po.FindAllWageParam;
import hrms.repository.RepositorySupport;
import hrms.util.ParseUtil;
import hrms.util.StringUtil;
import hrms.vo.WageDetail;
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
@Repository("userWageInfoRepository")
public class UserWageInfoRepository extends RepositorySupport<UserWageInfo> {

    public UserWageInfo findById(Integer wageId){
        DetachedCriteria d = DetachedCriteria.forClass(UserWageInfo.class);
        d.add(Restrictions.eq("wageId",wageId));
        return this.findOne(d);
    }

    public List<WageDetail> findAllWage(FindAllWageParam param,int page,int pageSize){
        String sql = "select a.user_id,a.user_name as aName,b.org_name, " +
                " c.wage_id,c.base_wage,c.subsidy_phone,c.subsidy_ins, " +
                " c.subsidy_other,c.subsidy_other_desc,c.create_time,d.user_name as bName,a.user_phone" +
                " from user_wage_info c,user_info a" +
                " left join org_member_info e on a.user_id=e.user_id and status=?" +
                " left join org_info b on b.org_id = e.org_id and org_status=?," +
                " user_info d " +
                " where c.user_id=a.user_id and c.create_user_id = d.user_id and a.user_status = ? ";
        if(param != null){
            if(!StringUtil.isEmpty(param.getUserName())){
                sql += " and a.USER_NAME LIKE "+param.getUserName();
            }
            if(! StringUtil.isEmpty(param.getUserPhone())){
                sql  += " and a.USER_PHONE LIKE " +param.getUserPhone();
            }
            if(! StringUtil.isEmpty(param.getUserId())){
                sql += " and a.USER_ID LIKE "+ param.getUserId();
            }
            if(! StringUtil.isEmpty(param.getOrgName())){
                sql  += " and b.ORG_NAME like "+param.getOrgName();
            }
        }

        sql += " order by a.user_id asc";


        List<Object> objects = this.executeSqlPage(sql, page, pageSize, Constant.STATUS_ABLE, Constant.STATUS_ABLE, Constant.STATUS_ABLE);
        if(objects == null || objects.size() < 1){
            return null;
        }
        List<WageDetail> list = new ArrayList<>();
        for(Object object:objects){
            Object[] o = (Object[]) object;
            WageDetail detail = new WageDetail();
            detail.setUserId(ParseUtil.parseInt(o[0]));
            detail.setUserName(ParseUtil.parseString(o[1]));
            detail.setOrgName(ParseUtil.parseString(o[2]));
            detail.setWageId(ParseUtil.parseInt(o[3]));
            detail.setBaseWage(ParseUtil.parseBigDecimal(o[4]));
            detail.setSubsidyPhone(ParseUtil.parseBigDecimal(o[5]));
            detail.setSubsidyIns(ParseUtil.parseBigDecimal(o[6]));
            detail.setSubsidyOther(ParseUtil.parseBigDecimal(o[7]));
            if(StringUtil.isEmpty(ParseUtil.parseString(o[8]))){
                detail.setSubsidyOtherDesc("");
            }else{
                detail.setSubsidyOtherDesc(ParseUtil.parseString(o[8]));
            }
            detail.setCreateTime(ParseUtil.parseString(o[9]));
            detail.setCreateUserName(ParseUtil.parseString(o[10]));
            detail.setUserPhone(ParseUtil.parseString(o[11]));
            list.add(detail);
        }

        return list;
    }

    public int countAllWage(FindAllWageParam param){
        String sql = "select count(a.user_id) " +
                " from user_wage_info c,user_info a" +
                " left join org_member_info e on a.user_id=e.user_id and status=?" +
                " left join org_info b on b.org_id = e.org_id and org_status=?," +
                " user_info d " +
                " where c.user_id=a.user_id and c.create_user_id = d.user_id and a.user_status = ? ";
        if(param != null){
            if(!StringUtil.isEmpty(param.getUserName())){
                sql += " and a.USER_NAME LIKE '"+param.getUserName()+"'";
            }
            if(! StringUtil.isEmpty(param.getUserPhone())){
                sql  += " and a.USER_PHONE LIKE '" +param.getUserPhone()+"'";
            }
            if(! StringUtil.isEmpty(param.getUserId())){
                sql += " and a.USER_ID LIKE '"+ param.getUserId()+"'";
            }
            if(! StringUtil.isEmpty(param.getOrgName())){
                sql  += " and b.ORG_NAME like '"+param.getOrgName()+"'";
            }
        }


        List<Object> objects = this.executeSql(sql, Constant.STATUS_ABLE, Constant.STATUS_ABLE, Constant.STATUS_ABLE);
        if(objects == null || objects.size() < 1){
            return 0;
        }
        return ParseUtil.parseInt(objects.get(0));

    }

    public WageDetail findUserWage(Integer userId){
        String sql = "select a.user_id,a.user_name as aName,b.org_name, " +
                " c.wage_id,c.base_wage,c.subsidy_phone,c.subsidy_ins, " +
                " c.subsidy_other,c.subsidy_other_desc,c.create_time,d.user_name as bName" +
                " from user_wage_info c,user_info a" +
                " left join org_member_info e on a.user_id=e.user_id and status=?" +
                " left join org_info b on b.org_id = e.org_id and org_status=?," +
                " user_info d " +
                " where c.user_id=a.user_id and c.create_user_id = d.user_id and a.user_status = ? and c.USER_ID = ?";
        List<Object> objects = this.executeSql(sql, Constant.STATUS_ABLE, Constant.STATUS_ABLE, Constant.STATUS_ABLE, userId);
        if(objects == null || objects.size() < 1){
            return null;
        }
        Object[] o = (Object[]) objects.get(0);

        WageDetail detail = new WageDetail();
        detail.setUserId(ParseUtil.parseInt(o[0]));
        detail.setUserName(ParseUtil.parseString(o[1]));
        detail.setOrgName(ParseUtil.parseString(o[2]));
        detail.setWageId(ParseUtil.parseInt(o[3]));
        detail.setBaseWage(ParseUtil.parseBigDecimal(o[4]));
        detail.setSubsidyPhone(ParseUtil.parseBigDecimal(o[5]));
        detail.setSubsidyIns(ParseUtil.parseBigDecimal(o[6]));
        detail.setSubsidyOther(ParseUtil.parseBigDecimal(o[7]));
        detail.setSubsidyOtherDesc(ParseUtil.parseString(o[8]));
        detail.setCreateTime(ParseUtil.parseString(o[9]));
        detail.setCreateUserName(ParseUtil.parseString(o[10]));

        return detail;
    }

    public Map<Integer,UserWageInfo> findByUser(Collection<Integer> userIds){
        DetachedCriteria d = DetachedCriteria.forClass(UserWageInfo.class);
        d.add(Restrictions.in("userId",userIds));
        List<UserWageInfo> all = this.findAll(d);
        if(all == null || all.size() < 1){
            return null;
        }
        Map<Integer,UserWageInfo> map = new HashMap<>();
        for(UserWageInfo userWageInfo:all){
            map.put(userWageInfo.getUserId(),userWageInfo);
        }
        return map;
    }
}
