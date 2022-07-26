package com.cloudrich.ereader.briefing.dao;

import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.briefing.entity.MeetBriefingMainEntity;

public interface MeetBriefingMainDao {
    int deleteByPrimaryKey(Integer briefid);

    int insert(MeetBriefingMainEntity record);

    MeetBriefingMainEntity selectByPrimaryKey(Integer briefid);

    List<MeetBriefingMainEntity> selectAll();

    int updateByPrimaryKey(MeetBriefingMainEntity record);
    
    List<MeetBriefingMainEntity> selectAllByMeetid(Integer meetid);
    
    List<MeetBriefingMainEntity>  searchBriefByKeyword(Map<String,Object> map);
    
    int selectBriefCountByMeetidAndUserid(Map map);
    
    List<MeetBriefingMainEntity> selectAllByMeetidAndUserid(Map<String,Object> map);
}