package com.cloudrich.ereader.login.entity;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

public class LoginUser implements HttpSessionBindingListener {
	private String username;
	private Integer id;
	private List<Map<String,Object>> permissionlist;
	
	private Map<String,Object> permissionmap;
	
	private String usertype;
	private String truename;
	
	
	
	public String getTruename() {
		return truename;
	}

	public void setTruename(String truename) {
		this.truename = truename;
	}

	public String getUsertype() {
		return usertype;
	}

	public void setUsertype(String usertype) {
		this.usertype = usertype;
	}

	public Map<String, Object> getPermissionmap() {
		return permissionmap;
	}

	public void setPermissionmap(Map<String, Object> permissionmap) {
		this.permissionmap = permissionmap;
	}

	private LoginUserList ul = LoginUserList.getInstance();

	
	public List<Map<String,Object>> getPermissionlist(){
		return permissionlist;
	}
	
	public void setPermissionlist(List<Map<String,Object>> permissionlist){
		this.permissionlist=permissionlist;
	}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public LoginUser() {

	}

	public LoginUser(String username)

	{

		this.username = username;

	}

	public void setUsername(String username)

	{

		this.username = username;

	}

	public String getUsername()

	{

		return username;

	}

	@Override
	public void valueBound(HttpSessionBindingEvent arg0) {
		 ul.addUser(username);

	}

	@Override
	public void valueUnbound(HttpSessionBindingEvent arg0) {
		 ul.removeUser(username);

	}

	@Override
	public String toString() {
		return "LoginUser [id=" + id + ", username=" + username + "]";
	}
}
