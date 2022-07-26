package com.cloudrich.ereader.calendar.dao;

import com.cloudrich.ereader.calendar.entity.CalendarPadEntity;

import java.util.List;
import java.util.Map;

public interface CalendarPadDao {
    int deleteByPrimaryKey(Map<String,Object> map);

    int insert(CalendarPadEntity record);

    CalendarPadEntity selectByPrimaryKey(Integer eventid);

    List<CalendarPadEntity> selectAll();

    int updateByPrimaryKey(CalendarPadEntity record);
    
    List<CalendarPadEntity> selectByUserid(Map<String,Object> map);
    
}