package hrms.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtil {
	
	public static final String BASE_FORMAT = "yyyy-MM-dd HH:mm:ss";
	public static final String BASE_FORMAT1 = "yyyy-MM-dd HH:mm";
	public static final String BASE_FORMAT2 = "yyyyMMdd HH:mm";
	public static final String SHORT_FORMAT = "yyyy-MM-dd";
	public static final String SHORT_FORMAT_MY = "yyyy-MM";
	public static final String CHINESE_FORMAT = "yyyy年MM月dd日HH时mm分ss秒";
	public static final String CHINESE_FORMAT_NOSECOND = "yyyy年MM月dd日HH时mm分";
	public static final String SHORT_C_FORMAT = "yyyy年MM月dd日";
	public static final String EN_FORMAT_A = "yyyyMMddHHmmss";
	public static final String EN_FORMAT_B = "yyyy/MM/dd HH:mm:ss";
	public static final String EN_FORMAT_C = "yyyyMMddHHmmss.SSS";
	public static final String BASE_FORMAT3 = "MM/dd HH:mm";
	public static final String BASE_FORMAT4 = "yy/MM/dd HH:mm";
	public static final String END_DAY_FOMAT_A = "yyyy/MM/dd 23:59:59";
	public static final String END_DAY_FOMAT_B = "yyyy-MM-dd 23:59:59";
	public static final String SHORT_EN_FORMAT = "yyyyMMdd";
	public static final String YEAR_EN_FORMAT = "yyyy";
	public static final String MINUTE_FORMAT = "yyyyMMddHHmm";
	public static final String SHORT_FORMAT_HOUR = "HH:mm";
	public static final String CN_SHORT_FORMAT = "MM月dd日";


	
	public static final String CN_CUT_FORMAT = "MM月dd日 HH:mm";
	public static final String CN_NOSECOND_FORMAT = "yyyy年MM月dd日 HH:mm";
	public static final String EN_NOSECOND_FORMAT = "yyyy-MM-dd HH:mm";

	public static final String BASE_DATE_FORMAT = "yyyy-MM-dd";
	
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
	
	public static Date now() {
		return new Date();
	}
	
	public static String formatDate() {
		SimpleDateFormat format = new SimpleDateFormat(BASE_FORMAT);
		return format.format(new Date());
	}
	public static String formatBaseDate(Date date) {
		SimpleDateFormat format = new SimpleDateFormat(BASE_FORMAT);
		return format.format(date);
	}
	public static String formatDate(String hour) {
		SimpleDateFormat format = new SimpleDateFormat(SHORT_FORMAT_HOUR);
		return format.format(parse(hour,SHORT_FORMAT_HOUR));
	}
	
	public static String formatDate(String formatter, Date date) {
		SimpleDateFormat format = new SimpleDateFormat(formatter);
		return format.format(date);
	}
	public static String formatDateCN(String dateStr) {
		SimpleDateFormat format = new SimpleDateFormat(CN_SHORT_FORMAT);
		return format.format(parse(dateStr));
	}
	public static Date yesterday() {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DATE, -1);
		return calendar.getTime();
	}
	
	public static Date lastMinute() {
		return lastMinute(new Date());
	}
	
	public static Long oneMinute() {
		return 60000l;
	}
	
	public static Long minutes(int num) {
		return num * oneMinute();
	}
	
	public static Long oneHour() {
		return 60 * oneMinute();
	}
	
	public static Long hours(int num) {
		return num * oneHour();
	}
	
	public static Date lastMinute(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.MINUTE, -1);
		return calendar.getTime();
	}
	
	public static Date addDays(Date date, int days) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.DATE, days);
		return calendar.getTime();
	}
	public static Date addDays(String time, int days) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(parse(time));
		calendar.add(Calendar.DATE, days);
		return calendar.getTime();
	}
	public static String checkTwoTime(String timeS,String timeE, String dayTime,int addDay,int type) {
		if(addDay!=0){
			dayTime = formatBaseDate(addDays(dayTime, addDay));
		}
		String dayS = dayTime.substring(0, 11)+"00:00:00",dayE = dayTime.substring(0, 11)+"23:59:59";
		long time1 = parse(timeS).getTime(),time2 = parse(timeS).getTime(),dayStart = parse(dayS).getTime(),dayEnd = parse(dayE).getTime();
		
		if(type==2){
			if( time2 > dayEnd && time1 < dayEnd ){//中间
				timeS =dayE.substring(0, 16);
			}if(time2>=dayStart&&time2<=dayEnd){//中间
				timeS = timeE.substring(0, 16);
			}else{
				timeS = null;
			}
		}else{
			if(time1>=dayStart&&time1<=dayEnd ){//中间
				timeS = timeS.substring(0, 16);
			}else if( time1 < dayStart &&time2>dayStart){//左边
				timeS = dayS.substring(0, 16);
			}else{
				timeS= null;
			}
		}
		
		//String time, String dayTime,int addDay,int type
/*		if(addDay!=0){
			dayTime = formatBaseDate(addDays(dayTime, addDay));
		}
		String dayS = dayTime.substring(0, 11)+"00:00:00",dayE = dayTime.substring(0, 11)+"23:59:59";
		long time1 = parse(time).getTime(),dayStart = parse(dayS).getTime(),dayEnd = parse(dayE).getTime();
		if(time1>=dayStart&&time1<=dayEnd){
			time = time.substring(0, 16);
		}else if( time1 < dayStart && type == 1 ){
			time = dayS.substring(0, 16);
		}else if( time1 > dayEnd && type == 2 ){
			time =dayE.substring(0, 16);
		}else{
			time = null;
		}
*/		
		return timeS;
	}
	public static Date addMonths(Date date, int months) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.MONTH, months);
		return calendar.getTime();
	}
	public static Date addMinutes(Date date, int minute) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.MINUTE, minute);
		return calendar.getTime();
	}
	public static Date addTime(Date date, int minute,int hour,int days,int months) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		if(minute!=0){
			calendar.add(Calendar.MINUTE, minute);
		}
		if(hour!=0){
			calendar.add(Calendar.HOUR, hour);
		}
		if(days!=0){
			calendar.add(Calendar.DATE, days);
		}
		if(months!=0){
			calendar.add(Calendar.MONTH, months);
		}
		return calendar.getTime();
	}
	public static String formatDate(Date date) {
		SimpleDateFormat format = new SimpleDateFormat(BASE_FORMAT);
		return format.format(date);
	}
	
	public static String formatDateShort(Date date) {
		SimpleDateFormat format = new SimpleDateFormat(SHORT_FORMAT);
		return format.format(date);
	}
	
	public static Date addFileds(Date date, int filed, int val) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(filed, val);
		return calendar.getTime();
	}
	
	public static Date startOfDay(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		Calendar calendar2 = Calendar.getInstance();
		calendar2.setTime(date);
		calendar2.set(Calendar.HOUR_OF_DAY, 0);
		calendar2.set(Calendar.MINUTE, 0);
		calendar2.set(Calendar.SECOND, 0);
		calendar2.set(Calendar.MILLISECOND, 0);
		return calendar2.getTime();
	}
	
	public static Date endOfDay(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		Calendar calendar2 = Calendar.getInstance();
		calendar2.setTime(date);
		calendar2.set(Calendar.HOUR_OF_DAY, 23);
		calendar2.set(Calendar.MINUTE, 59);
		calendar2.set(Calendar.SECOND, 59);
		calendar2.set(Calendar.MILLISECOND, 999);
		return calendar2.getTime();
	}
	
	public static Date startOfMonth(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		Calendar calendar2 = Calendar.getInstance();
		calendar2.setTime(date);
		calendar2.set(Calendar.YEAR, calendar.get(Calendar.YEAR));
		calendar2.set(Calendar.MONTH, calendar.get(Calendar.MONTH));
		calendar2.set(Calendar.DATE, 1);
		return startOfDay(calendar2.getTime());
	}
	
	public static Date endOfMonth(Date date) {
		Date tempDate = startOfMonth(date);
		tempDate = addMonths(tempDate, 1);
		tempDate = addDays(tempDate, -1);
		tempDate = endOfDay(tempDate);
		return tempDate;
	}

	public static Date parse(String dateStr) {
		if(dateStr.length()==16){
			return parse(dateStr, BASE_FORMAT1);
		}
		if(dateStr.length()==10){
			return parse(dateStr, SHORT_FORMAT);
		}
		return parse(dateStr, BASE_FORMAT);
	}
	
	public static Date parse(String dateStr, String formatStr) {
		return parse(dateStr, formatStr, null);
	}
	
	public static Date parse(String dateStr, String formatStr, Date defaultDate) {
		SimpleDateFormat format = new SimpleDateFormat(formatStr);
		try {
			return format.parse(dateStr);
		} catch (ParseException e) {
			return defaultDate;
		}
	}
	
	public static Date set(Date srcDate, int field, int value) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(srcDate);
		calendar.set(field, value);
		return calendar.getTime();
	}
	
	public static int get(Date srcDate, int field) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(srcDate);
		return calendar.get(field);
	}
	
	public static long randomNum(int len){
		int sum = 1;
		for(int i=0;i<len;i++){
			sum *= 10;
		}
		return (long)(Math.random()*sum); 
	}
	public static String itenfiy(int len){
		return formatDate(SHORT_EN_FORMAT,new Date())+randomNum(len);
	} 
	
	public static long minutesBetweenTwoTime(Date end,Date start){
		Calendar dateOne=Calendar.getInstance(),dateTwo=Calendar.getInstance();
		dateOne.setTime(end);	
		dateTwo.setTime(start);	
		long timeOne=dateOne.getTimeInMillis();
		long timeTwo=dateTwo.getTimeInMillis();
		long minute=(timeOne-timeTwo)/(1000*60);//转化minute
		return minute;
	}
	
	public static long houresBetweenTwoTime(Date end,Date start){
		Calendar dateOne=Calendar.getInstance(),dateTwo=Calendar.getInstance();
		dateOne.setTime(end);	
		dateTwo.setTime(start);	
		long timeOne=dateOne.getTimeInMillis();
		long timeTwo=dateTwo.getTimeInMillis();
		long hours=(timeOne-timeTwo)/(1000*60*60);//转化小时
		if((timeOne-timeTwo)%(1000*60*60)>0){
			hours += 1L;
		}
		return hours;
	}
	
	public static long daysBetweenTwoTime(Date end,Date start){
		Calendar dateOne=Calendar.getInstance(),dateTwo=Calendar.getInstance();
		dateOne.setTime(end);	
		dateTwo.setTime(start);	
		long timeOne=dateOne.getTimeInMillis();
		long timeTwo=dateTwo.getTimeInMillis();
		long days=(timeOne-timeTwo)/(1000*60*60*24) + 1L;//转化minute
		return days;
	}
	public static String getDayOfWeek(Date date){
		   SimpleDateFormat dateFm = new SimpleDateFormat("EEEE");
		   return dateFm.format(date);
	}
	@SuppressWarnings("deprecation")
	public static String translateBaseTime(String time){
		Date tim = parse(time);
		String t = formatDate(CN_SHORT_FORMAT, tim);
		//t += hourVal(tim.getHours())+tim.getMinutes()+"分";
		return t;
	}
	public static String hourVal(int hour){
		if(0<hour&&hour<=6){
			return "凌晨"+hour+"点";
		}else if(hour<=8){
			return "早晨"+hour+"点";
		}else if(hour<=11){
			return "上午"+hour+"点";
		}else if(hour<=13){
			if(hour==13){
				hour = 1;
			}
			return "中午"+hour+"点";
		}else if(hour<=17){
			hour = hour-12;
			return "下午"+hour+"点";
		}else if(hour<=22){
			hour = hour -12;
			return "晚上"+hour+"点";
		}else {
			hour = hour -12;
			return "夜间"+hour+"点";
		}
	}
	
	public static int getCurDayOfWeek(Date dt){
		Calendar cal = Calendar.getInstance();
        cal.setTime(dt);
        int w = cal.get(Calendar.DAY_OF_WEEK)-1;
        if (w < 0)
            w = 0;
        if(w==0){
        	return 7;
        }
        return w;
	}
	
	public static String getWeekOfDate(String dateStr) {
	    String[] weekOfDays = {"星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"};        
	    Calendar calendar = Calendar.getInstance();      
	    if(dateStr != null && dateStr.length()>9){ 
	    	Date da = parse(dateStr);
	         calendar.setTime(da);      
	    }        
	    int w = calendar.get(Calendar.DAY_OF_WEEK) - 1;      
	    if (w < 0){        
	        w = 0;      
	    }      
	    return weekOfDays[w];    
	}
	public static int daysOfTwo(String startTime, String endTime) {
		int days = (int)((parse(startTime).getTime() - parse(endTime).getTime())/86400000);
		if(days<0){
			return -days;
		}	
	    return days;

	}
	public static boolean boolTwodays(String oneTime, String twoTime) {//oneTime > true
		long a = (parse(oneTime).getTime() - parse(twoTime).getTime());
		boolean flag = a >0?true:false;
		return flag;

	}
	/**
	 * 获取上一周的起始时间
	 * @author sundf
	 * 2016年9月19日下午5:44:58
	 * @return
	 */
	public static Date getStartOfWeek(){
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.WEEK_OF_YEAR, -1);
		calendar.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		return calendar.getTime();
	}
	/**
	 * 获取上一周 的结束时间
	 * @author sundf
	 * 2016年9月19日下午5:45:11
	 * @return
	 */
	public static Date getEndOfWeek(){
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.WEEK_OF_YEAR, -1);
		calendar.set(Calendar.DAY_OF_WEEK, Calendar.SATURDAY);
		calendar.set(Calendar.HOUR_OF_DAY, 23);
		calendar.set(Calendar.MINUTE, 59);
		calendar.set(Calendar.SECOND, 59);
		return calendar.getTime();
	}

	//计算两个日期相差年数
	public static int yearBetweenTwoDate(String startDate,String endDate){
		Calendar calBegin = Calendar.getInstance(); //获取日历实例
		Calendar calEnd = Calendar.getInstance();
		calBegin.setTime(stringTodate(startDate,DateUtil.YEAR_EN_FORMAT)); //字符串按照指定格式转化为日期
		calEnd.setTime(stringTodate(endDate,DateUtil.YEAR_EN_FORMAT));
		return calEnd.get(Calendar.YEAR) - calBegin.get(Calendar.YEAR);
	}
	//字符串按照指定格式转化为日期
	public static Date stringTodate(String dateStr, String formatStr) {
		// 如果时间为空则默认当前时间
		Date date = null;
		SimpleDateFormat format = new SimpleDateFormat(formatStr);
		if (dateStr != null && !dateStr.equals("")) {
			String time = "";
			try {
				Date dateTwo = format.parse(dateStr);
				time = format.format(dateTwo);
				date = format.parse(time);
			} catch (ParseException e) {
				e.printStackTrace();
			}

		} else {
			String timeTwo = format.format(new Date());
			try {
				date = format.parse(timeTwo);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		return date;
	}

	public static void main(String[] args){
		//	public static final String BASE_FORMAT3 = "MM-dd HH:mm";
//		public static final String BASE_FORMAT4 = "yy-MM-dd HH:mm";
//		System.err.println(formatDate(BASE_FORMAT2, parse("2016-08-24 01:02")));
//		System.err.println(formatDate(BASE_FORMAT3, parse("2016-08-24 01:02")));
//		System.err.println(formatDate(BASE_FORMAT4, parse("2016-08-24 01:02")));
//		System.err.println("2016-08-24 01:02:00".substring(0, 11));
//		System.err.println("2016-08-24 01:02:00".substring(0, 12));
//		System.out.println(daysBetweenTwoTime(new Date(), parse("2016-08-24 01:02:00"))); //4
//		System.out.println(daysBetweenTwoTime(new Date(), parse("2016-08-24 01:02:00"))); //4
//		System.out.println(daysOfTwo("2020-01-24 01:02:00","2019-12-24 01:02:00"));//31
//		System.out.println(daysOfTwo("2019-12-24 03:02:00","2019-12-24 01:02:00"));//31
////		Map<Integer,String> map=new HashMap<Integer, String>();
//		List<TaskPeriod> list=new ArrayList<TaskPeriod>();
//		String s = "2016-08-24 01:02:00".substring(11, 16);
//		System.err.println(s+getWeekOfDate("2016-08-24"));
//		//list=getDaysList(DateUtil.parse("2016-08-30 17:00:00",DateUtil.SHORT_FORMAT), "15:00", 30);
//		list=getMonthDay("1,2,3,5", "10,13,16,30,31","2019-03-16","15:00", 30);
//		//list=getweekDaysList(DateUtil.parse("2016-08-30",DateUtil.SHORT_FORMAT),map);
//		System.out.println("-------------");
//		for(TaskPeriod t:list){
////			System.out.println(t.getEndtime()+"---"+t.getRemindtime()+"---"+t.getWeekDay());
//		}
//		
//		Calendar cal = Calendar.getInstance();
//		cal.setTime(new Date());
//		for(int i=0;i<10;i++){
//		   cal.add(Calendar.DATE, 1);//DATE=日
//		   cal.get(Calendar.DAY_OF_WEEK);
//		   System.out.println(DateUtil.formatDate(cal.getTime())+"---"+cal.get(Calendar.DAY_OF_WEEK));
//		}
//		System.out.println(formatDate("10:12"));
//		System.out.println(formatDate("0:2"));
//		System.out.println(translateBaseTime("2016-05-09 23:09"));
	/*	System.out.println(parse("2016-05-09","dd/MM/yyyy"));
		Date currentDate = parse("05/09/2016","dd/MM/yyyy");
		Date endOfMonth = endOfMonth(currentDate);
		Date endOfDay = endOfDay(currentDate);
		System.out.println(formatDate("yyyy-MM-dd", endOfDay));
		System.out.println(formatDate("yyyy-MM-dd", endOfMonth));
		Date startAdd3 = DateUtil.addMonths(DateUtil.parse("2016-03-14",DateUtil.SHORT_FORMAT),3);
		Date end = DateUtil.parse("2016-06-14",DateUtil.SHORT_FORMAT);
		int i = startAdd3.compareTo(end);
		System.out.println(DateUtil.now());
		System.out.println(formatDateShort(DateUtil.now()));*/
	} 
	
	
}
