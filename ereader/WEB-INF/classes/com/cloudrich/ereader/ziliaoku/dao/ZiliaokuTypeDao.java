package com.cloudrich.ereader.ziliaoku.dao;

import java.util.List;

import com.cloudrich.ereader.ziliaoku.entity.ZiliaokuTypeEntity;

public interface ZiliaokuTypeDao {
    int deleteByPrimaryKey(Integer typeid);

    int insert(ZiliaokuTypeEntity record);

    ZiliaokuTypeEntity selectByPrimaryKey(Integer typeid);

    List<ZiliaokuTypeEntity> selectAll();

    int updateByPrimaryKey(ZiliaokuTypeEntity record);
    
    List<ZiliaokuTypeEntity> selectFirstType();
    
    List<ZiliaokuTypeEntity> selectSecondType(Integer typeid);
    
    int addFirstType(ZiliaokuTypeEntity typeEntity);
    
    int addSecondType(ZiliaokuTypeEntity typeEntity);
    
}