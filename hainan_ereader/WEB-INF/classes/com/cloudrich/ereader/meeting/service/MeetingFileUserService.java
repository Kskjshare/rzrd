package com.cloudrich.ereader.meeting.service;

import java.util.List;

import com.cloudrich.ereader.meeting.entity.MeetFileUserEntity;


public interface MeetingFileUserService {
    int deleteByPrimaryKey(Integer id);

    int insert(MeetFileUserEntity record);

    MeetFileUserEntity selectByPrimaryKey(Integer id);

    List<MeetFileUserEntity> selectAll();

    int updateByPrimaryKey(MeetFileUserEntity record);
    
    //根据文件fileid获取用户 
    List<MeetFileUserEntity> selectFileUsersByFileid(Integer id);
}
