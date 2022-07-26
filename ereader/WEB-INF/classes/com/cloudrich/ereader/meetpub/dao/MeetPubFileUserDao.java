package com.cloudrich.ereader.meetpub.dao;

import com.cloudrich.ereader.meetpub.entity.MeetPubFileUserEntity;
import java.util.List;

public interface MeetPubFileUserDao {
    int deleteByPrimaryKey(Integer id);

    int insert(MeetPubFileUserEntity record);

    MeetPubFileUserEntity selectByPrimaryKey(Integer id);

    List<MeetPubFileUserEntity> selectAll();

    int updateByPrimaryKey(MeetPubFileUserEntity record);
}