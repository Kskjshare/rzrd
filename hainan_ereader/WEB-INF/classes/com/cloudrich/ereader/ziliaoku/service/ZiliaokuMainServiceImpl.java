package com.cloudrich.ereader.ziliaoku.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cloudrich.ereader.common.dao.PageHelper;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.common.dao.PageHelper.PageCall;
import com.cloudrich.ereader.ziliaoku.dao.ZiliaokuMainDao;
import com.cloudrich.ereader.ziliaoku.entity.ZiliaokuMainEntity;

@Service("ZiliaokuMainServiceImpl")
public class ZiliaokuMainServiceImpl implements ZiliaokuMainService{
	@Resource ZiliaokuMainDao ziliaokuMainDao;
	
	@Override
	public Page select(int pageNo, int pageSize, final ZiliaokuMainEntity entity) {
		return PageHelper.pagedQuery(new PageCall() {
			@Override
			public void executeQuery() {
				ziliaokuMainDao.select(entity);
			}
		}, pageNo, pageSize);
	}

	@Override
	public int upload(ZiliaokuMainEntity entity) {
		return ziliaokuMainDao.insert(entity);
	}

	@Override
	public ZiliaokuMainEntity selectById(int ziliaoid) {
		return ziliaokuMainDao.selectByPrimaryKey(ziliaoid);
	}

	@Override
	public int update(ZiliaokuMainEntity entity) {
		return ziliaokuMainDao.updateByPrimaryKey(entity);
	}

	@Override
	public int delete(int ziliaoid) {
		return ziliaokuMainDao.deleteByPrimaryKey(ziliaoid);
	}
	
	@Override
	public List<ZiliaokuMainEntity> selectByType(int type){
		return ziliaokuMainDao.selectByType(type);
	}
	
	@Override
	public List<ZiliaokuMainEntity> searchZiliaoByKeyword(String keyword){
		return ziliaokuMainDao.searchZiliaoByKeyword(keyword);
	}
}
