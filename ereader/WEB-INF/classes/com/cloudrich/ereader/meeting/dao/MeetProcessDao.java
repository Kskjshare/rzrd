package com.cloudrich.ereader.meeting.dao;

import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.meeting.entity.MeetProcessEntity;

public interface MeetProcessDao {
    int deleteByPrimaryKey(Integer id);

    int insert(MeetProcessEntity record);

    MeetProcessEntity selectByPrimaryKey(Integer id);

    List<MeetProcessEntity> selectAll();

    int updateByPrimaryKey(MeetProcessEntity record);
    
    /**
     * 根据meetid和子模块code获取当前流程信息
     * @param map
     * @return
     */
    MeetProcessEntity selectCurProcessByMeetidAndSubmodulecode(Map map);
    
    
    void updateCurState(java.util.Map<String,Object> map);
    
  
}