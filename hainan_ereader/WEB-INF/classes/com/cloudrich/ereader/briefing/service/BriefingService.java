package com.cloudrich.ereader.briefing.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.briefing.entity.MeetBriefingMainEntity;
import com.cloudrich.ereader.briefingpub.entity.MeetPubBriefingEntity;
import com.cloudrich.ereader.common.dao.PageHelper.Page;

public interface BriefingService {

	MeetBriefingMainEntity selectBriefingById(int briefid);
	
	List<MeetBriefingMainEntity> selectAllBriefingbyMeetid(int meetid);
	
    int insert(MeetBriefingMainEntity briefing);
    
    int insertPush(MeetBriefingMainEntity briefing,String actiontype);
    
    int update(MeetBriefingMainEntity briefing); 
    
    int delete(int briefid);
    
    List<MeetBriefingMainEntity> searchBriefByKeyword(String keyword,int userid);
    
    Page selectBriefingbyMeetid( int meetid,int pageNo, int pageSize);
    
    List<MeetBriefingMainEntity> selectAllBriefingbyMeetidAndUserid(int meetid,int userid);
	//获取最后一次发布时间
    MeetPubBriefingEntity selectLastPubBrief(int briefid);
    
    List<MeetPubBriefingEntity> selectAllPubBriefingbyMeetidAndUserid(int meetid,int userid) ;
}

