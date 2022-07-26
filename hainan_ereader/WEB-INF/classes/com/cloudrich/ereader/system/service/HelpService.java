package com.cloudrich.ereader.system.service;


import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.system.entity.SysHelpMainEntity;


public interface HelpService {
	
    int deleteByPrimaryKey(Integer id);

    int insert(SysHelpMainEntity record);

    SysHelpMainEntity selectByFiletype(String filetype);

    int updateByPrimaryKey(SysHelpMainEntity record);
    
    SysHelpMainEntity selectByPrimaryKey(Integer id);
    
    List<SysHelpMainEntity> selectAll(Map<String, Object> map);

	Page selectByPage(int pageNo, int pageSize, Map<String, Object> map);
}
