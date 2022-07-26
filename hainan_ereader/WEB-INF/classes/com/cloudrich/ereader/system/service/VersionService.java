package com.cloudrich.ereader.system.service;

import java.util.List;
import java.util.Map;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.system.entity.SysVersionMainEnity;

public interface VersionService {
	
	SysVersionMainEnity selectEntityById(int briefid);
	
	List<SysVersionMainEnity> selectAll(Map<String,Object> map);
	
    int insert(SysVersionMainEnity briefing);
    
    int update(SysVersionMainEnity briefing); 
    
    int delete(int id); 
    
	Page selectByPage(int pageNo, int pageSize,final Map<String, Object> map) ;
	
	List<SysVersionMainEnity> selectVersionByType(String type);

	SysVersionMainEnity selectMaxVersion();
	
}
