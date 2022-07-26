package com.cloudrich.ereader.login.service;

import com.cloudrich.ereader.login.entity.LoginClientUser;
import com.cloudrich.ereader.login.entity.LoginUser;

public interface LoginService {

	public LoginUser loginSys(String username,String password);
	
	
	//PAD端Login
	public LoginClientUser LoginClient(String username,String password);
	
}
