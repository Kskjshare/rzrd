package com.cloudrich.ereader.system.action;

import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.cloudrich.ereader.common.action.BaseAction;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.dict.entity.DictPermissionEntity;
import com.cloudrich.ereader.system.entity.SysRoleMainEntity;
import com.cloudrich.ereader.system.entity.SysRolePermissionEntity;
import com.cloudrich.ereader.system.entity.SysRoleUserEntity;
import com.cloudrich.ereader.system.entity.SysUserMainEnity;
import com.cloudrich.ereader.system.service.RolePermissionService;
import com.cloudrich.ereader.system.service.RoleService;
import com.cloudrich.ereader.system.service.RoleUserService;
import com.cloudrich.ereader.system.service.UserService;
import com.cloudrich.framework.util.Md5Utils;
import com.opensymphony.xwork2.ActionSupport;

@Controller("SysRoleAction")
@Scope("prototype")
public class RoleAction extends BaseAction{
	
	private static final long serialVersionUID = 1L;
	 
	@Resource
	private RoleService roleService;
	@Resource
	private UserService userService;
	@Resource
	private  RoleUserService roleUserService;
	@Resource
	private RolePermissionService rolePermissionService;
	private Page page;
	private int pageNo;
	private int pageSize=8;
	private long totalPage;
	private int roleid;
	private SysRoleMainEntity entity ;
	private List<SysUserMainEnity> list;
	private String rolename;
	private String des;
	private String[] usersid; 
	private int pageNoUser;
	private int pageSizeUser;
	private long totalPageUser;
    private Page pageUser;
    private List<DictPermissionEntity> permissionList;
    private String[] persimoncode;

	private Map<String ,Object> map;


	public String selectList(){
		permissionList=rolePermissionService.selectAllPermission();//权限集合
		page=roleService.selectByPage(pageNo, pageSize);
	    for (int i = 0; i <page.getResult().size(); i++) {
	    	SysRoleMainEntity mainentity=(SysRoleMainEntity)(page.getResult().get(i));
		}
		totalPage=page.getPages();
		jsonSuccess("查询成功");
		return ActionSupport.SUCCESS;
	}
	public String selectUserList(){
		pageUser=roleService.selectByPageUser(pageNoUser, pageSizeUser,roleid);
		totalPageUser=pageUser.getPages();
		jsonSuccess("查询成功");
		return ActionSupport.SUCCESS;
	}

	public String updateRole(){
		try {
		    SysRoleMainEntity role=new SysRoleMainEntity();
				role.setCreatetime(new Date());
				role.setIsdel(0);
				role.setDes(des);
				role.setRolename(rolename);
				role.setRoleid(roleid);
				int id=roleService.update(role);
				if(id>0){
					rolePermissionService.updateRolePermission(role.getRoleid(), persimoncode);	
				}
				jsonSuccess("更新成功");
		} catch (Exception e) {
				e.printStackTrace();
				jsonError("更新失败");
		}
			return ActionSupport.SUCCESS;
	}
	public String saveRole(){
		try {
		    SysRoleMainEntity role=new SysRoleMainEntity();
				role.setCreatetime(new Date());
				role.setIsdel(0);
				role.setDes(des);
				role.setRolename(rolename);
				int id=roleService.insert(role);
				if(persimoncode!=null&&persimoncode.length>0){
			        rolePermissionService.addRolePermission(role.getRoleid(), persimoncode);
				}
				jsonSuccess("新建成功");
		} catch (Exception e) {
				e.printStackTrace();
				jsonError("新建失败");
		}
			return ActionSupport.SUCCESS;
	}
	public String updateRoleUser(){
		try {
			SysRoleUserEntity userentity=new SysRoleUserEntity();
	   		if(usersid.length>0){
	   			roleUserService.deleteByRoleid(roleid);//角色权限表先删除再插入
				for (int i = 0; i < usersid.length; i++) {
					if(!"".equals(usersid[i])){
						userentity.setRoleid(roleid);
						userentity.setUserid(Integer.valueOf(usersid[i]));
						roleUserService.insert(userentity);
					}
			    }
	   		}
				jsonSuccess("修改成功");
		} catch (Exception e) {
				e.printStackTrace();
				jsonError("修改失败");
		}
			return ActionSupport.SUCCESS;
	}
	public String delete(){
		try {
			int line=roleService.delete(roleid);
			if(line==0){
				jsonError("删除失败");
			}else{
				rolePermissionService.deletePermissionByRoleid(roleid);
				jsonSuccess("删除成功");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ActionSupport.SUCCESS;
	}
	public String selectById(){
		SysRoleMainEntity roleentity=roleService.selectEntityById(roleid);
		List<SysRoleUserEntity> roleuserlist=roleUserService.selectByRoleid(roleid);
		Map<String,Object> usermap=new HashMap<String, Object>();
		usermap.put("usertype","2");
		List<SysUserMainEnity> userlist=userService.selectAll(usermap);
		if(roleuserlist.size()>0){
/*			for (int i = 0; i < roleuserlist.size(); i++) {
				for (int j = 0; j < userlist.size(); j++) {
					if( roleuserlist.get(i).getUserid()==userlist.get(j).getId()){
						userlist.remove(j);
					}
				}
			}*/
			Iterator<SysUserMainEnity> iter = userlist.iterator(); 
			while(iter.hasNext()){  
				SysUserMainEnity s = iter.next();
				for (int i = 0; i < roleuserlist.size(); i++) {
					if(roleuserlist.get(i).getUserid()==s.getId()){
						iter.remove();
					}
				}
			} 
		}
		List<SysRolePermissionEntity> rolePermission=rolePermissionService.selectByRoleid(roleid);
	    map=new HashMap<String, Object>();
		map.put("roleuserlist", roleuserlist);
		map.put("userlist", userlist);
		map.put("roleentity", roleentity);
		map.put("rolePermission", rolePermission);
		return ActionSupport.SUCCESS;
	}
	
    public RoleService getRoleService() {
		return roleService;
	}
	public void setRoleService(RoleService roleService) {
		this.roleService = roleService;
	}
	public Page getPage() {
		return page;
	}
	public void setPage(Page page) {
		this.page = page;
	}
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public long getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(long totalPage) {
		this.totalPage = totalPage;
	}
	public int getRoleid() {
		return roleid;
	}
	public void setRoleid(int roleid) {
		this.roleid = roleid;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public List<SysUserMainEnity> getList() {
		return list;
	}
	public void setList(List<SysUserMainEnity> list) {
		this.list = list;
	}
	public SysRoleMainEntity getEntity() {
		return entity;
	}
	public void setEntity(SysRoleMainEntity entity) {
		this.entity = entity;
	}
	public String getRolename() {
		return rolename;
	}
	public void setRolename(String rolename) {
		this.rolename = rolename;
	}
	public String getDes() {
		return des;
	}
	public void setDes(String des) {
		this.des = des;
	}
	public Map<String, Object> getMap() {
		return map;
	}
	public void setMap(Map<String, Object> map) {
		this.map = map;
	}
    public String[] getUsersid() {
		return usersid;
	}
	public void setUsersid(String[] usersid) {
		this.usersid = usersid;
	}
	public int getPageNoUser() {
		return pageNoUser;
	}
	public void setPageNoUser(int pageNoUser) {
		this.pageNoUser = pageNoUser;
	}
	public int getPageSizeUser() {
		return pageSizeUser;
	}
	public void setPageSizeUser(int pageSizeUser) {
		this.pageSizeUser = pageSizeUser;
	}
	public long getTotalPageUser() {
		return totalPageUser;
	}
	public void setTotalPageUser(long totalPageUser) {
		this.totalPageUser = totalPageUser;
	}
	public Page getPageUser() {
		return pageUser;
	}
	public void setPageUser(Page pageUser) {
		this.pageUser = pageUser;
	}
	public List<DictPermissionEntity> getPermissionList() {
		return permissionList;
	}
	public void setPermissionList(List<DictPermissionEntity> permissionList) {
		this.permissionList = permissionList;
	}
	public String[] getPersimoncode() {
		return persimoncode;
	}
	public void setPersimoncode(String[] persimoncode) {
		this.persimoncode = persimoncode;
	}
}
