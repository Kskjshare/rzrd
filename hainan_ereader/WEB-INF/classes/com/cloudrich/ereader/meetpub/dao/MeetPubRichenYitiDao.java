package com.cloudrich.ereader.meetpub.dao;

import java.util.List;

import com.cloudrich.ereader.meeting.entity.MeetRichenYitiEntity;
import com.cloudrich.ereader.meetpub.entity.MeetPubRichenYitiEntity;

public interface MeetPubRichenYitiDao {
    int deleteByPrimaryKey(Integer id);

    int insert(MeetPubRichenYitiEntity record);

    MeetPubRichenYitiEntity selectByPrimaryKey(Integer id);

    List<MeetPubRichenYitiEntity> selectAll();

    int updateByPrimaryKey(MeetPubRichenYitiEntity record);
    
    List<MeetRichenYitiEntity> selectAllYitiByRichenid(java.util.Map<String,Object> map);
    
    int deletePubRichenYitiByMeetid(int meetid);
}