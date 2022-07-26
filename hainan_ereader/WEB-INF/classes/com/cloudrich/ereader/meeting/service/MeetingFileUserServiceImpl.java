package com.cloudrich.ereader.meeting.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import com.cloudrich.ereader.meeting.dao.MeetFileUserDao;
import com.cloudrich.ereader.meeting.dao.MeetYichenMainDao;
import com.cloudrich.ereader.meeting.entity.MeetFileUserEntity;


public class MeetingFileUserServiceImpl implements MeetingFileUserService{
	
	private Logger log = Logger.getLogger(MeetingFileUserServiceImpl.class);
	
	@Resource MeetFileUserDao meetFileUserDao;

	@Override
	public int deleteByPrimaryKey(Integer id) {
		
		return meetFileUserDao.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(MeetFileUserEntity record) {
		
		return meetFileUserDao.insert(record);
	}

	@Override
	public MeetFileUserEntity selectByPrimaryKey(Integer id) {
		
		return meetFileUserDao.selectByPrimaryKey(id);
	}

	@Override
	public List<MeetFileUserEntity> selectAll() {
		
		return meetFileUserDao.selectAll();
	}

	@Override
	public int updateByPrimaryKey(MeetFileUserEntity record) {
		
		return meetFileUserDao.updateByPrimaryKey(record);
	}

	@Override
	public List<MeetFileUserEntity> selectFileUsersByFileid(Integer id) {
		
		return meetFileUserDao.selectFileUsersByFileid(id);
	}

}
