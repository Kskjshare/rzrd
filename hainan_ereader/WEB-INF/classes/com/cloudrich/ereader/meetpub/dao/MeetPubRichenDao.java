package com.cloudrich.ereader.meetpub.dao;

import java.util.List;

import com.cloudrich.ereader.meeting.entity.MeetRichenMainEntity;
import com.cloudrich.ereader.meetpub.entity.MeetPubRichenEntity;

public interface MeetPubRichenDao {
    int deleteByPrimaryKey(Integer id);

    int insert(MeetPubRichenEntity record);

    MeetPubRichenEntity selectByPrimaryKey(Integer id);

    List<MeetPubRichenEntity> selectAll();

    int updateByPrimaryKey(MeetPubRichenEntity record);
    
    //获取最后的版本号
    int selectMaxVersion();
    
    //获取父日程
    List<MeetRichenMainEntity> selectParentRichenByMeetid(java.util.Map<String,Object> map);
    
    //获取子日程
    List<MeetRichenMainEntity> selectSubRichenByRichenid(java.util.Map<String,Object> map);
    
    int deletePubRichenByMeetid(int meetid);
    
    MeetPubRichenEntity selectRichenPubtimeByMeetid(java.util.Map<String,Object> map);
    
}