package com.cloudrich.ereader.meetpub.dao;

import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.meetpub.entity.MeetPubFileScopeEntity;
import com.cloudrich.ereader.system.entity.SysUserMainEnity;

public interface MeetPubFileScopeDao {
    int deleteByPrimaryKey(Integer id);

    int insert(MeetPubFileScopeEntity record);

    MeetPubFileScopeEntity selectByPrimaryKey(Integer id);

    List<MeetPubFileScopeEntity> selectAll();

    int updateByPrimaryKey(MeetPubFileScopeEntity record);
    
    List<SysUserMainEnity> selectFileSendScopeUser(Map<String,Object> map);
    
    
    int deletePubFileScopeByMeetid(Map<String,Object> map);
}