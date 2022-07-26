package com.cloudrich.ereader.dict.dao;

import java.util.List;

import com.cloudrich.ereader.dict.entity.DictPermissionEntity;

public interface DictPermissionDao {
    int deleteByPrimaryKey(Integer id);

    int insert(DictPermissionEntity record);

    DictPermissionEntity selectByPrimaryKey(Integer id);

    List<DictPermissionEntity> selectAll();

    int updateByPrimaryKey(DictPermissionEntity record);
    
    DictPermissionEntity selectByPermissionCode(String permissioncode);
}