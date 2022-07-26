package com.cloudrich.ereader.remind.service;

import com.cloudrich.ereader.briefing.entity.MeetBriefingMainEntity;
import com.cloudrich.ereader.briefingpub.entity.MeetPubBriefingEntity;
import com.cloudrich.ereader.meeting.entity.MeetFileRemindEntity;
import com.cloudrich.ereader.notice.entity.NoticeMainEntity;
import com.cloudrich.ereader.notice.entity.NoticePubEntity;
import com.cloudrich.ereader.smsmanager.entity.SmsdefineMainEntity;

public interface RemindService {
	
	//推送通知的提醒消息	
	public void NoticeRemindHandler(String actiontype,NoticeMainEntity entity,int noticeid) throws Exception ;
	
	//推送简报的提醒消息
	public void BriefRemindHandler(String actiontype,MeetBriefingMainEntity entity,int briefid) throws Exception;
	
	//推送短信提醒消息
	 public void SmsManagerRemindHandler(String actiontype,SmsdefineMainEntity entity,int smsid) throws Exception;
   
	//推送会议文件的提醒消息
	 public void MeetFileRemindHandler(String actiontype,MeetFileRemindEntity entity,int meetid) throws Exception;
			
	
	 public void PadUserIsDestroyRemindHandler(int userid,String padmobile,String type) throws Exception;

}
