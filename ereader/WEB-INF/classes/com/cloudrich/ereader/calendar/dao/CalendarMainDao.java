package com.cloudrich.ereader.calendar.dao;

import com.cloudrich.ereader.calendar.entity.CalendarMainEntity;

import java.util.List;

public interface CalendarMainDao {
    int deleteByPrimaryKey(Integer eventid);

    int insert(CalendarMainEntity record);

    CalendarMainEntity selectByPrimaryKey(Integer eventid);

    List<CalendarMainEntity> selectAll();

    int updateByPrimaryKey(CalendarMainEntity record);
    
}