package com.cloudrich.ereader.system.dao;

import java.util.List;
import java.util.Map;
import com.cloudrich.ereader.system.entity.SysVersionMainEnity;

public interface SysVersionMainDao {
	
    int deleteByPrimaryKey(Integer id);

    int insert(SysVersionMainEnity record);

    SysVersionMainEnity selectByPrimaryKey(Integer id);
       
    List<SysVersionMainEnity> selectAll(Map<String, Object> map );

    int updateByPrimaryKey(SysVersionMainEnity record);
    
    List<SysVersionMainEnity> selectVersionByType(String apptype );
    
    SysVersionMainEnity selectMaxVersion();
    
}