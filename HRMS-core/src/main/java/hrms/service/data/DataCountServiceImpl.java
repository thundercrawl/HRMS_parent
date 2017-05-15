package hrms.service.data;

import hrms.common.CommonParams;
import hrms.common.ErrorCode;
import hrms.entity.UserWageBill;
import hrms.entity.UserWageBillDetail;
import hrms.repository.impl.role.UserRoleInfoRepository;
import hrms.repository.impl.sign.SignInfoRepository;
import hrms.repository.impl.user.UserInfoRepository;
import hrms.repository.impl.wage.UserWageBillDetailRepository;
import hrms.repository.impl.wage.UserWageBillRepository;
import hrms.util.DateUtil;
import hrms.util.ParseUtil;
import hrms.util.StringUtil;
import hrms.vo.BillCountDetail;
import hrms.vo.BillCountVo;
import hrms.vo.MsgVo;
import hrms.vo.SignCountDetail;
import hrms.vo.SignCountVo;
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
 * Created by 谢益文 on 2017/5/7.
 */
@Service("dataCountService")
public class DataCountServiceImpl implements DataCountService {
    @Resource
    private UserInfoRepository userInfoRepository;
    @Resource
    private UserRoleInfoRepository userRoleInfoRepository;
    @Resource
    private UserWageBillRepository userWageBillRepository;
    @Resource
    private UserWageBillDetailRepository userWageBillDetailRepository;
    @Resource
    private SignInfoRepository signInfoRepository;

    @Override
    public MsgVo signCount(String year, CommonParams commonParams) {

        boolean hrOrSM = userRoleInfoRepository.isHROrSM(commonParams.getUserId());
        if(!hrOrSM){
            return MsgVo.error(ErrorCode.ONLY_HR);
        }


        Date today = new Date();

        //当月不能查询
        if(StringUtil.isEmpty(year)){
            //2017
            Date previsionMonth = DateUtil.addMonths(today, -1);
            year = DateUtil.formatDate(previsionMonth).substring(0,4);
        }else{
            year = year.substring(0,4);
            if(year.equals(DateUtil.formatDate(today).substring(0,4))){
                Date previsionMonth = DateUtil.addMonths(today, -1);
                year = DateUtil.formatDate(previsionMonth).substring(0,4);
            }
        }

        String startOfYear = year+"-01-01 00:00:00";
        String endOfYear = year + "-12-31 23:59:59";
        SignCountVo vo = new SignCountVo();


        List<UserWageBill> allBill = userWageBillRepository.findAllByYear(startOfYear, endOfYear);
        if(allBill == null || allBill.size() < 1){
            return MsgVo.error(ErrorCode.USER_EMPTY);
        }


        Map<String,List<Integer>> billMap = new HashMap<>();
        Set<Integer> billIds = new HashSet<>();
        for(UserWageBill billDetail:allBill){
            billIds.add(billDetail.getBillId());
            if(billMap.containsKey(billDetail.getBillDate())){
                billMap.get(billDetail.getBillDate()).add(billDetail.getBillId());
            }else{
                List<Integer> list = new ArrayList<>();
                list.add(billDetail.getBillId());
                billMap.put(billDetail.getBillDate(),list);
            }
        }

        List<UserWageBillDetail> byIds = userWageBillDetailRepository.findByIds(billIds);
        Map<Integer,UserWageBillDetail> detailMap = new HashMap<>();
        for(UserWageBillDetail d:byIds){
            detailMap.put(d.getBillId(),d);
        }

        Date currentDay = DateUtil.parse(startOfYear);



        while(currentDay.before(DateUtil.parse(endOfYear))){
            int laterCount = 0;
            int earlyCount = 0;
            int noSignCount = 0;
            int normalCount = 0;

            int leaveCount = 0;
            int businessCount = 0;

            //2017-05
            String month = DateUtil.formatDate(currentDay).substring(0,7);
            SignCountDetail detail = new SignCountDetail();

            if(! billMap.containsKey(month)){
                //没有账单

                detail.setHasBill((byte) 0);

            }else{

                List<Integer> integers = billMap.get(month);

                for(Integer billId:integers){
                    UserWageBillDetail billDetail = detailMap.get(billId);
                    if(billDetail.getSignLaterCount().intValue() != 0){
                        laterCount ++;
                    }
                    if(billDetail.getSignEarlyCount().intValue() != 0){
                        earlyCount ++;
                    }
                    if(billDetail.getSignNoDays().intValue() != 0){
                        noSignCount ++;
                    }
                    if(billDetail.getSignNoDays().intValue() == 0 &&
                            billDetail.getSignLaterCount().intValue() == 0 &&
                            billDetail.getSignEarlyCount().intValue() == 0 &&
                            billDetail.getBusinessDays().intValue() == 0 &&
                            billDetail.getLeaveDays().intValue() == 0){
                        normalCount ++;
                    }
                    if(billDetail.getLeaveDays().intValue() != 0){
                        leaveCount ++;
                    }
                    if(billDetail.getBusinessDays().intValue() == 0){
                        businessCount ++;
                    }
                }


                detail.setEarlyCount(earlyCount);
                detail.setLaterCount(laterCount);
                detail.setNormalCount(normalCount);
                detail.setNoSignCount(noSignCount);
                detail.setBusinessCount(businessCount);
                detail.setLeaveCount(leaveCount);
                detail.setHasBill((byte) 1);
            }

            switch (DateUtil.getCurMonthOfYear(currentDay)){
                case 1:
                    vo.setMonth_1(detail);
                    break;
                case 2:
                    vo.setMonth_2(detail);
                    break;
                case 3:
                    vo.setMonth_3(detail);
                    break;
                case 4:
                    vo.setMonth_4(detail);
                    break;
                case 5:
                    vo.setMonth_5(detail);
                    break;
                case 6:
                    vo.setMonth_6(detail);
                    break;
                case 7:
                    vo.setMonth_7(detail);
                    break;
                case 8:
                    vo.setMonth_8(detail);
                    break;
                case 9:
                    vo.setMonth_9(detail);
                    break;
                case 10:
                    vo.setMonth_10(detail);
                    break;
                case 11:
                    vo.setMonth_11(detail);
                    break;
                case 12:
                    vo.setMonth_12(detail);
                    break;
            }


            currentDay = DateUtil.addMonths(currentDay,1);


        }

        Map map= new HashMap();
        map.put("result",vo);
        return MsgVo.success(map);

    }

    @Override
    public MsgVo billCount(String year, CommonParams commonParams) {
        boolean financeOrSM = userRoleInfoRepository.isFinanceOrSM(commonParams.getUserId());
        if(! financeOrSM){
            return MsgVo.error(ErrorCode.ONLY_FINANCE);
        }


        Date today = new Date();

        //当月不能查询
        if(StringUtil.isEmpty(year)){
            //2017
            Date previsionMonth = DateUtil.addMonths(today, -1);
            year = DateUtil.formatDate(previsionMonth).substring(0,4);
        }else{
            year = year.substring(0,4);
            if(year.equals(DateUtil.formatDate(today).substring(0,4))){
                Date previsionMonth = DateUtil.addMonths(today, -1);
                year = DateUtil.formatDate(previsionMonth).substring(0,4);
            }
        }

        String startOfYear = year+"-01-01 00:00:00";
        String endOfYear = year + "-12-31 23:59:59";
        BillCountVo vo = new BillCountVo();


        List<UserWageBill> allBill = userWageBillRepository.findAllByYear(startOfYear, endOfYear);
        if(allBill == null || allBill.size() < 1){
            return MsgVo.error(ErrorCode.USER_EMPTY);
        }


        Map<String,List<UserWageBill>> billMap = new HashMap<>();
        Set<Integer> billIds = new HashSet<>();
        for(UserWageBill billDetail:allBill){
            billIds.add(billDetail.getBillId());
            if(billMap.containsKey(billDetail.getBillDate())){
                billMap.get(billDetail.getBillDate()).add(billDetail);
            }else{
                List<UserWageBill> list = new ArrayList<>();
                list.add(billDetail);
                billMap.put(billDetail.getBillDate(),list);
            }
        }

        List<UserWageBillDetail> byIds = userWageBillDetailRepository.findByIds(billIds);
        Map<Integer,UserWageBillDetail> detailMap = new HashMap<>();
        for(UserWageBillDetail d:byIds){
            detailMap.put(d.getBillId(),d);
        }

        Date currentDay = DateUtil.parse(startOfYear);

        while(currentDay.before(DateUtil.parse(endOfYear))){
            BigDecimal baseWage = new BigDecimal(0);
            BigDecimal subsidy = new BigDecimal(0);
            BigDecimal subsidyIns = new BigDecimal(0);
            BigDecimal leaveDeduction = new BigDecimal(0);
            BigDecimal businessSubsidy = new BigDecimal(0);
            BigDecimal signDeduction = new BigDecimal(0);
            BigDecimal subBill = new BigDecimal(0);
            Byte hasBill = 0 ;

            //2017-05
            String month = DateUtil.formatDate(currentDay).substring(0,7);
            BillCountDetail detail = new BillCountDetail();

            if(! billMap.containsKey(month)){
                //没有账单
                detail.setHasBill((byte) 0);
            }else{
                List<UserWageBill> bills = billMap.get(month);
                for(UserWageBill bill:bills){
                    baseWage = baseWage.add(bill.getBaseWage());
                    subsidy = subsidy.add(bill.getSubsidy());
                    subsidyIns = subsidyIns.add(bill.getSubsidyIns());
                    leaveDeduction = leaveDeduction.add(bill.getLeaveDeduction());
                    businessSubsidy = businessSubsidy.add(bill.getBusinessSubsidy());
                    signDeduction = signDeduction.add(bill.getSignDeduction());
                    subBill = subBill.add(bill.getSubBill());
                }


                detail.setSubsidyIns(ParseUtil.parseString(subsidyIns));
                detail.setSubsidy(ParseUtil.parseString(subsidy));
                detail.setBaseWage(ParseUtil.parseString(baseWage));
                detail.setBusinessSubsidy(ParseUtil.parseString(businessSubsidy));
                detail.setLeaveDeduction(ParseUtil.parseString(leaveDeduction));
                detail.setSignDeduction(ParseUtil.parseString(signDeduction));
                detail.setSubBill(ParseUtil.parseString(subBill));
                detail.setHasBill((byte) 1);
            }

            switch (DateUtil.getCurMonthOfYear(currentDay)){
                case 1:
                    vo.setMonth_1(detail);
                    break;
                case 2:
                    vo.setMonth_2(detail);
                    break;
                case 3:
                    vo.setMonth_3(detail);
                    break;
                case 4:
                    vo.setMonth_4(detail);
                    break;
                case 5:
                    vo.setMonth_5(detail);
                    break;
                case 6:
                    vo.setMonth_6(detail);
                    break;
                case 7:
                    vo.setMonth_7(detail);
                    break;
                case 8:
                    vo.setMonth_8(detail);
                    break;
                case 9:
                    vo.setMonth_9(detail);
                    break;
                case 10:
                    vo.setMonth_10(detail);
                    break;
                case 11:
                    vo.setMonth_11(detail);
                    break;
                case 12:
                    vo.setMonth_12(detail);
                    break;
            }


            currentDay = DateUtil.addMonths(currentDay,1);


        }

        Map map= new HashMap();
        map.put("result",vo);
        return MsgVo.success(map);
    }
}
