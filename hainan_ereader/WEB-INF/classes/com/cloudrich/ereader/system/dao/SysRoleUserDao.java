package com.cloudrich.ereader.system.dao;

import java.util.List;

import com.cloudrich.ereader.system.entity.SysRoleUserEntity;

public interface SysRoleUserDao {
    int deleteByPrimaryKey(Integer id);
    
    int deleteByUserid(Integer id);

    int insert(SysRoleUserEntity record);

    SysRoleUserEntity selectByPrimaryKey(Integer id);

    List<SysRoleUserEntity> selectAll();

    int updateByPrimaryKey(SysRoleUserEntity record);
    
    int deleteByRoleid(Integer roleid);
    
    List<SysRoleUserEntity> selectByRoleid(Integer roleid);
    
    //根据用户id获取权限
    List<SysRoleUserEntity> selectByUserid(Integer userid);
}

