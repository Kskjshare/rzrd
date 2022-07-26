package com.cloudrich.ereader.remind.job;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.cloudrich.ereader.dict.service.DictDataService;
import com.cloudrich.ereader.meeting.entity.MeetFileRemindEntity;
import com.cloudrich.ereader.meeting.service.MeetingViewService;
import com.cloudrich.ereader.meetpub.dao.MeetPubFileScopeDao;
import com.cloudrich.ereader.system.entity.SysUserMainEnity;
import com.cloudrich.ereader.util.SpringBeanUtil;
import com.cloudrich.framework.im.ImMessageUtil;
import com.cloudrich.framework.job.JobEntity;
import com.cloudrich.sms.SmsBean;
import com.cloudrich.sms.SmsClient;


public class MeetFileRemindTask {
	
	private DictDataService dictService;
	private MeetPubFileScopeDao pubfilescopeDao;
	private MeetingViewService  meetingViewService;
	
	
	private  final Log log = LogFactory.getLog(NoticeRemindTask.class);

	
	public MeetFileRemindTask(){
	}
	/**
	 * 
	 * @throws Exception
	 */
	public void start(JobEntity remind) throws Exception {
		
		System.out.println("Meeting IM  Task is runing............................................ ...........");
		if(log.isInfoEnabled()){
			log.info("MeetFile IM Task is runing............................................ ...........");
		}
		  
		  this.dictService = (DictDataService)SpringBeanUtil.getObject("DictDataServiceImpl");
		  this.pubfilescopeDao = (MeetPubFileScopeDao)SpringBeanUtil.getObject("meetPubFileScopeDao");
		  this.meetingViewService=(MeetingViewService)SpringBeanUtil.getObject("meetingViewServiceImpl");
		  
		  MeetFileRemindEntity entity=(MeetFileRemindEntity)remind.getMap().get("meetfile");
		  
		  StringBuffer messbuf=null;
		  List<SysUserMainEnity> userlist=null;
				   messbuf=new StringBuffer();
				   String meetingname=meetingViewService.selectEntityById(entity.getMeetid()).getMname();
				   System.out.println("meetingname:"+meetingname);
				   messbuf.append(meetingname);
				   //会议类型
				   //messbuf.append(dictService.getNameByTypeAndcode("mtype", entity.getMtype().trim()));
				   if(entity.getFileown().trim().equals("1")){
					   messbuf.append("");
				   }else if(entity.getFileown().trim().equals("2")){
					   messbuf.append("-会中主任会议");
				   }else if(entity.getFileown().trim().equals("3")){
					   messbuf.append("-闭幕会");
				   }
				   messbuf.append("-会议文件更新");
				   messbuf.append("-请查收.");
				   Map<String,Object> map=new HashMap<String,Object>();
				   map.put("meetid", entity.getMeetid());
				   map.put("version", entity.getVersion());
				   userlist=pubfilescopeDao.selectFileSendScopeUser(map);
				   //System.out.println(userlist);
		  ArrayList<String> mobiles=new ArrayList<String>();
		  //提醒
		  if(userlist!=null&&userlist.size()!=0){
		      for(int i=0;i<userlist.size();i++){
		    	  //System.out.println(userlist.get(i).getPadmobile());
		    	  mobiles.add(userlist.get(i).getPadmobile());
		    	  ImMessageUtil.sendMessage(userlist.get(i).getPadmobile(), messbuf.toString(),"",entity.getMtype(),entity.getFileown(),meetingname,"3", entity.getMeetid());
		      }
		  }
		  
		 //短信提醒
		//汇总短信发送
		  int meetid=entity.getMeetid();
			boolean b=meetingViewService.isMeetingMiddle(meetid);
			if(b){
				//短信发送
				SmsClient proxy=new SmsClient();
				//proxy=new SmsClient();
				SmsBean sms=new SmsBean();
				sms.setSmsContent(messbuf.toString());
				sms.setMobileNoList(mobiles);
				//System.out.println(mobiles.toString());
			    int t=proxy.SendMessage(sms);
			    System.out.println("会议文件更新。。。"+t);
			}
			
		System.out.println("Meet file  Remind is ending .........-------------------------.."+messbuf.toString());
		if(log.isInfoEnabled()){
			log.info("SMS Task is end............................................ ...........");
		}
	}
}
