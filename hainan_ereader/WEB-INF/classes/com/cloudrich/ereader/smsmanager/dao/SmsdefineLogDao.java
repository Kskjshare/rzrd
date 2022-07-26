package com.cloudrich.ereader.smsmanager.dao;

import java.util.List;

import com.cloudrich.ereader.smsmanager.entity.SmsdefineLogEntity;

public interface SmsdefineLogDao {
    int deleteByPrimaryKey(Integer id);

    int insert(SmsdefineLogEntity record);

    SmsdefineLogEntity selectByPrimaryKey(Integer id);

    List<SmsdefineLogEntity> selectAll();

    int updateByPrimaryKey(SmsdefineLogEntity record);
    
    List<SmsdefineLogEntity> selectBySmsid(int smsid);
}