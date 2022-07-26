package com.cloudrich.ereader.ziliaoku.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cloudrich.ereader.ziliaoku.dao.ZiliaokuTypeDao;
import com.cloudrich.ereader.ziliaoku.entity.ZiliaokuTypeEntity;

@Service("ZiliaokuTypeServiceImpl")
public class ZiliaokuTypeServiceImpl implements ZiliaokuTypeService{
	
	@Resource ZiliaokuTypeDao ziliaokuTypeDao;
	
	@Override
	public List<ZiliaokuTypeEntity> selectFirstType() {
		return ziliaokuTypeDao.selectFirstType();
	}

	@Override
	public List<ZiliaokuTypeEntity> selectSecondType(final int typeid) {
		return ziliaokuTypeDao.selectSecondType(typeid);
	}

	@Override
	public List<ZiliaokuTypeEntity> selectType() {
		return ziliaokuTypeDao.selectAll();
	}

	@Override
	public int addFirstType(ZiliaokuTypeEntity typeEntity) {
		return ziliaokuTypeDao.addFirstType(typeEntity);
	}

	@Override
	public int addSecondType(ZiliaokuTypeEntity typeEntity) {
		return ziliaokuTypeDao.addSecondType(typeEntity);
	}

	@Override
	public ZiliaokuTypeEntity selectTypeById(int typeid) {
		return ziliaokuTypeDao.selectByPrimaryKey(typeid);
	}

	@Override
	public int updateType(ZiliaokuTypeEntity typeEntity) {
		return ziliaokuTypeDao.updateByPrimaryKey(typeEntity);
	}

	@Override
	public int deleteType(int typeid) {
		return ziliaokuTypeDao.deleteByPrimaryKey(typeid);
	}

	

}
