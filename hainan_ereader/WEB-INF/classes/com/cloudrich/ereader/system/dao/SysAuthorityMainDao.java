package com.cloudrich.ereader.system.dao;

import java.util.List;

import com.cloudrich.ereader.system.entity.SysAuthorityMainEntity;

public interface SysAuthorityMainDao {
    int deleteByPrimaryKey(Integer authid);

    int insert(SysAuthorityMainEntity record);

    SysAuthorityMainEntity selectByPrimaryKey(Integer authid);

    List<SysAuthorityMainEntity> selectAll();

    int updateByPrimaryKey(SysAuthorityMainEntity record);
}