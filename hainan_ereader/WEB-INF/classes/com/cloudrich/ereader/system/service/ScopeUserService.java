package com.cloudrich.ereader.system.service;

import java.util.List;

import com.cloudrich.ereader.system.entity.SysScopeUserEntity;

public interface ScopeUserService {

    int deleteByScopeId(Integer id);

    int insert(SysScopeUserEntity record);

    SysScopeUserEntity selectByPrimaryKey(Integer id);

    List<SysScopeUserEntity> selectAll();
    
    List<SysScopeUserEntity> selectByScopeId(Integer id);

    int updateByPrimaryKey(SysScopeUserEntity record);
    
    int deleteByUserId(Integer id);
}
