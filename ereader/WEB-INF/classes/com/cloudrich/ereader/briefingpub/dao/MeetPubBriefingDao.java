package com.cloudrich.ereader.briefingpub.dao;

import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.briefing.entity.MeetBriefingMainEntity;
import com.cloudrich.ereader.briefingpub.entity.MeetPubBriefingEntity;


public interface MeetPubBriefingDao {
    int deleteBybriefid(Integer briefid);

    int insert(MeetPubBriefingEntity record);

    MeetPubBriefingEntity selectByBriefid(Integer briefid);

    List<MeetPubBriefingEntity> selectAll();

    int updateByPrimaryKey(MeetPubBriefingEntity record);
    
    List<MeetPubBriefingEntity> selectAllByMeetid(Integer meetid);
    
    List<MeetBriefingMainEntity>  searchBriefByKeyword(Map<String,Object> map);
    
    int selectBriefCountByMeetidAndUserid(Map map);
    
    List<MeetPubBriefingEntity> selectAllByMeetidAndUserid(Map<String,Object> map);
}