package com.cloudrich.ereader.system.service;


import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.system.entity.SysRoleMainEntity;
import com.cloudrich.ereader.system.entity.SysScopeMainEntity;
import com.cloudrich.ereader.system.entity.SysScopeUserEntity;


public interface ScopeMainService {
	
    int delete(Integer scopeid);

    int insert(SysScopeMainEntity record);

    SysScopeMainEntity selectEntityById(Integer scopeid);

    List<SysScopeMainEntity> selectAll();

    int updateByPrimaryKey(SysScopeMainEntity record);
    
    Page selectByPage(int pageNo, int pageSize) ;
    
    Page selectByPageUser(int pageNo, int pageSize,int scopeid) ;
    
    List<SysScopeUserEntity> selectByScopeId(int scopeid);
}
