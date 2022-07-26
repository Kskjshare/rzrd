package com.cloudrich.ereader.meeting.dao;

import com.cloudrich.ereader.meeting.entity.MeetFileUserEntity;
import java.util.List;

public interface MeetFileUserDao {
    int deleteByPrimaryKey(Integer id);

    int insert(MeetFileUserEntity record);

    MeetFileUserEntity selectByPrimaryKey(Integer id);

    List<MeetFileUserEntity> selectAll();

    int updateByPrimaryKey(MeetFileUserEntity record);
    
    //根据文件fileid获取用户 
    List<MeetFileUserEntity> selectFileUsersByFileid(Integer id);
    //文件管理中根据文件fileid获取用户 
    List<MeetFileUserEntity> selectUserByFileid(Integer id);
}