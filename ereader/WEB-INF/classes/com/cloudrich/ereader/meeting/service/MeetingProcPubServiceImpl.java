package com.cloudrich.ereader.meeting.service;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.cloudrich.ereader.meeting.dao.MeetFileMainDao;
import com.cloudrich.ereader.meeting.dao.MeetFileScopeDao;
import com.cloudrich.ereader.meeting.dao.MeetGroupMainDao;
import com.cloudrich.ereader.meeting.dao.MeetMainDao;
import com.cloudrich.ereader.meeting.dao.MeetProcessDao;
import com.cloudrich.ereader.meeting.dao.MeetRichenMainDao;
import com.cloudrich.ereader.meeting.dao.MeetRichenYitiDao;
import com.cloudrich.ereader.meeting.dao.MeetYichenFileDao;
import com.cloudrich.ereader.meeting.dao.MeetYichenMainDao;
import com.cloudrich.ereader.meeting.entity.MeetFileMainEntity;
import com.cloudrich.ereader.meeting.entity.MeetFileScopeEntity;
import com.cloudrich.ereader.meeting.entity.MeetGroupMainEntity;
import com.cloudrich.ereader.meeting.entity.MeetMainEntity;
import com.cloudrich.ereader.meeting.entity.MeetProcessEntity;
import com.cloudrich.ereader.meeting.entity.MeetRichenMainEntity;
import com.cloudrich.ereader.meeting.entity.MeetRichenYitiEntity;
import com.cloudrich.ereader.meeting.entity.MeetYichenFileEntity;
import com.cloudrich.ereader.meeting.entity.MeetYichenMainEntity;
import com.cloudrich.ereader.meetpub.dao.MeetPubFileDao;
import com.cloudrich.ereader.meetpub.dao.MeetPubFileScopeDao;
import com.cloudrich.ereader.meetpub.dao.MeetPubGroupDao;
import com.cloudrich.ereader.meetpub.dao.MeetPubRichenDao;
import com.cloudrich.ereader.meetpub.dao.MeetPubRichenYitiDao;
import com.cloudrich.ereader.meetpub.dao.MeetPubYichenDao;
import com.cloudrich.ereader.meetpub.dao.MeetPubYichenFileDao;
import com.cloudrich.ereader.meetpub.entity.MeetPubFileEntity;
import com.cloudrich.ereader.meetpub.entity.MeetPubFileScopeEntity;
import com.cloudrich.ereader.meetpub.entity.MeetPubGroupEntity;
import com.cloudrich.ereader.meetpub.entity.MeetPubRichenEntity;
import com.cloudrich.ereader.meetpub.entity.MeetPubRichenYitiEntity;
import com.cloudrich.ereader.meetpub.entity.MeetPubYichenEntity;
import com.cloudrich.ereader.meetpub.entity.MeetPubYichenFileEntity;

@Service
public class MeetingProcPubServiceImpl implements MeetingProcPubService {
	
	private Logger log = Logger.getLogger(MeetingProcPubServiceImpl.class);
	
	@Resource MeetYichenMainDao yichenMainDao;
	@Resource MeetPubYichenDao pubyichenDao;
	
	@Resource MeetRichenMainDao richenMainDao;
	@Resource MeetPubRichenDao pubrichenDao;
	
	@Resource MeetRichenYitiDao richenYitiDao;
	@Resource MeetPubRichenYitiDao pubrichenYitiDao;
	
	@Resource MeetFileMainDao meetFileMainDao;
	@Resource MeetPubFileDao pubMeetFileDao;
	
	@Resource MeetFileScopeDao meetFileScopeDao;
	@Resource MeetPubFileScopeDao pubMeetFileScopeDao;
	
	@Resource MeetYichenFileDao yichenFileDao;
	@Resource MeetPubYichenFileDao pubYichenFileDao;
	
	@Resource MeetProcessDao meetProcessDao;
	
	@Resource MeetGroupMainDao meetGroupMainDao;
	@Resource MeetPubGroupDao meetPubGroupDao;
	
	@Resource MeetMainDao  meetMainDao;
	
	
	//常委会发布议程,把数据从一个表插入或者更新到另外一个表
	@Override
	public void pubMeetYichen(int meetid){
        
		//议程发布
		pubyichenDao.deletePubYichenFileByMeetid(meetid);
		List<MeetYichenMainEntity> list=yichenMainDao.selectAllByMeetid(meetid);
		
		for(int i=0;i<list.size();i++){
			MeetYichenMainEntity entity=(MeetYichenMainEntity)list.get(i);
			
			//对象转换
			MeetPubYichenEntity pubyichen=new MeetPubYichenEntity();
			pubyichen.setYichenid(entity.getYichenid());
			pubyichen.setTitle(entity.getTitle());
			pubyichen.setSort(entity.getSort());
			pubyichen.setPyichenid(entity.getPyichenid());
			pubyichen.setMeetid(entity.getMeetid());
			pubyichen.setIsdel(entity.getIsdel());
			pubyichen.setVersion(null);
			
			//查询是否在pub中存在
		    pubyichenDao.insert(pubyichen);
		}
		    
		   //议程文件发布
		   pubYichenFileDao.deletePubYichenByMeetid(meetid);
		   List<MeetYichenFileEntity> listycfile=yichenFileDao.selectYichenFileBymeetid(meetid);
		    MeetPubYichenFileEntity pubycfile=null;
		    MeetYichenFileEntity ycfile=null;
		    for(int j=0;j<listycfile.size();j++){
		    	ycfile=listycfile.get(j);
		    	
		    	
		    	pubycfile=new MeetPubYichenFileEntity();
		    	pubycfile.setYichenid(ycfile.getYichenid());
		    	pubycfile.setFileid(ycfile.getFileid());
		    	pubycfile.setSort(ycfile.getSort());
		    	pubycfile.setIsdel(ycfile.getIsdel());
		    	pubycfile.setVersion(null);
		    	pubYichenFileDao.insert(pubycfile);
		    	
		    }   
	}
	
//	//常委会发布日程
	@Override
	public void pubMeetRichen(int meetid){

		pubrichenDao.deletePubRichenByMeetid(meetid);
		//获取所有议程
		List<MeetRichenMainEntity> list=richenMainDao.selectAllRichenByMeetid(meetid);
		
		MeetRichenMainEntity entity=null;
		MeetPubRichenEntity pubrichen=null;
		
		for(int i=0;i<list.size();i++){
			entity=(MeetRichenMainEntity)list.get(i);
			
			//对象转换
			pubrichen=new MeetPubRichenEntity();
			pubrichen.setRichenid(entity.getRichenid());
			pubrichen.setName(entity.getName());
			pubrichen.setSort(entity.getSort());
			pubrichen.setPrichenid(entity.getPrichenid());
			pubrichen.setMeetid(entity.getMeetid());
			pubrichen.setIsdel(entity.getIsdel());
			pubrichen.setVersion(0);
			
			//查询是否在pub中存在
		    pubrichenDao.insert(pubrichen);
		}
		    
		    pubrichenYitiDao.deletePubRichenYitiByMeetid(meetid);
		    List<MeetRichenYitiEntity> listyt=richenYitiDao.selectYitiByMeetid(meetid);
		    MeetPubRichenYitiEntity pubyiti=null;
		    MeetRichenYitiEntity yiti=null;
		    for(int j=0;j<listyt.size();j++){
		    	yiti=listyt.get(j);
		    	pubyiti=new MeetPubRichenYitiEntity();
		    	pubyiti.setYitiid(yiti.getYitiid());
		    	pubyiti.setTitle(yiti.getTitle());
		    	pubyiti.setSort(yiti.getSort());
		    	pubyiti.setRichenid(yiti.getRichenid());
		    	pubyiti.setBindyichenid(yiti.getBindyichenid());
		    	pubyiti.setIsdel(yiti.getIsDel());
		    	pubyiti.setVersion(null);
		    	pubyiti.setBindbimu(yiti.getBindbimu());
		    	pubrichenYitiDao.insert(pubyiti);
		    }
		    
		  //更新会议的闭幕会时间
		    MeetRichenMainEntity richen1=richenMainDao.selectBmhDateRichenByMeetid(meetid);
		    if(richen1!=null){		    	
			    MeetRichenMainEntity richen2=richenMainDao.selectBmhTimeRichenByRichenid(richen1.getRichenid());
			    String daterichen=richen1.getName().trim();
			    if(richen2!=null){

			    String timerichen=richen2.getName().trim();
			    
			    String months=daterichen.substring(0,daterichen.indexOf("月"));
			    String days=daterichen.substring(daterichen.indexOf("月")+1,daterichen.indexOf("日"));
			    String hours=timerichen.substring(0,timerichen.indexOf(":"));
			    String minutes=timerichen.substring(timerichen.indexOf(":")+1,timerichen.indexOf(":")+3);
			    System.out.println("月："+months);
			    System.out.println("日："+days);
			    System.out.println("小时："+hours);
			    System.out.println("份："+minutes);
			    int month=0;
			    int day=0;
			    int hour=0;
			    int minute=0;
			    try{
			    	month=Integer.parseInt(months.trim());
			    	day=Integer.parseInt(days.trim());
			    	hour=Integer.parseInt(hours.trim());
			    	minute=Integer.parseInt(minutes.trim());
			    }catch(Exception e){
			    	e.printStackTrace();
			    }
			    
			    Calendar calendar = Calendar.getInstance(); 
	            calendar.set(Calendar.MONTH,month-1);
	            calendar.set(Calendar.DAY_OF_MONTH,day);
	            calendar.set(Calendar.HOUR_OF_DAY,hour);
	            calendar.set(Calendar.MINUTE,minute);
	            calendar.set(Calendar.SECOND,0);
		        Date  bmhtime=calendar.getTime();
		        MeetMainEntity meet=meetMainDao.selectEntityBymeetid(meetid);
		        meet.setBmhdate(bmhtime);
		        
		        meetMainDao.updateByPrimaryKey(meet);
		    }
	       
		    	
		    }
		    
		}
	
//	//常委会发布文件
	@Override
	public void pubMeetFiles(int meetid,String fileown){

		//获取所有文件
		HashMap<String,Object> map=new HashMap<String,Object>();
		map.put("meetid", meetid);
		map.put("fileown", fileown);
		pubMeetFileDao.deletePubFileByMeetid(map);
		
		List<MeetFileMainEntity> list=meetFileMainDao.selectAllFileByMeetidAndFileOwn(map);
		MeetFileMainEntity entity=null;
		MeetPubFileEntity pubfile=null;		
		
		
		for(int i=0;i<list.size();i++){
			entity=(MeetFileMainEntity)list.get(i);
			int fileid=entity.getFileid();
			//listfile=yichenFileDao.selectFilesByYichenid(yichenid);
			
			//对象转换
			pubfile=new MeetPubFileEntity();
			pubfile.setFileid(fileid);
			pubfile.setFilename(entity.getFilename());
			pubfile.setFileown(entity.getFileown());
			pubfile.setFilepath(entity.getFilepath());
			pubfile.setFiletype(entity.getFiletype());
			//System.out.println("filetype is-------------------------------------------------:"+pubfile.getFiletype());
			pubfile.setIsdel(entity.getIsdel());
			pubfile.setMeetid(meetid);
			pubfile.setSort(entity.getSort());
			pubfile.setTitle(entity.getTitle());
			pubfile.setUploadtime(entity.getUploadtime());
			pubfile.setVersion(null);
			pubfile.setMtype(entity.getMtype());
			pubfile.setFileguid(entity.getFileguid());
		    pubMeetFileDao.insert(pubfile);
		}
		    
		    pubMeetFileScopeDao.deletePubFileScopeByMeetid(map);
		    List<MeetFileScopeEntity> listfs=meetFileScopeDao.selectFileScopeByMeetid(map);
		    MeetPubFileScopeEntity pubscope=null;
		    MeetFileScopeEntity scope=null;
		    for(int j=0;j<listfs.size();j++){
		    	scope=listfs.get(j);
		    	pubscope=new MeetPubFileScopeEntity();
		    	pubscope.setFileid(scope.getFileid());
		    	pubscope.setScopeid(scope.getScopeid());
		    	pubscope.setIsdel(scope.getIsdel());
		    	pubscope.setVersion(null);
		    	
		    	pubMeetFileScopeDao.insert(pubscope);
		    }
		    
		    //议程文件发布
			   pubYichenFileDao.deletePubYichenByMeetid(meetid);
			   List<MeetYichenFileEntity> listycfile=yichenFileDao.selectYichenFileBymeetid(meetid);
			    MeetPubYichenFileEntity pubycfile=null;
			    MeetYichenFileEntity ycfile=null;
			    for(int j=0;j<listycfile.size();j++){
			    	ycfile=listycfile.get(j);
			    	
			    	
			    	pubycfile=new MeetPubYichenFileEntity();
			    	pubycfile.setYichenid(ycfile.getYichenid());
			    	pubycfile.setFileid(ycfile.getFileid());
			    	pubycfile.setSort(ycfile.getSort());
			    	pubycfile.setIsdel(ycfile.getIsdel());
			    	pubycfile.setVersion(null);
			    	pubYichenFileDao.insert(pubycfile);
			    	
			    }  
			// 日程议题关联
			    List<MeetRichenYitiEntity> listyt=richenYitiDao.selectYitiByMeetid(meetid);
			    MeetPubRichenYitiEntity pubyiti=null;
			    MeetRichenYitiEntity yiti=null;
			    for(int j=0;j<listyt.size();j++){
			    	yiti=listyt.get(j);
			    	pubyiti=new MeetPubRichenYitiEntity();
			    	pubyiti.setYitiid(yiti.getYitiid());
			    	pubyiti.setTitle(yiti.getTitle());
			    	pubyiti.setSort(yiti.getSort());
			    	pubyiti.setRichenid(yiti.getRichenid());
			    	pubyiti.setBindyichenid(yiti.getBindyichenid());
			    	pubyiti.setIsdel(yiti.getIsDel());
			    	pubyiti.setVersion(null);
			    	pubrichenYitiDao.updateByPrimaryKey(pubyiti);
			    }
			    
    }
	
	
	//更改流程当前状态，从已发布到已发布有变更

	@Override
	public void chgMeetProcState(String submodule,int meetid){
		  //空方法。
		//chgMeetProcState1(submodule,meetid);
	}
	
	/**
	 * 
	 * @param submodule
	 * @param meetid
	 */
	private void chgMeetProcState1(String submodule,int meetid){
		
		
		Map<String,Object> map=new java.util.HashMap<String,Object>();
		map.put("meetid", meetid);
		map.put("submodulecode", "yichen");
		//map.put("submodulecode", submodule);
		map.put("curstate", "4");
		
		MeetProcessEntity entity=meetProcessDao.selectCurProcessByMeetidAndSubmodulecode(map);
		System.out.println("change  process  state is"+((entity==null)?"":entity.getCurstate()));
		//System.out.println("change  process  state is"+entity.getCurstate());
		if(entity!=null&&entity.getCurstate().trim().equals("0")){
			System.out.println("change  process  state is"+entity.getCurstate());
				meetProcessDao.updateCurState(map);
	    }
	}

	
	@Override
	public int getPubYichenMaxVersion(int meetid){
	   //选择其中的版本号
         int version=0;
		  try{
			   version=pubyichenDao.selectMaxVersion(meetid);
		  }catch(Exception e){
			  //e.printStackTrace();
			  version=0;
			  return version+1;
		  }
		   version=version+1;
		   System.out.println("version is:"+version);
		   return version;
	}
	
	
	@Override
	public int selectPubFileCountByMeetid(int meetid,int version){
		
		int count=0;
		try{
			//int version=pubMeetFileDao.selectMaxVersion();
			Map<String,Object> map3=new HashMap<String,Object>();
			map3.put("meetid", meetid);
			//map3.put("version", version);
			count=pubMeetFileDao.selectPubFileCountByMeetidAndVersionAndUserid(map3);
		}catch(Exception e){;
			e.printStackTrace();
			count=0;
		}
		return count;
	}

	@Override
	public void pubMeetGroup(int meetid,String groupno) {
		//获取所有分组信息
		HashMap<String,Object> map=new HashMap<String,Object>();
		map.put("meetid", meetid);
		map.put("groupno", groupno);
		MeetGroupMainEntity entity=meetGroupMainDao.selectGroupByMeetidAndGroupno(map);
		MeetPubGroupEntity pubentity= new MeetPubGroupEntity();
		pubentity.setGroupno(groupno);
		pubentity.setMeetid(meetid);
		pubentity.setPushtime(new Date());
		pubentity.setGroupid(entity.getGroupid());
		pubentity.setFilename(entity.getFilename());
		pubentity.setTitle(entity.getTitle());
		pubentity.setFilepath(entity.getFilepath());
		pubentity.setFileguid(entity.getFileguid());
		int i=meetPubGroupDao.deleteByMeetid(map);
		meetPubGroupDao.insert(pubentity);
		}

		 
}
