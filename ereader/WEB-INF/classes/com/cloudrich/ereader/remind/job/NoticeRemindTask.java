package com.cloudrich.ereader.remind.job;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jivesoftware.smack.XMPPConnection;

import com.cloudrich.ereader.notice.entity.NoticeMainEntity;
import com.cloudrich.ereader.notice.service.NoticeSendscopeService;
import com.cloudrich.ereader.notice.service.NoticeService;
import com.cloudrich.ereader.system.entity.SysUserMainEnity;
import com.cloudrich.ereader.util.SpringBeanUtil;
import com.cloudrich.framework.im.ConnMgrUtil;
import com.cloudrich.framework.im.ImMessageUtil;
import com.cloudrich.framework.job.JobEntity;
import com.cloudrich.sms.SmsBean;
import com.cloudrich.sms.SmsClient;

public class NoticeRemindTask {
	
	
	private NoticeService noticeService;
	private NoticeSendscopeService noticeScopeService;
	private  final Log log = LogFactory.getLog(NoticeRemindTask.class);

	
	public NoticeRemindTask(){
	}
	/**
	 * 
	 * @throws Exception
	 */
	public void start(JobEntity remind) throws Exception {
		
		this.noticeScopeService = (NoticeSendscopeService)SpringBeanUtil.getObject("NoticeSendscopeServiceImpl");
		
		System.out.print("Notice   Task is runing............................................ ...........");
		NoticeMainEntity entity=(NoticeMainEntity)remind.getMap().get("notice");
		String messager=entity.getTitle();
		String filepath=entity.getPath();
		int noticeid=entity.getNoticeid();
		System.out.println("noticeid is:"+noticeid);
		List<SysUserMainEnity> list=noticeScopeService.selectScopeUserByNoticeId(noticeid);
		String sendtype=remind.getSendtype();
		System.out.println("scope user is:"+list.size());
		
		ArrayList<String> mobiles=new ArrayList<String>();
		
		if(list!=null&&list.size()!=0){
			for(int i=0;i<list.size();i++){
				String mobile=list.get(i).getPadmobile();
				mobiles.add(mobile);
				System.out.println("scope user mobile is:"+mobile);
				if(sendtype!=null&&sendtype.trim().length()!=0){
					//Pad端提醒
					if(sendtype.trim().indexOf("0")>=0){
						ImMessageUtil.sendMessage(mobile, messager,filepath,"","","","1", noticeid);
						System.out.print("Notice  Pad Task is runing.");
					}
					if(sendtype.trim().indexOf("1")>=0){
						//短信发送
						//PushService.pushTags(messager, tag);
						//todo
						System.out.print("Notice  SMS Task is runing.");
					}
				}else{
					//PushService.pushTags(messager, tag);
					ImMessageUtil.sendMessage(mobile, messager, "1", noticeid);
				}
				
			}
			
			//短信通知
			//汇总短信发送
				//短信发送
				SmsClient proxy=new SmsClient();
				//proxy=new SmsClient();
				SmsBean sms=new SmsBean();
				sms.setSmsContent(messager);
				sms.setMobileNoList(mobiles);
			    int t=proxy.SendMessage(sms);
			    System.out.println("通知短信。。。"+t);
		}
		System.out.print("Notice  Task is ending ..........。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。.");
	}
}
