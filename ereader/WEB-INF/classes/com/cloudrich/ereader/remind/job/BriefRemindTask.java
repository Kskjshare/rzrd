package com.cloudrich.ereader.remind.job;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.cloudrich.ereader.briefing.entity.MeetBriefingMainEntity;
import com.cloudrich.ereader.briefing.service.BriefingSendscopeService;
import com.cloudrich.ereader.meeting.entity.MeetMainEntity;
import com.cloudrich.ereader.meeting.service.MeetingViewService;
import com.cloudrich.ereader.system.entity.SysUserMainEnity;
import com.cloudrich.ereader.util.SpringBeanUtil;
import com.cloudrich.framework.im.ImMessageUtil;
import com.cloudrich.framework.job.JobEntity;
import com.cloudrich.sms.SmsBean;
import com.cloudrich.sms.SmsClient;

public class BriefRemindTask {
	


	private BriefingSendscopeService briefscopeService;
	private MeetingViewService meetingViewService;
	//private MeetingViewService   meetingViewService;
	private  final Log logger = LogFactory.getLog(NoticeRemindTask.class);
	

	
	public BriefRemindTask(){
	}
	/**
	 * 
	 * @throws Exception
	 */
	public void start(JobEntity remind) throws Exception {
		System.out.println("发送短信给用户或者推送到 PAD");
		
		this.briefscopeService = (BriefingSendscopeService)SpringBeanUtil.getObject("BriefingSendscopeServiceImpl");
		//this.meetingViewService =(MeetingViewService)SpringBeanUtil.getObject("MeetingViewServiceImpl");
			
		System.out.println("Brief Task is runing............................................ ...........");
		MeetBriefingMainEntity entity=(MeetBriefingMainEntity)remind.getMap().get("brief");
		String messager=entity.getFilename();
		int briefid=entity.getBriefid();
		System.out.println("noticeid is:"+briefid);
		List<SysUserMainEnity> list=briefscopeService.selectScopeUserByBriefId(briefid);
		//int meetid=entity.getMeetid();
		//boolean b=meetingViewService.isMeetingMiddle(meetid);
	
				//nService.selectScopeUserByNoticeId(noticeid);
		String sendtype=remind.getSendtype();
		ArrayList<String> mobiles=new ArrayList<String>();
		if(list!=null&&list.size()!=0){
			System.out.println("++++++");
			for(int i=0;i<list.size();i++){
				String mobile=list.get(i).getPadmobile();
				mobiles.add(mobile);
				if(sendtype!=null&&sendtype.trim().length()!=0){
					//Pad端提醒
					if(sendtype.trim().indexOf("0")>=0){
						ImMessageUtil.sendMessage(mobile, messager,entity.getFilepath(),"","","","2", briefid);
					}
					
				}else{
					ImMessageUtil.sendMessage(mobile, messager, "2", briefid);
				}
			}
			
			//汇总短信发送
			//if(b){
				//短信发送
				SmsClient proxy=new SmsClient();
				//proxy=new SmsClient();
				SmsBean sms=new SmsBean();
				sms.setSmsContent("《"+messager+"》已发布，请查收。");
				sms.setMobileNoList(mobiles);
			    int t=proxy.SendMessage(sms);
			    System.out.println("简报短信。。。"+t);
			//}
		}
		System.out.print("Brief Task is runing ...........");
	}
}
