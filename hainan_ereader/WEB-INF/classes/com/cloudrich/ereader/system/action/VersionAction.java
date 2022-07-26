package com.cloudrich.ereader.system.action;

import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.cloudrich.ereader.common.action.BaseAction;
import com.cloudrich.ereader.system.entity.SysVersionMainEnity;
import com.cloudrich.ereader.system.service.VersionService;
import com.cloudrich.ereader.util.Md5GuidUtil;
import com.opensymphony.xwork2.ActionSupport;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.common.util.ValidateUtil;
@Controller("SysVersionAction")
@Scope("prototype")
public class VersionAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Resource
	private VersionService versionService;	
	
    private Page page;
    private int versionid;
    private String versionnum;
    private String filetype;
    private String filename;
    private Date createtime;
    private String path;
    private String apptype;
	private String upcontent;
	private File file;
	private int pageNo;
	private int pageSize=8;
	private long totalPage;

	private SysVersionMainEnity entity;

	public String selectVersionList(){
		Map<String,Object> map=new HashMap<String,Object>();
		if(ValidateUtil.isValid(versionnum)){
			map.put("versionnum", versionnum);
		}		
		if(ValidateUtil.isValid(filetype)){
			map.put("filetype", filetype);
		}
		page=versionService.selectByPage(pageNo, pageSize, map);
		System.out.println(page.getResult().size()+"  page.getResult().size()");
		totalPage=page.getPages();
		jsonSuccess("查询成功");
		return ActionSupport.SUCCESS;
	}
	public String updateVersion(){
		try {
			SysVersionMainEnity entity = new SysVersionMainEnity();
            entity.setIsdel("0");
            entity.setApptype("R");
            entity.setFilename(filename);
            entity.setFiletype(filetype);
            entity.setUpcontent(upcontent);
            entity.setId(versionid);
            entity.setVersionnum(versionnum);
			if(file!=null){
				String upFile = saveVersionUploadFile(file, filename,true);
				String uppath=upFile.substring(upFile.indexOf("fileVersion")).replace("\\", "/");
	            entity.setPath(uppath);
	            entity.setFileguid(Md5GuidUtil.getMd5Guid(file));
			}
			int id=versionService.update(entity);
			if(id>0){
				jsonSuccess("更新成功");
			}else{
				jsonError("更新失败");
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonResult("false","更新失败");
		}
		return ActionSupport.SUCCESS;
	}
	public String saveVersion(){
		try {
			String upFile = saveVersionUploadFile(file, filename,true);
			SysVersionMainEnity entity = new SysVersionMainEnity();
            entity.setIsdel("0");
            entity.setApptype("R");
            entity.setCreatetime(new Date());
            entity.setFilename(filename);
            entity.setFiletype(filetype);
            entity.setUpcontent(upcontent);
            entity.setVersionnum(versionnum);
            System.out.println(upFile);
			String uppath=upFile.substring(upFile.indexOf("fileVersion")).replace("\\", "/");
            entity.setPath(uppath);
            entity.setFileguid(Md5GuidUtil.getMd5Guid(file));
            System.out.println(entity.toString());
			int id=versionService.insert(entity);
			if(id>0){
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
	public String delete(){
		try {
			int line=versionService.delete(versionid);
			if(line>0){
				jsonSuccess("删除成功");
			}else{
				jsonError("删除失败");
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonError("删除失败");
		}
		return ActionSupport.SUCCESS;
	}
	public String selectById(){
		entity=versionService.selectEntityById(versionid);
		return ActionSupport.SUCCESS;
	}
	public VersionService getVersionService() {
		return versionService;
	}
	public void setVersionService(VersionService versionService) {
		this.versionService = versionService;
	}
	public Page getPage() {
		return page;
	}
	public void setPage(Page page) {
		this.page = page;
	}
	public int getVersionid() {
		return versionid;
	}
	public void setVersionid(int versionid) {
		this.versionid = versionid;
	}
	public String getVersionnum() {
		return versionnum;
	}
	public void setVersionnum(String versionnum) {
		this.versionnum = versionnum;
	}
	public String getFiletype() {
		return filetype;
	}
	public void setFiletype(String filetype) {
		this.filetype = filetype;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getApptype() {
		return apptype;
	}
	public void setApptype(String apptype) {
		this.apptype = apptype;
	}
	public String getUpcontent() {
		return upcontent;
	}
	public void setUpcontent(String upcontent) {
		this.upcontent = upcontent;
	}
	public File getFile() {
		return file;
	}
	public void setFile(File file) {
		this.file = file;
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
	public SysVersionMainEnity getEntity() {
		return entity;
	}
	public void setEntity(SysVersionMainEnity entity) {
		this.entity = entity;
	}
	
}
