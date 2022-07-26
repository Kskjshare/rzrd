package com.cloudrich.ereader.system.dao;

import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.system.entity.SysHelpMainEntity;

public interface SysHelpMainDao {
    int deleteByPrimaryKey(Integer id);

    int insert(SysHelpMainEntity record);

    SysHelpMainEntity selectByFiletype(String filetype);
    
    SysHelpMainEntity selectByPrimaryKey(Integer id);

    int updateByPrimaryKey(SysHelpMainEntity record);
    
    List<SysHelpMainEntity> selectAll(Map<String,Object> map);
}