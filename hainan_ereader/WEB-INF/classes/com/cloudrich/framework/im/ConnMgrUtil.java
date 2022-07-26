package com.cloudrich.framework.im;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.jivesoftware.smack.ConnectionConfiguration;
import org.jivesoftware.smack.XMPPConnection;
import org.jivesoftware.smack.XMPPException;
import org.jivesoftware.smack.packet.Message;
import org.jivesoftware.smackx.OfflineMessageManager;

public class ConnMgrUtil {
	private static ThreadLocal<XMPPConnection>  
	  connectionHolders = new ThreadLocal<XMPPConnection>();
	
	private final static String filename="im.properties";
	public final static String ip="112.35.52.91";
	public final static String domain="skyfrontchat";
	public final static int port=5222;
	public final static String username="padpush";
	public final static String password="1";
	ConnectionConfiguration connectionConfig;
	
	public static XMPPConnection  padpushConnection=null;
	//public static String password="admin_rd_openfire";
	
	public static ConnMgrUtil getInstance(){
//		Properties p = new Properties();     
//		  try{
//		      //读取属性文件a.properties
//			  String filepath=ConnMgrUtil.class.getResource("/").getPath()+filename;
//			  System.out.println("filepath ="+filepath);
//					 // ResourceRender.class.getResource("/").getPath(
//		      InputStream in = new BufferedInputStream (new FileInputStream(filepath));
//		      p.load(in);     ///加载属性列表
//		      if(p.containsKey("ip")){  
//		             ip = p.getProperty("ip").trim();  
//		         }  
//		         if(p.containsKey("domain")){  
//		        	 domain = p.getProperty("domain").trim();  
//		         }  
//		         if(p.containsKey("port")){  
//		        	 String str=p.getProperty("port").trim();
//		        	 if(str!=null&&str.trim().length()!=0){
//		        		 port = Integer.parseInt(str);
//		        	 }
//		         }  
//		         if(p.containsKey("username")){  
//		        	 username = p.getProperty("username").trim();  
//		         }  
//		         if(p.containsKey("password")){  
//		        	 password = p.getProperty("password").trim();  
//		         } 
//		      in.close();
//		            System.out.println("ip ="+ip);
//		            System.out.println("port ="+port);
//		            System.out.println("username ="+username);
//		            System.out.println("password ="+password);
//		            System.out.println("domain ="+domain);
//		            
//		     }
//		    catch(Exception e){
//		             e.printStackTrace();
//		             return null;
//		     }
		  return new ConnMgrUtil();
	}
	
	/**
	 * 
	 * @param userName
	 * @param passWord
	 * @return
	 */
	public  XMPPConnection getUserConn(String userName, String passWord) {
		 final ConnectionConfiguration connectionConfig = new ConnectionConfiguration(
			        ip, port,domain);
			    // 鍏佽鑷姩杩炴帴
			    connectionConfig.setReconnectionAllowed(true);
			    connectionConfig.setSASLAuthenticationEnabled(false);
//			    connectionConfig.setSendPresence(false);//涓嶈鍛婅瘔鏈嶅姟鍣ㄨ嚜宸辩殑鐘舵�
			    XMPPConnection connection = new XMPPConnection(connectionConfig);
			    try {
			      connection.connect();// 寮�惎杩炴帴
			    } catch (XMPPException e) {
			      throw new IllegalStateException(e);
			    } 
			    try {
					connection.login(userName,passWord);
//				     accountManager.deleteAccount();
				} catch (XMPPException e) {
					e.printStackTrace();
				} 
		return connection;
	}
	/**
	 * 
	 * @return
	 * @throws XMPPException
	 */
	public XMPPConnection getConnection() throws XMPPException {
		final ConnectionConfiguration connectionConfig = new ConnectionConfiguration(
				ip, port,domain);
		    // 鍏佽鑷姩杩炴帴
		    connectionConfig.setReconnectionAllowed(true);
		    connectionConfig.setSASLAuthenticationEnabled(false);
		    connectionConfig.setSendPresence(false);//涓嶈鍛婅瘔鏈嶅姟鍣ㄨ嚜宸辩殑鐘舵�
		    XMPPConnection connection = new XMPPConnection(connectionConfig);
		    return connection;
	}
	
	/**
	 * 
	 * @return
	 */
	public  XMPPConnection getConn() {
		XMPPConnection conn = connectionHolders.get();
		if(conn == null){
			try {
				conn = getConnection();
			} catch (XMPPException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			/**
			 * 銆�hreadLocal鐨剆et鏂规硶锛氫互鎵ц褰撳墠杩欒
			 * 浠ｇ爜鐨勭嚎绋嬪仛涓簁ey,淇濆瓨value銆�
			 */
			connectionHolders.set(conn);
		}
		return conn;
	}
	
	/**
	 * 
	 */
	public  void getPadPushConn() {
		 
		if(padpushConnection==null||!padpushConnection.isConnected()){
			   final ConnectionConfiguration connectionConfig = new ConnectionConfiguration(
				        ip, port,domain);
				
			   System.out.println("padpush is connecting .....");
				    connectionConfig.setReconnectionAllowed(true);
				    connectionConfig.setSASLAuthenticationEnabled(false);
				    padpushConnection = new XMPPConnection(connectionConfig);
				    try {
				    	padpushConnection.connect();// 寮�惎杩炴帴
				    	padpushConnection.login(username, password);
					} catch (XMPPException e) {
						e.printStackTrace();
					} 
		}
	}
	
	/**
	 * 
	 * @return
	 */
	public  List<Message> getOffLine() {
		List<Message> msglist = new ArrayList<Message>();
		// 鑾峰彇绂荤嚎娑堟伅,绾跨▼闃诲 涓嶈兘ToastF
		try {
			XMPPConnection conn=getConnection();
			conn.connect();
			conn.login(username,password);
			Iterator<Message> it  = new OfflineMessageManager(conn).getMessages();
			while (it.hasNext()) {
				Message message = it.next();
				msglist.add(message);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 璁剧疆鍦ㄧ嚎
//			if (XmppTool.getConnection().isConnected()) {
//				XmppTool.getConnection().sendPacket(
//						new Presence(Presence.Type.available));
//				try {
//					if(msglist.size()>0){
//					XmppTool.getOffLineMessageManager().deleteMessages();
//					}
//				} catch (Exception e) {
//					e.printStackTrace();
//				}
//			}
		}
		return msglist;
	}
	
	
	public static void main(String[] args){
		//ConnMgrUtil.getInstance().getPadPushConn();
		ImMessageUtil.sendMessage( "15071491521", "test","1",11);
		
		ImMessageUtil.sendMessage( "15071491521", "rrrrrr","1",11);
	}
}

