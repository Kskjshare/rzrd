package com.cloudrich.ereader.ziliaoku.service;

import java.util.List;

import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.ziliaoku.entity.ZiliaokuMainEntity;

public interface ZiliaokuMainService {
	Page select(int pageNo, int pageSize, ZiliaokuMainEntity entity);
	int upload(ZiliaokuMainEntity entity);
	ZiliaokuMainEntity selectById(int ziliaoid);
	int update(ZiliaokuMainEntity entity);
	int delete(int ziliaoid);
	
	//根据type获取资料
	List<ZiliaokuMainEntity> selectByType(int type);
	
	
	List<ZiliaokuMainEntity> searchZiliaoByKeyword(String keyword);
	
}
