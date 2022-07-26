package com.cloudrich.ereader.system.dao;

import java.util.List;

import com.cloudrich.ereader.system.entity.SysScopeUserEntity;

public interface SysScopeUserDao {
    int deleteByScopeId(Integer scopeid);
    
    int deleteByUserId(Integer userid);

    int insert(SysScopeUserEntity record);

    SysScopeUserEntity selectByPrimaryKey(Integer id);
    
    List<SysScopeUserEntity> selectByScopeId(Integer id);

    List<SysScopeUserEntity> selectAll();

    int updateByPrimaryKey(SysScopeUserEntity record);
}