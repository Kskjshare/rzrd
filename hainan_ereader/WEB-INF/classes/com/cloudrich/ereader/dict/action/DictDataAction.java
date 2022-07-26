package com.cloudrich.ereader.dict.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.cloudrich.ereader.common.action.BaseAction;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.dict.entity.DictDataEntity;
import com.cloudrich.ereader.dict.service.DictDataService;
import com.cloudrich.ereader.system.entity.SysRoleMainEntity;
import com.cloudrich.ereader.system.entity.SysRolePermissionEntity;
import com.cloudrich.ereader.system.entity.SysRoleUserEntity;
import com.cloudrich.ereader.system.entity.SysUserMainEnity;

import com.opensymphony.xwork2.ActionSupport;


@Controller("DictDataAction")
public class DictDataAction extends BaseAction{
	@Resource DictDataService dictDataService;

	private static final long serialVersionUID = 1L;

    private Page page;
	private int pageNo;
	private int pageSize=8;
	private long totalPage;
    private String type;
    private List<DictDataEntity> typelist;
    private DictDataEntity entity;
    private int id;
    private DictDataEntity selectentity;
    private String code;
    
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public DictDataEntity getSelectentity() {
		return selectentity;
	}
	public void setSelectentity(DictDataEntity selectentity) {
		this.selectentity = selectentity;
	}
	public DictDataEntity getEntity() {
		return entity;
	}
	public void setEntity(DictDataEntity entity) {
		this.entity = entity;
	}
	public String selectList(){
		Map<String,Object> map=new HashMap<String,Object>();
		if(type!=null&&!"".equals(type)){
			map.put("type", type);
		}
		typelist=dictDataService.getAllDictDataType();
		page=dictDataService.selectByPage(pageNo, pageSize, map);
		totalPage=page.getPages();
		jsonSuccess("查询成功");
		return ActionSupport.SUCCESS;
	}
	public String updateDictData(){
		try {
			entity.setIsactive("Y");
			entity.setId(id);
			int id=dictDataService.updateByPrimaryKey(entity);
			if(id>0){
				jsonSuccess("更新成功");
			}else{
				jsonError("更新失败");
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonResult("false","更新失败");
		}
		entity=new DictDataEntity();
		return ActionSupport.SUCCESS;
	}
	public String checkdictdaratype(){
		DictDataEntity dict=dictDataService.getDictByTypeAndcode(type,code);
		System.out.println(dict.getType()+":::"+dict.getTypename());
		if(dict==null){
			jsonError("0");
		}else{
			jsonSuccess("1");
		}
		return ActionSupport.SUCCESS;
	}
	public String saveDictData(){
		try { 
			entity.setIsactive("Y");
			entity.setIsshow("0");
			System.out.println(entity.getId());
			dictDataService.insert(entity);
			jsonSuccess("新建成功");
		} catch (Exception e) {
			e.printStackTrace();
			jsonError("新建失败");
		}
		return ActionSupport.SUCCESS;
	}
	public String selectById(){
		selectentity=dictDataService.getDictDataById(id);
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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	public List<DictDataEntity> getTypelist() {
		return typelist;
	}

	public void setTypelist(List<DictDataEntity> typelist) {
		this.typelist = typelist;
	}

}
