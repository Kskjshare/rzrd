package com.cloudrich.ereader.system.service;


import java.util.List;

import com.cloudrich.ereader.system.entity.SysRoleAuthorityEntity;
import com.cloudrich.ereader.system.entity.SysRoleMainEntity;


public interface RoleAuthorityService {
	
    int insert(SysRoleAuthorityEntity briefing);
    int deleteByRoleid(int roleid);
    List<SysRoleAuthorityEntity> selectByRoleid(int id);
}
