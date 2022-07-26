package com.cloudrich.ereader.remind.job;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jivesoftware.smack.XMPPConnection;

import com.cloudrich.framework.im.ConnMgrUtil;
import com.cloudrich.framework.im.ImMessageUtil;
import com.cloudrich.framework.job.JobEntity;

public class NormalRemindTask {
	
	private  final Log logger = LogFactory.getLog(NormalRemindTask.class);

	
	public NormalRemindTask(){
	}
	/**
	 * 
	 * @throws Exception
	 */
	public void start(JobEntity remind) throws Exception {
		
		
		 	String padmobile=(String)remind.getMap().get("content");
		 	int userid=(Integer)remind.getMap().get("id");
		 	String type=(String)remind.getMap().get("type");
		 	
		 	//4是销毁  5是解除销毁
		
			ImMessageUtil.sendMessage(padmobile, padmobile, type, userid);
					
		    System.out.print("Nomal Task is ending ...........");
	}
}
