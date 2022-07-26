package com.cloudrich.ereader.meeting.dao;

import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.meeting.entity.MeetMainEntity;

public interface MeetMainDao {
	int deleteByPrimaryKey(Integer meetid);

	 int insert(MeetMainEntity record);

    MeetMainEntity selectByPrimaryKey(Integer meetid);
    MeetMainEntity deleteMeetBasicByMeetId(Integer meetid);

    List<MeetMainEntity> selectAll();
    
    int updateByPrimaryKey(MeetMainEntity record);
    
    
    /**
     * 删除历史会议
     * @param meetid
     * @return
     */
    int deletemeetLS(Integer meetid);
    
    List<MeetMainEntity> selectCurMeeting(String mtype);
    
    List<MeetMainEntity> selectHisMeeting(String mtype);
    
    List<MeetMainEntity>  selectALLMeetingByMtype (String mtype);

	int delete(Integer id);
	
	//根据meetid获取会议基本信息
	MeetMainEntity selectEntityBymeetid(Integer meetid);
	
	
	List<MeetMainEntity> selectJnumByMtype(String mtype);
	
	List<MeetMainEntity> selectAllTypeCurMeeting();
	
	String selectMtypeByMeetid(int meetid);
	
	List<MeetMainEntity> selectHisMeetingCnum(Map<String,Object> map);
}