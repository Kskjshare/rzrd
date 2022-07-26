package com.cloudrich.ereader.ziliaoku.dao;

import java.util.List;

import com.cloudrich.ereader.ziliaoku.entity.ZiliaokuMainEntity;

public interface ZiliaokuMainDao {
    int deleteByPrimaryKey(Integer ziliaoid);

    int insert(ZiliaokuMainEntity record);

    ZiliaokuMainEntity selectByPrimaryKey(Integer ziliaoid);

    List<ZiliaokuMainEntity> select(ZiliaokuMainEntity record);

    int updateByPrimaryKey(ZiliaokuMainEntity record);
    
    //根据type获取资料
    List<ZiliaokuMainEntity> selectByType(int type);
    
    List<ZiliaokuMainEntity> searchZiliaoByKeyword(String name);
    
    List<ZiliaokuMainEntity> selectAll();
    
}