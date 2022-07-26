package com.cloudrich.ereader.smsmanager.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cloudrich.ereader.common.dao.PageHelper;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.common.dao.PageHelper.PageCall;
import com.cloudrich.ereader.smsmanager.dao.SmsdefineLogDao;
import com.cloudrich.ereader.smsmanager.dao.SmsdefineMainDao;
import com.cloudrich.ereader.smsmanager.entity.SmsdefineLogEntity;
import com.cloudrich.ereader.smsmanager.entity.SmsdefineMainEntity;

@Service
public class SmsdefineLogServiceImpl implements SmsdefineLogService{

	@Resource SmsdefineLogDao  smsdefineLogDao;
	@Override
	public SmsdefineLogEntity selectEntityById(int smsid) {
		SmsdefineLogEntity smsdefineLogEntity=smsdefineLogDao.selectByPrimaryKey(smsid);
		return smsdefineLogEntity;
	}

	@Override
	public List<SmsdefineLogEntity> selectAll() {
		List<SmsdefineLogEntity> list=null;
			smsdefineLogDao.selectAll();
		return list;
	}

	@Override
	public Page selectByPage(int pageNo, int pageSize) {
	
		return PageHelper.pagedQuery(new PageCall() {
			@Override
			public void executeQuery() {
				smsdefineLogDao.selectAll();
			}
		}, pageNo, pageSize);
	}

	@Override
	public int insertSmsdefineLog(SmsdefineLogEntity entity) {
		int i=0;
		List<SmsdefineLogEntity> list=smsdefineLogDao.selectBySmsid(entity.getSmsid());
		if(list!=null&&list.size()!=0){
			entity.setLogid(list.get(0).getLogid());
			i=smsdefineLogDao.updateByPrimaryKey(entity);
		}else{
		    i=smsdefineLogDao.insert(entity);
		}
		return i;
	}

	@Override
	public int updateSmsdefineLog(SmsdefineLogEntity entity) {
		int i=smsdefineLogDao.updateByPrimaryKey(entity);
		return i;
	}

	@Override
	public int deleteSmsdefineLog(int id) {
		int i=smsdefineLogDao.deleteByPrimaryKey(id);
		return i;
	}


} 
