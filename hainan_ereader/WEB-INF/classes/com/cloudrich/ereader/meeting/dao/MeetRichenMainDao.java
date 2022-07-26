package com.cloudrich.ereader.meeting.dao;

import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.meeting.entity.MeetRichenMainEntity;

public interface MeetRichenMainDao {
    int deleteByPrimaryKey(Integer richenid);

    int insert(MeetRichenMainEntity record);

    MeetRichenMainEntity selectByPrimaryKey(Integer richenid);

    List<MeetRichenMainEntity> selectAll();

    int updateByPrimaryKey(MeetRichenMainEntity record);
    
    List<MeetRichenMainEntity> selectAllRichenByMeetid(int meetid);
    
    int insertAndGetId(MeetRichenMainEntity record);
    
    List<MeetRichenMainEntity> selectParentRichenByMeetid(int meetid);
    
    List<MeetRichenMainEntity> selectSubRichenByRichenid(int richenid);
    
    MeetRichenMainEntity selectMeetIdByRichenYiyiid(Integer yitiid);
    
    //查询父日程
    MeetRichenMainEntity selectParentRichenByNameAndMeetid(Map<String,Object> map);
    
    //查询子日程
    MeetRichenMainEntity selectSubRichenByNameAndMeetid(Map<String,Object> map);
    
    int updateRichenSort(Map<String,Object> map);
    
    MeetRichenMainEntity selectBmhDateRichenByMeetid(int meetid);
    
    MeetRichenMainEntity selectBmhTimeRichenByRichenid(int richenid);

    List<MeetRichenMainEntity> selectRichenFileByFileid(int fileid);
    
}