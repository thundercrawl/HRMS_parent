package hrms.util;

import org.joda.time.DateTime;
import org.joda.time.Days;
import org.joda.time.LocalDate;
import org.joda.time.Months;


public class JodaTimeUtil {
	
	public static final String BASE_FORMAT = "yyyy-MM-dd HH:mm:ss";
	public static final String SHORT_FORMAT = "yyyy-MM-dd";
	public static final String CHINESE_FORMAT = "yyyy年MM月dd日HH时mm分ss秒";
	public static final String CHINESE_FORMAT_NOSECOND = "yyyy年MM月dd日HH时mm分";
	public static final String SHORT_C_FORMAT = "yyyy年MM月dd日";
	public static final String SHORT_D_FORMAT = "yyyy年MM月dd日 EE";
	public static final String EN_FORMAT_A = "yyyyMMddHHmmss";
	public static final String EN_FORMAT_B = "yyyy/MM/dd HH:mm:ss";
	public static final String EN_FORMAT_C = "yyyyMMddHHmmss.SSS";
	public static final String END_DAY_FOMAT_A = "yyyy/MM/dd 23:59:59";
	public static final String END_DAY_FOMAT_B = "yyyy-MM-dd 23:59:59";
	public static final String SHORT_EN_FORMAT = "yyyyMMdd";
	public static final String MINUTE_FORMAT = "yyyyMMddHHmm";
	public static final String CN_SHORT_FORMAT = "MM月dd日";
	public static final String CN_CUT_FORMAT = "MM月dd日 HH:mm";
	public static final String CN_NOSECOND_FORMAT = "yyyy年MM月dd日 HH:mm";
	public static final String EN_NOSECOND_FORMAT = "yyyy-MM-dd HH:mm";
	
    public final static int ERA = 0;
    public final static int YEAR = 1;
    public final static int MONTH = 2;
    public final static int WEEK_OF_YEAR = 3;
    public final static int WEEK_OF_MONTH = 4;
    public final static int DATE = 5;
    public final static int DAY_OF_MONTH = 5;
    public final static int DAY_OF_YEAR = 6;
    public final static int DAY_OF_WEEK = 7;
    public final static int DAY_OF_WEEK_IN_MONTH = 8;
    public final static int AM_PM = 9;
    public final static int HOUR = 10;
    public final static int HOUR_OF_DAY = 11;
    public final static int MINUTE = 12;
    public final static int SECOND = 13;
    public final static int MILLISECOND = 14;
	
	
	
	public static void main(String[] args){
	
		long x = 1;
		long s = x==2?2:(x==3?3:1);
		System.err.println(s);
	}



	/**
	 * 获取两个日期之间相差几天
	 * eg:2012-12-14
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	public static int getDays(String startTime, String endTime) {
		LocalDate start=new LocalDate(startTime);    
        LocalDate end=new LocalDate(endTime);    
        int days = Days.daysBetween(start, end).getDays();
		return days;
	} 
	
	
	/**
	 *获取连个日期之间相差几个月
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	public static int getMonths(String startTime, String endTime) {
		LocalDate start=new LocalDate(startTime);    
        LocalDate end=new LocalDate(endTime);    
        int months = Months.monthsBetween(start, end).getMonths();
		return months;
	} 
	
	
	public static Boolean judgeDateByDay(String time){//2015-23-21
		//time = "2016-10-21";
		Boolean flag = false;
		String param = "20";
		String startTime = time.substring(0, 8)+param;
		int days = JodaTimeUtil.getDays(startTime, time);
		if(days>0){
			flag = true;
		}
		return flag;
	}
	
	/**
	 * 判断该时间是否为某月第一天
	 * @param time
	 * @return
	 */
	public static Boolean isMonthFirstDay(String time){//2015-23-21
		Boolean flag = false;
		DateTime dateTime = new DateTime(time);
		String dateTimeStr = dateTime.dayOfMonth().withMinimumValue().toString("yyyy-MM-dd");
		if(dateTimeStr.equals(time)){
			flag = true;
		}
		return flag;
	}
	
	
	/**
	 * 获取某一个月的第一天
	 * @param time
	 * @return
	 */
	public static String getMonthOneDay(String time){//2015-23-21
		DateTime dateTime = new DateTime(time);
		String dateTimeStr = dateTime.dayOfMonth().withMinimumValue().toString("yyyy-MM-dd");
		return dateTimeStr;
	}
	
	/**
	 * 获取某个月的最后一天
	 * @param time
	 * @return
	 */
	public static String getMonthLastDay(String time){//2015-23-21
		DateTime dateTime = new DateTime(time);
		String dateTimeStr = dateTime.dayOfMonth().withMaximumValue().toString("yyyy-MM-dd");
		return dateTimeStr;
	}
	
	/**
	 * 该当前日期增加n月
	 * @param time
	 * @param n
	 * @return
	 */
	public static String addMonths(String time,int n){//2015-23-21
		DateTime dateTime = new DateTime(time);
		String dateTimeStr = dateTime.plusMonths(n).toString("yyyy-MM-dd");
		return dateTimeStr;
	}
	
	
	/**
	 * 当前日期增加N天
	 * @param time
	 * @param n
	 * @return
	 */
	public static String addDays(String time,int n){//2015-23-21
		DateTime dateTime = new DateTime(time);
		String dateTimeStr = dateTime.plusDays(n).toString("yyyy-MM-dd");
		return dateTimeStr;
	}
	
	/**
	 * 当前时间增加n个工作日，不包含周末
	 * @param time
	 * @param n
	 * @return
	 */
	public static String addWorkDays(String time,int n){//2015-23-21
		DateTime dateTime = new DateTime(time);
		for(int i=0;i<n;i++){
			dateTime = dateTime.plusDays(1);
			int dayOfWeek = dateTime.getDayOfWeek();
			if(dayOfWeek>5){
				i--;
			}
		}
		String dateTimeStr = dateTime.toString("yyyy-MM-dd");
		return dateTimeStr;
	}
	
	/**
	 * 获取当前日期为星期几
	 * @param time
	 * @return
	 */
	public static String getDayOfWeek(String time){
		String[] weekStr = {"星期一","星期二","星期三","星期四","星期五","星期六","星期日"};
		DateTime dateTime = new DateTime(time);
		int dayOfWeek = dateTime.getDayOfWeek();
		
		return weekStr[dayOfWeek-1];
	}
	
	public static String formatDateShow(String time,String showFormat){
		DateTime dateTime = new DateTime(time);
		String dateShow = dateTime.toString(showFormat);
		return dateShow;
	}
	
}
