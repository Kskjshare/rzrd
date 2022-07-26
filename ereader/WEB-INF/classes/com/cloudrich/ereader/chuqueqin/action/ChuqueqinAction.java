package com.cloudrich.ereader.chuqueqin.action;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.cloudrich.ereader.chuqueqin.entity.BookMarkerVO;
import com.cloudrich.ereader.chuqueqin.entity.ChuqueqinMainEntity;
import com.cloudrich.ereader.chuqueqin.entity.ChuqueqinPubEntity;
import com.cloudrich.ereader.chuqueqin.service.ChuqueqinService;
import com.cloudrich.ereader.common.action.BaseAction;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.common.util.ValidateUtil;
import com.cloudrich.ereader.dict.entity.DictDataEntity;
import com.cloudrich.ereader.dict.service.DictDataService;
import com.cloudrich.ereader.meeting.entity.MeetMainEntity;
import com.cloudrich.ereader.meeting.service.MeetingViewService;
import com.cloudrich.ereader.pdf.SingleOpenOfficeDemo;
import com.cloudrich.ereader.util.Md5GuidUtil;
import com.opensymphony.xwork2.ActionSupport;


@Controller("AbsenceAction")
@Scope("prototype")
public class ChuqueqinAction extends BaseAction{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Resource ChuqueqinService leaveService;
	@Resource MeetingViewService meetingViewService;
	@Resource DictDataService dictDataService;
	
	private Integer absentid;
	private String path;
	private File file;
	private String fileName;
	private String title;
	private Page page;
	private int pageNo;
	private int pageSize=8;
	private long totalPage;
    private ChuqueqinMainEntity entity;
    private String pushflag;
    private String meetingname,fname,truename;
    private List<ChuqueqinMainEntity> meetinglist;
    private Map<DictDataEntity,List<MeetMainEntity>> mapD;
    private List<DictDataEntity> dictList;
	public String selectList(){
		Map<String,Object> map=new HashMap<String,Object>();
		if(title!=null&&!"".equals(title)){
			map.put("title", title);
		}
		page=leaveService.selectByPage(pageNo, pageSize, map);
		List<ChuqueqinMainEntity> list=page.getResult();
		for (int i = 0; i < list.size(); i++) {
			ChuqueqinPubEntity pubentity=leaveService.selectLatestPubtime(list.get(i).getAbsentid());
			if(pubentity!=null){
				list.get(i).setPushdate(pubentity.getPubtime());
			}
		}
		page.setResult(list);
		totalPage=page.getPages();
		jsonSuccess("查询成功");
		return ActionSupport.SUCCESS;
	}
	public String selectBM(){
		Map<String,Object> map=new HashMap<String,Object>();
		if(ValidateUtil.isValid(fname)){
			map.put("fname", fname);
		}
		if(ValidateUtil.isValid(meetingname)){
			map.put("meetingname", meetingname);
		}
		if(ValidateUtil.isValid(truename)){
			map.put("truename", truename);
		}
		System.out.println("map:"+mapD);
		meetinglist=leaveService.selectBookMeeting();
//		if(meetinglist!=null&&meetinglist.size()>0){
//			ChuqueqinMainEntity e=new ChuqueqinMainEntity();
//			e.setTitle("");
//			meetinglist.add(0, e);
//		}
		for(int i=0;i<meetinglist.size();i++){
			String mn=meetinglist.get(i).getTitle();
			if(mn.equals(meetingname)){
				meetinglist.set(0,meetinglist.set(i, meetinglist.get(0)));
			}
		}
		System.out.println("meetinglist:"+meetinglist.toString());
		System.out.println(pageSize+","+pageNo);
		page=leaveService.selectBm(pageNo, pageSize, map);
		totalPage=page.getPages();
		System.out.println("page:"+page.getResult());
		jsonSuccess("listAbesnceSearch");
		return ActionSupport.SUCCESS;
	}
	public String selectSearch(){
		Map<String,Object> map=new HashMap<String,Object>();
		if(title!=null&&!"".equals(title)){
			map.put("title", title);
		}
		page=leaveService.selectByPage(pageNo, pageSize, map);
		List<ChuqueqinMainEntity> list=page.getResult();
		for (int i = 0; i < list.size(); i++) {
			ChuqueqinPubEntity pubentity=leaveService.selectLatestPubtime(list.get(i).getAbsentid());
			if(pubentity!=null){
				list.get(i).setPushdate(pubentity.getPubtime());
			}
		}
		page.setResult(list);
		totalPage=page.getPages();
		jsonSuccess("listAbesnceSearch");
		return ActionSupport.SUCCESS;
	}
	public String updateAbsence(){
		try {
			ChuqueqinMainEntity chuqueqinMainEntity=new ChuqueqinMainEntity();
			if(file!=null&&fileName!=null&&!"".equals(fileName)){
				String upFile=saveUploadFile(file, fileName, true);
				String uppath=upFile.substring(upFile.indexOf("upload")).replace("\\", "/");
				chuqueqinMainEntity.setPath(uppath);
				chuqueqinMainEntity.setFilename(fileName);
				chuqueqinMainEntity.setFileguid(Md5GuidUtil.getMd5Guid(file));
			}
			chuqueqinMainEntity.setPubtime(new Date());
			chuqueqinMainEntity.setAbsentid(absentid);
			chuqueqinMainEntity.setTitle(title);
			chuqueqinMainEntity.setIsdel(0);//0代表未删除
			if(getCurrentUser()==null){
				chuqueqinMainEntity.setPubuserid(0);
			}else{
				chuqueqinMainEntity.setPubuserid(getCurrentUser().getId());
			}
			int id=leaveService.update(chuqueqinMainEntity);
			if("1".equals(pushflag)){
				chuqueqinMainEntity=leaveService.selectEntityById(chuqueqinMainEntity.getAbsentid());
				int i=leaveService.insertAndPush(chuqueqinMainEntity);
				if(i>0){
					jsonSuccess("发布成功");
				}else{
					jsonSuccess("发布成功");
				}
			}else{
				if(id>0){
					jsonSuccess("更新成功");
				}else{
					jsonError("更新失败");
				}
			}		
		} catch (Exception e) {
			e.printStackTrace();
			jsonResult("false","更新失败");
		}
		return ActionSupport.SUCCESS;
	}
	public String saveAbsence(){
		try {
			String upFile=saveUploadFile(file, fileName, true);
			ChuqueqinMainEntity chuqueqinMainEntity=new ChuqueqinMainEntity();
			chuqueqinMainEntity.setFilename(fileName);
			chuqueqinMainEntity.setPubtime(new Date());
			chuqueqinMainEntity.setTitle(title);
			String uppath=upFile.substring(upFile.indexOf("upload")).replace("\\", "/");
			chuqueqinMainEntity.setPath(uppath);
			chuqueqinMainEntity.setIsdel(0);//0代表未删除
			chuqueqinMainEntity.setFileguid(Md5GuidUtil.getMd5Guid(new File(upFile)));
			if(getCurrentUser()==null){
				chuqueqinMainEntity.setPubuserid(0);
			}else{
				chuqueqinMainEntity.setPubuserid(getCurrentUser().getId());
			}
			leaveService.insert(chuqueqinMainEntity);
			if("1".equals(pushflag)){
				int i=leaveService.insertAndPush(chuqueqinMainEntity);
				if(i>0){
					jsonSuccess("发布成功");
				}else{
					jsonSuccess("发布成功");
				}
			}else{
				jsonSuccess("保存成功");
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonError("操作失败");
		}
		return ActionSupport.SUCCESS;
	}	
	public String delete(){
		try {
			int line=leaveService.delete(absentid);
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
	
	public String selectById(){
		entity=leaveService.selectEntityById(absentid);
		return ActionSupport.SUCCESS;
	}

	public Integer getAbsentid() {
		return absentid;
	}
	public void setAbsentid(Integer absentid) {
		this.absentid = absentid;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public File getFile() {
		return file;
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
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
	public ChuqueqinMainEntity getEntity() {
		return entity;
	}
	public void setEntity(ChuqueqinMainEntity entity) {
		this.entity = entity;
	}
	public String getPushflag() {
		return pushflag;
	}
	public void setPushflag(String pushflag) {
		this.pushflag = pushflag;
	}
	public String getMeetingname() {
		return meetingname;
	}
	public void setMeetingname(String meetingname) {
		this.meetingname = meetingname;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public String getTruename() {
		return truename;
	}
	public void setTruename(String truename) {
		this.truename = truename;
	}
	public List<ChuqueqinMainEntity> getMeetinglist() {
		return meetinglist;
	}
	public void setMeetinglist(List<ChuqueqinMainEntity> meetinglist) {
		this.meetinglist = meetinglist;
	}
	public Map<DictDataEntity, List<MeetMainEntity>> getMapD() {
		return mapD;
	}
	public void setMapD(Map<DictDataEntity, List<MeetMainEntity>> mapD) {
		this.mapD = mapD;
	}
	public List<DictDataEntity> getDictList() {
		return dictList;
	}
	public void setDictList(List<DictDataEntity> dictList) {
		this.dictList = dictList;
	}
}
