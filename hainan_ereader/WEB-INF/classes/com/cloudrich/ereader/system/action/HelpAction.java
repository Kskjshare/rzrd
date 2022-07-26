package com.cloudrich.ereader.system.action;

import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.cloudrich.ereader.chuqueqin.entity.ChuqueqinMainEntity;
import com.cloudrich.ereader.common.action.BaseAction;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.dict.entity.DictPermissionEntity;
import com.cloudrich.ereader.system.entity.SysHelpMainEntity;
import com.cloudrich.ereader.system.entity.SysRoleMainEntity;
import com.cloudrich.ereader.system.entity.SysRolePermissionEntity;
import com.cloudrich.ereader.system.entity.SysRoleUserEntity;
import com.cloudrich.ereader.system.entity.SysUserMainEnity;
import com.cloudrich.ereader.system.service.HelpService;
import com.cloudrich.ereader.system.service.HelpServiceImpl;
import com.cloudrich.ereader.system.service.RolePermissionService;
import com.cloudrich.ereader.system.service.RoleService;
import com.cloudrich.ereader.system.service.RoleUserService;
import com.cloudrich.ereader.system.service.UserService;
import com.cloudrich.ereader.util.Md5GuidUtil;
import com.cloudrich.framework.util.Md5Utils;
import com.opensymphony.xwork2.ActionSupport;

@Controller("SysHelpAction")
@Scope("prototype")
public class HelpAction extends BaseAction{
	
	private static final long serialVersionUID = 1L;
	 
	@Resource
	private HelpService helpService;

	private Page page;
	private int pageNo;
	private int pageSize=8;
	private long totalPage;
    private File file;
    private String title;
    private String fileName;
    private String filetype;
    private int id;
    private SysHelpMainEntity entity;
    private String type;

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public SysHelpMainEntity getEntity() {
		return entity;
	}

	public void setEntity(SysHelpMainEntity entity) {
		this.entity = entity;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFiletype() {
		return filetype;
	}

	public void setFiletype(String filetype) {
		this.filetype = filetype;
	}

	public String selectAllHelpList(){
		Map<String,Object> map=new HashMap<String, Object>();
		if(!"".equals(type)&&type!=null){
			map.put("filetype", type);
		}
		page=helpService.selectByPage(pageNo, pageSize,map);
		totalPage=page.getPages();
		jsonSuccess("查询成功");
		return ActionSupport.SUCCESS;
	}
	public String selectErHelpList(){
		Map<String,Object> map=new HashMap<String, Object>();
		if(!"".equals(type)&&type!=null){
			map.put("filetype", type);
		}
		page=helpService.selectByPage(pageNo, pageSize,map);
		totalPage=page.getPages();
		jsonSuccess("查询成功");
		return ActionSupport.SUCCESS;
	}
	
	public String updateHelpInfo(){
		try {
			SysHelpMainEntity entity=new SysHelpMainEntity();
			if(file!=null&&fileName!=null&&!"".equals(fileName)){
				String upFile=saveUploadFile(file, fileName, true);
				entity.setFilename(fileName);
				String uppath=upFile.substring(upFile.indexOf("upload")).replace("\\", "/");
				entity.setFilepath(uppath);
				entity.setFileguid(Md5GuidUtil.getMd5Guid(new File(upFile)));
			}	
			    entity.setTitle(title);
				entity.setFiletype(filetype);
				entity.setId(id);
			int i=helpService.updateByPrimaryKey(entity);
            if(i!=0){
            	jsonSuccess("修改成功");
            }else{
            	jsonError("修改失败");
            }
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonError("新建失败");
		}
		return ActionSupport.SUCCESS;
	}
	
	public String saveHelpInfo(){
		try {
			String upFile=saveUploadFile(file, fileName, true);
			SysHelpMainEntity entity=new SysHelpMainEntity();
			entity.setTitle(title);
			entity.setFilename(fileName);
			String uppath=upFile.substring(upFile.indexOf("upload")).replace("\\", "/");
			entity.setFilepath(uppath);
			entity.setFiletype(filetype);
			entity.setFileguid(Md5GuidUtil.getMd5Guid(new File(upFile)));
			int i=helpService.insert(entity);
            if(i!=0){
            	jsonSuccess("新建成功");
            }else{
            	jsonError("新建失败");
            }
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonError("新建失败");
		}
		return ActionSupport.SUCCESS;
	}
	public String selectById(){
		entity=helpService.selectByPrimaryKey(id);
		return ActionSupport.SUCCESS;
	}	

	public String delete(){
		try {
			int line=helpService.deleteByPrimaryKey(id);
			if(line==0){
				jsonError("删除失败");
			}else{
				jsonSuccess("删除成功");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ActionSupport.SUCCESS;
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

}
