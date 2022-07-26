package com.cloudrich.ereader.meeting.dao;

import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.meeting.entity.MeetFileScopeEntity;
import com.cloudrich.ereader.system.entity.SysUserMainEnity;

public interface MeetFileScopeDao {
    int deleteByPrimaryKey(Integer id);
    

    int insert(MeetFileScopeEntity record);

    MeetFileScopeEntity selectByPrimaryKey(Integer id);

    List<MeetFileScopeEntity> selectAll();

    int updateByPrimaryKey(MeetFileScopeEntity record);
    
    List<MeetFileScopeEntity> selectByFileid(int fileid);
    
    List<SysUserMainEnity> selectFileSendScopeUser(int fileid);
    
    List<MeetFileScopeEntity> selectFileScopeByMeetid(Map<String,Object> map);
}