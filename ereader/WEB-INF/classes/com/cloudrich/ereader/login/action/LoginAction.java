package com.cloudrich.ereader.login.action;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;

import com.cloudrich.ereader.common.action.BaseAction;
import com.cloudrich.ereader.common.constant.LoginConstant;
import com.cloudrich.ereader.login.entity.LoginUser;
import com.cloudrich.ereader.login.service.LoginService;
import com.cloudrich.ereader.system.entity.SysVersionMainEnity;
import com.cloudrich.ereader.system.service.VersionService;
import com.opensymphony.xwork2.ActionSupport;

@Controller("LoginAction")
public class LoginAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	private String username;
	private String password;
	String resultString;

	@Resource
	LoginService loginService;
	
	@Resource
	private VersionService versionService;	
	
	private SysVersionMainEnity entity;


	public String login() {
		int result = -20;// 用户的状态 1：登录成功 2账号或者密码错误 3权限不足
		LoginUser userEntity = loginService.loginSys(username, password);// 根据账号密码获取用户信息
		System.out.println("userEntity:" + userEntity);
		if (userEntity == null) {// 用户对象等于空 登录失败 账号或者密码错误
			result = 2;
			resultString = "账号或者密码错误";
			this.getSession().setAttribute("resultString", resultString);
			jsonError(resultString);
		} else {
			if(userEntity.getUsertype().trim().equals("3")){
				result = 2;
				resultString = "PAD用户不能登录后台系统";
				this.getSession().setAttribute("resultString", resultString);
				jsonError(resultString);
			}else{
				try {
					this.getSession().setAttribute(LoginConstant.USER,userEntity);
					result = 1;
					jsonSuccess("login");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return ActionSupport.SUCCESS;
	}
	public String getApkVersion(){
		entity=versionService.selectMaxVersion();
		return ActionSupport.SUCCESS;
	}
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	public SysVersionMainEnity getEntity() {
		return entity;
	}
	public void setEntity(SysVersionMainEnity entity) {
		this.entity = entity;
	}
}
