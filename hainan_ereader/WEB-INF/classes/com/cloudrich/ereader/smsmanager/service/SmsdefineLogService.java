package com.cloudrich.ereader.smsmanager.service;

import java.util.List;

import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.smsmanager.entity.SmsdefineLogEntity;
import com.cloudrich.ereader.smsmanager.entity.SmsdefineMainEntity;


public interface SmsdefineLogService {

	SmsdefineLogEntity  selectEntityById(int smsid);

	List<SmsdefineLogEntity> selectAll();

	Page selectByPage(int pageNo, int pageSize);

	int insertSmsdefineLog(SmsdefineLogEntity entity);

	int updateSmsdefineLog(SmsdefineLogEntity entity);

	int deleteSmsdefineLog(int id);
	
} 
