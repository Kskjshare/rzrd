package com.cloudrich.ereader.smsmanager.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cloudrich.ereader.common.dao.PageHelper;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.common.dao.PageHelper.PageCall;
import com.cloudrich.ereader.smsmanager.dao.SmsdefineLogDetailDao;
import com.cloudrich.ereader.smsmanager.entity.SmsdefineLogDetailEntity;

@Service
public class SmsdefineLogDetailServiceImpl implements SmsdefineLogDetailService{

	@Resource SmsdefineLogDetailDao  smsdefineLogDetailDao;
	@Override
	public SmsdefineLogDetailEntity selectEntityById(int smsid) {
		SmsdefineLogDetailEntity smsdefineLogDetailEntity=smsdefineLogDetailDao.selectByPrimaryKey(smsid);
		return smsdefineLogDetailEntity;
	}

	@Override
	public List<SmsdefineLogDetailEntity> selectAll() {
		List<SmsdefineLogDetailEntity> list=smsdefineLogDetailDao.selectAll();
		return list;
	}

	@Override
	public Page selectByPage(int pageNo, int pageSize) {
	
		return PageHelper.pagedQuery(new PageCall() {
			@Override
			public void executeQuery() {
				smsdefineLogDetailDao.selectAll();
			}
		}, pageNo, pageSize);
	}

	@Override
	public int insertSmsdefineLogDetail(SmsdefineLogDetailEntity entity) {
		System.out.println("service层，将发送记录保存至数据库中");
		System.out.println(entity.toString());
		int i=smsdefineLogDetailDao.insert(entity);
		return i;
	}

	@Override
	public int updateSmsdefineLogDetail(SmsdefineLogDetailEntity entity) {
		int i=smsdefineLogDetailDao.updateByPrimaryKey(entity);
		return i;
	}

	@Override
	public int deleteSmsdefineLogDetail(int id) {
		int i=smsdefineLogDetailDao.deleteByPrimaryKey(id);
		return i;
	}

	@Override
	public List<SmsdefineLogDetailEntity> selectSmsdefineByLogid(int id) {
		List<SmsdefineLogDetailEntity> list=smsdefineLogDetailDao.selectByLogid(id);
		return list;
	}



} 
