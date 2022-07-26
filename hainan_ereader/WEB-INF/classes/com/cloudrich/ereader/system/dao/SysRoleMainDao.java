package com.cloudrich.ereader.system.dao;

import java.util.List;

import com.cloudrich.ereader.system.entity.SysRoleMainEntity;

public interface SysRoleMainDao {
    int deleteByPrimaryKey(Integer roleid);

    int insert(SysRoleMainEntity record);

    SysRoleMainEntity selectByPrimaryKey(Integer roleid);

    List<SysRoleMainEntity> selectAll();

    int updateByPrimaryKey(SysRoleMainEntity record);
}