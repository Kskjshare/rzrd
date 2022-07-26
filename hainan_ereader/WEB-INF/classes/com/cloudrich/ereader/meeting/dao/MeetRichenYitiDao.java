package com.cloudrich.ereader.meeting.dao;

import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.meeting.entity.MeetRichenYitiEntity;

public interface MeetRichenYitiDao {
    int deleteByPrimaryKey(Integer yitiid);

    int insert(MeetRichenYitiEntity record);

    MeetRichenYitiEntity selectByPrimaryKey(Integer yitiid);

    List<MeetRichenYitiEntity> selectAll();

    int updateByPrimaryKey(MeetRichenYitiEntity record);
    
    List<MeetRichenYitiEntity> selectAllYitiByRichenid(Integer richenid);
    
    
    int deleteYitiByRichenId(int richenid);
    
    MeetRichenYitiEntity selectYitiByYtTitleAndRichenid(Map<String,Object> map);
    
    int updateYitiSort(Map<String,Object> map);
    
    List<MeetRichenYitiEntity> selectYitiByMeetid(int meetid);
    
    int deleteAllYitiByRichenId(int richenid);

	int updateYitiBindBimu(int richenid);
    
   
}