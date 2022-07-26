package com.cloudrich.ereader.dict.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cloudrich.ereader.dict.dao.DictPermissionDao;
import com.cloudrich.ereader.dict.entity.DictPermissionEntity;

@Service("DictPermissionServiceImpl")
public class DictPermissionServiceImpl implements DictPermissionService{
	
	@Resource DictPermissionDao permissionDao;
	
	@Override
	public List<DictPermissionEntity> selectAllPermission(){
		
		return permissionDao.selectAll();
			
	}
	
	@Override
	public List<Map<String,Object>> selectAllPermissionMap(){
		
		List<DictPermissionEntity> list=permissionDao.selectAll();
		List<Map<String,Object>> maplist=new ArrayList<Map<String,Object>>();
		DictPermissionEntity entity=null;
		Map<String,Object> map=null;
		for(int i=0;i<list.size();i++){
			entity=list.get(i);
			map=new HashMap<String,Object>();
			map.put("moduleno", entity.getModuleno());
			map.put("modulename", entity.getModulename());
			map.put("operation", entity.getOperation());
			map.put("permissioncode", entity.getPersimoncode());
			maplist.add(map);
		}
		
		return maplist;
			
	}

	@Override
	public DictPermissionEntity selectByPermissionCode(String permissioncode){
		return permissionDao.selectByPermissionCode(permissioncode);
	}
	
	
}
