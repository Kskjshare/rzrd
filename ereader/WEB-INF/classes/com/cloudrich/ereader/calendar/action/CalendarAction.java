package com.cloudrich.ereader.calendar.action;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;

import com.cloudrich.ereader.calendar.entity.CalendarMainEntity;
import com.cloudrich.ereader.calendar.entity.CalendarPubEntity;
import com.cloudrich.ereader.calendar.service.CalendarService;
import com.cloudrich.ereader.common.action.BaseAction;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.dict.entity.DictDataEntity;
import com.cloudrich.framework.common.util.RandomID;
import com.cloudrich.framework.util.LunarCalendar;

@Controller("CalendarAction")
public class CalendarAction extends BaseAction{

	private static final long serialVersionUID = 1L;
	@Resource CalendarService calendarService;
	private CalendarMainEntity entity;
	private Page page;
	private int pageNo=1;
	private int pageSize=8;
	private long totalPage;
	private String eventname;
	private String showdate;
	private String comment;
	private int eventid;
	private List<CalendarMainEntity> list;
	private String eventtype;
	private String caldate;

	public String select(){
		page=calendarService.selectAll(pageNo,pageSize);
		totalPage=page.getPages();
		return SUCCESS;
	}
	public void getSelectJson() {
		list=calendarService.selectEvent();
		JSONObject json=new JSONObject();
		try{
			json.put("list",JSONArray.fromObject(list).toString());
			json.put("state", true);
			SimpleDateFormat  sdf=new SimpleDateFormat("dd/MM/yyyy");
			Map<String,String> lunar=LunarCalendar.getLundar(caldate);
			for (int i = 0; i < list.size(); i++) {
				Date showdate=list.get(i).getShowdate();
				Calendar c=Calendar.getInstance();
				c.setTime(showdate);
				String day=String.valueOf(c.get(Calendar.DAY_OF_MONTH));
				String month=String.valueOf(c.get(Calendar.MONTH)+1);
				String year=String.valueOf(c.get(Calendar.YEAR));
				if(month.trim().length()==1){
					month="0"+month;
				}
				if(day.trim().length()==1){
					day="0"+day;
				}
				String dateStr=day+"/"+month+"/"+year;
				if(lunar.get(dateStr)!=null&&!"".equals(lunar.get(dateStr))){
					lunar.remove(dateStr);
				}
			}
			json.put("lunarmap",lunar);
		}catch (Exception e) {
			json.put("state", false);
			e.printStackTrace();
		}
		outJsonString(json.toString());
	}

	public String add(){
		entity=new CalendarMainEntity();
		entity.setEventname(eventname);
		RandomID r=new RandomID();
		entity.setShowdate(r.getNewDate3(showdate));
		entity.setCreateuserid(getUseridInSession());
		entity.setIsdel(0);
		entity.setComment(comment);
		entity.setEventtype(eventtype);
		calendarService.insert(entity);
		return SUCCESS;
	}
	public String insertAndPush(){
		try {
			calendarService.insertAndPush();
			jsonSuccess("发布成功");
		} catch (Exception e) {
			jsonError("发布失败");
		}	
		return SUCCESS;
	}
	public String getPubtime(){
		try {
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
		    CalendarPubEntity entity=calendarService.selectLatestPubtime();
			jsonSuccess(sdf.format(entity.getCreatedate()));
		} catch (Exception e) {
			jsonError("");
		}	
		return SUCCESS;
	}
	public String deleteById(){
		CalendarMainEntity  calentity=calendarService.selectEntityById(eventid);
		CalendarPubEntity  pubcalentity=calendarService.selectEntityByIdpub(eventid);
		
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		showdate=sdf.format(calentity.getShowdate());
		calendarService.delete(eventid);
		calendarService.deletepub(eventid);
		return SUCCESS;
	}
	public String selectById() {
		entity=calendarService.selectEntityById(eventid);
		return SUCCESS;
	}
	public String update(){
		entity=new CalendarMainEntity();
		entity.setEventid(eventid);
		entity.setEventname(eventname);
		RandomID r=new RandomID();
		entity.setShowdate(r.getNewDate3(showdate));
		entity.setComment(comment);
		entity.setEventtype(eventtype);
		calendarService.update(entity);
		return SUCCESS;
	}

	public List<CalendarMainEntity> getList() {
		return list;
	}

	public void setList(List<CalendarMainEntity> list) {
		this.list = list;
	}

	public CalendarMainEntity getEntity() {
		return entity;
	}

	public void setEntity(CalendarMainEntity entity) {
		this.entity = entity;
	}

	public int getEventid() {
		return eventid;
	}

	public void setEventid(int eventid) {
		this.eventid = eventid;
	}

	public String getEventname() {
		return eventname;
	}

	public void setEventname(String eventname) {
		this.eventname = eventname;
	}

	public String getShowdate() {
		return showdate;
	}

	public void setShowdate(String showdate) {
		this.showdate = showdate;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public long getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(long totalPage) {
		this.totalPage = totalPage;
	}

	public String getEventtype() {
		return eventtype;
	}

	public void setEventtype(String eventtype) {
		this.eventtype = eventtype;
	}
	public String getCaldate() {
		return caldate;
	}
	public void setCaldate(String caldate) {
		this.caldate = caldate;
	}	
}
