package com.cloudrich.framework.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;
/** 
 * Creation date: 3-19-2013
 * @author 石松林
 * XDoclet definition:
 * 
 * */
/**
 * 
 * 获得当前时间的不同格式
 * 
 *
 */
public class RandomID {
	
	public String Random()
	{
		Calendar c = Calendar.getInstance();
		String time = c.getTimeInMillis() + "";
		return time;
	}
	public String RandomNum()
	{
		SimpleDateFormat  sim = new SimpleDateFormat("yyyyMMddHHmmss");
		String date= sim.format(new Date()).trim()+Math.random();
		date = date.replace(".", "");
		String time = date.substring(2, 16).trim();
		return time;
	}
	public String date()
	{
		SimpleDateFormat  sim = new SimpleDateFormat("yyyyMMddHHmmss");
		String time= sim.format(new Date()).trim();
		return time;
	}
	public String dateDay()
	{
		SimpleDateFormat  sim = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date= sim.format(new Date()).trim();
		return date;
	}
	public String departId()
	{
		SimpleDateFormat  sim = new SimpleDateFormat("yyyyMMddHHmmss");
		String date= sim.format(new Date()).trim()+Math.random();
		String time = date.substring(12, 14).trim();
		return time;
	}
	public String time_start()
	{
		SimpleDateFormat  sim = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
		String date= sim.format(new Date()).trim();
		return date;
	}
	public String time()
	{
		SimpleDateFormat  sim = new SimpleDateFormat("yyyy-MM-ddHHmmss");
		String date= sim.format(new Date()).trim();   
		return date;
	}
	public String timess()
	{
		SimpleDateFormat  sim = new SimpleDateFormat("yyyy-MM-ddHHmmss");
		String date1= sim.format(new Date()).trim()+Math.random();
		String date2 = date1.substring(12, 14).trim();
		String date=sim.format(new Date()).trim()+date2;
		return date;
	}
	public Date time1() throws ParseException
	{
		SimpleDateFormat  sim = new SimpleDateFormat("yyyy-MM-dd");
		String date1= sim.format(new Date()).trim();
		return sim.parse(date1);
	}
	public String time2(){
		SimpleDateFormat  sim = new SimpleDateFormat("yyyy-MM-dd");
		String date= sim.format(new Date()).trim();
		return date;
	}
	public String getLashMonth(String day){
		Date date=new Date();
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		if(day.equals("30")){
			c.add(Calendar.MONTH, -1);
		}else if(day.equals("7")){
			c.add(Calendar.DATE, -8);
		}else if(day.equals("90")){
			c.add(Calendar.MONTH, -3);
		}else if(day.equals("1000")){
			c.add(Calendar.YEAR, -3);
		}else if(day.equals("1")){
			c.add(Calendar.DATE, -1);
		}
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		String d=sf.format(c.getTime()).trim();
		return d;
	}
	public String getNewDate(String date,int day,String format){
		SimpleDateFormat  sim = new SimpleDateFormat(format);
		Date d = null;
		String date1=null;
		try {
			d = sim.parse(date);
			d.setDate(d.getDate()-day);
			date1=sim.format(d).trim();
			System.out.println("date:"+date1);
		} catch (ParseException e) {
			System.out.println("日期转换失败");
			e.printStackTrace();
		}
		return date1;
	}
	public Date getNewDate1(String date){
		SimpleDateFormat  sim = new SimpleDateFormat("yyyy-MM-ddhh:mm:ss");
		Date d = null;
		try {
			d = sim.parse(date);
		} catch (ParseException e) {
			System.out.println("日期转换失败");
			e.printStackTrace();
		}
		return d;
	}
	public Date getNewDate2(String date,int day,String format){
		SimpleDateFormat  sim = new SimpleDateFormat(format);
		Date d = null;
		try {
			d = sim.parse(date);
			d.setDate(d.getDate()-day);
		} catch (ParseException e) {
			System.out.println("日期转换失败");
			e.printStackTrace();
		}
		return d;
	}
	public String dateToString(Date date)
	{
		SimpleDateFormat  sim = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date1= sim.format(date).trim();
		return date1;
	}
	public Date getLongDate(String date){
		SimpleDateFormat  sim = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		Date d = null;
		try {
			d = sim.parse(date);
		} catch (ParseException e) {
			System.out.println("日期转换失败");
			e.printStackTrace();
		}
		return d;
	}
	public String dateToString1(Date date)
	{
		SimpleDateFormat  sim = new SimpleDateFormat("yyyy-MM-dd");
		String date1= sim.format(date).trim();
		return date1;
	}
	public String getPath(){
		SimpleDateFormat  sim = new SimpleDateFormat("yyyy/MM/dd");
		String date= sim.format(new Date()).trim();
		return date;
	}
	public String randomNo(int i,String format,int length)
	{
		Random r=new Random();
		SimpleDateFormat  sim = new SimpleDateFormat(format);
		Date time=new Date();
		time.setDate(time.getDate()-i);
		String date= sim.format(time).trim();   
		String random=date+(Math.random()+"").replace(".", "");
		return random.substring(0, length);
	}
	public String getNewDateMin(String date,int min){
		SimpleDateFormat  sim = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date d = null;
		String date1=null;
		try {
			d = sim.parse(date);
			d.setMinutes(d.getMinutes()+min);
			date1=sim.format(d).trim();
			System.out.println("date:"+date1);
		} catch (ParseException e) {
			System.out.println("日期转换失败");
			e.printStackTrace();
		}
		return date1;
	}
	public static void main(String[] args) {
		RandomID r=new RandomID();
		System.out.println(r.getNewDate("2014-12-03 15:30:27", -1, "yyyy-mm-dd"));
		System.out.println("2014-12-03 15:30:27".substring(0, 30));
		
	}
}






