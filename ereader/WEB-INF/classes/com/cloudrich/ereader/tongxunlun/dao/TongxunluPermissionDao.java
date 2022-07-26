package com.cloudrich.ereader.tongxunlun.dao;

import com.cloudrich.ereader.tongxunlun.entity.TongxunluPermissionEntity;
import java.util.List;

public interface TongxunluPermissionDao {
    int deleteByPrimaryKey(Integer id);

    int insert(TongxunluPermissionEntity record);

    TongxunluPermissionEntity selectByPrimaryKey(Integer id);

    List<TongxunluPermissionEntity> selectAll();

    int updateByPrimaryKey(TongxunluPermissionEntity record);
    
    int deleteAllPermission();
    
    int selectPermisssionByUserid(int userid);
}