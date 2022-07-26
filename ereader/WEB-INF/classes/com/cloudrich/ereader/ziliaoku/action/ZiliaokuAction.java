package com.cloudrich.ereader.ziliaoku.action;

import java.io.File;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.cloudrich.ereader.common.action.BaseAction;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.util.Md5GuidUtil;
import com.cloudrich.ereader.ziliaoku.entity.ZiliaokuMainEntity;
import com.cloudrich.ereader.ziliaoku.entity.ZiliaokuTypeEntity;
import com.cloudrich.ereader.ziliaoku.service.ZiliaokuMainService;
import com.cloudrich.ereader.ziliaoku.service.ZiliaokuTypeService;

@Controller("ZiliaokuAction")
public class ZiliaokuAction extends BaseAction{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Resource ZiliaokuTypeService ziliaokuTypeService;
	@Resource ZiliaokuMainService ziliaokuMainService;
	
	private Page page;
	private int pageNo=1;
	private int pageSize=8;
	private long totalPage;
	private ZiliaokuMainEntity entity;
	private ZiliaokuTypeEntity typeEntity;
	private ZiliaokuTypeEntity ftypeEntity;
	private ZiliaokuTypeEntity stypeEntity;
	private List<ZiliaokuTypeEntity> firstList;
	private List<ZiliaokuTypeEntity> secondList;
	private int typeid;
	private String searchName="";
	private List<ZiliaokuTypeEntity> typeList;
	private File file;
	private String fileName;
	private String ziliaoName;
	private int ziliaoid;
	private String firstName;
	private String secondName;
	private int flag;
	private int ptypeid;
	private String filePath;
	
	public String selectFirstType() {
		System.out.println("一级分类");
		firstList=ziliaokuTypeService.selectFirstType();
		jsonSuccess("listFirstType");
		return SUCCESS;
	}
	
	public String selectSecondType(){
		System.out.println("二级分类:typeid:"+typeid);
		ftypeEntity=ziliaokuTypeService.selectTypeById(typeid);
		secondList=ziliaokuTypeService.selectSecondType(typeid);
		jsonSuccess("listSecondType");
		return SUCCESS;
	}
	
	public String select(){
		stypeEntity=ziliaokuTypeService.selectTypeById(typeid);
		entity=new ZiliaokuMainEntity();
		entity.setTypeid(typeid);
		entity.setName(searchName);
		System.out.println(pageNo+","+ pageSize+","+entity);
		page=ziliaokuMainService.select(pageNo, pageSize, entity);
		totalPage=page.getPages();
		jsonSuccess("listZiliao");
		return SUCCESS;
	}
	
	public String selectType(){
		typeList=ziliaokuTypeService.selectType();
		jsonSuccess("typeList");
		return SUCCESS;
	}
	
	public String upload() throws Exception{
		entity=new ZiliaokuMainEntity();
		if (file!=null) {
			String upFile = saveUploadFile(file, filePath,true);
			File tempFile =new File(upFile.trim());  
	        String ftName = tempFile.getName();
	        String uppath="upload/"+ftName;
			entity.setPath(uppath);
			entity.setFileguid(Md5GuidUtil.getMd5Guid(new File(upFile)));
		}
		entity.setName(ziliaoName);
		entity.setFilename(fileName);
		entity.setCreatetime(new Date());
		entity.setTypeid(typeid);
		entity.setIsdel(0);
		ziliaokuMainService.upload(entity);
		return SUCCESS;
	}
	
	public String selectById() {
		System.out.println(ziliaoid);
		entity=ziliaokuMainService.selectById(ziliaoid);
		return SUCCESS;
	}
	
	public String update(){
		System.out.println("修改id:"+ziliaoid);
		entity=new ZiliaokuMainEntity();
		if (file!=null) {
			String upFile = saveUploadFile(file, filePath,true);
			File tempFile =new File(upFile.trim());  
	        String ftName = tempFile.getName();
	        String uppath="upload/"+ftName;
	        entity.setPath(uppath);
	        entity.setFileguid(Md5GuidUtil.getMd5Guid(new File(upFile)));
		}
		entity.setZiliaoid(ziliaoid);
		entity.setName(ziliaoName);
		entity.setFilename(fileName);
		entity.setCreatetime(new Date());
		entity.setTypeid(typeid);
		entity.setIsdel(0);
		ziliaokuMainService.update(entity);
		return SUCCESS;
	}
	public String delete(){
		System.out.println(ziliaoid);
		ziliaokuMainService.delete(ziliaoid);
		return SUCCESS;
	}
	
	public String addType(){
		typeEntity=new ZiliaokuTypeEntity();
		typeEntity.setName(firstName);
		typeEntity.setIsdel(0);
		typeEntity.setPtypeid(0);
		ziliaokuTypeService.addFirstType(typeEntity);
		return SUCCESS;
	}
	
	public String addSecondType(){
		typeEntity=new ZiliaokuTypeEntity();
		typeEntity.setPtypeid(ptypeid);
		typeEntity.setName(secondName);
		typeEntity.setIsdel(0);
		ziliaokuTypeService.addSecondType(typeEntity);
		return SUCCESS;
	}
	
	public String selectTypeById(){
		typeEntity=ziliaokuTypeService.selectTypeById(typeid);
		return SUCCESS;
	}
	
	public String updateType(){
		typeEntity=new ZiliaokuTypeEntity();
		typeEntity.setTypeid(typeid);
		if (flag==2) {//更新二级分类
			System.out.println(secondName);
			typeEntity.setName(secondName);			
		}else {//更新一级分类
			System.out.println(firstName);
			typeEntity.setName(firstName);		
		}
		typeEntity.setIsdel(0);
		ziliaokuTypeService.updateType(typeEntity);
		return SUCCESS;
	}
	
	public String deleteType(){
		System.out.println("删除typeid:"+typeid);
		if (flag==2) {
			ziliaokuTypeService.deleteType(typeid);
		}else{
			ziliaokuTypeService.deleteType(typeid);
			List<ZiliaokuTypeEntity> sList=ziliaokuTypeService.selectSecondType(typeid);
			for (ZiliaokuTypeEntity e : sList) {
				ziliaokuTypeService.deleteType(e.getTypeid());
			}
		}
		return SUCCESS;
	}
	
	
	

	public ZiliaokuTypeEntity getFtypeEntity() {
		return ftypeEntity;
	}

	public void setFtypeEntity(ZiliaokuTypeEntity ftypeEntity) {
		this.ftypeEntity = ftypeEntity;
	}

	public ZiliaokuTypeEntity getStypeEntity() {
		return stypeEntity;
	}

	public void setStypeEntity(ZiliaokuTypeEntity stypeEntity) {
		this.stypeEntity = stypeEntity;
	}

	public ZiliaokuTypeEntity getTypeEntity() {
		return typeEntity;
	}

	public void setTypeEntity(ZiliaokuTypeEntity typeEntity) {
		this.typeEntity = typeEntity;
	}
	
	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public int getPtypeid() {
		return ptypeid;
	}

	public void setPtypeid(int ptypeid) {
		this.ptypeid = ptypeid;
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getSecondName() {
		return secondName;
	}

	public void setSecondName(String secondName) {
		this.secondName = secondName;
	}

	public File getFile() {
		return file;
	}
	
	public int getZiliaoid() {
		return ziliaoid;
	}

	public void setZiliaoid(int ziliaoid) {
		this.ziliaoid = ziliaoid;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getZiliaoName() {
		return ziliaoName;
	}

	public void setZiliaoName(String ziliaoName) {
		this.ziliaoName = ziliaoName;
	}

	public List<ZiliaokuTypeEntity> getFirstList() {
		return firstList;
	}

	public void setFirstList(List<ZiliaokuTypeEntity> firstList) {
		this.firstList = firstList;
	}

	public List<ZiliaokuTypeEntity> getSecondList() {
		return secondList;
	}

	public void setSecondList(List<ZiliaokuTypeEntity> secondList) {
		this.secondList = secondList;
	}

	public List<ZiliaokuTypeEntity> getTypeList() {
		return typeList;
	}

	public void setTypeList(List<ZiliaokuTypeEntity> typeList) {
		this.typeList = typeList;
	}

	public String getSearchName() {
		return searchName;
	}

	public void setSearchName(String searchName) {
		this.searchName = searchName;
	}

	public ZiliaokuMainEntity getEntity() {
		return entity;
	}

	public void setEntity(ZiliaokuMainEntity entity) {
		this.entity = entity;
	}

	public int getTypeid() {
		return typeid;
	}

	public void setTypeid(int typeid) {
		this.typeid = typeid;
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
