package com.cloudrich.framework.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.commons.lang3.StringUtils;

import cn.jpush.api.JPushClient;
import cn.jpush.api.common.APIConnectionException;
import cn.jpush.api.common.APIRequestException;
import cn.jpush.api.push.PushResult;
import cn.jpush.api.push.model.Platform;
import cn.jpush.api.push.model.PushPayload;
import cn.jpush.api.push.model.audience.Audience;
import cn.jpush.api.push.model.audience.AudienceTarget;
import cn.jpush.api.push.model.notification.Notification;


public class PushService {
	
	
	static List<JPushClient> jpushClients = new ArrayList<JPushClient>();
	//地震观测员
	private static final String appKey1 ="ab19be7bbb942b75d83cb174";
	private static final String masterSecret1 = "2b7e1f6eac9176b34f9a246b";
	//地震领导
	private static final String appKey2 ="0ac307a80410996d9e0176dc";
	private static final String masterSecret2 = "fcbc72c53b3e844e938f8c62";
	//外勤通
	private static final String appKey3 ="197019d787a632d1af194e1a";
	private static final String masterSecret3 = "fcbc72c53b3e844e938f8c62";
	
	//物价局
	private static final String appKey4 ="a513e5a01ea90d0a443ec5fa";
	private static final String masterSecret4 = "34a874431c6629ac61aa6071";
	//保亭公益林巡检
	//物价局
	private static final String appKey5 ="9eac2aad36d0156daf163045";
	private static final String masterSecret5 = "bb368eb46550e4c646774eb8";
	//会议助理
	private static final String appKey6 ="c15762bbc846b18d24446702";
	private static final String masterSecret6 = "a68456e51efc194e4ed958db";
	static {
		Map<String,String> key1 = new HashMap<String, String>();
		Map<String,String> key6 = new HashMap<String, String>();
		key6.put("appkey",appKey6);
		key6.put("masterSecret",masterSecret6);
		
		List<Map<String,String>> keys = new ArrayList<Map<String,String>>();
//		keys.add(key1);
//		keys.add(key2);
//		keys.add(key3);
//		keys.add(key4);
//		keys.add(key5);
		keys.add(key6);
		for(int i = 0 ; i < keys.size() ; i ++){
			jpushClients.add(new JPushClient(keys.get(i).get("masterSecret"),keys.get(i).get("appkey")));
		}
	}
	public static void main(String[] args) {
		System.out.println(getJsonStr());
//		System.out.println("国庆_true".substring(0, "国庆_true".lastIndexOf("_true")));
//		pushAlias("123","123", "5");
//		pushActionMessage1("通知推送", "5");
//		pushTags("2fcac858-9d9c-45d2-80ef-04e7916727f8.doc","5");
//		String str=StringUtils.leftPad("2", 2, "0");
//		System.out.println("str:"+str);
//		pushAlias("123","234","1");
//		PushService.pushActionMessage(PushService.GETLOCATION,"53");
		//PushService.pushTags1("您有异常反馈，请注意查看",  "52");	
 	}
	public static String getJsonStr(){
		JSONObject json=new JSONObject();
		json.put("title", "通知标题");
		json.put("content", "通知内容");
		json.put("type", "1");
		return json.toString();
	}
	public static String pushTag6(String msg){
		JPushClient jpush = new JPushClient(masterSecret6, appKey6,86400);
		PushPayload pushload = PushPayload.newBuilder()  
        .setPlatform(Platform.all())//设置接受的平台  
        .setAudience(Audience.all())//Audience设置为all，说明采用广播方式推送，所有用户都可以接收到  
        .setNotification(Notification.alert(msg))  
        .build();
    	System.out.println(pushload.toJSON().toString());
    	PushResult str = null;
    	try {
    		str=jpush.sendPush(pushload);
		} catch (APIConnectionException e) {
			e.printStackTrace();
		} catch (APIRequestException e) {
			e.printStackTrace();
		}
		return str.toString();
	}
	public static void pushAlias(String title ,String msg,String alias){
		try {
			for(JPushClient jpushClient : jpushClients){
				jpushClient.sendAndroidNotificationWithAlias(title, msg, null, alias);
			}
		} catch (APIConnectionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (APIRequestException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static void pushAll(String msg) {
        for(JPushClient jpushClient : jpushClients){
        	PushPayload payload = buildPushObject_all_all_alert(msg);
            
            try {
                PushResult result = jpushClient.sendPush(payload);
                
            } catch (APIConnectionException e) {
            	e.printStackTrace();
                
            } catch (APIRequestException e) {
            	e.printStackTrace();
            }
        }
        
	}
	
	public static PushPayload buildPushObject_all_all_alert(String msg) {
	    return PushPayload.alertAll(msg);
	}
	
	
	
    public static void pushTags(String messager ,String tag){
    	for(JPushClient jpushClient : jpushClients){
    	PushPayload pushload = PushPayload.newBuilder().setPlatform(Platform.android())
    	.setAudience(new Audience.Builder().addAudienceTarget(AudienceTarget.tag(tag)).build())
    	.setNotification(new Notification.Builder().setAlert(messager).build()).build();
    	System.out.println(pushload.toJSON().toString());
    	try {
			jpushClient.sendPush(pushload);
			System.out.println(messager+"------------------------------------------------------------------------");
		} catch (APIConnectionException e) {
			e.printStackTrace();
		} catch (APIRequestException e) {
			e.printStackTrace();
		}
    	}
    }
    
    public static String pushTagsMess(String messager ,String tag){
    	for(JPushClient jpushClient : jpushClients){
    	PushPayload pushload = PushPayload.newBuilder().setPlatform(Platform.android())
    	.setAudience(new Audience.Builder().addAudienceTarget(AudienceTarget.tag(tag)).build())
    	.setNotification(new Notification.Builder().setAlert(messager).build()).build();
    	System.out.println(pushload.toJSON());
    	try {
			jpushClient.sendPush(pushload);
			return "1";
			
		} catch (APIConnectionException e) {
			e.printStackTrace();
			return "2";
		} catch (APIRequestException e) {
			e.printStackTrace();
			return "2";
		}
    	}
		return "";
    }
    
    public static void pushActionMessage(String msg,String alias) {
    	for(JPushClient jpushClient : jpushClients){              
	        try {
	        	PushResult result = jpushClient.sendAndroidMessageWithAlias("", msg, alias);
	        	System.out.println( result.toString());
	        	   System.out.println( result.isResultOK());
	        } catch (APIConnectionException e) {
	            e.printStackTrace();
	        } catch (APIRequestException e) {
	        	e.printStackTrace();
	        }
    	}
	}
    public static void pushActionMessage1(String msg,String alias) {
    	for(JPushClient jpushClient : jpushClients){              
        try {
        	PushResult result = jpushClient.sendAndroidMessageWithAlias("111111111111111", msg, alias);
        	   System.out.println( result.isResultOK());
        
        } catch (APIConnectionException e) {
            e.printStackTrace();
        } catch (APIRequestException e) {
        	e.printStackTrace();
        }
    	}
	}
    
   
    public static final String GETLOCATION  = "{action:'getgps'}";
    public static final String GETLOCATION2  = "{action:'ycjc'}";
}
