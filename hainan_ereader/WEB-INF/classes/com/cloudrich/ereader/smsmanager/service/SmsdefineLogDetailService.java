package com.cloudrich.ereader.smsmanager.service;

import java.util.List;

import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.smsmanager.entity.SmsdefineLogDetailEntity;
import com.cloudrich.ereader.smsmanager.entity.SmsdefineMainEntity;


public interface SmsdefineLogDetailService {

	SmsdefineLogDetailEntity  selectEntityById(int smsid);

	List<SmsdefineLogDetailEntity> selectAll();
	
	List<SmsdefineLogDetailEntity> selectSmsdefineByLogid(int id);

	Page selectByPage(int pageNo, int pageSize);

	int insertSmsdefineLogDetail(SmsdefineLogDetailEntity entity);

	int updateSmsdefineLogDetail(SmsdefineLogDetailEntity entity);

	int deleteSmsdefineLogDetail(int id);
	
} 
