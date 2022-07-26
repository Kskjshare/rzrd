package com.cloudrich.ereader.tongxunlun.action;

import java.io.File;
import java.io.FileInputStream;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;

import com.cloudrich.ereader.common.action.BaseAction;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.dict.entity.DictDataEntity;
import com.cloudrich.ereader.dict.service.DictDataService;
import com.cloudrich.ereader.system.entity.SysScopeMainEntity;
import com.cloudrich.ereader.system.service.ScopeMainService;
import com.cloudrich.ereader.tongxunlun.entity.TongxunluMainEntity;
import com.cloudrich.ereader.tongxunlun.entity.TongxunluPermissionEntity;
import com.cloudrich.ereader.tongxunlun.entity.TongxunluPubEntity;
import com.cloudrich.ereader.tongxunlun.service.TongxunluService;
import com.cloudrich.ereader.util.DoWorkUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller("TongxunlunAction")
public class TongxunlunAction extends BaseAction{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Resource TongxunluService tongxunluService;
	@Resource DictDataService dictDataService;
	@Resource ScopeMainService scopeMainService;
	
	private TongxunluMainEntity entity;
	private Page page;
	private int pageNo=1;
	private int pageSize=8;
	private long totalPage;
	private int id;
	private String dept;
	private String jobtitle;
	private String phoneOffice;
	private String phoneHome;
	private String mobile;
	private String mail;
	private String comment;
	private int compCode=1;
	private String name="";//名字
	private List<TongxunluMainEntity> entityList;
	private List<DictDataEntity> dicList;
	private File file;
	private String pushflag;
	private Date Pubtime;
	private String txlids;
	private String[] scopeid;
	public Date getPubtime() {
		return Pubtime;
	}

	public void setPubtime(Date pubtime) {
		Pubtime = pubtime;
	}

	public String getPushflag() {
		return pushflag;
	}

	public void setPushflag(String pushflag) {
		this.pushflag = pushflag;
	}

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public String selectComp(){
		page = tongxunluService.selectByPage(pageNo, pageSize,name);
		totalPage=page.getPages();
		TongxunluPubEntity entity=tongxunluService.selectPubtime();
		if(entity!=null)
		Pubtime=entity.getPubtime();
		jsonSuccess("listTongxunlun");		
		return SUCCESS;
	}
	
	public String select(){
		page = tongxunluService.selectByPage(pageNo, pageSize,name);
		totalPage=page.getPages();
		TongxunluPubEntity entity=tongxunluService.selectPubtime();
		if(entity!=null)
		Pubtime=entity.getPubtime();
		jsonSuccess("listTongxunlun");
		return SUCCESS;
	}
	
	public String deleteById() {
		tongxunluService.delete(id);
		return SUCCESS;
	}
	
	public String deleteAll() {
		tongxunluService.deleteAll(txlids);
		return SUCCESS;
	}
	
	public String update(){
		tongxunluService.update(entity);
		jsonSuccess("update");
		return SUCCESS;
	}
	
	public String selectById(){
		entity=tongxunluService.selectEntityById(id);
		return SUCCESS;
	}
	public String add(){
		tongxunluService.insert(entity);
		jsonSuccess("add");
		return SUCCESS;
	}
	public String addPush(){
		try {
			tongxunluService.insertPush();
			jsonSuccess("发布成功");
		} catch (Exception e) {
			e.printStackTrace();
			jsonError("发布失败");
		}
		return SUCCESS;
	}
	
	//导入通讯录 
	public String autoImportUser(){
		try {
			System.out.println("*****************------------------------------************************");
			System.out.println(file);
			HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(file));	
			HSSFSheet sheet = wb.getSheetAt(0);
			Map<String,String> content=DoWorkUtil.getInfoInHSSF(1,sheet,10);
				int totalRowNums=Integer.parseInt(content.get("totalRowNums"));//行数
				int totalColNums=Integer.parseInt(content.get("totalColNums"));//列数
				for (int i = 1; i <=totalRowNums-1; i++) {
					TongxunluMainEntity entity=new TongxunluMainEntity();
						entity.setName(content.get(i+"-"+0));//姓名
						entity.setCompCode(getCodeByName(content.get(i+"-"+1)));//分组
						int sort=Integer.parseInt(content.get(i+"-"+2));
						if(content.get(i+"-"+2).indexOf(".")>-1){
							sort=Integer.parseInt(content.get(i+"-"+2).substring(0,content.get(i+"-"+2).indexOf(".")));
						}
						entity.setSort(sort);//排序
						entity.setDept(content.get(i+"-"+3));//单位
						entity.setJobtitle(content.get(i+"-"+4));//职务
						String phoneOffice=content.get(i+"-"+5);
						if(content.get(i+"-"+5).indexOf(".")>-1){
							 phoneOffice=new BigDecimal(content.get(i+"-"+5)).toPlainString();

						}
						String phoneHome=content.get(i+"-"+6);
						if(content.get(i+"-"+6).indexOf(".")>-1){
							phoneHome=new BigDecimal(content.get(i+"-"+6)).toPlainString();
							
						}
						String mobile=content.get(i+"-"+7);
						if(content.get(i+"-"+7).indexOf(".")>-1){
							mobile=new BigDecimal(content.get(i+"-"+7)).toPlainString();	
						}
						entity.setPhoneOffice(phoneOffice);//办公电话
						entity.setPhoneHome(phoneHome);//住宅电话
						entity.setMobile(mobile);//手机
						entity.setMail(content.get(i+"-"+8));//邮箱
						if("是".equals(content.get(i+"-"+9))){
							entity.setComment("0");//加粗
						}else{
							entity.setComment("1");
						}
						
						entity.setIsdel(0);
						tongxunluService.insert(entity);
			}			
			jsonSuccess("导入成功");
		} catch (Exception e) {
			e.printStackTrace();
			jsonError("导入失败");
		}

		return SUCCESS;
	}
	
	public int getCodeByName(String name){
		List<DictDataEntity> list=dictDataService.getDictDataByType("compcode");
		if(name!=null&&!"".equals(name)){
			for (int i = 0; i <list.size(); i++) {
				if(list.get(i).getName().trim().equals(name.trim())){
					return Integer.parseInt(list.get(i).getCode());
				}
			}
			if(name.trim().equals("省人大常委会")){
				    return 1;
			}
		}

		return 0;
	}
	public void selectTxlPermission(){
		JSONObject permit=new JSONObject();
		List<SysScopeMainEntity> list=scopeMainService.selectAll();
		List<TongxunluPermissionEntity>  permitlist=tongxunluService.selectAllPermission();
		if(permitlist.size()>0){
			Iterator<SysScopeMainEntity> iter = list.iterator(); 
			while(iter.hasNext()){  
				SysScopeMainEntity s = iter.next();  
				for (int j = 0; j < permitlist.size(); j++) {
					if(permitlist.get(j).getScopeid()==s.getScopeid()){
						iter.remove();
	
					}
				} 
			} 
		}
		permit.put("list", list);
		permit.put("permitlist", permitlist);
	    outJsonString(permit);;
	}
	public void savePermission(){
		tongxunluService.deleteAllPermission();
		TongxunluPermissionEntity entity=new TongxunluPermissionEntity();
		for (int i = 0; i < scopeid.length; i++) {
			entity=new TongxunluPermissionEntity();
			entity.setScopeid(Integer.parseInt(scopeid[i]));
			tongxunluService.savePermission(entity);
		}
	}
	public List<TongxunluMainEntity> getEntityList() {
		return entityList;
	}

	public void setEntityList(List<TongxunluMainEntity> entityList) {
		this.entityList = entityList;
	}
	
	public List<DictDataEntity> getDicList() {
		return dicList;
	}

	public void setDicList(List<DictDataEntity> dicList) {
		this.dicList = dicList;
	}

	public int getCompCode() {
		return compCode;
	}

	public void setCompCode(int compCode) {
		this.compCode = compCode;
	}

	public TongxunluMainEntity getEntity() {
		return entity;
	}

	public void setEntity(TongxunluMainEntity entity) {
		this.entity = entity;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	public String getDept() {
		return dept;
	}

	public void setDept(String dept) {
		this.dept = dept;
	}

	public String getJobtitle() {
		return jobtitle;
	}

	public void setJobtitle(String jobtitle) {
		this.jobtitle = jobtitle;
	}

	public String getPhoneOffice() {
		return phoneOffice;
	}

	public void setPhoneOffice(String phoneOffice) {
		this.phoneOffice = phoneOffice;
	}

	public String getPhoneHome() {
		return phoneHome;
	}

	public void setPhoneHome(String phoneHome) {
		this.phoneHome = phoneHome;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getMail() {
		return mail;
	}

	public void setMail(String mail) {
		this.mail = mail;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getTxlids() {
		return txlids;
	}

	public void setTxlids(String txlids) {
		this.txlids = txlids;
	}

	public String[] getScopeid() {
		return scopeid;
	}
	
    
	public void setScopeid(String[] scopeid) {
		this.scopeid = scopeid;
	}
	
}
