package com.cloudrich.ereader.briefing.dao;

import com.cloudrich.ereader.briefing.entity.*;
import com.cloudrich.ereader.system.entity.SysUserMainEnity;

import java.util.List;

public interface MeetBriefingSendscopeDao {
    int deleteByPrimaryKey(Integer id);

    int insert(MeetBriefingSendscopeEntity record);

    MeetBriefingSendscopeEntity selectByPrimaryKey(Integer id);

    List<MeetBriefingSendscopeEntity> selectAll();

    int updateByPrimaryKey(MeetBriefingSendscopeEntity record);

    
    List<MeetBriefingSendscopeEntity> selectByBriefid(Integer id);
    
    int deleteByBrifeid(Integer id);

    
    List<SysUserMainEnity> selectScopeUserByBriefId(int briefid);

}