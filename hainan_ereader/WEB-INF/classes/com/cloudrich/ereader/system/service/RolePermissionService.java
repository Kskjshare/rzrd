package com.cloudrich.ereader.system.service;

import java.util.List;

import com.cloudrich.ereader.dict.entity.DictPermissionEntity;
import com.cloudrich.ereader.system.entity.SysRolePermissionEntity;

public interface RolePermissionService {

	
	
	List<DictPermissionEntity> selectAllPermission();
	
	List<SysRolePermissionEntity> selectByRoleid(int roleid);
	
    void addRolePermission(int roleid,String[] permissionids);
    
	void updateRolePermission(int roleid,String[] permissionids);
	
	void deletePermissionByRoleid(int roleid);
}
