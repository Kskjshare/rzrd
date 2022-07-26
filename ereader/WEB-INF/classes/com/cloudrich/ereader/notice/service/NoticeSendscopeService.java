package com.cloudrich.ereader.notice.service;


import java.util.List;
import com.cloudrich.ereader.notice.entity.NoticeSendscopeEntity;
import com.cloudrich.ereader.system.entity.SysUserMainEnity;

public interface NoticeSendscopeService {
	
    int deleteByPrimaryKey(Integer id);
    
    int deleteByNoticeId(Integer id);
    
    int insert(NoticeSendscopeEntity record);

    NoticeSendscopeEntity selectByPrimaryKey(Integer id);

    List<NoticeSendscopeEntity> selectAll();
    
    List<NoticeSendscopeEntity> selectByNoticeId(Integer id);

    int updateByPrimaryKey(NoticeSendscopeEntity record);
    
    List<SysUserMainEnity> selectScopeUserByNoticeId(int noticeid);
		

}
