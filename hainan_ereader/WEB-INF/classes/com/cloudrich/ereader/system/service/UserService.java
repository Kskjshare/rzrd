package com.cloudrich.ereader.system.service;

import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.common.dao.PageHelper;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.common.dao.PageHelper.PageCall;
import com.cloudrich.ereader.system.entity.SysUserMainEnity;

public interface UserService {
	
	SysUserMainEnity selectEntityById(int briefid);
	
	SysUserMainEnity selectEntityByName(String username);
	
	List<SysUserMainEnity> selectAll(Map<String,Object> map);
	
    int insert(SysUserMainEnity briefing);
    
    int update(SysUserMainEnity briefing); 
    
    int delete(int id); 
    
	Page selectByPage(int pageNo, int pageSize,final Map<String, Object> map) ;
	
	List<SysUserMainEnity> selectAllPadUser();
	
	List<SysUserMainEnity> selectAllUsers();
}
