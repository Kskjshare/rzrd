package com.cloudrich.ereader.ziliaoku.service;

import java.util.List;

import com.cloudrich.ereader.ziliaoku.entity.ZiliaokuTypeEntity;

public interface ZiliaokuTypeService {
	List<ZiliaokuTypeEntity> selectFirstType();
	List<ZiliaokuTypeEntity> selectSecondType(int typeid);
	List<ZiliaokuTypeEntity> selectType();
	int addFirstType(ZiliaokuTypeEntity typeEntity);
	int addSecondType(ZiliaokuTypeEntity typeEntity);
	ZiliaokuTypeEntity selectTypeById(int typeid);
	int updateType(ZiliaokuTypeEntity typeEntity);
	int deleteType(int typeid);
}
