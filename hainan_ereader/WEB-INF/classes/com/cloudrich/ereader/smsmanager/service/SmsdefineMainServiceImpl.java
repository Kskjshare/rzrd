package com.cloudrich.ereader.smsmanager.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cloudrich.ereader.common.dao.PageHelper;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.common.dao.PageHelper.PageCall;
import com.cloudrich.ereader.remind.service.RemindService;
import com.cloudrich.ereader.smsmanager.dao.SmsdefineMainDao;
import com.cloudrich.ereader.smsmanager.entity.SmsdefineMainEntity;
import com.cloudrich.ereader.system.entity.SysUserMainEnity;

@Service
public class SmsdefineMainServiceImpl implements SmsdefineMainService{

	@Resource SmsdefineMainDao  smsdefineMainDao;
	@Resource RemindService  remindService;
	@Override
	public SmsdefineMainEntity selectEntityById(int smsid) {
		SmsdefineMainEntity entity=smsdefineMainDao.selectByPrimaryKey(smsid);
		return entity;
	}

	@Override
	public List<SmsdefineMainEntity> selectAll() {
		List<SmsdefineMainEntity> list=smsdefineMainDao.selectAll();
		return list;
	}

	@Override
	public Page selectByPage(int pageNo, int pageSize) {
	
		return PageHelper.pagedQuery(new PageCall() {
			@Override
			public void executeQuery() {
				smsdefineMainDao.selectAll();
			}
		}, pageNo, pageSize);
	}

	@Override
	public int insertSmsdefine(SmsdefineMainEntity entity) {
		System.out.println("2.进入service");
		System.out.println(entity.toString());
		int i=smsdefineMainDao.insert(entity);
		 try{
			 /*byte[] middleUCS2=entity.getContent().getBytes("UnicodeBigUnmarked");
			entity.setContent(new String(middleUCS2,"middleUCS2"));*/
			 remindService.SmsManagerRemindHandler("insert",entity,0);
			}catch(Exception e){
				e.printStackTrace();
			}
		return i;
	}

	@Override
	public int updateSmsdefine(SmsdefineMainEntity entity) {
		int i=smsdefineMainDao.updateByPrimaryKey(entity);//处理通知提醒
		  try{
				remindService.SmsManagerRemindHandler("update",entity,0);
			}catch(Exception e){
				e.printStackTrace();
			}
		
		return i;
	}

	@Override
	public int deleteSmsdefine(int id) {
		int i=smsdefineMainDao.deleteByPrimaryKey(id);
		//处理通知提醒
		  try{
				remindService.SmsManagerRemindHandler("delete",null,id);
			}catch(Exception e){
				e.printStackTrace();
			}
		return i;
	}
	
	@Override
	 public List<SysUserMainEnity> selectScopeUserBySmsid(int smsid){
		 return smsdefineMainDao.selectScopeUserBySmsid(smsid);
	 }

} 
