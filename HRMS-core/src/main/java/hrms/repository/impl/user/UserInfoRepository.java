package hrms.repository.impl.user;

import hrms.common.Constant;
import hrms.entity.UserInfo;
import hrms.po.FindUserParam;
import hrms.repository.RepositorySupport;
import hrms.util.DateUtil;
import hrms.util.EnumerateUtil;
import hrms.util.ParseUtil;
import hrms.util.StringUtil;
import hrms.vo.UserDetail;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

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
            sql = "select a.USER_ID,a.USER_NAME,a.USER_PHONE,a.USER_SEX,b.PIC_URL," +
                    "a.WORK_STATUS,c.USER_CARD_NUMBER,c.DATA_OF_BIRTH,c.WORK_TIME,d.JON_NAME,e.ORG_NAME,e.ORG_ID " +
                    " from user_info a,picture_info b,user_sensitive_info c,org_member_info d,org_info e " +
                    " where  a.USER_ID = c.USER_ID AND a.USER_ID = b.REL_ID  " +
                    " AND b.REL_TYPE = ? AND a.USER_STATUS = ? ";
        }else{
            sql = "select a.USER_ID,a.USER_NAME,a.USER_PHONE,a.USER_SEX,b.PIC_URL," +
                    "a.WORK_STATUS,c.DATA_OF_BIRTH,d.JON_NAME,e.ORG_NAME,e.ORG_ID " +
                    " from user_info a,picture_info b,user_sensitive_info c,org_member_info d,org_info e " +
                    " where  a.USER_ID = c.USER_ID AND a.USER_ID = b.REL_ID  " +
                    " AND b.REL_TYPE = ? AND a.USER_STATUS = ? ";
        }
        if(param != null){
            if(! StringUtil.isEmpty(param.getUserPhone())){
                sql += " AND a.USER_PHONE LIKE '%"+param.getUserPhone()+"%' ";
            }
            if(! StringUtil.isEmpty(param.getUserName())){
                sql += " AND a.USER_NAME LIKE '%"+param.getUserName()+"%' ";
            }
            if(! StringUtil.isEmpty(param.getJobName())){
                sql += " AND d.JOB_NAME LIKE '%"+param.getJobName()+"%' ";
            }
            if(! StringUtil.isEmpty(param.getOrgName())){
                sql += " AND e.ORG_NAME LIKE '%"+param.getOrgName()+"%' ";
            }
        }

        List<Object> objects = this.executeSqlPage(sql, page, pageSize, Constant.REL_TYPE_USER_PHOTO, Constant.STATUS_ABLE);
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
                userDetail.setUserPhoto(ParseUtil.parseString(o[4]));
                userDetail.setWorkStatus(ParseUtil.parseByte(o[5]));
                userDetail.setWorkStatusMessage(EnumerateUtil.translator("user_info-WORK_STATUS-"+ParseUtil.parseByte(o[5])));
                userDetail.setUserCardNumber(ParseUtil.parseString(o[6]));
                userDetail.setDataOfBirth(ParseUtil.parseString(o[7]));
                userDetail.setUserAge(DateUtil.yearBetweenTwoDate(ParseUtil.parseString(o[7]),DateUtil.formatDate()));
                userDetail.setWorkTime(ParseUtil.parseString(o[8]));
                userDetail.setJobName(ParseUtil.parseString(o[9]));
                userDetail.setOrgID(ParseUtil.parseInt(o[10]));
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
                userDetail.setUserPhoto(ParseUtil.parseString(o[4]));
                userDetail.setWorkStatus(ParseUtil.parseByte(o[5]));
                userDetail.setWorkStatusMessage(EnumerateUtil.translator("user_info-WORK_STATUS-"+ParseUtil.parseByte(o[5])));
                userDetail.setUserCardNumber("");
                userDetail.setDataOfBirth(ParseUtil.parseString(o[7]));
                userDetail.setUserAge(DateUtil.yearBetweenTwoDate(ParseUtil.parseString(o[7]),DateUtil.formatDate()));
                userDetail.setWorkTime("");
                userDetail.setJobName(ParseUtil.parseString(o[9]));
                userDetail.setOrgID(ParseUtil.parseInt(o[10]));
                userDetails.add(userDetail);
            }
        }

        return userDetails;
    }

    public List<UserDetail> findUserBaseInfos(FindUserParam param, int page, int pageSize){
        String sql = "";
        sql = "select a.USER_ID,a.USER_NAME,a.USER_PHONE,a.USER_SEX," +
                "a.WORK_STATUS,c.DATA_OF_BIRTH,d.JON_NAME,e.ORG_NAME,e.ORG_ID " +
                " from user_info a,picture_info b,user_sensitive_info c,org_member_info d,org_info e " +
                " where  a.USER_ID = c.USER_ID AND a.USER_ID = b.REL_ID  " +
                " AND b.REL_TYPE = ? AND a.USER_STATUS = ? ";
        if(param != null){
            if(! StringUtil.isEmpty(param.getUserPhone())){
                sql += " AND a.USER_PHONE LIKE '%"+param.getUserPhone()+"%' ";
            }
            if(! StringUtil.isEmpty(param.getUserName())){
                sql += " AND a.USER_NAME LIKE '%"+param.getUserName()+"%' ";
            }
            if(! StringUtil.isEmpty(param.getJobName())){
                sql += " AND d.JOB_NAME LIKE '%"+param.getJobName()+"%' ";
            }
            if(! StringUtil.isEmpty(param.getOrgName())){
                sql += " AND e.ORG_NAME LIKE '%"+param.getOrgName()+"%' ";
            }
        }

        List<Object> objects = this.executeSqlPage(sql, page, pageSize, Constant.REL_TYPE_USER_PHOTO, Constant.STATUS_ABLE);
        if(objects == null || objects.size() < 1){
            return null;
        }
        List<UserDetail> userDetails = new ArrayList<>();
        for(Object object:objects){
            Object[] o = (Object[]) object;
            UserDetail userDetail  = new UserDetail();

            userDetail.setUserID(ParseUtil.parseInt(o[0]));
            userDetail.setUserName(ParseUtil.parseString(o[1]));
            userDetail.setUserPhone(ParseUtil.parseString(o[2]));
            userDetail.setUserSex(ParseUtil.parseByte(o[3]));
            userDetail.setUserSexMessage(EnumerateUtil.translator("user_info-SEX-"+ParseUtil.parseByte(o[3])));
            userDetail.setWorkStatus(ParseUtil.parseByte(o[5]));
            userDetail.setWorkStatusMessage(EnumerateUtil.translator("user_info-WORK_STATUS-"+ParseUtil.parseByte(o[5])));
            userDetail.setDataOfBirth(ParseUtil.parseString(o[7]));
            userDetail.setUserAge(DateUtil.yearBetweenTwoDate(ParseUtil.parseString(o[7]),DateUtil.formatDate()));
            userDetail.setJobName(ParseUtil.parseString(o[9]));
            userDetail.setOrgID(ParseUtil.parseInt(o[10]));
            userDetails.add(userDetail);
        }

        return userDetails;
    }
    public UserDetail findUserDetail(Integer userID,boolean includeSensitive){
        String sql = "";
        if(includeSensitive){
            sql = "select a.USER_ID,a.USER_NAME,a.USER_PHONE,a.USER_SEX,b.PIC_URL," +
                    "a.WORK_STATUS,c.USER_CARD_NUMBER,c.DATA_OF_BIRTH,c.WORK_TIME,d.JON_NAME,e.ORG_NAME,e.ORG_ID " +
                    " from user_info a,picture_info b,user_sensitive_info c,org_member_info d,org_info e " +
                    " where  a.USER_ID = c.USER_ID AND a.USER_ID = b.REL_ID  " +
                    " AND b.REL_TYPE = ? AND a.USER_ID = ? AND a.USER_STATUS = ? ";
        }else{
            sql = "select a.USER_ID,a.USER_NAME,a.USER_PHONE,a.USER_SEX,b.PIC_URL," +
                    "a.WORK_STATUS,c.DATA_OF_BIRTH,d.JON_NAME,e.ORG_NAME,e.ORG_ID " +
                    " from user_info a,picture_info b,user_sensitive_info c,org_member_info d,org_info e " +
                    " where  a.USER_ID = c.USER_ID AND a.USER_ID = b.REL_ID  " +
                    " AND b.REL_TYPE = ? AND a.USER_STATUS = ? ";
        }

        List<Object> objects = this.executeSqlPage(sql,Constant.REL_TYPE_USER_PHOTO, userID,Constant.STATUS_ABLE);
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
                userDetail.setWorkStatusMessage(EnumerateUtil.translator("user_info-WORK_STATUS-"+ParseUtil.parseByte(o[5])));
                userDetail.setUserCardNumber(ParseUtil.parseString(o[6]));
                userDetail.setDataOfBirth(ParseUtil.parseString(o[7]));
                userDetail.setUserAge(DateUtil.yearBetweenTwoDate(ParseUtil.parseString(o[7]),DateUtil.formatDate()));
                userDetail.setWorkTime(ParseUtil.parseString(o[8]));
                userDetail.setJobName(ParseUtil.parseString(o[9]));
                userDetail.setOrgID(ParseUtil.parseInt(o[10]));
        }else{
                Object[] o = (Object[]) objects.get(0);

                userDetail.setUserID(ParseUtil.parseInt(o[0]));
                userDetail.setUserName(ParseUtil.parseString(o[1]));
                userDetail.setUserPhone(ParseUtil.parseString(o[2]));
                userDetail.setUserSex(ParseUtil.parseByte(o[3]));
                userDetail.setUserSexMessage(EnumerateUtil.translator("user_info-SEX-"+ParseUtil.parseByte(o[3])));
                userDetail.setUserPhoto(ParseUtil.parseString(o[4]));
                userDetail.setWorkStatus(ParseUtil.parseByte(o[5]));
                userDetail.setWorkStatusMessage(EnumerateUtil.translator("user_info-WORK_STATUS-"+ParseUtil.parseByte(o[5])));
                userDetail.setUserCardNumber("");
                userDetail.setDataOfBirth(ParseUtil.parseString(o[7]));
                userDetail.setUserAge(DateUtil.yearBetweenTwoDate(ParseUtil.parseString(o[7]),DateUtil.formatDate()));
                userDetail.setWorkTime("");
                userDetail.setJobName(ParseUtil.parseString(o[9]));
                userDetail.setOrgID(ParseUtil.parseInt(o[10]));
        }

        return userDetail;
    }

}
