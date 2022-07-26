package com.cloudrich.ereader.notice.dao;

import java.util.List;
import com.cloudrich.ereader.system.entity.SysUserMainEnity;

import com.cloudrich.ereader.notice.entity.NoticeSendscopeEntity;

public interface NoticeSendscopeDao {
    int deleteByPrimaryKey(Integer id);
    int deleteByNoticeId(Integer id);
    int insert(NoticeSendscopeEntity record);

    NoticeSendscopeEntity selectByPrimaryKey(Integer id);

    List<NoticeSendscopeEntity> selectAll();
    
    List<NoticeSendscopeEntity> selectByNoticeId(Integer id);

    int updateByPrimaryKey(NoticeSendscopeEntity record);
    
    List<SysUserMainEnity> selectScopeUserByNoticeId(int noticeid);
}