package com.cloudrich.ereader.meeting.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.meeting.entity.MeetGroupMainEntity;

public interface MeetGroupMainDao {
    int deleteByPrimaryKey(Integer groupid);

    int insert(MeetGroupMainEntity record);

    MeetGroupMainEntity selectByPrimaryKey(Integer groupid);

    List<MeetGroupMainEntity> selectAll(int meetid);

    int updateByPrimaryKey(MeetGroupMainEntity record);
    
    MeetGroupMainEntity selectGroupByMeetidAndGroupno(HashMap<String, Object> map);
}