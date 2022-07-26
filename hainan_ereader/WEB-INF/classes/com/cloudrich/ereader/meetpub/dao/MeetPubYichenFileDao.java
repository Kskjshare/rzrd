package com.cloudrich.ereader.meetpub.dao;

import java.util.List;

import com.cloudrich.ereader.meetpub.entity.MeetPubYichenFileEntity;

public interface MeetPubYichenFileDao {
    int deleteByPrimaryKey(Integer id);

    int insert(MeetPubYichenFileEntity record);

    MeetPubYichenFileEntity selectByPrimaryKey(Integer id);

    List<MeetPubYichenFileEntity> selectAll();

    int updateByPrimaryKey(MeetPubYichenFileEntity record);
   
    int deletePubYichenByMeetid(int meetid);
}