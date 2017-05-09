package hrms.repository.impl.leave;

import hrms.common.Constant;
import hrms.entity.UserLeaveInfo;
import hrms.po.FindApproveParam;
import hrms.po.FindLeavesParam;
import hrms.repository.RepositorySupport;
import hrms.util.EnumerateUtil;
import hrms.util.ParseUtil;
import hrms.util.StringUtil;
import hrms.vo.ApproveDetail;
import hrms.vo.LeaveDetail;
import org.hibernate.criterion.DetachedCriteria;
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
@Repository("userLeaveInfoRepository")
public class UserLeaveInfoRepository extends RepositorySupport<UserLeaveInfo> {

    public UserLeaveInfo findById(Integer leaveId) {
        DetachedCriteria d = DetachedCriteria.forClass(UserLeaveInfo.class);
        d.add(Restrictions.eq("leaveId", leaveId));
        return this.findOne(d);
    }

    public UserLeaveInfo findByLeaveCode(String leaveCode) {
        DetachedCriteria d = DetachedCriteria.forClass(UserLeaveInfo.class);
        d.add(Restrictions.eq("leaveCode", leaveCode));
        return this.findOne(d);
    }

    /**
     * @param param
     * @param userId
     * @return
     * @describe 查找用户提交的所有请假出差审批
     * @author xieyw
     */
    public List<LeaveDetail> findAllLeaves(FindLeavesParam param, Integer userId, int page, int pageSize) {
        String sql = "select a.user_id,a.user_name,b.leave_id,b.leave_type,b.start_time,b.end_time,b.up_time," +
                "b.approve_time,b.leave_status,b.leave_content,b.leave_code " +
                " from user_info a,user_leave_info b " +
                " where a.user_id = b.approve_user_id and b.user_id = ? ";
        if (param != null) {
            if (param.getLeaveType() != null) {
                sql += " and b.leave_type = " + param.getLeaveType();
            }
            if (!StringUtil.isEmpty(param.getLeaveCode())) {
                sql += " and b.leave_code like '" + param.getLeaveCode()+"'";
            }
            if (param.getLeaveStatus() != null && param.getLeaveStatus() != 0) {
                sql += " and b.leave_status = " + param.getLeaveStatus();
            }
        }
        sql += " order by b.up_time asc";

        List<Object> list = this.executeSqlPage(sql, page, pageSize, userId);
        if (list == null || list.size() < 1) {
            return null;
        }
        List<LeaveDetail> result = new ArrayList<>();
        for (Object object : list) {
            Object[] o = (Object[]) object;
            LeaveDetail detail = new LeaveDetail();
            detail.setApproveUserName(ParseUtil.parseString(o[1]));
            detail.setLeaveId(ParseUtil.parseInt(o[2]));
            detail.setLeaveType(EnumerateUtil.translator("user_leave_info-LEAVE_TYPE-" + o[3]));
            detail.setStartTime(ParseUtil.parseString(o[4]));
            detail.setEndTime(ParseUtil.parseString(o[5]));
            detail.setUpTime(ParseUtil.parseString(o[6]));
            detail.setApproveTime(ParseUtil.parseString(o[7]));
            detail.setLeaveStatus(EnumerateUtil.translator("user_leave_info-LEAVE_STATUS-" + o[8]));
            detail.setLeaveContent(ParseUtil.parseString(o[9]));
            detail.setLeaveCode(ParseUtil.parseString(o[10]));
            result.add(detail);
        }
        return result;
    }

    public int countAllLeaves(FindLeavesParam param, Integer userId) {
        String sql = "select count(a.user_id)" +
                " from user_info a,user_leave_info b " +
                " where a.user_id = b.approve_user_id and b.user_id = ? ";
        if (param != null) {
            if (param.getLeaveType() != null) {
                sql += " and b.leave_type = " + param.getLeaveType();
            }
            if (!StringUtil.isEmpty(param.getLeaveCode())) {
                sql += " and b.leave_code like '" + param.getLeaveCode()+"'";
            }
            if (param.getLeaveStatus() != null && param.getLeaveStatus() != 0) {
                sql += " and b.leave_status = " + param.getLeaveStatus();
            }
        }

        List<Object> list = this.executeSql(sql, userId);
        if (list == null || list.size() < 1) {
            return 0;
        }
        return ParseUtil.parseInt(list.get(0));
    }

    /**
     * @describe 查询审核条目详单
     * @author xieyw
     * @param leaveId
     * @return
     */
    public ApproveDetail findApproveDetail(Integer leaveId){
        String sql  =" select a.user_name,b.org_name,c.job_name, " +
                " d.start_time,d.end_time,d.leave_content,a.user_phone,d.leave_code,d.up_time " +
                " from  user_leave_info d,user_info a " +
                " left join org_member_info c on a.user_id=c.user_id and c.status = ? " +
                " left join org_info b on b.org_id = c.org_id and b.org_status = ? " +
                " where d.user_id=a.user_id and d.leave_id = ?";
        List<Object> objects = this.executeSql(sql, Constant.STATUS_ABLE, Constant.STATUS_ABLE, leaveId);
        if(objects == null || objects.size() < 1){
            return null;
        }
        Object[] o = (Object[]) objects.get(0);
        ApproveDetail detail = new ApproveDetail();
        detail.setUserName(ParseUtil.parseString(o[0]));
        detail.setOrgName(ParseUtil.parseString(o[1]));
        detail.setJobName(ParseUtil.parseString(o[2]));
        detail.setStartTime(ParseUtil.parseString(o[3]));
        detail.setEndTime(ParseUtil.parseString(o[4]));
        detail.setLeaveContent(ParseUtil.parseString(o[5]));
        detail.setUserPhone(ParseUtil.parseString(o[6]));
        detail.setLeaveCode(ParseUtil.parseString(o[7]));
        detail.setUpTime(ParseUtil.parseString(o[8]));

        return detail;
    }

    /**
     * @describe 查询需要审核的事项
     * @author xieyw
     * @param param
     * @param userId
     * @return
     */
    public List<LeaveDetail>  findApproves(FindApproveParam param,Integer userId,int page,int pageSize){
        String sql = "select a.user_name,b.leave_code,b.leave_type,b.start_time,b.end_time,b.up_time,b.leave_content,b.leave_id " +
                " from user_info a,user_leave_info b " +
                " where a.user_id = b.user_id and b.approve_user_id = ? " +
                " and b.leave_status = ? and a.user_status= ? ";
        if (param != null) {
            if (!StringUtil.isEmpty(param.getLeaveCode())) {
                sql += " and b.leave_code like '" + param.getLeaveCode()+"'";
            }
        }
        sql += " order by b.up_time asc";

        List<Object> list = this.executeSqlPage(sql,page,pageSize,userId,Constant.LEAVE_STATUS_WAIT,Constant.STATUS_ABLE);
        if (list == null || list.size() < 1) {
            return null;
        }
        List<LeaveDetail> result = new ArrayList<>();
        for (Object object : list) {
            Object[] o = (Object[]) object;
            LeaveDetail detail = new LeaveDetail();
            detail.setUserName(ParseUtil.parseString(o[0]));
            detail.setLeaveCode(ParseUtil.parseString(o[1]));
            detail.setLeaveType(EnumerateUtil.translator("user_leave_info-LEAVE_TYPE-"+o[2]));
            detail.setStartTime(ParseUtil.parseString(o[3]));
            detail.setEndTime(ParseUtil.parseString(o[4]));
            detail.setUpTime(ParseUtil.parseString(o[5]));
            detail.setLeaveContent(ParseUtil.parseString(o[6]));
            detail.setLeaveId(ParseUtil.parseInt(o[7]));
            result.add(detail);
        }

        return result;
    }

    public int  countApproves(FindApproveParam param,Integer userId){
        String sql = "select count(b.leave_id) " +
                " from user_info a,user_leave_info b " +
                " where a.user_id = b.user_id and b.approve_user_id = ? " +
                " and b.leave_status = ? and a.user_status= ? ";
        if (param != null) {
            if (!StringUtil.isEmpty(param.getLeaveCode())) {
                sql += " and b.leave_code like '" + param.getLeaveCode()+"'";
            }
        }

        List<Object> list = this.executeSql(sql,userId,Constant.LEAVE_STATUS_WAIT,Constant.STATUS_ABLE);
        if (list == null || list.size() < 1) {
            return 0;
        }
        return ParseUtil.parseInt(list.get(0));
    }

    public boolean hasLeave(Integer userId, Collection<Byte> leaveStatuses, String startTime, String endTime){
        DetachedCriteria d =  DetachedCriteria.forClass(UserLeaveInfo.class);
        d.add(Restrictions.le("startTime",endTime))
                .add(Restrictions.ge("endTime",startTime))
                .add(Restrictions.in("leaveStatus",leaveStatuses));
        UserLeaveInfo one = this.findOne(d);
        if(one == null){
            return false;
        }
        return true;
    }

    public Map<Integer,List<UserLeaveInfo>> findUserLeaves(Collection<Integer> userIds,String startTime,String endTime){
        DetachedCriteria d = DetachedCriteria.forClass(UserLeaveInfo.class);
        d.add(Restrictions.in("userId",userIds))
                .add(Restrictions.eq("leaveStatus",Constant.LEAVE_STATUS_PASS))
                .add(Restrictions.le("startTime",endTime))
                .add(Restrictions.ge("endTime",startTime));

        List<UserLeaveInfo> all = this.findAll(d);
        if(all == null|| all.size() < 1){
            return null;
        }
        Map<Integer,List<UserLeaveInfo>> map = new HashMap<>();
        for(UserLeaveInfo leaveInfo:all){
            if(map.containsKey(leaveInfo.getUserId())){
                map.get(leaveInfo.getUserId()).add(leaveInfo);
            }else{
                List<UserLeaveInfo> list = new ArrayList<>();
                list.add(leaveInfo);
                map.put(leaveInfo.getUserId(),list);
            }
        }
        return map;
    }


}

