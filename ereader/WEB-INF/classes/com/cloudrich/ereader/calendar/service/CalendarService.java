package com.cloudrich.ereader.calendar.service;

import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.calendar.entity.CalendarMainEntity;
import com.cloudrich.ereader.calendar.entity.CalendarPadEntity;
import com.cloudrich.ereader.calendar.entity.CalendarPubEntity;
import com.cloudrich.ereader.common.dao.PageHelper.Page;

public interface CalendarService {
	
	CalendarMainEntity selectEntityById(int briefid);
	Page selectAll(int pageNo, int pageSize);
    int insert(CalendarMainEntity briefing);
    int update(CalendarMainEntity briefing); 
    int delete(int id);
    List<CalendarMainEntity> selectEvent();
    List<CalendarMainEntity> selectPubEvent();
    
    int insertEvent(CalendarPadEntity briefing);
    List<CalendarPadEntity> selectByUserid(Map<String,Object> map);
    int deletePadCalendar(Map<String,Object> map);
    int updatePadCalendar(CalendarPadEntity entity);
    
    void insertAndPush();
    CalendarPubEntity selectLatestPubtime();
    
    int deletepub(int id);
    CalendarPubEntity selectEntityByIdpub(int id);
}
