package com.cloudrich.ereader.system.dao;

import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.system.entity.SysUserMainEnity;

public interface SysUserMainDao {
    int deleteByPrimaryKey(Integer id);

    int insert(SysUserMainEnity record);

    SysUserMainEnity selectByPrimaryKey(Integer id);
    SysUserMainEnity selectByUserName(String username);
    
    List<SysUserMainEnity> selectAll(Map<String, Object> map );

    int updateByPrimaryKey(SysUserMainEnity record);
    
    List<SysUserMainEnity> selectAllPadUser();
    
    List<SysUserMainEnity> selectAllUsers();
    
    List<SysUserMainEnity> selectSmsFileUser5();
    
    List<SysUserMainEnity> selectSmsFileUser10();
}