package hrms.repository.impl.user;

import hrms.common.Constant;
import hrms.entity.UserInfo;
import hrms.model.UserBaseInfo;
import hrms.po.FindSignParam;
import hrms.po.FindUserParam;
import hrms.po.SearchBillParam;
import hrms.repository.RepositorySupport;
import hrms.util.DateUtil;
import hrms.util.EnumerateUtil;
import hrms.util.ParseUtil;
import hrms.util.StringUtil;
import hrms.vo.BillDetail;
import hrms.vo.UserDetail;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

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


    public List<UserDetail> findUsers(FindUserParam param,boolean includeSensitive, int page, int pageSize){
        String sql = "";
        if(includeSensitive){
            sql = "select a.USER_ID,a.USER_NAME,a.USER_PHONE,a.USER_SEX," +
                    "a.WORK_STATUS,c.USER_CARD_NUMBER,c.DATA_OF_BIRTH,c.WORK_TIME,d.JOB_NAME,e.ORG_NAME,e.ORG_ID " +
                    " from user_sensitive_info c,user_info a " +
                    " left join org_member_info d on d.USER_ID = a.USER_ID and d.STATUS = ? " +
                    " LEFT JOIN org_info e ON e.ORG_ID = d.ORG_id AND e.ORG_STATUS = ? " +
                    " where  a.USER_ID = c.USER_ID " +
                    " AND a.USER_STATUS = ? ";
        }else{
            sql = "select a.USER_ID,a.USER_NAME,a.USER_PHONE,a.USER_SEX," +
                    "a.WORK_STATUS,c.DATA_OF_BIRTH,d.JOB_NAME,e.ORG_NAME,e.ORG_ID " +
                    " from user_sensitive_info c,user_info a " +
                    " left join org_member_info d on d.USER_ID = a.USER_ID and d.STATUS = ? " +
                    " LEFT JOIN org_info e ON e.ORG_ID = d.ORG_id AND e.ORG_STATUS = ? " +
                    " where  a.USER_ID = c.USER_ID " +
                    " AND a.USER_STATUS = ? ";
        }
        if(param != null){
            if(! StringUtil.isEmpty(param.getUserPhone())){
                sql += " AND a.USER_PHONE LIKE '"+param.getUserPhone().trim()+"'";
            }
            if(! StringUtil.isEmpty(param.getUserName())){
                sql += " AND a.USER_NAME LIKE '"+param.getUserName().trim()+"'";
            }
            if(! StringUtil.isEmpty(param.getJobName())){
                sql += " AND d.JOB_NAME LIKE '"+param.getJobName().trim()+"'";
            }
            if(! StringUtil.isEmpty(param.getOrgName())){
                sql += " AND e.ORG_NAME LIKE '"+param.getOrgName().trim()+"'";
            }
        }

        List<Object> objects = this.executeSqlPage(sql, page, pageSize, Constant.STATUS_ABLE, Constant.STATUS_ABLE, Constant.STATUS_ABLE);
        if(objects == null || objects.size() < 1){
            return null;
        }
        List<UserDetail> userDetails = new ArrayList<>();
        if(includeSensitive){
            for(Object object:objects){
                Object[] o = (Object[]) object;
                UserDetail userDetail  = new UserDetail();

                userDetail.setUserID(ParseUtil.parseInt(o[0]));
                userDetail.setUserName(ParseUtil.parseString(o[1]));
                userDetail.setUserPhone(ParseUtil.parseString(o[2]));
                userDetail.setUserSex(ParseUtil.parseByte(o[3]));
                userDetail.setUserSexMessage(EnumerateUtil.translator("user_info-SEX-"+ParseUtil.parseByte(o[3])));
                userDetail.setWorkStatus(ParseUtil.parseByte(o[4]));
                userDetail.setWorkStatusMessage(EnumerateUtil.translator("user_info-WORK_STATUS-"+userDetail.getWorkStatus()));

                userDetail.setUserCardNumber(ParseUtil.parseString(o[5]));
                userDetail.setDataOfBirth(ParseUtil.parseString(o[6]));
                userDetail.setUserAge(DateUtil.yearBetweenTwoDate(ParseUtil.parseString(o[6]),DateUtil.formatDate()));
                userDetail.setWorkTime(ParseUtil.parseString(o[7]));
                userDetail.setJobName(ParseUtil.parseString(o[8]));
                userDetail.setOrgID(ParseUtil.parseInt(o[9]));
                userDetails.add(userDetail);
            }
        }else{
            for(Object object:objects){
                Object[] o = (Object[]) object;
                UserDetail userDetail  = new UserDetail();

                userDetail.setUserID(ParseUtil.parseInt(o[0]));
                userDetail.setUserName(ParseUtil.parseString(o[1]));
                userDetail.setUserPhone(ParseUtil.parseString(o[2]));
                userDetail.setUserSex(ParseUtil.parseByte(o[3]));
                userDetail.setUserSexMessage(EnumerateUtil.translator("user_info-SEX-"+ParseUtil.parseByte(o[3])));
                userDetail.setWorkStatus(ParseUtil.parseByte(o[4]));
                userDetail.setWorkStatusMessage(EnumerateUtil.translator("user_info-WORK_STATUS-"+userDetail.getWorkStatus()));

                userDetail.setUserCardNumber("");
                userDetail.setDataOfBirth(ParseUtil.parseString(o[6]));
                userDetail.setUserAge(DateUtil.yearBetweenTwoDate(ParseUtil.parseString(o[6]),DateUtil.formatDate()));
                userDetail.setWorkTime("");
                userDetail.setJobName(ParseUtil.parseString(o[8]));
                userDetail.setOrgID(ParseUtil.parseInt(o[9]));
                userDetails.add(userDetail);
            }
        }

        return userDetails;
    }
    public int findUserCount(FindUserParam param,boolean includeSensitive){
        String sql = "";
        sql = "select count(a.USER_ID) " +
                " from user_sensitive_info c,user_info a " +
                " left join org_member_info d on d.USER_ID = a.USER_ID and d.STATUS = ? " +
                " LEFT JOIN org_info e ON e.ORG_ID = d.ORG_id AND e.ORG_STATUS = ? " +
                " where  a.USER_ID = c.USER_ID " +
                " AND a.USER_STATUS = ? ";
        if(param != null){
            if(! StringUtil.isEmpty(param.getUserPhone())){
                sql += " AND a.USER_PHONE LIKE '"+param.getUserPhone().trim()+"'";
            }
            if(! StringUtil.isEmpty(param.getUserName())){
                sql += " AND a.USER_NAME LIKE '"+param.getUserName().trim()+"'";
            }
            if(! StringUtil.isEmpty(param.getJobName())){
                sql += " AND d.JOB_NAME LIKE '"+param.getJobName().trim()+"'";
            }
            if(! StringUtil.isEmpty(param.getOrgName())){
                sql += " AND e.ORG_NAME LIKE '"+param.getOrgName().trim()+"'";
            }
        }

        List<Object> objects = this.executeSql(sql, Constant.STATUS_ABLE, Constant.STATUS_ABLE, Constant.STATUS_ABLE);
        if(objects == null || objects.size() < 1){
            return 0;
        }
        return ParseUtil.parseInt(objects.get(0));
    }

    public List<UserDetail> findUserBaseInfos(FindUserParam param, int page, int pageSize){
        String sql = "";
        sql = "select a.USER_ID,a.USER_NAME,a.USER_PHONE,a.USER_SEX, " +
                "a.WORK_STATUS,c.DATA_OF_BIRTH,d.JOB_NAME,e.ORG_NAME,e.ORG_ID " +
                "from user_sensitive_info c,user_info a "+
                "left join org_member_info d on d.USER_ID = a.USER_ID and d.STATUS = ?  "+
                "left join org_info e  on d.ORG_ID = e.ORG_ID AND e.ORG_STATUS = ? "+
                "where  a.USER_ID = c.USER_ID "+
                "AND a.USER_STATUS = ? ";
        if(param != null){
            if(! StringUtil.isEmpty(param.getUserID())) {
                sql += " AND a.USER_ID LIKE '"+param.getUserID().trim()+"'";
            }
            if(! StringUtil.isEmpty(param.getUserPhone())){
                sql += " AND a.USER_PHONE LIKE '"+param.getUserPhone().trim()+"'";
            }
            if(! StringUtil.isEmpty(param.getUserName())){
                sql += " AND a.USER_NAME LIKE '"+param.getUserName().trim()+"'";
            }
            if(! StringUtil.isEmpty(param.getJobName())){
                sql += " AND d.JOB_NAME LIKE '"+param.getJobName().trim()+"'";
            }
            if(! StringUtil.isEmpty(param.getOrgName())){
                sql += " AND e.ORG_NAME LIKE '"+param.getOrgName().trim()+"'";
            }
        }

        List<Object> objects = this.executeSqlPage(sql, page, pageSize, Constant.STATUS_ABLE, Constant.STATUS_ABLE, Constant.STATUS_ABLE);
        if(objects == null || objects.size() < 1){
            return null;
        }
        List<UserDetail> userDetails = new ArrayList<>();
        for(Object object:objects){
            Object[] o = (Object[]) object;
            System.out.println(o.toString());
            UserDetail userDetail  = new UserDetail();

            userDetail.setUserID(ParseUtil.parseInt(o[0]));
            userDetail.setUserName(ParseUtil.parseString(o[1]));
            userDetail.setUserPhone(ParseUtil.parseString(o[2]));
            userDetail.setUserSex(ParseUtil.parseByte(o[3]));
            userDetail.setUserSexMessage(EnumerateUtil.translator("user_info-SEX-"+ParseUtil.parseByte(o[3])));
            userDetail.setWorkStatus(ParseUtil.parseByte(o[4]));
            userDetail.setWorkStatusMessage(EnumerateUtil.translator("user_info-WORK_STATUS-"+userDetail.getWorkStatus()));

            userDetail.setDataOfBirth(ParseUtil.parseString(o[5]));
            userDetail.setUserAge(DateUtil.yearBetweenTwoDate(ParseUtil.parseString(o[5]),DateUtil.formatDate()));
            userDetail.setJobName(ParseUtil.parseString(o[6]));
            userDetail.setOrgName(ParseUtil.parseString(o[7]));
            userDetail.setOrgID(ParseUtil.parseInt(o[8]));
            userDetails.add(userDetail);
        }

        return userDetails;
    }
    public int findUserBaseInfoCount(FindUserParam param){
        String sql = "select count(a.USER_ID) " +
                "from user_sensitive_info c,user_info a "+
                " left join org_member_info d on d.USER_ID = a.USER_ID and d.STATUS = ? " +
                " LEFT JOIN org_info e ON e.ORG_ID = d.ORG_id AND e.ORG_STATUS = ? " +
                "where  a.USER_ID = c.USER_ID "+
                "AND a.USER_STATUS = ? ";
        if(param != null){
            if(! StringUtil.isEmpty(param.getUserID())) {
                sql += " AND a.USER_ID LIKE '"+param.getUserID()+"'";
            }
            if(! StringUtil.isEmpty(param.getUserPhone())){
                sql += " AND a.USER_PHONE LIKE '"+param.getUserPhone()+"'";
            }
            if(! StringUtil.isEmpty(param.getUserName())){
                sql += " AND a.USER_NAME LIKE '"+param.getUserName()+"'";
            }
            if(! StringUtil.isEmpty(param.getJobName())){
                sql += " AND d.JOB_NAME LIKE '"+param.getJobName()+"'";
            }
            if(! StringUtil.isEmpty(param.getOrgName())){
                sql += " AND e.ORG_NAME LIKE '"+param.getOrgName()+"'";
            }
        }

        List<Object> objects = this.executeSql(sql, Constant.STATUS_ABLE, Constant.STATUS_ABLE, Constant.STATUS_ABLE);
        if(objects == null || objects.size() < 1){
            return 0;
        }
        return ParseUtil.parseInt(objects.get(0));
    }
    public UserDetail findUserDetail(Integer userID,boolean includeSensitive){
        String sql = "";
        if(includeSensitive){
            sql = "select a.USER_ID,a.USER_NAME,a.USER_PHONE,a.USER_SEX,b.PIC_URL," +
                    "a.WORK_STATUS,c.USER_CARD_NUMBER,c.DATA_OF_BIRTH,c.WORK_TIME,d.JOB_NAME,e.ORG_NAME,e.ORG_ID,a.USER_EMAIL " +
                    " from user_sensitive_info c,user_info a " +
                    " left join picture_info b on a.USER_ID = b.REL_ID AND b.REL_TYPE = ? AND b.PIC_STATUS = ? " +
                    " left join org_member_info d on d.USER_ID = a.USER_ID and d.STATUS = ? " +
                    " LEFT JOIN org_info e ON e.ORG_ID = d.ORG_id AND e.ORG_STATUS = ? " +
                    " where  a.USER_ID = c.USER_ID AND a.USER_ID = ?  AND a.USER_STATUS = ?";
        }else{
            sql = "select a.USER_ID,a.USER_NAME,a.USER_PHONE,a.USER_SEX,b.PIC_URL," +
                    "a.WORK_STATUS,c.DATA_OF_BIRTH,d.JOB_NAME,e.ORG_NAME,e.ORG_ID,a.USER_EMAIL " +
                    " from user_sensitive_info c,user_info a " +
                    " left join picture_info b on a.USER_ID = b.REL_ID AND b.REL_TYPE = ? AND b.PIC_STATUS = ? " +
                    " left join org_member_info d on d.USER_ID = a.USER_ID and d.STATUS = ? " +
                    " LEFT JOIN org_info e ON e.ORG_ID = d.ORG_id AND e.ORG_STATUS = ? " +
                    " where  a.USER_ID = c.USER_ID AND a.USER_ID = ?  AND a.USER_STATUS = ?";
        }

        List<Object> objects = this.executeSql(sql,Constant.REL_TYPE_USER_PHOTO, Constant.STATUS_ABLE, Constant.STATUS_ABLE, Constant.STATUS_ABLE ,userID,Constant.STATUS_ABLE);
        if(objects == null || objects.size() < 1){
            return null;
        }
        UserDetail userDetail  = new UserDetail();
        if(includeSensitive){
                Object[] o = (Object[]) objects.get(0);

                userDetail.setUserID(ParseUtil.parseInt(o[0]));
                userDetail.setUserName(ParseUtil.parseString(o[1]));
                userDetail.setUserPhone(ParseUtil.parseString(o[2]));
                userDetail.setUserSex(ParseUtil.parseByte(o[3]));
                userDetail.setUserSexMessage(EnumerateUtil.translator("user_info-SEX-"+ParseUtil.parseByte(o[3])));
                userDetail.setUserPhoto(ParseUtil.parseString(o[4]));
                userDetail.setWorkStatus(ParseUtil.parseByte(o[5]));
                userDetail.setWorkStatusMessage(EnumerateUtil.translator("user_info-WORK_STATUS-"+userDetail.getWorkStatus()));


                userDetail.setUserCardNumber(ParseUtil.parseString(o[6]));
                userDetail.setDataOfBirth(ParseUtil.parseString(o[7]));
                userDetail.setUserAge(DateUtil.yearBetweenTwoDate(ParseUtil.parseString(o[7]),DateUtil.formatDate()));
                userDetail.setWorkTime(ParseUtil.parseString(o[8]));
                userDetail.setJobName(ParseUtil.parseString(o[9]));
                userDetail.setOrgName(ParseUtil.parseString(o[10]));
                userDetail.setOrgID(ParseUtil.parseInt(o[11]));
                userDetail.setUserEamil(ParseUtil.parseString(o[12]));
        }else{
                Object[] o = (Object[]) objects.get(0);

                userDetail.setUserID(ParseUtil.parseInt(o[0]));
                userDetail.setUserName(ParseUtil.parseString(o[1]));
                userDetail.setUserPhone(ParseUtil.parseString(o[2]));
                userDetail.setUserSex(ParseUtil.parseByte(o[3]));
                userDetail.setUserSexMessage(EnumerateUtil.translator("user_info-SEX-"+ParseUtil.parseByte(o[3])));
                userDetail.setUserPhoto(ParseUtil.parseString(o[4]));
                userDetail.setWorkStatus(ParseUtil.parseByte(o[5]));
                userDetail.setWorkStatusMessage(EnumerateUtil.translator("user_info-WORK_STATUS-"+userDetail.getWorkStatus()));

                userDetail.setUserCardNumber("");
                userDetail.setDataOfBirth(ParseUtil.parseString(o[6]));
                userDetail.setUserAge(DateUtil.yearBetweenTwoDate(ParseUtil.parseString(o[6]),DateUtil.formatDate()));
                userDetail.setWorkTime("");
                userDetail.setJobName(ParseUtil.parseString(o[7]));
                userDetail.setOrgName(ParseUtil.parseString(o[8]));
                userDetail.setOrgID(ParseUtil.parseInt(o[9]));
            userDetail.setUserEamil(ParseUtil.parseString(o[10]));
        }

        return userDetail;
    }

    public UserInfo findByUserId(Integer userID){
        DetachedCriteria d = DetachedCriteria.forClass(UserInfo.class);
        d.add(Restrictions.eq("userId",userID));
        return this.findOne(d);
    }

    public List<UserInfo> findByUserIds(Collection<Integer> userIds){
        DetachedCriteria d = DetachedCriteria.forClass(UserInfo.class);
        d.add(Restrictions.in("userId",userIds));
        return this.findAll(d);
    }
    public List<UserInfo> findNormalIds(Collection<Integer> userIds){
        DetachedCriteria d = DetachedCriteria.forClass(UserInfo.class);
        d.add(Restrictions.in("userId",userIds))
                .add(Restrictions.eq("userStatus", Constant.STATUS_ABLE));
        return this.findAll(d);
    }
    public List<UserInfo> findNormalByPhones(Collection<String>userPhones){
        DetachedCriteria d = DetachedCriteria.forClass(UserInfo.class);
        d.add(Restrictions.in("userPhone",userPhones))
                .add(Restrictions.eq("userStatus", Constant.STATUS_ABLE));
        return this.findAll(d);
    }

    public List<UserBaseInfo> findAllUserName(String userName){
        String sql = "select USER_ID,USER_NAME FROM user_info where USER_STATUS = ? ";
        if(! StringUtil.isEmpty(userName)){
            sql += " AND USER_NAME LIKE '"+userName+"'";
        }
        List<Object> objects = this.executeSql(sql, Constant.STATUS_ABLE);
        if(objects == null || objects.size() < 1){
            return null;
        }
        List<UserBaseInfo> list = new ArrayList<>();
        for(Object object:objects){
            Object[] o = (Object[]) object;
            UserBaseInfo userBaseInfo = new UserBaseInfo();
            userBaseInfo.setUserId(ParseUtil.parseInt(o[0]));
            userBaseInfo.setUserName(ParseUtil.parseString(o[1]));
            list.add(userBaseInfo);
        }
        return list;
    }

    public Map<String,UserInfo> findByPhones(Collection<String> phones){
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(UserInfo.class);
        detachedCriteria.add(Restrictions.in("userPhone",phones))
        .add(Restrictions.eq("userStatus",Constant.STATUS_ABLE));
        List<UserInfo> all = this.findAll(detachedCriteria);
        if(all == null || all.size() < 1) {
            return null;
        }
        Map<String,UserInfo>  map = new HashMap();
        for(UserInfo userInfo:all){
            map.put(userInfo.getUserPhone(),userInfo);
        }
        return map;
    }

    public Set<Integer> findUsers(FindSignParam param){
        String sql = "select a.USER_ID " +
                " from user_info a " +
                " left join org_member_info d on d.USER_ID = a.USER_ID and d.STATUS = ? " +
                " LEFT JOIN org_info e ON e.ORG_ID = d.ORG_id AND e.ORG_STATUS = ? " +
                " where a.USER_STATUS = ? ";
        if(param != null){
            if(! StringUtil.isEmpty(param.getUserName())){
                sql += " AND a.USER_NAME LIKE '"+param.getUserName().trim()+"'";
            }
            if(! StringUtil.isEmpty(param.getOrgName())){
                sql += " AND e.ORG_NAME LIKE '"+param.getOrgName().trim()+"'";
            }
        }

        List<Object> objects = this.executeSql(sql,Constant.STATUS_ABLE, Constant.STATUS_ABLE, Constant.STATUS_ABLE);
        if(objects == null || objects.size() < 1){
            return null;
        }
        Set<Integer> set = new HashSet<>();
        for(Object object:objects){

            set.add(ParseUtil.parseInt(object));
        }

        return set;
    }

    public List<UserInfo> findAllUser(int page,int pageSize){
        DetachedCriteria detachedCriteria  = DetachedCriteria.forClass(UserInfo.class);
        detachedCriteria.add(Restrictions.eq("userStatus",Constant.STATUS_ABLE));
        return this.findAll(detachedCriteria,page,pageSize);
    }

    public List<BillDetail> findUser(SearchBillParam param){
        String sql = " select a.user_id,a.user_name,a.user_phone,b.job_name,c.org_name " +
                " from user_info a " +
                " left join org_member_info b on b.user_id = a.user_id and b.status=? " +
                " left join org_info c on c.org_id = b.org_id and c.org_status = ? " +
                " where a.user_status = ? ";
        if(param != null){
            if(! StringUtil.isEmpty(param.getUserName())){
                sql += " and a.user_name like '"+param.getUserName()+"'";
            }
            if(! StringUtil.isEmpty(param.getUserPhone())){
                sql += " and a.user_phone like '" + param.getUserPhone()+"'";
            }
            if(! StringUtil.isEmpty(param.getOrgName())){
                sql += " and a.user_phone like '"+param.getOrgName()+"'";
            }
        }

        List<Object> objects = this.executeSql(sql, Constant.STATUS_ABLE, Constant.STATUS_ABLE, Constant.STATUS_ABLE);
        if(objects == null || objects.size() < 1){
            return null;
        }
        List<BillDetail> list = new ArrayList<>();
        for(Object object:objects){
            Object[] o = (Object[]) object;
            BillDetail detail = new BillDetail();
            detail.setUserId(ParseUtil.parseInt(o[0]));
            detail.setUserName(ParseUtil.parseString(o[1]));
            detail.setUserPhone(ParseUtil.parseString(o[2]));
            detail.setJobName(ParseUtil.parseString(o[3]));
            detail.setOrgName(ParseUtil.parseString(o[4]));
            list.add(detail);
        }
        return list;
    }

    public BillDetail findUser(Integer userId){
        String sql = " select a.user_id,a.user_name,a.user_phone,b.job_name,c.org_name " +
                " from user_info a " +
                " left join org_member_info b on b.user_id = a.user_id and b.status=? " +
                " left join org_info c on c.org_id = b.org_id and c.org_status = ? " +
                " where a.user_status = ? and a.user_id = ? ";

        List<Object> objects = this.executeSql(sql, Constant.STATUS_ABLE, Constant.STATUS_ABLE, Constant.STATUS_ABLE,userId);
        if(objects == null || objects.size() < 1){
            return null;
        }
        Object[] o = (Object[]) objects.get(0);
        BillDetail detail = new BillDetail();
        detail.setUserId(ParseUtil.parseInt(o[0]));
        detail.setUserName(ParseUtil.parseString(o[1]));
        detail.setUserPhone(ParseUtil.parseString(o[2]));
        detail.setJobName(ParseUtil.parseString(o[3]));
        detail.setOrgName(ParseUtil.parseString(o[4]));

        return detail;
    }
}
