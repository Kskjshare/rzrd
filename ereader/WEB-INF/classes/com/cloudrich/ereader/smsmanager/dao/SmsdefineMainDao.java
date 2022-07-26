package com.cloudrich.ereader.smsmanager.dao;

import java.util.List;

import com.cloudrich.ereader.smsmanager.entity.SmsdefineMainEntity;
import com.cloudrich.ereader.system.entity.SysUserMainEnity;

public interface SmsdefineMainDao {
    int deleteByPrimaryKey(Integer smsid);

    int insert(SmsdefineMainEntity record);

    SmsdefineMainEntity selectByPrimaryKey(Integer smsid);

    List<SmsdefineMainEntity> selectAll();

    int updateByPrimaryKey(SmsdefineMainEntity record);
    
    List<SysUserMainEnity> selectScopeUserBySmsid(int smsid);
}