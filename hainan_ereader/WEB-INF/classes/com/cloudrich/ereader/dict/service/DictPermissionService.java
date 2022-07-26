package com.cloudrich.ereader.dict.service;

import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.dict.entity.DictPermissionEntity;

public interface DictPermissionService {
	
	List<DictPermissionEntity> selectAllPermission();
	
	List<Map<String,Object>> selectAllPermissionMap();
	/**
	 * 根据code获取权限
	 * @param permissioncode
	 * @return
	 */
	DictPermissionEntity   selectByPermissionCode(String permissioncode);
}
