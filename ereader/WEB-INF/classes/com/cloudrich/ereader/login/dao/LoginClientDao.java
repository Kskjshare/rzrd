package com.cloudrich.ereader.login.dao;

import java.util.Map;

import com.cloudrich.ereader.login.entity.LoginClientUser;
import com.cloudrich.ereader.login.entity.LoginUser;


public interface LoginClientDao {

	LoginClientUser selectLoginClientUser(Map<String,Object> map);
	
	LoginUser selectLoginSysUser(Map<String,Object> map);	
}
