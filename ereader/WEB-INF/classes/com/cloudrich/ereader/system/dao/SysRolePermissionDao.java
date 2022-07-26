package com.cloudrich.ereader.system.dao;

import java.util.List;

import com.cloudrich.ereader.system.entity.SysRolePermissionEntity;

public interface SysRolePermissionDao {
    int deleteByPrimaryKey(Integer id);

    int insert(SysRolePermissionEntity record);

    SysRolePermissionEntity selectByPrimaryKey(Integer id);

    List<SysRolePermissionEntity> selectAll();

    int updateByPrimaryKey(SysRolePermissionEntity record);
    
    
   void deletePermissionByRoleid(Integer roleid);
    
    List<SysRolePermissionEntity> selectPermissionByRoleid (Integer roleid);
    
    
}