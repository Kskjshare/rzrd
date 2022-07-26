package com.cloudrich.ereader.meeting.dao;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.meeting.entity.MeetFileMainEntity;

public interface MeetFileMainDao {
    int deleteByPrimaryKey(Integer fileid);

    int insert(MeetFileMainEntity record);

    MeetFileMainEntity selectByPrimaryKey(Integer fileid);

    List<MeetFileMainEntity> selectAll();

    int updateByPrimaryKey(MeetFileMainEntity record);
    
    
    List<MeetFileMainEntity> selectAllFileByMeetidAndFileOwn(HashMap<String,Object> map);
    
    int insertAndGetId(MeetFileMainEntity record); 
    
    int updateFileTypeByFileId(MeetFileMainEntity record); 
     
    List<MeetFileMainEntity> searchFileByKeyword(Map<String,Object> map);
    
    int updateFileSort(Map<String,Object> map);
    //置顶
    int updateFileSortZD(Map<String,Object> map);
    
    int getMeetFileMaxSort(Map<String,Object> map);
    
    int selectFileCountByMeetidAndFileOwnAndUserid(Map<String,Object> map);
    
    int selectYichenFileCountByMeetid(int meetid);
    
    
    List<MeetFileMainEntity> selectAllFileByMeetidAndFileOwnAndUserid(Map<String,Object> map);
    
}