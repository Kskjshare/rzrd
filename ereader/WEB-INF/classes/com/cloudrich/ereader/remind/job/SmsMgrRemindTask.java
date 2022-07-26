
package com.cloudrich.ereader.remind.job;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.cloudrich.ereader.smsmanager.entity.SmsdefineLogDetailEntity;
import com.cloudrich.ereader.smsmanager.entity.SmsdefineLogEntity;
import com.cloudrich.ereader.smsmanager.entity.SmsdefineMainEntity;
import com.cloudrich.ereader.smsmanager.service.SmsdefineLogDetailService;
import com.cloudrich.ereader.smsmanager.service.SmsdefineLogService;
import com.cloudrich.ereader.smsmanager.service.SmsdefineMainService;
import com.cloudrich.ereader.system.entity.SysUserMainEnity;
import com.cloudrich.ereader.util.SpringBeanUtil;
import com.cloudrich.framework.job.JobEntity;
import com.cloudrich.sms.SmsBean;
import com.cloudrich.sms.SmsClient;


public class SmsMgrRemindTask {
	
	private SmsdefineLogService smslogService;
	private SmsdefineLogDetailService logDetailService;
	private SmsdefineMainService smsdefineService;
	
	
	private  final Log log = LogFactory.getLog(NoticeRemindTask.class);

	
	public SmsMgrRemindTask(){
	}
	
	/**
	 * 
	 * @throws Exception
	 */
	public void start(JobEntity remind) throws Exception {
		System.out.println("7.SMS Task is runing");
		System.out.print("SMS Task is runing............................................ ...........");
		if(log.isInfoEnabled()){
			log.info("Notice SMS Task is runing............................................ ...........");
		}
		  //SpringBeanUtil.ListBeans();
		  this.smslogService = (SmsdefineLogService)SpringBeanUtil.getObject("smsdefineLogServiceImpl");
		  this.smsdefineService = (SmsdefineMainService)SpringBeanUtil.getObject("smsdefineMainServiceImpl");
		  this.logDetailService = (SmsdefineLogDetailService)SpringBeanUtil.getObject("smsdefineLogDetailServiceImpl");
		  
		  
		SmsdefineMainEntity entity=(SmsdefineMainEntity)remind.getMap().get("smsmgr");
		
		SmsdefineLogEntity logentity=new SmsdefineLogEntity();
		logentity.setSmsid(entity.getSmsid());
		logentity.setSmscontent(entity.getContent());
	
		logentity.setSendtype("1");
		smslogService.insertSmsdefineLog(logentity);
		int logid=logentity.getLogid();
		
		SmsdefineLogDetailEntity detailEntity=null;
		
		String messager=entity.getContent();
		int smsid=entity.getSmsid();
		System.out.println("id is:"+smsid);
		List<SysUserMainEnity> list=smsdefineService.selectScopeUserBySmsid(smsid);
		
		ArrayList<String> mobiles=null;
		SmsClient proxy=new SmsClient();
		try{
			Thread.sleep(500);
		}catch(Exception e){
			e.printStackTrace();
		}
		 
		 	int t=1;
		if(list!=null&&list.size()!=0){
			for(int i=0;i<list.size();i++){
				 
				String phone=list.get(i).getPadmobile();
				System.out.println("------:"+phone);
				boolean b=true;
				String issucess="0";
				//原短信发送，字符数量有限
				/*if(phone!=null&&phone.trim().length()!=0){
					//短信发送
					proxy=new SmsClient();
					SmsBean sms=new SmsBean();
					sms.setSmsContent(entity.getContent());
					mobiles=new ArrayList<String>();
					mobiles.add(phone);
					sms.setMobileNoList(mobiles);
				     t=proxy.SendMessage(sms);
				}*/
				//自动判断短信长度进行劈分，但无法保证句子内容的完整性
				if(phone!=null&&phone.trim().length()!=0){
					//短信发送
					proxy=new SmsClient();
					SmsBean sms=new SmsBean();
					mobiles=new ArrayList<String>();
					mobiles.add(phone);
					String tempContent = entity.getContent();
					int conLeng = entity.getContent().length();
					System.out.println("conLeng============================="+conLeng);
					if(conLeng>70){
						int msgNum=(int) Math.ceil(conLeng/70);
						for(int j=0;j<msgNum;j++){
							if(j==msgNum-1){
								System.out.println("最后一段");
								System.out.println(tempContent.substring(j*70));
								sms.setSmsContent(tempContent.substring(j*70));
							}else{
								System.out.println("分段发送短信，段数："+j);
								System.out.println(tempContent.substring(j*70, (j+1)*70-1));
								sms.setSmsContent(tempContent.substring(j*70, (j+1)*70-1));
							}
							sms.setMobileNoList(mobiles);
						     t=proxy.SendMessage(sms);
						}
					}else{
						System.out.println("发送单条短信");
						sms.setSmsContent(entity.getContent());		
						sms.setMobileNoList(mobiles);
					     t=proxy.SendMessage(sms);
					     System.err.println("t********************************"+t);
					}
				}
				
				detailEntity=new SmsdefineLogDetailEntity();
				detailEntity.setLogid(logid);
				System.err.println(detailEntity.getLogid());
				detailEntity.setTongxluserid(list.get(i).getId());
				detailEntity.setName(list.get(i).getTruename());
				detailEntity.setPhonenum(phone);
				System.err.println(detailEntity.getPhonenum());
				if(t==1){
					detailEntity.setIssucess("0");
				}else{
					detailEntity.setIssucess("1");
				}
				logDetailService.insertSmsdefineLogDetail(detailEntity);
				
			}
		}
		
		String phonenums=entity.getPhonenums();
		if(phonenums!=null&&phonenums.trim().length()!=0){
			String[] phones=phonenums.split(",");
			for(int i=0;i<phones.length;i++){
				String phone=phones[i];
				proxy=new SmsClient();
				 SmsBean sms=new SmsBean();
				 sms.setSmsContent(entity.getContent());
				mobiles=new ArrayList<String>();
				mobiles.add(phone);
				sms.setMobileNoList(mobiles);
			     t=proxy.SendMessage(sms);
			    
			     
				detailEntity=new SmsdefineLogDetailEntity();
				detailEntity.setLogid(logid);
				detailEntity.setPhonenum(phone);
				if(t==1){
					detailEntity.setIssucess("0");
				}else{
					detailEntity.setIssucess("1");
				}
				//detailEntity.setTongxluserid(tongxluserid);
			
				logDetailService.insertSmsdefineLogDetail(detailEntity);
				//短信发送
			}
			
			  
			 	
		}
		
		//发送短信
		
		System.out.print("SMS Remind is ending .........-------------------------..");
		if(log.isInfoEnabled()){
			log.info("SMS Task is end............................................ ...........");
		}
	}
}
