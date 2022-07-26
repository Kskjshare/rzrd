package com.cloudrich.ereader.briefing.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cloudrich.ereader.briefing.dao.MeetBriefingMainDao;
import com.cloudrich.ereader.briefing.entity.MeetBriefingMainEntity;
import com.cloudrich.ereader.briefingpub.dao.MeetPubBriefingDao;
import com.cloudrich.ereader.briefingpub.entity.MeetPubBriefingEntity;
import com.cloudrich.ereader.common.dao.PageHelper;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.common.dao.PageHelper.PageCall;
import com.cloudrich.ereader.remind.service.RemindService;
import com.cloudrich.ereader.util.Md5GuidUtil;

@Service("BriefingServiceImpl")
public class BriefingServiceImpl  implements BriefingService{
	
	private static final long serialVersionUID = 1L;

	@Resource MeetBriefingMainDao briefingDaoIn;
	@Resource RemindService remindService;
	@Resource MeetPubBriefingDao meetPubBriefingDao;

	@Override
	public int delete(int briefid){
		int i=briefingDaoIn.deleteByPrimaryKey(briefid);
		meetPubBriefingDao.deleteBybriefid(briefid);
		//处理通知提醒
		  try{
				remindService.BriefRemindHandler("delete", null, briefid);
			}catch(Exception e){
				e.printStackTrace();
			}
		return i;
		
	}

	@Override
	public MeetBriefingMainEntity selectBriefingById(int briefid) {
		return briefingDaoIn.selectByPrimaryKey(briefid);
	}

	@Override
	public List<MeetBriefingMainEntity> selectAllBriefingbyMeetid(int meetid) {
			List<MeetBriefingMainEntity> list = briefingDaoIn.selectAllByMeetid(meetid);
			return list;
		
	}
	
	
	//根据推送范围获取简报
	@Override
	public List<MeetBriefingMainEntity> selectAllBriefingbyMeetidAndUserid(int meetid,int userid) {
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("meetid", meetid);
		map.put("userid", userid);
			List<MeetBriefingMainEntity> list = briefingDaoIn.selectAllByMeetidAndUserid(map);
			return list;
		
	}
	//根据推送范围获取简报
	@Override
	public List<MeetPubBriefingEntity> selectAllPubBriefingbyMeetidAndUserid(int meetid,int userid) {
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("meetid", meetid);
		map.put("userid", userid);
			List<MeetPubBriefingEntity> list = meetPubBriefingDao.selectAllByMeetidAndUserid(map);
			return list;
		
	}    
	
	@Override
	 public int insert(MeetBriefingMainEntity briefing){
		 int i=briefingDaoIn.insert(briefing);		
		  return i; 
	 }
	
	@Override
	 public int insertPush(MeetBriefingMainEntity briefing, String actiontype){
		 meetPubBriefingDao.deleteBybriefid(briefing.getBriefid());		
		 MeetPubBriefingEntity pubentity=new MeetPubBriefingEntity();
			 pubentity.setBriefname(briefing.getBriefname());
			 pubentity.setFilename(briefing.getFilename());
			 pubentity.setFilepath(briefing.getFilepath());
			 pubentity.setMeetid(briefing.getMeetid());
			 pubentity.setPubtime(new Date());
			 pubentity.setScopename(briefing.getScopename());
			 pubentity.setSendtime(briefing.getSendtime());
			 pubentity.setSendtype(briefing.getSendtype());
			 pubentity.setBriefid(briefing.getBriefid());
			 pubentity.setFileguid(briefing.getFileguid());
		 int i=meetPubBriefingDao.insert(pubentity);
		
		//处理通知提醒
		  try{
			  	System.out.println("=====service简报发送=====");
				remindService.BriefRemindHandler(actiontype,briefing,0);
			}catch(Exception e){
				e.printStackTrace();
			}
		  return i; 
	 }
	 
	@Override
	 public int update(MeetBriefingMainEntity briefing){
		 int i=briefingDaoIn.updateByPrimaryKey(briefing);
		 return i;
	 }
    
	@Override
	 public List<MeetBriefingMainEntity> searchBriefByKeyword(String keyword,int userid){
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("userid", userid);
		map.put("briefname", keyword);
		 
	    return meetPubBriefingDao.searchBriefByKeyword(map);
	 }
	
	
	@Override
	public Page selectBriefingbyMeetid(final int meetid,int pageNo, int pageSize){
		return PageHelper.pagedQuery(new PageCall() {
			@Override
			public void executeQuery() {
				briefingDaoIn.selectAllByMeetid(meetid);
			}
		}, pageNo,pageSize);
	}

	@Override
	public MeetPubBriefingEntity selectLastPubBrief(int briefid) {	
		return meetPubBriefingDao.selectByBriefid(briefid);
	}

	
}
