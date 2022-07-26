package com.cloudrich.ereader.system.dao;

import java.util.List;

import com.cloudrich.ereader.system.entity.SysScopeMainEntity;

public interface SysTsscopeMainDao {
    int deleteByPrimaryKey(Integer scopeid);

    int insert(SysScopeMainEntity record);

    SysScopeMainEntity selectByPrimaryKey(Integer scopeid);

    List<SysScopeMainEntity> selectAll();

    int updateByPrimaryKey(SysScopeMainEntity record);
}