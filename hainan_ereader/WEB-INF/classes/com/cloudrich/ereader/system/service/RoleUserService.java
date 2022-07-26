package com.cloudrich.ereader.system.service;

import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.system.entity.SysRoleMainEntity;
import com.cloudrich.ereader.system.entity.SysRoleUserEntity;


public interface RoleUserService {
	
	SysRoleUserEntity selectEntityById(int briefid);
	
	List<SysRoleUserEntity> selectAll();
	
    int insert(SysRoleUserEntity briefing);
    
    int update(SysRoleUserEntity briefing); 
    
    int delete(int id); 
    
    int deleteByRoleid(int id); 
    
    int deleteByUserid(int id); 
  
    List<SysRoleUserEntity> selectByRoleid(Integer id);
    
    
    //根据userid获取roleusr对象列表
    List<SysRoleUserEntity> selectByRuserid(Integer userid);
    
}
