package com.cloudrich.ereader.meetpub.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.meetpub.entity.MeetPubGroupEntity;


public interface MeetPubGroupDao {
    int deleteByPrimaryKey(Integer groupid);
    
    int deleteByMeetid(Map<String, Object> map);

    int insert(MeetPubGroupEntity record);

    MeetPubGroupEntity selectByPrimaryKey(Integer groupid);

    List<MeetPubGroupEntity> selectAll();

    int updateByPrimaryKey(MeetPubGroupEntity record);
    
    int updateByMeetid(MeetPubGroupEntity record);
    
    MeetPubGroupEntity selectGroupByMeetidAndGroupno(Map<String, Object> map);
    
    List<MeetPubGroupEntity> selectGroupByMeetidAndGroupnoClient(Map<String, Object> map);
    
    int selectFileCountByMeetid(Map<String, Object> map);
}