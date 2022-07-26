package com.cloudrich.ereader.filemonitor.service;

import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.filemonitor.entity.FileMonitorEntity;

public interface FileMonitorService {
	
	 public int updateUserFileMoniter(FileMonitorEntity entity);
	 
	 public int selectUserAcceptFileCount(int meetid,int userid);
	 
	 public int selectTotalMeetFileCount(int meetid,String mtype,int userid);

	 public List<Map<String, Object>> selectAllUsers();
	
	 public  List<Map<String, Object>> selectAllUsersByMeetid(Map<String, Object> map);
}
