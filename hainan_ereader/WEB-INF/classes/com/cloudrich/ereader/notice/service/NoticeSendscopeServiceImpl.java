package com.cloudrich.ereader.notice.service;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cloudrich.ereader.notice.dao.NoticeSendscopeDao;
import com.cloudrich.ereader.notice.entity.NoticeSendscopeEntity;
import com.cloudrich.ereader.system.entity.SysUserMainEnity;

@Service("NoticeSendscopeServiceImpl")
public class NoticeSendscopeServiceImpl implements NoticeSendscopeService{
	
   @Resource NoticeSendscopeDao noticeSendscopeDao;

	@Override
	public int deleteByPrimaryKey(Integer id) {
		int i=noticeSendscopeDao.deleteByPrimaryKey(id);
		return i;
	}

	@Override
	public int deleteByNoticeId(Integer id) {
		int i=noticeSendscopeDao.deleteByNoticeId(id);
		return i;
	}

	@Override
	public int insert(NoticeSendscopeEntity record) {
		int i=noticeSendscopeDao.insert(record);
		return i;
	}

	@Override
	public NoticeSendscopeEntity selectByPrimaryKey(Integer id) {
		NoticeSendscopeEntity entity=noticeSendscopeDao.selectByPrimaryKey(id);
		return entity;
	}

	@Override
	public List<NoticeSendscopeEntity> selectAll() {
		List<NoticeSendscopeEntity> list=noticeSendscopeDao.selectAll();
		return list;
	}

	@Override
	public List<NoticeSendscopeEntity> selectByNoticeId(Integer id) {
		List<NoticeSendscopeEntity> list=noticeSendscopeDao.selectByNoticeId(id);
		return list;
	}

	@Override
	public int updateByPrimaryKey(NoticeSendscopeEntity record) {
		int i=noticeSendscopeDao.updateByPrimaryKey(record);
		return i;
	}
	
	@Override
	public List<SysUserMainEnity> selectScopeUserByNoticeId(int noticeid){
		return noticeSendscopeDao.selectScopeUserByNoticeId(noticeid);
	}	

}
