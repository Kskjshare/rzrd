package com.cloudrich.ereader.smsmanager.dao;

import java.util.List;

import com.cloudrich.ereader.smsmanager.entity.SmsdefineLogDetailEntity;

public interface SmsdefineLogDetailDao {
    int deleteByPrimaryKey(Integer id);

    int insert(SmsdefineLogDetailEntity record);

    SmsdefineLogDetailEntity selectByPrimaryKey(Integer id);
    
    List<SmsdefineLogDetailEntity> selectByLogid(Integer id);

    List<SmsdefineLogDetailEntity> selectAll();

    int updateByPrimaryKey(SmsdefineLogDetailEntity record);
}