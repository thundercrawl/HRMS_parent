package hrms.service.leave.impl;

import hrms.common.CommonParams;
import hrms.common.Constant;
import hrms.common.ErrorCode;
import hrms.entity.UserInfo;
import hrms.entity.UserLeaveInfo;
import hrms.entity.UserRoleInfo;
import hrms.model.OrgMemberDetail;
import hrms.po.FindApproveParam;
import hrms.po.FindLeavesParam;
import hrms.po.UpApproveParam;
import hrms.repository.impl.leave.UserLeaveInfoRepository;
import hrms.repository.impl.org.OrgManagerInfoRepository;
import hrms.repository.impl.org.OrgMemberInfoRepository;
import hrms.repository.impl.role.UserRoleInfoRepository;
import hrms.repository.impl.user.UserInfoRepository;
import hrms.service.leave.UserLeaveService;
import hrms.util.DateUtil;
import hrms.util.StringUtil;
import hrms.vo.ApproveDetail;
import hrms.vo.FindAllApproveVo;
import hrms.vo.FindAllLeaveVo;
import hrms.vo.LeaveDetail;
import hrms.vo.MsgVo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 谢益文 on 2017/5/3.
 */
@Service("userLeaveService")
public class UserLeaveServiceImpl implements UserLeaveService {
    @Resource
    private UserLeaveInfoRepository userLeaveInfoRepository;
    @Resource
    private UserInfoRepository userInfoRepository;
    @Resource
    private UserRoleInfoRepository userRoleInfoRepository;
    @Resource
    private OrgMemberInfoRepository orgMemberInfoRepository;
    @Resource
    private OrgManagerInfoRepository orgManagerInfoRepository;

    @Override
    public MsgVo upApprove(UpApproveParam param, CommonParams commonParams) {

        Integer userId = commonParams.getUserId();
        UserInfo userInfo = userInfoRepository.findByUserId(userId);

        if(userInfo == null || userInfo.getUserStatus().byteValue() == Constant.STATUS_DISABLE){
            return MsgVo.fail(ErrorCode.USER_EMPTY);
        }

        boolean isManager = false;
        OrgMemberDetail orgMemberDetail = orgMemberInfoRepository.findOrg(userId);
        if(orgMemberDetail != null){
            isManager = orgManagerInfoRepository.isManager(userId,orgMemberDetail.getOrgID());
        }

        UserLeaveInfo leaveInfo = new UserLeaveInfo();
        leaveInfo.setUserId(userId);
        leaveInfo.setUpTime(DateUtil.formatDate());
        leaveInfo.setStartTime(param.getStartTime());
        leaveInfo.setEndTime(param.getEndTime());
        leaveInfo.setLeaveContent(param.getLeaveContent());

        List<Byte> leaveStatuses = new ArrayList<>();
        leaveStatuses.add(Constant.LEAVE_STATUS_PASS);
        leaveStatuses.add(Constant.LEAVE_STATUS_WAIT);
        boolean hasLeave = userLeaveInfoRepository.hasLeave(userId, leaveStatuses,param.getStartTime(), param.getEndTime());
        if(hasLeave){
            return MsgVo.error(ErrorCode.LEAVE_REPEAT);
        }

        if(param.getLeaveType() == Constant.LEAVE_TYPE_LEAVE){
            leaveInfo.setLeaveType(Constant.LEAVE_TYPE_LEAVE);
        }
        else if(param.getLeaveType() == Constant.LEAVE_TYPE_BUSINESS){
            leaveInfo.setLeaveType(Constant.LEAVE_TYPE_BUSINESS);
        }else{
            return MsgVo.error(ErrorCode.LEAVE_TYPE_ERROR);
        }

        leaveInfo.setLeaveStatus(Constant.LEAVE_STATUS_WAIT);

        if(isManager){
            //由人事审批
            List<UserRoleInfo> hrs = userRoleInfoRepository.findByRole(Constant.ROLE_HR_VALUE);
            if(hrs != null){
                int i = (int) (Math.random() * hrs.size());
                leaveInfo.setApproveUserId(hrs.get(i).getUserId());
            }else{
                //由系统管理员审批
                List<UserRoleInfo> sms = userRoleInfoRepository.findByRole(Constant.ROLE_SYSTEM_MANAGER_VALUE);
                int i = (int) (Math.random() * sms.size());
                leaveInfo.setApproveUserId(sms.get(i).getUserId());
            }
        }else{

            boolean hasApprove = false;
            if(orgMemberDetail != null){
                //其他的由部门经理审批
                Integer manager = orgManagerInfoRepository.getManager(orgMemberDetail.getOrgID());
                if(manager != null){
                    leaveInfo.setApproveUserId(manager);
                    hasApprove = true;
                }
            }

            if(!hasApprove){
                //由人事审批
                List<UserRoleInfo> hrs = userRoleInfoRepository.findByRole(Constant.ROLE_HR_VALUE);
                if(hrs != null){
                    int i = (int) (Math.random() * hrs.size());
                    leaveInfo.setApproveUserId(hrs.get(i).getUserId());
                }else{
                    //由系统管理员审批
                    List<UserRoleInfo> sms = userRoleInfoRepository.findByRole(Constant.ROLE_SYSTEM_MANAGER_VALUE);
                    int i = (int) (Math.random() * sms.size());
                    leaveInfo.setApproveUserId(sms.get(i).getUserId());
                }
            }
        }

        String leaveCode = StringUtil.generateLeaveCode();
        UserLeaveInfo byLeaveCode = userLeaveInfoRepository.findByLeaveCode(leaveCode);
        int count = 10;
        while(count > 0){
            if(byLeaveCode != null){
                leaveCode = StringUtil.generateLeaveCode();
                byLeaveCode = userLeaveInfoRepository.findByLeaveCode(leaveCode);
            }else{
                break;
            }
            count --;
        }
        if(count == 0){
            return MsgVo.fail(ErrorCode.LEAVE_CODE_GENERATE_ERROR);
        }

        leaveInfo.setLeaveCode(leaveCode);

        userLeaveInfoRepository.save(leaveInfo);

        return MsgVo.success(null);
    }

    @Override
    public MsgVo findAllLeaves(FindLeavesParam param, CommonParams commonParams) {

        Integer userId = commonParams.getUserId();
        UserInfo userInfo = userInfoRepository.findByUserId(userId);
        if(userInfo == null || userInfo.getUserStatus().byteValue() == Constant.STATUS_DISABLE){
            return MsgVo.fail(ErrorCode.USER_EMPTY);
        }

        FindAllLeaveVo vo = new FindAllLeaveVo();

        List<LeaveDetail> allLeaves = userLeaveInfoRepository.findAllLeaves(param, commonParams.getUserId(), commonParams.getPage(), commonParams.getPagesize());
        if(allLeaves != null && allLeaves.size() > 0){
            for(LeaveDetail detail:allLeaves){
                detail.setUserId(userInfo.getUserId());
                detail.setUserName(userInfo.getUserName());
                detail.setUserPhone(userInfo.getUserPhone());
            }
        }
        vo.setLeaveDetails(allLeaves);
        int count = userLeaveInfoRepository.countAllLeaves(param, commonParams.getUserId());
        vo.setCount(count);
        Map map = new HashMap();
        map.put("result",vo);
        return MsgVo.success(map);
    }

    @Override
    public MsgVo findAllApproves(FindApproveParam param, CommonParams commonParams) {
        Integer userId = commonParams.getUserId();
        UserInfo byUserId = userInfoRepository.findByUserId(userId);
        if(byUserId == null || byUserId.getUserStatus().byteValue() == Constant.STATUS_DISABLE){
            return MsgVo.error(ErrorCode.USER_EMPTY);
        }

        List<LeaveDetail> approves = userLeaveInfoRepository.findApproves(param, userId,commonParams.getPage(),commonParams.getPagesize());
        FindAllApproveVo vo = new FindAllApproveVo();
        vo.setApproves(approves);
        vo.setCount(userLeaveInfoRepository.countApproves(param,userId));

        Map map = new HashMap();
        map.put("result",vo);

        return MsgVo.success(map);
    }

    @Override
    public MsgVo findApproveDetail(Integer leaveId) {
        ApproveDetail detail = userLeaveInfoRepository.findApproveDetail(leaveId);
        if(detail == null){
            return MsgVo.fail(ErrorCode.RESULT_EMPTY);
        }

        Map map = new HashMap();
        map.put("result",detail);

        return MsgVo.success(map);
    }

    @Override
    public MsgVo passApprove(Integer leaveId, CommonParams commonParams) {
        Integer userId = commonParams.getUserId();
        UserInfo byUserId = userInfoRepository.findByUserId(userId);
        if(byUserId == null || byUserId.getUserStatus().byteValue() == Constant.STATUS_DISABLE){
            return MsgVo.error(ErrorCode.USER_EMPTY);
        }

        UserLeaveInfo leave = userLeaveInfoRepository.findById(leaveId);
        if(leave == null || leave.getLeaveStatus().byteValue() != Constant.LEAVE_STATUS_WAIT){
            return MsgVo.fail(ErrorCode.LEAVE_APPROVE_REPEAT);
        }
        if(leave.getApproveUserId().intValue() != userId.intValue()){
            return MsgVo.fail(ErrorCode.LEAVE_APPROVE_USER_ERROR);
        }

        leave.setLeaveStatus(Constant.LEAVE_STATUS_PASS);
        leave.setApproveTime(DateUtil.formatDate());

        userLeaveInfoRepository.save(leave);
        return MsgVo.success(null);
    }

    @Override
    public MsgVo rejectApprove(Integer leaveId, CommonParams commonParams) {
        Integer userId = commonParams.getUserId();
        UserInfo byUserId = userInfoRepository.findByUserId(userId);
        if(byUserId == null || byUserId.getUserStatus().byteValue() == Constant.STATUS_DISABLE){
            return MsgVo.error(ErrorCode.USER_EMPTY);
        }

        UserLeaveInfo leave = userLeaveInfoRepository.findById(leaveId);
        if(leave == null || leave.getLeaveStatus().byteValue() != Constant.LEAVE_STATUS_WAIT){
            return MsgVo.fail(ErrorCode.LEAVE_APPROVE_REPEAT);
        }
        if(leave.getApproveUserId().intValue() != userId.intValue()){
            return MsgVo.fail(ErrorCode.LEAVE_APPROVE_USER_ERROR);
        }
        leave.setLeaveStatus(Constant.LEAVE_STATUS_REJECT);
        leave.setApproveTime(DateUtil.formatDate());

        userLeaveInfoRepository.save(leave);
        return MsgVo.success(null);
    }

}
