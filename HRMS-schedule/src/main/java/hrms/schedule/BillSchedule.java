package hrms.schedule;

import hrms.service.wage.BillSearchService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.TimerTask;


/**
 * Created by 谢益文 on 2017/5/6.
 */
@Component
public class BillSchedule  extends TimerTask {

    private static final int PAGE_SIZE = 100;
    private static final Log log = LogFactory.getLog(BillSchedule.class);
    @Autowired
    private BillSearchService billSearchService;

    @Scheduled(cron="${schedule.generateBill}")
    public void run(){
        try {
            int page = 0;
            while (true){
                int code = billSearchService.generateBill(page, PAGE_SIZE);
                if(code == -1){
                    break;
                }
                page ++;

            }
            log.info("出账完成");
            System.out.println("出账完成");
        }catch (Exception e){
            e.printStackTrace();
            log.error("出账失败.Catch Exception:" + e.getMessage());
            System.err.println("出账失败.Catch Exception:" + e.getMessage());
        }

    }
}
