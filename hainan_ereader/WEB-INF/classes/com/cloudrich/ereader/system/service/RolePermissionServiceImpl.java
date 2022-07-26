package com.cloudrich.ereader.system.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cloudrich.ereader.dict.entity.DictPermissionEntity;
import com.cloudrich.ereader.dict.service.DictPermissionService;
import com.cloudrich.ereader.system.dao.SysRolePermissionDao;
import com.cloudrich.ereader.system.entity.SysRolePermissionEntity;

@Service("RolePermissionServiceImpl")
public class RolePermissionServiceImpl implements RolePermissionService {

	@Resource DictPermissionService permissionService;
	@Resource SysRolePermissionDao rolePermissiondao;
	
	@Override
	public List<DictPermissionEntity> selectAllPermission(){
		return permissionService.selectAllPermission();
	}
	
	@Override
	public List<SysRolePermissionEntity> selectByRoleid(int roleid){
		return rolePermissiondao.selectPermissionByRoleid(roleid);
	}
	
	@Override
	public void addRolePermission(int roleid,String[] permissioncodes){
		
		SysRolePermissionEntity entity=null;
		for(int i=0;i<permissioncodes.length;i++){
			entity=new SysRolePermissionEntity();
			entity.setRoleid(roleid);
			entity.setPermissioncode(permissioncodes[i]);
			rolePermissiondao.insert(entity);
		}
	}
	
	@Override
	public void updateRolePermission(int roleid,String[] permissioncodes){
		SysRolePermissionEntity entity=null;
		rolePermissiondao.deletePermissionByRoleid(roleid);
		
		for(int i=0;i<permissioncodes.length;i++){
			entity=new SysRolePermissionEntity();
			entity.setRoleid(roleid);
			entity.setPermissioncode(permissioncodes[i]);
			rolePermissiondao.insert(entity);
		}
	}

	@Override
	public void deletePermissionByRoleid(int roleid) {
		rolePermissiondao.deletePermissionByRoleid(roleid);
		
	}
	   
}
