package com.cloudrich.framework.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtils {
	
	/**
	 * 默认日期格式
	 */
	public static final String DEFAULT_DATE_FORMAT = "yyyy-MM-dd";
	/**
	 * 默认日期+时间格式
	 */
	public static final String DEFAULT_DATETIME_FORMAT = "yyyy-MM-dd HH:mm:ss";
	
	private static final DateFormat parseDate = new SimpleDateFormat(DEFAULT_DATE_FORMAT);

	private static final DateFormat parseDateTime = new SimpleDateFormat(DEFAULT_DATETIME_FORMAT);

	public static final String format_yyyyMMdd="yyyyMMdd";
	public static final String format_yyyyMM="yyyyMM";
	public static final String format_yyyy="yyyy";
	public static final String format_yyyycnMMcnddcn="yyyy年MM月dd日";
	public static final String format_yyyycnMMcn="yyyy年MM月";
	public static final String format_yyyycn="yyyy年";
	
	
	public static String formatter1 = "yyyy-MM-dd HH:mm:ss";
	public static String formatter2 = "yyyy-MM-dd";
	public static String formatter3 = "HH:mm:ss";
	public static String formatter4 = "yyyyMMdd";
	
	
	
	
	/**
	 * 解析日期 yyyy-MM-dd
	 * @param date
	 * @return
	 */
	public static Date parseDate(String date){
		try {
			return parseDate.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 解析日期时间 yyyy-MM-dd HH:mm:ss
	 * @param datetime
	 * @return
	 */
	public static Date parseDateTime(String datetime){
		try {
			return parseDateTime.parse(datetime);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 格式化指定格式的日期字符串
	 * @param dateStr	日期字符串
	 * @param pattern 日期格式
	 * @return
	 * @author  zhangdongdong
	 * @date	2014年8月18日
	 */
	public static Date parseDate(String dateStr, String pattern) {
		DateFormat dateFormat = new SimpleDateFormat(pattern);
		try {
			return dateFormat.parse(dateStr);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 根据给定的格式格式化日期
	 * @param Calendar 要格式的日期 
	 * @param format 格式后的格式<br/>
	 * 字母  日期或时间元素 <br/>
	 *	y  年  Year<br/>
	 *	M  年中的月份 <br/>
	 *	d  月份中的天数 <br/>
	 *	H  一天中的小时数（0-23）<br/>
	 *	h  am/pm 中的小时数（1-12）<br/>
	 *	m  小时中的分钟数  Number <br/>
	 *	s  分钟中的秒数  Number<br/>
	 *	S  毫秒数  Number <br/>
	 * @see #formatDate(Calendar, String)
	 * @return String 格式后的字符串
	 */
	public static String format(Date date,String format){
		return format(getCalendar(date), format);
	}
	
	public static Calendar getCalendar(Date date){
		Calendar calendar=Calendar.getInstance();
		calendar.setTime(date);
		return calendar;
	}
	/**
	 * 根据给定的格式格式化日期
	 * @param Calendar 要格式的日期 
	 * @param format 格式后的格式<br/>
	 * 字母  日期或时间元素 <br/>
	 *	y  年  Year<br/>
	 *	M  年中的月份 <br/>
	 *	d  月份中的天数 <br/>
	 *	H  一天中的小时数（0-23）<br/>
	 *	h  am/pm 中的小时数（1-12）<br/>
	 *	m  小时中的分钟数  Number <br/>
	 *	s  分钟中的秒数  Number<br/>
	 *	S  毫秒数  Number <br/>
	 * @return String 格式后的字符串
	 */
	public static String format(Calendar calendar,String format){
		int year=calendar.get(Calendar.YEAR);
		format=format.replaceAll("yyyy",String.valueOf(year));
		format=format.replaceAll("yy",String.valueOf(year%100));
		String month=String.valueOf(calendar.get(Calendar.MONTH)+1);//默认从0开始，加一进行修正
		format=format.replaceAll("MM",month.length()==1?'0'+month:month);
		format=format.replaceAll("M",month);
		String date1=String.valueOf(calendar.get(Calendar.DATE));
		format=format.replaceAll("dd",date1.length()==1?'0'+date1:date1);
		format=format.replaceAll("d",date1);
		int hour=calendar.get(Calendar.HOUR_OF_DAY);
		String hour1=String.valueOf(hour);
		format=format.replaceAll("HH",hour1.length()==1?'0'+hour1:hour1);
		format=format.replaceAll("H",hour1);
		if(hour>12)hour-=12;
		hour1=String.valueOf(hour);
		format=format.replaceAll("hh",hour1.length()==1?'0'+hour1:hour1);
		format=format.replaceAll("h",hour1);
		String minute=String.valueOf(calendar.get(Calendar.MINUTE));
		format=format.replaceAll("mm",minute.length()==1?'0'+minute:minute);
		format=format.replaceAll("m",minute);
		String second=String.valueOf(calendar.get(Calendar.SECOND));
		format=format.replaceAll("ss",second.length()==1?'0'+second:second);
		format=format.replaceAll("s",second);
		format=format.replaceAll("[SSSS|SSS|SS|S]",String.valueOf(calendar.get(Calendar.MILLISECOND)));
		return format;
	}

	
	public static String getNowDateYYYMMDDString(){
		return dateToString(new Date(), formatter2);
	}
	
	public static String dateToString(Date date ,String formatter){
		SimpleDateFormat df = new SimpleDateFormat(formatter);//设置日期格式
		return df.format(date);
	}
	
	public static Date stringToDate(String date ,String formatter){
		SimpleDateFormat df = new SimpleDateFormat(formatter);//设置日期格式
		try {
			return df.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
     * <li>功能描述：时间相减得到天数
     * @param beginDateStr
     * @param endDateStr
     * @return
     * long 
     * @author Administrator
     */
    public static long getDaySub(String beginDateStr,String endDateStr)
    {
        long day=0;
        java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd");    
        java.util.Date beginDate;
        java.util.Date endDate;
        try
        {
            beginDate = format.parse(beginDateStr);
            endDate= format.parse(endDateStr);    
            day=(endDate.getTime()-beginDate.getTime())/(24*60*60*1000);    
        } catch (ParseException e)
        {
            e.printStackTrace();
        }   
        return day;
    }
    
    public static String  getDayAdd(String strdate,int days){
    	java.text.SimpleDateFormat format = new java.text.SimpleDateFormat(formatter2);  
		Calendar date = Calendar.getInstance();
		try {
			date.setTime(format.parse(strdate));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		date.set(Calendar.DATE, date.get(Calendar.DATE) + days);
		String result = format.format(date.getTime());
		return result;
    }
    public static String dayForWeek(String pTime)  {
    	SimpleDateFormat format = new SimpleDateFormat(formatter2);
    	Calendar c = Calendar.getInstance();
    	try {
			c.setTime(format.parse(pTime));
		} catch (ParseException e) {
			e.printStackTrace();
		}
    	int dayForWeek = 0;
    	if(c.get(Calendar.DAY_OF_WEEK) == 1){
    	dayForWeek = 7;
    	}else{
    	dayForWeek = c.get(Calendar.DAY_OF_WEEK) - 1;
    	}
    	String strweek = "";
    	switch(dayForWeek){
    	case 1:strweek = "星期一";
    	break ;
    	case 2:strweek = "星期二";
    	break ;
    	case 3:strweek = "星期三";
    	break ;
    	case 4:strweek = "星期四";
    	break ;
    	case 5:strweek = "星期五";
    	break ;
    	case 6:strweek = "星期六";
    	break ;
    	case 7:strweek = "星期天";
    	break ;
    	}
    	return strweek;
    	}
    
    public boolean test(Date date){

		String time1 = "18:00:00";
		String time2 = "08:00:00";
		String datetime = DateUtils.dateToString(date, formatter1);
		String strweek = DateUtils.dayForWeek(datetime);
		Date temp1 = DateUtils.stringToDate(datetime, formatter1);
		String temp2 = DateUtils.dateToString(temp1, formatter3);
		Date hhmmssdate = DateUtils.stringToDate(temp2, formatter3);
		Date etime = DateUtils.stringToDate(time1, formatter3);
		Date stime = DateUtils.stringToDate(time2, formatter3);
		if(strweek.equals("星期六") || strweek.equals("星期天"))
		{
			return false;
		}else if(!(hhmmssdate.before(etime) && hhmmssdate.after(stime))){
			return false;
		}
		
		return true ;
	
    }
    public static void main(String[] args) {
    	String s = "2014-02-14 18:00:01";
    	boolean flag = new DateUtils().test(DateUtils.stringToDate(s, formatter1));
    	System.out.println(flag);
	}
}
