package com.cloudrich.ereader.filemonitor.dao;


import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.filemonitor.entity.FileMonitorEntity;

public interface FileMonitorDao {
    int deleteByPrimaryKey(Integer id);

    int insert(FileMonitorEntity record);

    FileMonitorEntity selectByPrimaryKey(Integer id);

    List<FileMonitorEntity> selectAll();

    int updateByPrimaryKey(FileMonitorEntity record);
    
    FileMonitorEntity selectEntityByUseridAndMeetidAndModuleid(java.util.Map<String,Object> map);
    int selectFileAcceptCountByMeetidAndUserid(java.util.Map<String,Object> map);

	List<Map<String, Object>> selectAllUsers();
	
	List<Map<String, Object>> selectAllUsersByMeetid(Map<String, Object> map);
}