package com.cloudrich.ereader.briefing.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.briefing.entity.MeetBriefingMainEntity;
import com.cloudrich.ereader.briefing.entity.MeetBriefingSendscopeEntity;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.system.entity.SysUserMainEnity;

public interface BriefingSendscopeService {

	MeetBriefingSendscopeEntity selectBriefingById(int briefid);
	
    int insert(MeetBriefingSendscopeEntity briefing);
    
    int update(MeetBriefingSendscopeEntity briefing);  

    int delete(int briefid);

	List<MeetBriefingSendscopeEntity> selectByBriefid(int id);
	
	  int deleteByBriefid(int briefid);
	  
	  public List<SysUserMainEnity> selectScopeUserByBriefId(int briefid);
}

