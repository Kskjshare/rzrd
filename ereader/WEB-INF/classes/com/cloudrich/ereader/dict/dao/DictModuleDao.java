package com.cloudrich.ereader.dict.dao;


import java.util.List;

import com.cloudrich.ereader.dict.entity.DictModuleEntity;

public interface DictModuleDao {
    int deleteByPrimaryKey(Integer id);

    int insert(DictModuleEntity record);

    DictModuleEntity selectByPrimaryKey(Integer id);

    List<DictModuleEntity> selectAll();

    int updateByPrimaryKey(DictModuleEntity record);
}