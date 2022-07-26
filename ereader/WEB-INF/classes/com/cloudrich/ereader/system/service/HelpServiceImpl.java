package com.cloudrich.ereader.system.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import com.cloudrich.ereader.common.dao.PageHelper;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.common.dao.PageHelper.PageCall;
import com.cloudrich.ereader.system.dao.SysHelpMainDao;
import com.cloudrich.ereader.system.entity.SysHelpMainEntity;


@Service("HelpServiceImpl")
public class HelpServiceImpl implements HelpService{
	@Resource SysHelpMainDao sysHelpMainDao;

	@Override
	public int deleteByPrimaryKey(Integer id) {
		int i=sysHelpMainDao.deleteByPrimaryKey(id);
		return i;
	}

	@Override
	public int insert(SysHelpMainEntity record) {
		int i=sysHelpMainDao.insert(record);
		return i;
	}

	@Override
	public SysHelpMainEntity selectByFiletype(String filetype) {
		SysHelpMainEntity entity=sysHelpMainDao.selectByFiletype(filetype);
		return entity;
	}

	@Override
	public int updateByPrimaryKey(SysHelpMainEntity record) {
			int i=sysHelpMainDao.updateByPrimaryKey(record);
			return i;
	}

	@Override
	public SysHelpMainEntity selectByPrimaryKey(Integer id) {
		SysHelpMainEntity entity =sysHelpMainDao.selectByPrimaryKey(id);
		return entity;
	}

	@Override
	public List<SysHelpMainEntity> selectAll(Map<String,Object> map) {
		List<SysHelpMainEntity> list=sysHelpMainDao.selectAll(map);
		return list;
	}
	
	@Override
	public Page selectByPage(int pageNo, int pageSize,final Map<String,Object> map) {
		return PageHelper.pagedQuery(new PageCall() {
			@Override
			public void executeQuery() {
				sysHelpMainDao.selectAll(map);
			}
		}, pageNo, pageSize);
	}
}
