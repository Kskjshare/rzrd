package com.cloudrich.ereader.remind.service;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.cloudrich.ereader.briefing.entity.MeetBriefingMainEntity;
import com.cloudrich.ereader.briefingpub.entity.MeetPubBriefingEntity;
import com.cloudrich.ereader.meeting.entity.MeetFileRemindEntity;
import com.cloudrich.ereader.notice.entity.NoticeMainEntity;
import com.cloudrich.ereader.notice.entity.NoticePubEntity;
import com.cloudrich.ereader.remind.job.BriefRemindJob;
import com.cloudrich.ereader.remind.job.MeetFileRemindJob;
import com.cloudrich.ereader.remind.job.NormalRemindJob;
import com.cloudrich.ereader.remind.job.NoticeRemindJob;
import com.cloudrich.ereader.remind.job.SmsMgrRemindJob;
import com.cloudrich.ereader.smsmanager.entity.SmsdefineMainEntity;
import com.cloudrich.ereader.util.RemindTimeUtil;
import com.cloudrich.framework.job.JobEngine;
import com.cloudrich.framework.job.JobEntity;

@Service
public class RemindServiceImpl implements RemindService {
	
	
	
	private static Logger logger = Logger.getLogger("RemindServiceImpl");
	
	@Resource
	private JobEngine remindEngine;
	
	@Override
	public void NoticeRemindHandler(String actiontype,NoticeMainEntity entity,int noticeid) throws Exception {
		
		String cronStr=null;
		//立即提醒
		if(entity!=null&&entity.getSendtype().trim().equals("1")){
			cronStr=RemindTimeUtil.getLjRemindTime();
			//定期提醒
		}else if(entity!=null&&entity.getSendtype().trim().equals("2")){
			Date sendtime=entity.getSendtime();
			cronStr=RemindTimeUtil.getGdRemindTime(sendtime);	
		}
		
		if(cronStr!=null&&cronStr.trim().length()!=0){
			//产生提醒任务
			if(logger.isDebugEnabled()){
				logger.debug("产生通知的提醒任务:"+entity.getFilename()+"  "+cronStr);
			}
			System.out.println("-----:产生通知的提醒任务:"+entity.getFilename()+"  "+cronStr);
			JobEntity jobentity=new JobEntity();
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("notice", entity);
			jobentity.setId(entity.getNoticeid());
			jobentity.setMap(map);
			jobentity.setCronexpression(cronStr);
			jobentity.setJobtype("notice");
			jobentity.setJobtype2("1");
			//0代表Pad端，1代表手机发送
			jobentity.setSendtype("01");
			NoticeRemindJob noticejob=new NoticeRemindJob();
			if(actiontype!=null&&actiontype.trim().length()!=0){
				if(actiontype.trim().equals("insert")){
					remindEngine.startJob(jobentity,noticejob);
				}else if(actiontype.trim().equals("update")){
					remindEngine.updateJob(jobentity,noticejob);
				}
			}
			
		}else{
			//删除job
			if(actiontype.trim().equals("delete")){
				remindEngine.stopJob(noticeid,"notice","1");
			}
		}
	}
	
	//简报发送管理
	@Override
	public void BriefRemindHandler(String actiontype,MeetBriefingMainEntity entity,int briefid) throws Exception {
		System.out.println("RemindService处理简报信息");
		String cronStr=null;
		//立即提醒
		if(entity!=null&&entity.getSendtype().trim().equals("1")){
			cronStr=RemindTimeUtil.getLjRemindTime();
			//定期提醒
		}else if(entity!=null&&entity.getSendtype().trim().equals("2")){
			Date sendtime=entity.getSendtime();
			cronStr=RemindTimeUtil.getGdRemindTime(sendtime);	
		}
		
		if(cronStr!=null&&cronStr.trim().length()!=0){
			//产生提醒任务
			if(logger.isDebugEnabled()){
				logger.debug("产生通知的提醒任务:"+entity.getFilename()+"  "+cronStr);
			}
			JobEntity jobentity=new JobEntity();
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("brief", entity);
			jobentity.setId(entity.getBriefid());
			jobentity.setMap(map);
			jobentity.setCronexpression(cronStr);
			jobentity.setJobtype("brief");
			jobentity.setJobtype2("1");
			//pad端提醒
			jobentity.setSendtype("0");
			BriefRemindJob briefjob=new BriefRemindJob();
			
			if(actiontype!=null&&actiontype.trim().length()!=0){
				if(actiontype.trim().equals("insert")){
					remindEngine.startJob(jobentity,briefjob);
					System.out.println("开始Job");
				}else if(actiontype.trim().equals("update")){
					remindEngine.updateJob(jobentity,briefjob);
				}
			}
		}else{
			//删除job
			if(actiontype.trim().equals("delete")){
				remindEngine.stopJob(briefid,"brief","1");
			}
		}
	}
	
	//短信管理
	@Override
	   public void SmsManagerRemindHandler(String actiontype,SmsdefineMainEntity entity,int smsid) throws Exception{
		System.out.println("3.===RemindService发送至手机===");   
		String cronStr=null;
			//立即提醒
			if(entity!=null&&entity.getSendway().trim().equals("1")){
				cronStr=RemindTimeUtil.getLjRemindTime();
				//定期提醒
			}else if(entity!=null&&entity.getSendway().trim().equals("2")){
				Date sendtime=entity.getSendtime();
				cronStr=RemindTimeUtil.getGdRemindTime(sendtime);	
			}
			
			if(cronStr!=null&&cronStr.trim().length()!=0){
				//产生提醒任务
				
				JobEntity jobentity=new JobEntity();
				Map<String,Object> map=new HashMap<String,Object>();
				map.put("smsmgr", entity);
				System.out.println("entity.getSmsid()-----------"+entity.getSmsid());
				jobentity.setId(entity.getSmsid());
				jobentity.setMap(map);
				jobentity.setCronexpression(cronStr);
				jobentity.setJobtype("smsmgr");
				jobentity.setJobtype2("1");
				//pad端提醒
				jobentity.setSendtype("0");
				SmsMgrRemindJob briefjob=new SmsMgrRemindJob();
				
				if(actiontype!=null&&actiontype.trim().length()!=0){
					if(actiontype.trim().equals("insert")){
						remindEngine.startJob(jobentity,briefjob);
						System.out.println("Job已开始");
					}else if(actiontype.trim().equals("update")){
						remindEngine.updateJob(jobentity,briefjob);
					}
				}
			}else{
				//删除job
				if(actiontype.trim().equals("delete")){
					remindEngine.stopJob(smsid,"smsmgr","1");
				}
			}
	   }
	  //会议文件发送管理
	 @Override
	 public void MeetFileRemindHandler(String actiontype,MeetFileRemindEntity entity,int meetid) throws Exception{
		   String cronStr=null;
			  cronStr=RemindTimeUtil.getLjRemindTime();
		 
			  System.out.println("cronStr-----------------"+cronStr);
			if(cronStr!=null&&cronStr.trim().length()!=0){
				//产生提醒任务
				
				JobEntity jobentity=new JobEntity();
				Map<String,Object> map=new HashMap<String,Object>();
				map.put("meetfile", entity);
				jobentity.setId(entity.getMeetid());
				jobentity.setMap(map);
				jobentity.setCronexpression(cronStr);
				jobentity.setJobtype("meetfile");
				jobentity.setJobtype2(entity.getFileown().trim());
				//pad端提醒
				jobentity.setSendtype("0");
				MeetFileRemindJob meetjob=new MeetFileRemindJob();
				
				if(actiontype!=null&&actiontype.trim().length()!=0){
					if(actiontype.trim().equals("insert")){
						remindEngine.startJob(jobentity,meetjob);
					}
				}
			}
			
	   }
	   
	 
	 @Override
	 public void PadUserIsDestroyRemindHandler(int userid,String padmobile,String type) throws Exception{
		   
		 String cronStr=null;
			  cronStr=RemindTimeUtil.getLjRemindTime();
		 
			  System.out.println("cronStr-----------------"+cronStr);
			if(cronStr!=null&&cronStr.trim().length()!=0){
				//产生提醒任务
				
				JobEntity jobentity=new JobEntity();
				Map<String,Object> map=new HashMap<String,Object>();
				map.put("content", padmobile);
				map.put("id", userid);
				map.put("type", type);
				
				jobentity.setId(userid);
				jobentity.setMap(map);
				jobentity.setCronexpression(cronStr);
				jobentity.setJobtype("user");
				jobentity.setJobtype2("destroy");
				//pad端提醒
				jobentity.setSendtype("0");
				
				NormalRemindJob normaljob=new NormalRemindJob();
				remindEngine.startJob(jobentity,normaljob);
				
			}
			
	   }

}
