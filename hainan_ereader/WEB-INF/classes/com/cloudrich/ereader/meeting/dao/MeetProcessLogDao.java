package com.cloudrich.ereader.meeting.dao;

import java.util.List;

import com.cloudrich.ereader.meeting.entity.MeetProcessLogEntity;

public interface MeetProcessLogDao {
    int deleteByPrimaryKey(Integer id);

    int insert(MeetProcessLogEntity record);

    MeetProcessLogEntity selectByPrimaryKey(Integer id);

    List<MeetProcessLogEntity> selectAll();

    int updateByPrimaryKey(MeetProcessLogEntity record);
    
    List<MeetProcessLogEntity> selectProcessLogByMeetid(int meetid);
    
    int selectMaxProcessLogGlobalid();
}