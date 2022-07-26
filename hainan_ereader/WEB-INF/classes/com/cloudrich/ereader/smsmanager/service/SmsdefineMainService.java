package com.cloudrich.ereader.smsmanager.service;

import java.util.List;

import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.smsmanager.entity.SmsdefineMainEntity;
import com.cloudrich.ereader.system.entity.SysUserMainEnity;


public interface SmsdefineMainService {

	SmsdefineMainEntity  selectEntityById(int smsid);

	List<SmsdefineMainEntity> selectAll();

	Page selectByPage(int pageNo, int pageSize);

	int insertSmsdefine(SmsdefineMainEntity entity);

	int updateSmsdefine(SmsdefineMainEntity entity);

	int deleteSmsdefine(int id);
	
	List<SysUserMainEnity> selectScopeUserBySmsid(int smsid);
	
} 
