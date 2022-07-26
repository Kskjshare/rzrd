package com.cloudrich.framework.im;

import org.jivesoftware.smack.AccountManager;
import org.jivesoftware.smack.Chat;
import org.jivesoftware.smack.XMPPConnection;
import org.jivesoftware.smack.XMPPException;

import net.sf.json.JSONObject;

public class ImMessageUtil {
    
	
public static int sendMultiUserMessage(String[] usernames,String message,String type,int noticeid){
		int m=0;
		JSONObject data = new JSONObject();
		data.put("type", type.trim());
		data.put("title", message);
		data.put("content", noticeid);
		//XMPPConnection connection = ConnMgrUtil.getInstance().getAdminConn();
		for(int i=0;i<usernames.length;i++){
			
			boolean b=sendMessage(usernames[i], data.toString());
			m++;	
		}
		
		return m;
	}
	/**
	 * 发送消息
	 * @param username
	 * @param message
	 * @param type
	 * @param noticeid
	 * @return
	 */
	public static boolean sendMessage(String username,String message,String type,int noticeid){
		
		JSONObject data = new JSONObject();
		data.put("type", type.trim());
		data.put("title", message);
		data.put("content", noticeid);
		//XMPPConnection connection = ConnMgrUtil.getInstance().getAdminConn();
		boolean b=sendMessage(username, data.toString());
		
		return b;
	}
	
	/**
	 * 发送消息
	 * @param username
	 * @param message
	 * @param type
	 * @param noticeid
	 * @return
	 */
	public static boolean sendMessage(String username,String message,String filepath,String meetingtype,String fileown,String meetingname,String type,int noticeid){
		
		JSONObject data = new JSONObject();
		data.put("type", type.trim());
		data.put("title", message);
		data.put("content", noticeid);
		data.put("filepath", filepath);
		data.put("meetingtype", meetingtype);
		data.put("fileown", fileown);
		data.put("meetingid", noticeid);
		data.put("meetingname", meetingname);
		//XMPPConnection connection = ConnMgrUtil.getInstance().getAdminConn();
		boolean b=sendMessage(username, data.toString());
		
		return b;
	}
	
	 /**
     * 增加用户
     * @param username
     * @param password
     */
	 public static boolean regiest(String username,String password){
//		 XMPPConnection connection = ConnMgrUtil.getInstance().getAdminConn();
//		 AccountManager amgr = connection.getAccountManager();
//		 try {
//			amgr.createAccount(username,password);
//			connection.disconnect();
//			System.out.println("ok");
//		} catch (XMPPException e) {
//			e.printStackTrace();
//			return false;
//		}
		 return true;
	 }	
	 
	 /**
	  * 删除用户
	  * @param username
	  * @param password
	  * @return
	  */
	 public static boolean deleteUser(String username,String password){
		 XMPPConnection connection = ConnMgrUtil.getInstance().getUserConn(username,password);
		 AccountManager amgr = connection.getAccountManager();
		 try {
			 amgr.deleteAccount();
			 connection.disconnect();
		 } catch (XMPPException e) {
			 e.printStackTrace();
			 return false;
		 }
		 return true;
	 }	 
	 
	 /**
	  * 
	  * @param username
	  * @param message
	  * @return
	  */
	 public static boolean sendMessage(String username,String message){
			try{
			// TODO Auto-generated method stub
			//XMPPConnection.DEBUG_ENABLED=true;
			//XMPPConnection connection = ConnMgrUtil.getInstance().getAdminConn();
			StringBuffer toAddress=new StringBuffer();
			toAddress.append(username);
			toAddress.append("@");
			toAddress.append(ConnMgrUtil.domain);
			
			ConnMgrUtil.getInstance().getPadPushConn();
			Chat chat = ConnMgrUtil.padpushConnection.getChatManager().createChat(toAddress.toString(), null);
			chat.sendMessage(message);
			System.out.println("send message! username is:"+username+"--message is:"+message);
			 
			}catch(Exception e){
				e.printStackTrace();
				return false;
			}
			return true;
		}
	 /**
	  * 
	  * @param args
	  */
	public static void main(String args[]){
		//UserMgrUtil.regiest("zhaojb1", "zhaojb1");
		//UserMgrUtil.deleteUser("zhaojb1", "zhaojb1");
		//UserMgrUtil.sendMessage("13910840411", "zhaojb1");
	} 
	
	
	

}
