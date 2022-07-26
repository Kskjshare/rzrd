package com.cloudrich.ereader.tongxunlun.dao;

import java.util.List;

import com.cloudrich.ereader.tongxunlun.entity.TongxunluPubEntity;

public interface TongxunluPubDao {
    int deleteByTxlid(Integer id);

    int insert(TongxunluPubEntity record);

    TongxunluPubEntity selectByPrimaryKey(Integer id);

    List<TongxunluPubEntity> selectAll(String name);

    int updateByPrimaryKey(TongxunluPubEntity record);
    
    List<TongxunluPubEntity> selectByComp(Integer compCode);
    
    TongxunluPubEntity selectPubtime();
    
    int deleteAll();
}