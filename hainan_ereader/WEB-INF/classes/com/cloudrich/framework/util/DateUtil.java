package com.cloudrich.framework.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtil {
	
	
	
	

	
	/***
	 * @author liuxiaocun 2013-10-19
	 * 
	 * @method 获得当前系统时间的yyyy-MM-dd HH:mm:ss SSS格式字符串
	 * 
	 * @return 返回当前系统时间的yyyy-MM-dd HH:mm:ss SSS格式字符串
	 */
	public static String yMdHmsS(){
		
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss:SSS");
		String dateString = formatter.format(date);
		
		return dateString;
	}
	
	/***
	 * @author liuxiaocun 2013-10-19
	 * 
	 * @method 获得当前系统时间的用户自定义格式字符串
	 * 
	 * @param format用户自定义时间格式
	 * @return 返回当前系统时间的用户自定义格式字符串
	 */
	public static String getDate(String format){
		
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat(format);
		String dateString = formatter.format(date);
		
		return dateString;
	}
	
	/***
	 * 
	 * @author liuxiaocun 2013-10-19
	 * 
	 * @method 获得给定时间的用户自定义格式字符串
	 * 
	 * @param date 传入的给定时间
	 * @param format 用户自定义时间格式
	 * @return 返回给定时间的用户自定义格式字符串
	 */
	public static String getDateCustom(Date date,String format){
		
		SimpleDateFormat formatter = new SimpleDateFormat(format);
		String dateString = formatter.format(date);
		
		return dateString;
	}
	
	/***
	 * @author liuxiaocun 2013-11-01
	 * 
	 * @method 把字符串时间 转成 Date格式时间
	 * 
	 * @param dateStr 传入的时间字符串
	 * @param format 用户自定义时间格式
	 * @return 返回时间字符串转化成的Date格式时间 。（自定义时间格式出错 则返回当前时间）
	 */
	public static Date toDateCustom(String dateStr,String format){
		SimpleDateFormat sdf = new SimpleDateFormat(format); 
		Date date=new Date();
		try {
			date = sdf.parse(dateStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}
	
	/***
	 * @author liuxiaocun 2013-11-01
	 * 
	 * @method Date格式时间 加上（减去）几天，最后返回String类型时间
	 * 
	 * @param date Date格式的时间 以此时间为基准相加减天数
	 * @param format 用户自定义时间格式
	 * @param dddSubtract 是加还是减   值有+/-
	 * @param numberOfDays 天数
	 * @return 返回date时间相加减天数后的String类型时间
	 */
	public static String addSubtractDay(Date date,String format,String dddSubtract,int numberOfDays){

		Calendar cal = Calendar.getInstance();//使用默认时区和语言环境获得一个日历。  
		cal.setTime(date);

		if("+".equals(dddSubtract)){
			cal.add(Calendar.DAY_OF_MONTH, +numberOfDays);
		}else if("-".equals(dddSubtract)){
			cal.add(Calendar.DAY_OF_MONTH, -numberOfDays);
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat(format); 
		String dateStr=sdf.format(cal.getTime());//取当前日期的后一天
		return dateStr;
	}
	
	public static String yMdHms(){
		
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dateString = formatter.format(date);
		
		return dateString;
	}
	
	public static String Hm(){
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("HH:mm");
		String dateString = formatter.format(date);
		
		return dateString;
	}
	
	/*
	 * @author xiakai 2014-9-18
	 * 得到当前日期 yyyy-MM-dd格式
	 */
	public static String yMdDate(){
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");	
		Date date = new Date();
		String dateStr = simpleDateFormat.format(date);
		System.out.println(dateStr);
		return dateStr;
	}
	
	
	/*
	 * @author xiakai 2014-09-18
	 * 
	 * @method 得到当前星期几
	 */
	public static int getWeek(){
		Date date = new Date();
		Calendar cal = Calendar.getInstance();   
		cal.setTime(date);    
		int week = cal.get(Calendar.DAY_OF_WEEK); 
		System.out.println(week);//老外的星期
		System.out.println(convertWeekToLocal(week));//咱的星期
		return convertWeekToLocal(week);
	}
	
	public static String getWeekByDateInChinese(String str){
		try {
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date date = simpleDateFormat.parse(str);
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(date);
			//calendar.add(Calendar.DAY_OF_YEAR, count);
			//date = calendar.getTime();
			int week = calendar.get(Calendar.DAY_OF_WEEK); 
			return getWeekInChinese(week);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return null;
	}
	
	//得到汉子星期
	private static String getWeekInChinese(int week){
		String weekStr[] = new String[]{"七","一","二","三","四","五","六"};
		return weekStr[week-1];
	}
	
	/*
	 * @author xiakai 2014-9-18
	 * 将老外的星期转为中国滴星期
	 * 外国人真奇怪，人家的星期7是我们的星期6
	 * 人家的星期1是我们的星期7
	 * 人家的星期2是我们的星期1
	 */
	private static int convertWeekToLocal(int input){
		switch (input) {
		case 1:
			return 7;
		case 2:
		case 3:
		case 4:
		case 5:
		case 6:
		case 7:
			return input-1;
		default:
			return 0;
		}
	}
	
	/*
	 * code by XiaKai
	 * 得到某日期字符串的后几天
	 * str-日期字符串 count-天数，负数则表示前几天
	 */
	public static String getNextDayStr(String str,int count){
		try {
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date date = simpleDateFormat.parse(str);
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(date);
			calendar.add(Calendar.DAY_OF_YEAR, count);
			date = calendar.getTime();
			return simpleDateFormat.format(date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		return null;
	}
	
	//得到本月最后一天日期
	public static String getLastDayOfMonth(String str){
		try {
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date date = simpleDateFormat.parse(str);
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(date);
			calendar.add(Calendar.MONTH, 1);
			calendar.set(Calendar.DAY_OF_MONTH, 0);
			date = calendar.getTime();
			return simpleDateFormat.format(date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		return null;
	}
	
	//下月第一天
	public static String getNextMonthFirstDayStr(String str){
		try {
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date date = simpleDateFormat.parse(str);
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(date);
			calendar.add(Calendar.MONTH, 1);
			calendar.set(Calendar.DAY_OF_MONTH, 1);
			date = calendar.getTime();
			return simpleDateFormat.format(date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		return null;
	}
	
	//本月第一天日期
	public static String getFirstDayOfMonth(String str){
		try {
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date date = simpleDateFormat.parse(str);
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(date);
			calendar.set(Calendar.DAY_OF_MONTH, 1);
			date = calendar.getTime();
			return simpleDateFormat.format(date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		return null;
	}
	
}
