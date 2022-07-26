package com.cloudrich.ereader.system.service;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cloudrich.ereader.system.dao.SysRoleAuthorityDao;
import com.cloudrich.ereader.system.entity.SysRoleAuthorityEntity;


@Service("RoleAuthorityServiceImpl")
public class RoleAuthorityServiceImpl implements RoleAuthorityService{
	@Resource SysRoleAuthorityDao sysRoleAuthorityDao;
	@Override
	public int insert(SysRoleAuthorityEntity briefing) {
		 int i=sysRoleAuthorityDao.insert(briefing);
		 return i;
	} 
	public int deleteByRoleid(int id){
		int i=sysRoleAuthorityDao.deleteByRoleid(id);
		return i;
		
	}
	public List<SysRoleAuthorityEntity> selectByRoleid(int id){
	    return sysRoleAuthorityDao.selectByRoleid(id);
	}
}
