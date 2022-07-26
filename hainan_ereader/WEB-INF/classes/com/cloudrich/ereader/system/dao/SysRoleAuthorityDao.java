package com.cloudrich.ereader.system.dao;

import java.util.List;

import com.cloudrich.ereader.system.entity.SysRoleAuthorityEntity;

public interface SysRoleAuthorityDao {
    int deleteByPrimaryKey(Integer id);

    int deleteByRoleid(Integer roleid);
    
    int insert(SysRoleAuthorityEntity record);

    SysRoleAuthorityEntity selectByPrimaryKey(Integer id);

    List<SysRoleAuthorityEntity> selectAll();

    int updateByPrimaryKey(SysRoleAuthorityEntity record);
    
    List<SysRoleAuthorityEntity> selectByRoleid(int id);
}