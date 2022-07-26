package com.cloudrich.ereader.meeting.dao;

import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.meeting.entity.MeetFileMainEntity;
import com.cloudrich.ereader.meeting.entity.MeetYichenMainEntity;

public interface MeetYichenMainDao {
    int deleteByPrimaryKey(Integer yichenid);

    int insert(MeetYichenMainEntity record);

    MeetYichenMainEntity selectByPrimaryKey(Integer yichenid);

    List<MeetYichenMainEntity> selectAll();

    int updateByPrimaryKey(MeetYichenMainEntity record);
    
    List<MeetYichenMainEntity> selectAllByMeetid(Integer meetid);
    
    List<MeetFileMainEntity> selectFilesByYichenid(Integer yichenid);
    
    
    /**
     * 获取所有议程包括删除的
     * @param meetid
     * @return
     */
    List<MeetYichenMainEntity> selectAllByMeetidProc(Integer meetid);
    
    List<MeetYichenMainEntity> selectAllParentYichenByMeetid(Integer meetid);
    
    List<MeetYichenMainEntity> selectAllSubYichenByYichenid(int yichenid);
    
    int deleteSubYichenByPid(int pyichenid);
    
    MeetYichenMainEntity selectYichenByTitleAndMeetid(Map<String,Object> map);
    
    int updateYichenSort(Map<String,Object> map);
    
    List<MeetYichenMainEntity> selectBindYichenByFileid(Integer fileid);
    
    List<MeetFileMainEntity> selectFilesByYichenidAndUserid(Map<String,Object> map);
    
    
}