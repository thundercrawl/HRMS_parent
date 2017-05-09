package hrms.service.wage.impl;

import hrms.common.CommonParams;
import hrms.common.Constant;
import hrms.common.ErrorCode;
import hrms.entity.SignInfo;
import hrms.entity.SysParamConfig;
import hrms.entity.UserInfo;
import hrms.entity.UserLeaveInfo;
import hrms.entity.UserWageBill;
import hrms.entity.UserWageBillDetail;
import hrms.entity.UserWageInfo;
import hrms.po.FindBillParam;
import hrms.po.SearchBillParam;
import hrms.repository.impl.leave.UserLeaveInfoRepository;
import hrms.repository.impl.role.UserRoleInfoRepository;
import hrms.repository.impl.sign.SignInfoRepository;
import hrms.repository.impl.sys.SysParamConfigRepository;
import hrms.repository.impl.user.UserInfoRepository;
import hrms.repository.impl.wage.UserWageBillDetailRepository;
import hrms.repository.impl.wage.UserWageBillRepository;
import hrms.repository.impl.wage.UserWageInfoRepository;
import hrms.service.wage.BillSearchService;
import hrms.util.DateUtil;
import hrms.util.ParseUtil;
import hrms.vo.BillDetail;
import hrms.vo.BillDetailVo;
import hrms.vo.MsgVo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created by 谢益文 on 2017/5/6.
 */
@Service("billSearchService")
public class BillSearchServiceImpl implements BillSearchService {
    @Resource
    private UserInfoRepository userInfoRepository;
    @Resource
    private UserRoleInfoRepository userRoleInfoRepository;
    @Resource
    private UserWageInfoRepository userWageInfoRepository;
    @Resource
    private UserWageBillRepository userWageBillRepository;
    @Resource
    private UserWageBillDetailRepository userWageBillDetailRepository;
    @Resource
    private UserLeaveInfoRepository userLeaveInfoRepository;
    @Resource
    private SignInfoRepository signInfoRepository;
    @Resource
    private SysParamConfigRepository sysParamConfigRepository;
    @Override
    public MsgVo searchBill(SearchBillParam param, CommonParams commonParams) {

        List<BillDetail> user = new ArrayList<>();
        if(param.getIsFinance().byteValue() == 1){
            //财务,进行权限验证
            Integer operId = commonParams.getUserId();
            UserInfo oper = userInfoRepository.findByUserId(operId);
            if(oper == null || oper.getUserStatus().byteValue() == Constant.STATUS_DISABLE){
                return MsgVo.error(ErrorCode.USER_EMPTY);
            }
            if(oper.getWorkStatus().byteValue() ==Constant.STATUS_DISABLE){
                return MsgVo.error(ErrorCode.USER_WORK_DISABLE);
            }
            boolean financeOrSM = userRoleInfoRepository.isFinanceOrSM(operId);
            if(! financeOrSM){
                return MsgVo.error(ErrorCode.ONLY_FINANCE);
            }
            user = userInfoRepository.findUser(param);
        }else{
            BillDetail user1 = userInfoRepository.findUser(commonParams.getUserId());
            user.add(user1);
        }

        if(user == null || user.size() < 1){
            BillDetailVo vo = new BillDetailVo();
            vo.setCount(0);
            Map map = new HashMap();
            map.put("result",vo);
            return MsgVo.success(map);
        }

        Map<Integer,BillDetail> userMap = new HashMap<>();
        for(BillDetail detail:user){
            userMap.put(detail.getUserId(),detail);
        }

        Set<Long> userIds = new HashSet<>();
        for(BillDetail detail:user){
            userIds.add(ParseUtil.parseLong(detail.getUserId()));
        }

        Map<Integer, List<UserWageBill>> billMap = userWageBillRepository.findAll(userIds, param.getDate(),commonParams.getPage(), commonParams.getPagesize());
        if(billMap == null || billMap.size() < 1){
            BillDetailVo vo = new BillDetailVo();
            vo.setCount(0);
            Map map = new HashMap();
            map.put("result",vo);
            return MsgVo.success(map);
        }

        Set<Integer> integers = billMap.keySet();

        List<BillDetail> details = new ArrayList<>();
        for(Integer userId:integers){
            List<UserWageBill> userWageBills = billMap.get(userId);
            for(UserWageBill wageBill:userWageBills){
                BillDetail detail = userMap.get(userId);

                detail.setBillId(wageBill.getBillId());
                detail.setBillDate(wageBill.getBillDate());
                detail.setBaseWage(wageBill.getBaseWage());
                detail.setSubsidy(wageBill.getSubsidy());
                detail.setSubsidyIns(wageBill.getSubsidyIns());
                detail.setLeaveDeduction(wageBill.getLeaveDeduction());
                detail.setBusinessSubsidy(wageBill.getBusinessSubsidy());
                detail.setSignDeduction(wageBill.getSignDeduction());
                detail.setSubBill(wageBill.getSubBill());

                details.add(detail);
            }
        }

        BillDetailVo vo = new BillDetailVo();
        vo.setBillDetails(details);
        vo.setCount(userWageBillRepository.countAll(userIds,param.getDate()));

        Map map = new HashMap();
        map.put("result",vo);

        return MsgVo.success(map);
    }

    @Override
    public MsgVo findBillDetail(FindBillParam param) {

        UserWageBillDetail byId = userWageBillDetailRepository.findById(param.getBillId());

        Map map = new HashMap();
        map.put("result",byId);

        return MsgVo.success(map);
    }

    @Override
    public int generateBill(int page,int pageSize) {
        List<UserInfo> allUser = userInfoRepository.findAllUser(page,pageSize);
        if(allUser == null || allUser.size() < 1){
            return -1;
        }
        Map<Integer,UserInfo> userInfoMap = new HashMap<>();
        List<Integer> userIds = new ArrayList<>();
        for(UserInfo userInfo:allUser){
            userInfoMap.put(userInfo.getUserId(),userInfo);
            userIds.add(userInfo.getUserId());
        }

        //查询所有工资单
        Map<Integer, UserWageInfo> userWages = userWageInfoRepository.findByUser(userIds);


        //计算账单的开始时间和结束时间
        Date today = new Date();

        Date thisMonth = DateUtil.startOfMonth(today);
        Date previousMonth = DateUtil.addMonths(thisMonth,-1);

        Date startTime = null;
        Date endTime = null;

        SysParamConfig startConfig = sysParamConfigRepository.findByID(Constant.BILL_START_DAY_PARAM);
        SysParamConfig endConfig = sysParamConfigRepository.findByID(Constant.BILL_END_DAY_PARAM);
        if(startConfig != null){
            startTime = DateUtil.addDays(previousMonth, ParseUtil.parseInt(startConfig.getParamValue()));
        }else{
            startTime = DateUtil.addDays(previousMonth,26);  //default  26
        }
        if(endConfig != null){
            endTime = DateUtil.addDays(thisMonth, ParseUtil.parseInt(endConfig.getParamValue()));
        }else{
            endTime = DateUtil.addDays(thisMonth,26);  //default  25
        }
        endTime = DateUtil.endOfDay(endTime);


        //请假 出差
        Map<Integer, List<UserLeaveInfo>> leaveMap = userLeaveInfoRepository.findUserLeaves(userIds, DateUtil.formatDate(startTime), DateUtil.formatBaseDate(endTime));
        //考勤记录
        Map<Integer, List<SignInfo>> signMap = signInfoRepository.findAll(userIds, DateUtil.formatDate(startTime), DateUtil.formatBaseDate(endTime));


        List<UserWageBillDetail> detailBatch = new ArrayList<>();
        for(Integer userId:userIds){

            if(! userWages.containsKey(userId)){
                UserWageBill bill = new UserWageBill();
                bill.setBaseWage(ParseUtil.parseBigDecimal(0));
                bill.setUserId(userId);
                bill.setBillDate(DateUtil.formatDate(thisMonth).substring(0,6));
                bill.setBusinessSubsidy(ParseUtil.parseBigDecimal(0));
                bill.setLeaveDeduction(ParseUtil.parseBigDecimal(0));
                bill.setSignDeduction(ParseUtil.parseBigDecimal(0));
                bill.setSubBill(ParseUtil.parseBigDecimal(0));
                bill.setSubsidy(ParseUtil.parseBigDecimal(0));
                bill.setSubsidyIns(ParseUtil.parseBigDecimal(0));

                UserWageBill saveBill = userWageBillRepository.save(bill);

                UserWageBillDetail detail = new UserWageBillDetail();
                detail.setBillId(saveBill.getBillId());
                detailBatch.add(detail);

                continue;
            }


            int laterCount = 0;
            int earlyCount = 0;
            int businessDays = 0;
            int leaveDays = 0;
            int noSignDays = 0;

            int normalDays = 0;

            int reallyWorkDays = 0;

            List<UserLeaveInfo> userLeaveInfos = new ArrayList<>();
            if(leaveMap != null && leaveMap.size() > 0){
                userLeaveInfos = leaveMap.get(userId);
            }
            List<SignInfo> signInfos = new ArrayList<>();
            if(signMap != null && signMap.size() > 0){
                signInfos = signMap.get(userId);
            }

            Date currentDay = startTime;
            while(currentDay.before(endTime)){
                Date currentStartTime = currentDay;
                Date currentEndTime = DateUtil.endOfDay(currentDay);

                int week = DateUtil.getCurDayOfWeek(currentDay);

                //请假 出差
                boolean hasLeave = false;
                if(userLeaveInfos != null && userLeaveInfos.size() > 0){
                    for(UserLeaveInfo leaveInfo:userLeaveInfos){
                        if(leaveInfo.getStartTime().compareToIgnoreCase(DateUtil.formatDate(currentEndTime)) <= 0 &&
                                leaveInfo.getEndTime().compareToIgnoreCase(DateUtil.formatDate(currentStartTime)) >= 0 ){
                            hasLeave = true;
                            if(leaveInfo.getLeaveType().byteValue() == Constant.LEAVE_TYPE_LEAVE){
                                leaveDays ++;
                            }
                            else if(leaveInfo.getLeaveType().byteValue() == Constant.LEAVE_TYPE_BUSINESS){
                                businessDays ++;
                            }
                            break;
                        }
                    }
                }
                if(hasLeave){
                    continue;
                }

                //考勤
                boolean hasSignIn = false;
                boolean hasSignOut = false;

                boolean isNormal = true;
                if(signInfos != null && signInfos.size() > 0){
                    for(SignInfo signInfo:signInfos){
                        if(signInfo.getSignTime().compareTo(DateUtil.formatDate(currentStartTime)) >= 0 &&
                                signInfo.getSignTime().compareTo(DateUtil.formatDate(currentEndTime)) <= 0 ){

                            if(signInfo.getSignType().byteValue() == Constant.SING_TYPE_IN){
                                hasSignIn = true;
                            }
                            else if(signInfo.getSignType().byteValue() == Constant.SING_TYPE_OUT){
                                hasSignOut = true;
                            }

                            if(signInfo.getSignStatus().byteValue() == Constant.SIGN_STATUS_LATER){
                                laterCount++;
                                isNormal = false;
                            }
                            else if(signInfo.getSignStatus().byteValue() == Constant.SIGN_STATUS_EARLY){
                                earlyCount ++;
                                isNormal = false;
                            }
                        }
                    }
                }

                if(!(week == 6 || week == 7)){

                    if(hasSignIn && hasSignOut && isNormal){
                        normalDays ++;
                    }

                    reallyWorkDays ++;
                    if(! hasSignIn && ! hasSignOut){
                        noSignDays ++;
                    }
                    if(! hasSignIn && hasSignOut){
                        laterCount++;
                    }
                    if(hasSignIn && ! hasSignOut){
                        earlyCount ++;
                    }

                }
                currentDay = DateUtil.addDays(currentDay,1);
            }



            UserWageInfo wageInfo = userWages.get(userId);
            BigDecimal dayMoney = wageInfo.getBaseWage().divide(ParseUtil.parseBigDecimal(reallyWorkDays), 2, BigDecimal.ROUND_HALF_UP);

            BigDecimal leaveDeduction = dayMoney.multiply(ParseUtil.parseBigDecimal(leaveDays));
            leaveDeduction.setScale( 2, BigDecimal.ROUND_UP);

            BigDecimal signDeduction = ParseUtil.parseBigDecimal(Constant.MONEY_LATER_EARLY*(laterCount+earlyCount)).add(dayMoney.multiply(ParseUtil.parseBigDecimal(noSignDays)));
            signDeduction.setScale(2, BigDecimal.ROUND_UP);

            BigDecimal businessSubsidy = ParseUtil.parseBigDecimal(Constant.MONEY_BUSINESS*businessDays);
            businessSubsidy.setScale(2, BigDecimal.ROUND_UP);

            //电话补贴+其他补贴
            BigDecimal subsidy = wageInfo.getSubsidyPhone().add(wageInfo.getSubsidyOther());

            BigDecimal oldIns = wageInfo.getBaseWage().multiply(ParseUtil.parseBigDecimal(Constant.INS_OLD));
            oldIns.setScale(2, BigDecimal.ROUND_UP);
            BigDecimal houseIns = wageInfo.getBaseWage().multiply(ParseUtil.parseBigDecimal(Constant.INS_HOUSE));
            houseIns.setScale(2, BigDecimal.ROUND_UP);
            BigDecimal injuryIns = wageInfo.getBaseWage().multiply(ParseUtil.parseBigDecimal(Constant.INS_INJURY));
            injuryIns.setScale(2, BigDecimal.ROUND_UP);
            BigDecimal maternityIns = wageInfo.getBaseWage().multiply(ParseUtil.parseBigDecimal(Constant.INS_MATERNITY));
            maternityIns.setScale(2, BigDecimal.ROUND_UP);
            BigDecimal medicalIns = wageInfo.getBaseWage().multiply(ParseUtil.parseBigDecimal(Constant.INS_MEDICAL));
            medicalIns.setScale(2, BigDecimal.ROUND_UP);
            BigDecimal unWorkIns = wageInfo.getBaseWage().multiply(ParseUtil.parseBigDecimal(Constant.INS_UNWORK));
            unWorkIns.setScale(2, BigDecimal.ROUND_UP);

            BigDecimal subsidyIns = oldIns.add(houseIns).add(injuryIns).add(maternityIns).add(medicalIns).add(unWorkIns);

            UserWageBill bill = new UserWageBill();
            bill.setUserId(userId);
            bill.setBaseWage(wageInfo.getBaseWage());
            bill.setBillDate(DateUtil.formatDate(thisMonth).substring(0,7));
            bill.setBusinessSubsidy(businessSubsidy);
            bill.setLeaveDeduction(leaveDeduction);
            bill.setSignDeduction(signDeduction);

            BigDecimal subBill = wageInfo.getBaseWage().add(subsidy).add(subsidyIns).add(businessSubsidy).subtract(leaveDeduction).subtract(signDeduction);

            bill.setSubBill(subBill);
            bill.setSubsidy(subsidy);
            bill.setSubsidyIns(subsidyIns);

            UserWageBill saveBill = userWageBillRepository.save(bill);

            UserWageBillDetail detail = new UserWageBillDetail();
            detail.setBillId(saveBill.getBillId());

            detail.setBusinessDays(businessDays);
            detail.setBusinessSubsidy(businessSubsidy);

            detail.setLeaveDays(leaveDays);
            detail.setLeaveDeduction(leaveDeduction);

            detail.setHouseIns(houseIns);
            detail.setInjuryIns(injuryIns);
            detail.setMaternityIns(maternityIns);
            detail.setMedicalIns(medicalIns);
            detail.setOldIns(oldIns);
            detail.setUnWorkIns(unWorkIns);

            detail.setSignDeduction(signDeduction);
            detail.setSignEarlyCount(earlyCount);
            detail.setSignLaterCount(laterCount);
            detail.setSignNoDays(noSignDays);
            detail.setSignNormalDays(normalDays);

            detailBatch.add(detail);

        }

        userWageBillDetailRepository.batchSave(detailBatch);

        return 0;
    }
}
