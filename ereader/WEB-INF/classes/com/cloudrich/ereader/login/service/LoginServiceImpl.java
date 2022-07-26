package com.cloudrich.ereader.login.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.cloudrich.ereader.dict.entity.DictPermissionEntity;
import com.cloudrich.ereader.dict.service.DictPermissionService;
import com.cloudrich.ereader.login.dao.LoginClientDao;
import com.cloudrich.ereader.login.entity.LoginClientUser;
import com.cloudrich.ereader.login.entity.LoginUser;
import com.cloudrich.ereader.meeting.service.MeetingViewServiceImpl;
import com.cloudrich.ereader.system.entity.SysRolePermissionEntity;
import com.cloudrich.ereader.system.entity.SysRoleUserEntity;
import com.cloudrich.ereader.system.entity.SysUserMainEnity;
import com.cloudrich.ereader.system.service.RolePermissionService;
import com.cloudrich.ereader.system.service.RoleUserService;
import com.cloudrich.ereader.system.service.UserService;
import com.cloudrich.framework.util.Md5Utils;

@Service
public class LoginServiceImpl implements LoginService {

	@Resource UserService userService;
	@Resource RoleUserService  roleUserService;
	@Resource  RolePermissionService rolePermissionService;
	@Resource   DictPermissionService dictPermissionService;
	@Resource   LoginClientDao  loginClientDao;
	
	private Logger log = Logger.getLogger(MeetingViewServiceImpl.class);

	
	@Override
	public LoginUser loginSys(String username, String password) {
		LoginUser user=null;
		List<Map<String,Object>> permissionlist=new ArrayList<Map<String,Object>>();
		Map<String,Object> permissionMap=new HashMap<String,Object>();
		try {
			
			
			/**
			 * 
			 */
			Map<String,Object> maps=new java.util.HashMap<String,Object>();
			String passwordmd5=Md5Utils.MD5_32(password);
			
			maps.put("username", username);
			maps.put("passwd", passwordmd5);
			System.out.println("username"+username);
			System.out.println("passwd"+passwordmd5);
			
	    	user=loginClientDao.selectLoginSysUser(maps);
			//SysUserMainEnity entity = userService.selectEntityByName(username);
			
			if (user != null) {
						
				if(!user.getUsertype().trim().equals("1")){
						//获取所在的角色
						List<SysRoleUserEntity> list=roleUserService.selectByRuserid(user.getId());
						for(int i=0;i<list.size();i++){
							SysRoleUserEntity roleuser=list.get(i);
							int roleid=roleuser.getRoleid();
							//根据roleid获取权限
							List<SysRolePermissionEntity> list1=rolePermissionService.selectByRoleid(roleid);
							Map<String,Object> map=null;
							for(int t=0;t<list1.size();t++){
								String permissioncode=list1.get(t).getPermissioncode();
								DictPermissionEntity permission=dictPermissionService.selectByPermissionCode(permissioncode);
								map=new HashMap<String,Object>();
								map.put("moduleno", permission.getModuleno());
								map.put("modulename", permission.getModulename());
								map.put("operation", permission.getOperation());
								map.put("permissioncode", permission.getPersimoncode());
								permissionMap.put(permission.getModuleno().toString(), permission.getOperation());
								permissionlist.add(map);
								//System.out.println(permission.getModulename()+permission.getOperation());
							}
							
						}
				}
				
				//user
				user.setPermissionlist(permissionlist);
				user.setPermissionmap(permissionMap);
				if(log.isDebugEnabled()){
					log.debug("login user is:"+user.getUsername());
				}
				
			}
		} catch (Exception e) {
			e.printStackTrace();
			return user;
		}
		return user;
	}
	
	
	    //PAD端Login
	    @Override
		public LoginClientUser LoginClient(String padmobile,String password){
			Map<String,Object> map=new java.util.HashMap<String,Object>();
			String passwordmd5=Md5Utils.MD5_32(password);
			
			map.put("padmobile", padmobile);
			map.put("passwd", passwordmd5);
			System.out.println("padMobile1 is:"+padmobile);
			System.out.println("password1 is:"+password);
			System.out.println("passwordmd51 is:"+passwordmd5);
			
	    	LoginClientUser user=loginClientDao.selectLoginClientUser(map);
	    	return user;
		}
	public static void main(String[] args) {
		System.out.println(Md5Utils.MD5_32("admin"));
	}
}
