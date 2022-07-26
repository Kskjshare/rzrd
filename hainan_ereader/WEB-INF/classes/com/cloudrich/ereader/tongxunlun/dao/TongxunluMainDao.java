package com.cloudrich.ereader.tongxunlun.dao;

import java.util.List;

import com.cloudrich.ereader.tongxunlun.entity.TongxunluMainEntity;

public interface TongxunluMainDao {
    int deleteByPrimaryKey(Integer id);

    int insert(TongxunluMainEntity record);

    TongxunluMainEntity selectByPrimaryKey(Integer id);

    List<TongxunluMainEntity> selectAll(String name);

    int updateByPrimaryKey(TongxunluMainEntity record);
    
    List<TongxunluMainEntity> selectByComp(Integer compCode);
}