package com.cloudrich.ereader.filemonitor.service;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cloudrich.ereader.briefing.dao.MeetBriefingMainDao;
import com.cloudrich.ereader.briefingpub.dao.MeetPubBriefingDao;
import com.cloudrich.ereader.filemonitor.dao.FileMonitorDao;
import com.cloudrich.ereader.filemonitor.entity.FileMonitorEntity;
import com.cloudrich.ereader.meeting.dao.MeetFileMainDao;
import com.cloudrich.ereader.meeting.service.MeetingService;
import com.cloudrich.ereader.meetpub.dao.MeetPubFileDao;
import com.cloudrich.ereader.meetpub.dao.MeetPubGroupDao;

@Service("FileMonitorServiceImpl")
public class FileMonitorServiceImpl  implements FileMonitorService {


	private static final long serialVersionUID = 1L;
	@Resource FileMonitorDao filemonitorDao;
	@Resource MeetingService meetService;
	@Resource MeetFileMainDao meetFileMainDao;
	@Resource MeetPubFileDao meetPubFileDao;
	@Resource MeetBriefingMainDao meetBriefDao;
	@Resource MeetPubBriefingDao meetPubBriefDao;
	@Resource MeetPubGroupDao meetPubGroupDao;
	
	@Override
	public int updateUserFileMoniter(FileMonitorEntity entity){
		 
		//首先
		java.util.Map<String,Object> map=new HashMap<String,Object>();
		map.put("userid", entity.getUserid());
		map.put("meetid", entity.getMeetid());
		map.put("moduleid", entity.getModuleid());
		FileMonitorEntity tempentity=filemonitorDao.selectEntityByUseridAndMeetidAndModuleid(map);
		
		int moduleid=0;
		int filecount=0;
		moduleid=entity.getModuleid();
		java.util.Map<String,Object> mapcount=new HashMap<String,Object>();
		mapcount.put("meetid", entity.getMeetid());
		mapcount.put("userid", entity.getUserid());
		
		
		//常委会议程
		try{
				if(moduleid==1){
					mapcount.put("fileown", "1");
					filecount=meetPubFileDao.selectPubFileCountByMeetidAndVersionAndUserid(mapcount);
			    //会中主任会议
				}else if(moduleid==2){
					mapcount.put("fileown","2");
					filecount=meetPubFileDao.selectPubFileCountByMeetidAndVersionAndUserid(mapcount);
				//分组
				}else if(moduleid==8){
					
					filecount=meetPubGroupDao.selectFileCountByMeetid(mapcount);
				//参阅文件
				}else if(moduleid==4){
					filecount=meetPubFileDao.selectCYFileCountByMeetidAndVersionAndUserid(mapcount);
					
				//主任及其他会议议程
				}else if(moduleid==6){
					mapcount.put("fileown","1");
					filecount=meetPubFileDao.selectPubFileCountByMeetidAndVersionAndUserid(mapcount);
					
				//简报和纪要
				} else if(moduleid==7){
					//mapcount.put("fileown","1");
					filecount=meetPubBriefDao.selectBriefCountByMeetidAndUserid(mapcount);
					
					
				}
		}catch(Exception e){
			e.printStackTrace();
			filecount=0;
		}
		entity.setFilecount(filecount);
	
		
		if(tempentity==null){
			filemonitorDao.insert(entity);
		}else{
			filemonitorDao.updateByPrimaryKey(entity);
		}
		
		return 1; 
	 }
	
	
	@Override
	public int selectUserAcceptFileCount(int meetid,int userid){
		Map<String,Object> map=new java.util.HashMap<String,Object>();
		map.put("meetid", meetid);
		map.put("userid", userid);
		int count=0;
		try{
			count= filemonitorDao.selectFileAcceptCountByMeetidAndUserid(map);
	    }catch(Exception e){
	    	count=0;
	    }
		return count;
	}
	
	
	@Override
	public int selectTotalMeetFileCount(int meetid,String mtype,int userid){
		int totalfile=0;
		java.util.Map<String,Object> mapcount=new HashMap<String,Object>();
		
		mapcount.put("meetid", meetid);
		mapcount.put("userid", userid);
		int filecount=0;
		int version=0;
		int yccount=0;
		int hzzrcount=0;
		int bmhcount=0;
		int cycount=0;
		int jbcount=0;
		
			   //议程	
		       try{
					mapcount.put("fileown", "1");
				   yccount=meetPubFileDao.selectPubFileCountByMeetidAndVersionAndUserid(mapcount);
				}catch(Exception e){
					e.printStackTrace();
				}
				
				//会中主任	
				try{
					mapcount.put("fileown","2");
				   hzzrcount=meetPubFileDao.selectPubFileCountByMeetidAndVersionAndUserid(mapcount);
				}catch(Exception e){
					e.printStackTrace();
				}
					
				//分组
				try{
				   bmhcount=meetPubGroupDao.selectFileCountByMeetid(mapcount);;
				}catch(Exception e){
					e.printStackTrace();
				}
				
				//参阅文件
				try{
				   cycount=meetPubFileDao.selectCYFileCountByMeetidAndVersionAndUserid(mapcount);
				}catch(Exception e){
					e.printStackTrace();
				}
				
				//简报
				try{
				   jbcount=meetPubBriefDao.selectBriefCountByMeetidAndUserid(mapcount);
				}catch(Exception e){
					e.printStackTrace();
				}
				
				System.out.println("yichenFileMonitor is------yichen--------:"+yccount);
				System.out.println("yichenFileMonitor is------hzzrcount---------:"+hzzrcount);
				System.out.println("yichenFileMonitor is-------bmhcount--------:"+bmhcount);
				System.out.println("yichenFileMonitor is--------cycount-------:"+cycount);
				//System.out.println("yichenFileMonitor is---------------:"+yccount);
				totalfile=yccount+hzzrcount+bmhcount+cycount+jbcount;
				
		return totalfile;
	}


	@Override
	public List<Map<String, Object>> selectAllUsers() {
		return filemonitorDao.selectAllUsers();
	}


	@Override
	public List<Map<String, Object>> selectAllUsersByMeetid(Map<String, Object> map) {
		return filemonitorDao.selectAllUsersByMeetid(map);
	}
		
	
}
