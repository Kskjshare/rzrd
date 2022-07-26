package com.cloudrich.ereader.calendar.dao;

import com.cloudrich.ereader.calendar.entity.CalendarMainEntity;
import com.cloudrich.ereader.calendar.entity.CalendarPubEntity;

import java.util.List;

public interface CalendarPubDao {
    int deleteByPrimaryKey(Integer eventid);
    
    int insert(CalendarPubEntity record);

    CalendarPubEntity selectByPrimaryKey(Integer eventid);

    List<CalendarMainEntity> selectAll();

    int updateByPrimaryKey(CalendarPubEntity record);
    
    CalendarPubEntity selectLatestPubtime();
    
    int deleteAll();
}