package com.cloudrich.ereader.remind.job;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cloudrich.ereader.system.dao.SysUserMainDao;
import com.cloudrich.ereader.system.entity.SysUserMainEnity;
import com.cloudrich.sms.SmsBean;
import com.cloudrich.sms.SmsClient;

	/**
	 * 产品状态自动更改
	 * @author zhaojb
	 *
	 */
	@Service
 public class SmsPreJob10 { 
		@Resource SysUserMainDao sysUserMainDao;
		
		public void work() {
	      
			List<SysUserMainEnity> list=sysUserMainDao.selectSmsFileUser10();
			
			if(list!=null&&list.size()!=0){
				ArrayList<String> mobiles=new ArrayList<String>();
				
				for(int i=0;i<list.size();i++){
					mobiles.add(list.get(i).getPadmobile());
				}
				
				SmsClient proxy=new SmsClient();
				proxy=new SmsClient();
				SmsBean sms=new SmsBean();
				sms.setSmsContent("有新文件请查收。");
				sms.setMobileNoList(mobiles);
			    int t=proxy.SendMessage(sms);
			}
		    System.out.println("会前短信上午10点。。。。。。。。。。。。。。。。。。"+list.size());
	    }

}
