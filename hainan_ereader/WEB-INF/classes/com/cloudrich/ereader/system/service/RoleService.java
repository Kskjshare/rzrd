package com.cloudrich.ereader.system.service;

import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.system.entity.SysRoleMainEntity;


public interface RoleService {
	
	SysRoleMainEntity selectEntityById(int briefid);
	
	List<SysRoleMainEntity> selectAll();
	
    int insert(SysRoleMainEntity briefing);
    
    int update(SysRoleMainEntity briefing); 
    
    int delete(int id); 
    
    Page selectByPage(int pageNo, int pageSize) ;
    
    Page selectByPageUser(int pageNo, int pageSize,Integer roleid) ;
    
  
}
