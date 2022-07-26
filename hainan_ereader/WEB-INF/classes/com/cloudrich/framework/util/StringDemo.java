package com.cloudrich.framework.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class StringDemo {

	
public String getWeekDay(String DateStr){
	      SimpleDateFormat formatYMD=new SimpleDateFormat("yyyy-MM-dd");//formatYMD表示的是yyyy-MM-dd格式
	      SimpleDateFormat formatD=new SimpleDateFormat("E");//"E"表示"day in week"
	      Date d=null;
	      String weekDay="";
	      try{
	         d=formatYMD.parse(DateStr);//将String 转换为符合格式的日期
	         weekDay=formatD.format(d);
	      }catch (Exception e){
	         e.printStackTrace();
	      }
	      //System.out.println("日期:"+DateStr+" ： "+weekDay);
	     return weekDay;
	 }
public static void main(String args[]){
	StringDemo s=new StringDemo();
	
	System.out.println(s.getWeekDay("2014-07-02"));
	
}
	
}
