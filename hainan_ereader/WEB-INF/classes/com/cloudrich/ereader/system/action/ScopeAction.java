package com.cloudrich.ereader.system.action;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.cloudrich.ereader.common.action.BaseAction;
import com.cloudrich.ereader.system.entity.SysScopeMainEntity;
import com.cloudrich.ereader.system.entity.SysScopeUserEntity;
import com.cloudrich.ereader.system.service.ScopeMainService;
import com.cloudrich.ereader.system.service.ScopeUserService;
import com.cloudrich.ereader.system.service.UserService;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.opensymphony.xwork2.ActionSupport;
import com.cloudrich.ereader.system.entity.SysUserMainEnity;
@Controller("SysScopeAction")
@Scope("prototype")
public class ScopeAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String scopename;
	private int pageNo;
	private int pageSize=8;
	private long totalPage;
	private int scopeid;
	private Page page;
	private String des;
	private List<SysUserMainEnity> list;
    private String[] usersid;
    private SysScopeMainEntity entity;
    private Map<String,Object> map;
	private Page pageUser;
	private long  totalPageUser;
	private int pageNoUser;
	private int pageSizeUser=4;
	private List<SysScopeUserEntity> scopelist;

	@Resource
	private ScopeMainService scopeMainService;
	@Resource
	private UserService userService;
	@Resource
	private ScopeUserService scopeUserService;
	
	public String selectList(){
		list=userService.selectAllPadUser();
		page=scopeMainService.selectByPage(pageNo, pageSize);
		totalPage=page.getPages();
		jsonSuccess("查询成功");
		return ActionSupport.SUCCESS;
	}
	public String selectUserList(){
		//pageUser=scopeMainService.selectByPageUser(pageNoUser, pageSizeUser,scopeid);
		//totalPageUser=pageUser.getPages();
	    scopelist=scopeMainService.selectByScopeId(scopeid);
		jsonSuccess("查询成功");
		return ActionSupport.SUCCESS;
	}

	public String updateScope(){
		try {
		    SysScopeMainEntity scope=new SysScopeMainEntity();
		    	scope.setDes(des);
		    	scope.setScopename(scopename);
		    	scope.setScopeid(scopeid);
		    int a=scopeMainService.updateByPrimaryKey(scope);
		    SysScopeUserEntity userentity=new SysScopeUserEntity();
		    scopeUserService.deleteByScopeId(scopeid);
		    if(a>0&&usersid.length>0){
		    	for (int i = 0; i < usersid.length; i++) {
		    		if(!"".equals(usersid[i])){
		    		userentity.setScopeid(scope.getScopeid());
		    		userentity.setUserid(Integer.valueOf(usersid[i]));
		    		scopeUserService.insert(userentity);//向范围组表加用户
		    		}
				}
		    	
		    }
				jsonSuccess("新建成功");
		} catch (Exception e) {
				e.printStackTrace();
				jsonError("新建失败");
		}
			return ActionSupport.SUCCESS;
	}
	public String saveScope(){
		try {
		    SysScopeMainEntity scope=new SysScopeMainEntity();
		    	scope.setDes(des);
		    	scope.setScopename(scopename);
		    int a=scopeMainService.insert(scope);
		    SysScopeUserEntity userentity=new SysScopeUserEntity();
		    if(a>0&&usersid.length>0){
		    	for (int i = 0; i < usersid.length; i++) {
		    		userentity.setScopeid(scope.getScopeid());
		    		if(!usersid[i].equals("")){
		    		userentity.setUserid(Integer.valueOf(usersid[i]));
		    		scopeUserService.insert(userentity);//向范围组表加用户
		    		}
				}
		    	
		    }
				jsonSuccess("新建成功");
		} catch (Exception e) {
				e.printStackTrace();
				jsonError("新建失败");
		}
			return ActionSupport.SUCCESS;
	}
	
	public String delete(){
		try {
			int line=scopeMainService.delete(scopeid);
			if(line==0){
				jsonError("删除失败");
			}else{
				scopeUserService.deleteByScopeId(scopeid);
				jsonSuccess("删除成功");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ActionSupport.SUCCESS;
	}
	public String selectById(){
		SysScopeMainEntity scopeentity=scopeMainService.selectEntityById(scopeid);
		List<SysScopeUserEntity> suesrlist=scopeUserService.selectByScopeId(scopeid);
		List<SysUserMainEnity> userlist=userService.selectAllPadUser();
		if(userlist.size()>0){
/*			for (int i = 0; i < suesrlist.size(); i++) {
				for (int j = 0; j < userlist.size(); j++) {
					if(suesrlist.get(i).getUserid()==userlist.get(j).getId()){
						userlist.remove(j);
					}
				}
			}*/
			Iterator<SysUserMainEnity> iter = userlist.iterator(); 
			while(iter.hasNext()){  
				SysUserMainEnity s = iter.next();
				for (int i = 0; i < suesrlist.size(); i++) {
					if(suesrlist.get(i).getUserid()==s.getId()){
						iter.remove();
					}
				}
			} 			
		}
		map=new HashMap<String, Object>();
		map.put("entity", scopeentity);
		map.put("suserlist", suesrlist);
		map.put("userlist", userlist);
		return ActionSupport.SUCCESS;
	}
    
	public List<SysScopeUserEntity> getScopelist() {
		return scopelist;
	}
	public void setScopelist(List<SysScopeUserEntity> scopelist) {
		this.scopelist = scopelist;
	}
    public ScopeMainService getScopeMainService() {
		return scopeMainService;
	}
	public void setScopeMainService(ScopeMainService scopeMainService) {
		this.scopeMainService = scopeMainService;
	}
	public Page getPage() {
		return page;
	}
	public void setPage(Page page) {
		this.page = page;
	}
	public String getScopename() {
		return scopename;
	}
	public void setScopename(String scopename) {
		this.scopename = scopename;
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
	public int getScopeid() {
		return scopeid;
	}
	public void setScopeid(int scopeid) {
		this.scopeid = scopeid;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getDes() {
		return des;
	}
	public void setDes(String des) {
		this.des = des;
	}
	public List<SysUserMainEnity> getList() {
		return list;
	}
	public void setList(List<SysUserMainEnity> list) {
		this.list = list;
	}
	public String[] getUsersid() {
		return usersid;
	}
	public void setUsersid(String[] usersid) {
		this.usersid = usersid;
	}
	public Map<String, Object> getMap() {
		return map;
	}
	public void setMap(Map<String, Object> map) {
		this.map = map;
	}
	public SysScopeMainEntity getEntity() {
		return entity;
	}
	public void setEntity(SysScopeMainEntity entity) {
		this.entity = entity;
	}
	public Page getPageUser() {
		return pageUser;
	}
	public void setPageUser(Page pageUser) {
		this.pageUser = pageUser;
	}
	public long getTotalPageUser() {
		return totalPageUser;
	}
	public void setTotalPageUser(long totalPageUser) {
		this.totalPageUser = totalPageUser;
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
}
