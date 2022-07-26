package com.cloudrich.ereader.meetpub.dao;

import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.meeting.entity.MeetFileMainEntity;
import com.cloudrich.ereader.meeting.entity.MeetYichenMainEntity;
import com.cloudrich.ereader.meetpub.entity.MeetPubYichenEntity;

public interface MeetPubYichenDao {
    int deleteByPrimaryKey(Integer id);

    int insert(MeetPubYichenEntity record);

    MeetPubYichenEntity selectByPrimaryKey(Integer id);

    List<MeetPubYichenEntity> selectAll();

    int updateByPrimaryKey(MeetPubYichenEntity record);
    
    //根据议程id获取议程
    MeetPubYichenEntity selectByYichenid(Integer id);
    
    //获取最后的版本号
    int selectMaxVersion(int meetid);
    
    //获取父议程
    List<MeetYichenMainEntity> selectAllParentYichenByMeetid(java.util.Map<String,Object> map);
    
    //获取子议程
    List<MeetYichenMainEntity> selectAllSubYichenByYichenid(java.util.Map<String,Object> map);
    
    //获取议程文件
    List<MeetFileMainEntity> selectFilesByYichenid(java.util.Map<String,Object> map);
    
    
    List<MeetFileMainEntity> selectFilesByYichenidAndUserid(java.util.Map<String,Object> map);
    
    List<MeetFileMainEntity> selectFilesByYichenidAndUseridLHG(java.util.Map<String,Object> map);
    
    int deletePubYichenFileByMeetid(int meetid);
    
    MeetPubYichenEntity selectPubtimeByMeetid(Map<String,Object> map);
}

