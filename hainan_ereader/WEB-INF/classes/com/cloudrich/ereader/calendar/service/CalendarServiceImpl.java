package com.cloudrich.ereader.calendar.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cloudrich.ereader.calendar.dao.CalendarMainDao;
import com.cloudrich.ereader.calendar.dao.CalendarPadDao;
import com.cloudrich.ereader.calendar.dao.CalendarPubDao;
import com.cloudrich.ereader.calendar.entity.CalendarMainEntity;
import com.cloudrich.ereader.calendar.entity.CalendarPadEntity;
import com.cloudrich.ereader.calendar.entity.CalendarPubEntity;
import com.cloudrich.ereader.common.dao.PageHelper;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.common.dao.PageHelper.PageCall;

@Service("CalendarServiceImpl")
public class CalendarServiceImpl implements CalendarService{


	@Resource CalendarMainDao calendarMainDao ;
	@Resource CalendarPubDao calendarPubDao ;
	@Resource CalendarPadDao calendarPadDao ;

	private static final long serialVersionUID = 1L;


	/**
	 * 修改isdel的数据为1
	 */
	@Override
	public int delete(int id){
		int i=calendarMainDao.deleteByPrimaryKey(id);
		return i;

	}
	
	
	/**
	 * 展示 isdel=0的数据
	 */
	@Override
	public CalendarMainEntity selectEntityById(int id) {
		return calendarMainDao.selectByPrimaryKey(id);
	}
	
	
	@Override
	public Page selectAll(int pageNo, int pageSize) {
		return PageHelper.pagedQuery(new PageCall() {
			@Override
			public void executeQuery() {
				calendarMainDao.selectAll();
			}
		}, pageNo, pageSize);
	}

	/**
	 * 新增事件数据
	 */
	public int insert(CalendarMainEntity entiry){
		int i=calendarMainDao.insert(entiry);
		return i;

	}
	
	/**
	 * 修改事件数据
	 */
	public int update(CalendarMainEntity entiry){
		int i=calendarMainDao.updateByPrimaryKey(entiry);
		return i;
	}
	/**
	 * 展示所有isdel=0的数据
	 */
	@Override
	public List<CalendarMainEntity> selectEvent() {
		List<CalendarMainEntity> list=calendarMainDao.selectAll();
		return list;
	}
	/**
	 * 展示发送的数据
	 */
	@Override
	public List<CalendarMainEntity> selectPubEvent() {
		List<CalendarMainEntity> list=calendarPubDao.selectAll();
		return list;
	}
	/**
	 * 用pad端增加事件
	 */
	@Override
	public int insertEvent(CalendarPadEntity briefing) {
		return calendarPadDao.insert(briefing);
	}

	@Override
	public List<CalendarPadEntity> selectByUserid(Map<String,Object> map) {
		// TODO Auto-generated method stub
		return calendarPadDao.selectByUserid(map);
	}
	
	/**
	 * pc端发送的数据新增到pad端并展示
	 */
	@Override
	public void insertAndPush() {
		List<CalendarMainEntity> list=calendarMainDao.selectAll();
		if(list==null||list.size()==0){
			calendarPubDao.deleteAll();	
		}else{
			for (int i = 0; i < list.size(); i++) {
				CalendarMainEntity entity=list.get(i);
				calendarPubDao.deleteByPrimaryKey(entity.getEventid());
				CalendarPubEntity pubentity=new  CalendarPubEntity();
				pubentity.setComment(entity.getComment());
				pubentity.setCreatedate(new Date());
				pubentity.setCreateuserid(entity.getCreateuserid());
				pubentity.setEventid(entity.getEventid());
				pubentity.setEventname(entity.getEventname());
				pubentity.setEventtype(entity.getEventtype());
				pubentity.setIsdel(0);
				pubentity.setShowdate(entity.getShowdate());
				calendarPubDao.insert(pubentity);
			}
			
		}
		
		
	}

	@Override
	public CalendarPubEntity selectLatestPubtime() {
		
		return calendarPubDao.selectLatestPubtime();
	}

	@Override
	public int deletePadCalendar(Map<String,Object> map) {
		
		return calendarPadDao.deleteByPrimaryKey(map);
	}

	@Override
	public int updatePadCalendar(CalendarPadEntity entity) {
		
		return calendarPadDao.updateByPrimaryKey(entity);
	}

	@Override
	public int deletepub(int id) {
		int i=calendarPubDao.deleteByPrimaryKey(id);
		return i;
	}


	@Override
	public CalendarPubEntity selectEntityByIdpub(int id) {
		return calendarPubDao.selectByPrimaryKey(id);
	}

}
