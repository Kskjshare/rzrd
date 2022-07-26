package com.cloudrich.ereader.util;

import java.util.Calendar;
import java.util.Date;

public class RemindTimeUtil {

	
	/**
	 * 获取立即发送时间
	 * @return
	 */
	public static String getLjRemindTime(){
		
		Calendar calendar = Calendar.getInstance(); 
		calendar.add(Calendar.SECOND,3);
		String year=String.valueOf(calendar.get(Calendar.YEAR));
		String month=String.valueOf(calendar.get(Calendar.MONTH)+1);
		String day=String.valueOf(calendar.get(Calendar.DAY_OF_MONTH));
		String hour=String.valueOf(calendar.get(Calendar.HOUR_OF_DAY));
		String minue=String.valueOf(calendar.get(Calendar.MINUTE));
		String second=String.valueOf(calendar.get(Calendar.SECOND));
		
		
//		String minuestr=String.valueOf(minue);
//		String secondstr=String.valueOf(second);
		
		String ljCronStr=second.trim()+" "+minue.trim()+" "+hour.trim()+" "+day.trim()+" "+month.trim()+" "+"? "+year.trim();
		//System.out.println("Notice Message is:"+ljCronStr);
		return ljCronStr;
	}
	
	/**
	 * 获取固定发送时间
	 * @return
	 */
	public static String getGdRemindTime(Date sendtime){
		
		 Calendar calendar = Calendar.getInstance(); 
         calendar.setTime(sendtime);
         
			
		String year=String.valueOf(calendar.get(Calendar.YEAR));
		String month=String.valueOf(calendar.get(Calendar.MONTH)+1);
		String day=String.valueOf(calendar.get(Calendar.DAY_OF_MONTH));
		String hour=String.valueOf(calendar.get(Calendar.HOUR_OF_DAY));
		String minue=String.valueOf(calendar.get(Calendar.MINUTE));
		String second=String.valueOf(calendar.get(Calendar.SECOND));
		
		String ljCronStr=second.trim()+" "+minue.trim()+" "+hour.trim()+" "+day.trim()+" "+month.trim()+" "+"? "+year.trim();
		System.out.println("Croan Message is:"+ljCronStr);
	    return ljCronStr;
	}
	
	/**
	 * 
	 * @param args
	 */
	public static void main(String[] args){
		System.out.println(getLjRemindTime());
	}
}
