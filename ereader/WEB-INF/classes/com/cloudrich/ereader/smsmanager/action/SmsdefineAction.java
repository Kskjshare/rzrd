package com.cloudrich.ereader.smsmanager.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import com.cloudrich.ereader.common.action.BaseAction;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.notice.constant.NotifyConstant;
import com.cloudrich.ereader.smsmanager.entity.SmsdefineLogDetailEntity;
import com.cloudrich.ereader.smsmanager.entity.SmsdefineLogEntity;
import com.cloudrich.ereader.smsmanager.entity.SmsdefineMainEntity;
import com.cloudrich.ereader.smsmanager.service.SmsdefineLogDetailService;
import com.cloudrich.ereader.smsmanager.service.SmsdefineLogService;
import com.cloudrich.ereader.smsmanager.service.SmsdefineMainService;
import com.cloudrich.ereader.system.entity.SysRoleMainEntity;
import com.cloudrich.ereader.system.entity.SysRolePermissionEntity;
import com.cloudrich.ereader.system.entity.SysRoleUserEntity;
import com.cloudrich.ereader.system.entity.SysScopeMainEntity;
import com.cloudrich.ereader.system.entity.SysScopeUserEntity;
import com.cloudrich.ereader.system.entity.SysUserMainEnity;
import com.cloudrich.ereader.system.service.ScopeMainService;
import com.cloudrich.ereader.system.service.ScopeUserService;
import com.cloudrich.ereader.system.service.UserService;
import com.cloudrich.ereader.tongxunlun.entity.TongxunluMainEntity;
import com.cloudrich.ereader.tongxunlun.service.TongxunluService;
import com.opensymphony.xwork2.ActionSupport;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


@Controller("SmsdefineAction")
@Scope("prototype")
public class SmsdefineAction extends BaseAction{
	
	private static final long serialVersionUID = 1L;
	
	@Resource
	private SmsdefineMainService smsdefineMainService;
	@Resource
	private SmsdefineLogDetailService smsdefineLogDetailService;
	@Resource
	private SmsdefineLogService smsdefineLogService;
	@Resource
	private UserService userService;
	@Resource 
	ScopeMainService scopeMainService;
	@Resource 
	ScopeUserService scopeUserService;
	private int pageNo;
	private int pageSize=8;
	private int totalPage;
	private Page page;
	private int logid;
    private List<SmsdefineLogDetailEntity> list;
    private List<SmsdefineMainEntity> mainlist;
    private List<SysUserMainEnity> txlist;
    private String content;
    private String[] tongxluserids;
    private List<SysUserMainEnity> userslist;
	private String phonenums;
    private String userids;
    private String mobilesend;
    private String sendTimeStr;
    private String sendway;
    private String smsid;
    private Map<String ,Object> map;
    private String jsonStr;


	public String selectSmsdefineLog(){
		page = smsdefineLogService.selectByPage(pageNo, pageSize);
		totalPage=page.getPages();
		return ActionSupport.SUCCESS;
	}
	public String selectSmsdefineLogDetail(){
		list=smsdefineLogDetailService.selectSmsdefineByLogid(logid);
		for (int i = 0; i < list.size(); i++) {
			int userid=list.get(i).getTongxluserid();
			SysUserMainEnity entity=userService.selectEntityById(userid);
			if(entity!=null){
				String name=entity.getTruename();
				list.get(i).setName(name);
			}	
		}
		return ActionSupport.SUCCESS;
	}
	public String selectSmsdefineMain(){
		txlist=userService.selectAll(new HashMap<String, Object>());
		page = smsdefineMainService.selectByPage(pageNo, pageSize);
	    mainlist=page.getResult();
		for (int i = 0; i < mainlist.size(); i++) {
			int id=mainlist.get(i).getCreateuserid();
			SysUserMainEnity entity=userService.selectEntityById(id);
			if(entity!=null){
				String name=entity.getUsername();
				mainlist.get(i).setCreateusername(name);
			}
		}
		totalPage=page.getPages();
		JSONArray array=new JSONArray();
		JSONObject scope=new JSONObject();
		List<SysScopeMainEntity> list=scopeMainService.selectAll();
		for (int i = 0; i < list.size(); i++) {
			scope=new JSONObject();
			scope.put("id", "scopeid"+list.get(i).getScopeid());
			scope.put("pId", 0);
			scope.put("name", list.get(i).getScopename());
			array.add(scope);
			List<SysScopeUserEntity> userlist=scopeUserService.selectByScopeId(list.get(i).getScopeid());
			if(userlist.size()>0){
				for (int j = 0; j <userlist.size(); j++) {
					scope=new JSONObject();
					scope.put("id", userlist.get(j).getUserid());
					scope.put("pId", "scopeid"+userlist.get(j).getScopeid());
					scope.put("name", userlist.get(j).getUsername());
					array.add(scope);
				}
			}			
		}

		jsonStr=array.toString();
		System.out.println("短信推送范围：");
		System.out.println(jsonStr);
		return ActionSupport.SUCCESS;
	}

	public String insertSmsdefine() throws Exception{
		try {
	        SmsdefineMainEntity entity=new SmsdefineMainEntity();
	        entity.setContent(new String(content.getBytes("GBK"),"GBK"));
	        entity.setCreatetime(new Date());
	        if(getCurrentUser()==null){
	        	 entity.setCreateuserid(0);
	        }else{
		        entity.setCreateuserid(getCurrentUser().getId());
	        }
	        entity.setIsdel(0);
	        entity.setIsvalid(0);
	        entity.setPhonenums(phonenums);
	        String userids="";
	        if(tongxluserids.length>0){
	        	for (int i = 0; i < tongxluserids.length; i++) {
	        		userids+=tongxluserids[i]+",";
				}
	        	 entity.setTongxluserids(userids.substring(0, userids.lastIndexOf(',')));
	        }
	        entity.setSendtype("10");
	        if(NotifyConstant.SENDTYPE_CUSTOM.equals(sendway)){
	        	entity.setSendtime(parseDataStr(sendTimeStr));
	        }else{
	        	entity.setSendtime(new Date());
	        }
	        entity.setSendway(sendway);
	        System.out.println("1.Action层smsdefineMain数据");
	        System.out.println(entity.toString());
	        int numb=smsdefineMainService.insertSmsdefine(entity);
	        if(numb>0){
	        	jsonSuccess("新增成功");
	        }else{
	        	jsonError("新增失败");
	        }
		} catch (Exception e) {
			e.printStackTrace();
			jsonError("新增失败");
		}
		return ActionSupport.SUCCESS;
	}
	
	public String updateSmsdefine() throws Exception{
		try {
	        SmsdefineMainEntity entity=new SmsdefineMainEntity();
	        System.out.println(content);
	        //System.out.println(new String(content.getBytes(),"GBK"));
	        System.out.println(content.length());
	        entity.setContent(new String(content.getBytes("GBK"),"GBK"));
	        entity.setCreatetime(new Date());
	        if(getCurrentUser()==null){
	        	 entity.setCreateuserid(0);
	        }else{
		        entity.setCreateuserid(getCurrentUser().getId());
	        }
	        entity.setSmsid(Integer.valueOf(smsid));
	        entity.setIsdel(0);
	        entity.setIsvalid(0);
	        entity.setPhonenums(phonenums);
	        String userids="";
	        if(tongxluserids.length>0){
	        	for (int i = 0; i < tongxluserids.length; i++) {
	        		userids+=tongxluserids[i]+",";
				}
	        	 entity.setTongxluserids(userids.substring(0, userids.lastIndexOf(',')));
	        }
	        entity.setSendtype("10");
	        if(NotifyConstant.SENDTYPE_CUSTOM.equals(sendway)){
	        	entity.setSendtime(parseDataStr(sendTimeStr));
	        }else{
	        	entity.setSendtime(new Date());
	        }
	        entity.setSendway(sendway);
	        int numb=smsdefineMainService.updateSmsdefine(entity);
	        if(numb>0){
	        	jsonSuccess("更新成功");
	        }else{
	        	jsonError("更新失败");
	        }
		} catch (Exception e) {
			e.printStackTrace();
			jsonError("更新失败");
		}
		return ActionSupport.SUCCESS;
	}
	
	public String delete(){
		int i=smsdefineMainService.deleteSmsdefine(Integer.valueOf(smsid));
		int log=smsdefineLogService.deleteSmsdefineLog(Integer.valueOf(smsid));
		System.err.println("*********************************************************************---:"+i);
		System.err.println("*********************************************************************---:"+log);
		if(i>0 && log>0){
			jsonSuccess("删除成功");
		}else{
			jsonError("删除失败");
		}
		return ActionSupport.SUCCESS;
	}
	public String selectBySmsid(){
		SmsdefineMainEntity smsdefineEntity=smsdefineMainService.selectEntityById(Integer.valueOf(smsid));
		List<SysUserMainEnity> userlist=userService.selectAll(new HashMap<String, Object>());
		List<SysUserMainEnity> smsdefineUserList=new ArrayList<SysUserMainEnity>();
		String userids=smsdefineEntity.getTongxluserids();
		if(!"".equals(userids)&&userids!=null){
			String[] ids=userids.split(",");
			for (int i = 0; i < ids.length; i++) {
				for (int j = 0; j < userlist.size(); j++) {
					if( Integer.valueOf(ids[i])==userlist.get(j).getId()){
						smsdefineUserList.add(userlist.get(j));
						userlist.remove(j);
					}
				}
			}
		}
	    map=new HashMap<String, Object>();
		map.put("smsdefineEntity", smsdefineEntity);
		map.put("smsdefineUserList", smsdefineUserList);
		map.put("userlist", userlist);
		return ActionSupport.SUCCESS;
	}
	public String selectUserList(){
		String[] users=null;
		 userslist=new ArrayList<SysUserMainEnity>();
		if(userids!=null&&!"".equals(userids)){
			if(userids.lastIndexOf(",")>0){
			 users=userids.split(",");
			 for (int i = 0; i < users.length; i++) {
				 SysUserMainEnity entity=userService.selectEntityById(Integer.valueOf(users[i]));
				 userslist.add(entity);
			 }
			}else{
				 SysUserMainEnity entity=userService.selectEntityById(Integer.valueOf(userids));
				 userslist.add(entity);
			}
		}
		return ActionSupport.SUCCESS;
	}
	public String selectAllScopeUser(){
		List<SysScopeMainEntity> list=scopeMainService.selectAll();
		return ActionSupport.SUCCESS;
	}	
	private Date parseDataStr(String dateStr) throws Exception{
		SimpleDateFormat format = new SimpleDateFormat(DATE_PATTERN);
		return format.parse(dateStr);
	}
	public void getScopeUsers(){
		JSONArray array=new JSONArray();
		JSONObject scope=new JSONObject();
		List<SysScopeMainEntity> list=scopeMainService.selectAll();
		for (int i = 0; i < list.size(); i++) {
			scope=new JSONObject();
			scope.put("id", "scopeid"+list.get(i).getScopeid());
			scope.put("pid", 0);
			scope.put("name", list.get(i).getScopename());
			array.add(scope);
		}
		for (int i = 0; i < list.size(); i++) {
			List<SysScopeUserEntity> userlist=scopeUserService.selectByScopeId(list.get(i).getScopeid());
			if(userlist.size()>0){
				for (int j = 0; j <userlist.size(); j++) {
					scope=new JSONObject();
					scope.put("id", userlist.get(j).getUserid());
					scope.put("pid", "scopeid"+userlist.get(j).getScopeid());
					scope.put("name", userlist.get(j).getUsername());
					array.add(scope);
				}
			}
		}
		jsonStr=array.toString();
	}
	private static final String DATE_PATTERN = "yyyy-MM-dd HH:mm:ss";
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String[] getTongxluserids() {
		return tongxluserids;
	}
	public void setTongxluserids(String[] tongxluserids) {
		this.tongxluserids = tongxluserids;
	}
	public String getPhonenums() {
		return phonenums;
	}
	public void setPhonenums(String phonenums) {
		this.phonenums = phonenums;
	}
	public List<SysUserMainEnity> getTxlist() {
		return txlist;
	}
	public void setTxlist(List<SysUserMainEnity> txlist) {
		this.txlist = txlist;
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

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}
	public List<SmsdefineMainEntity> getMainlist() {
		return mainlist;
	}
	public void setMainlist(List<SmsdefineMainEntity> mainlist) {
		this.mainlist = mainlist;
	}
	public List<SmsdefineLogDetailEntity> getList() {
		return list;
	}
	public void setList(List<SmsdefineLogDetailEntity> list) {
		this.list = list;
	}
	public int getLogid() {
		return logid;
	}
	public void setLogid(int logid) {
		this.logid = logid;
	}	
	public List<SysUserMainEnity> getUserslist() {
		return userslist;
	}
	public void setUserslist(List<SysUserMainEnity> userslist) {
		this.userslist = userslist;
	}
	public String getUserids() {
		return userids;
	}
	public void setUserids(String userids) {
		this.userids = userids;
	}
	public String getMobilesend() {
		return mobilesend;
	}
	public void setMobilesend(String mobilesend) {
		this.mobilesend = mobilesend;
	}
	public String getSendTimeStr() {
		return sendTimeStr;
	}
	public void setSendTimeStr(String sendTimeStr) {
		this.sendTimeStr = sendTimeStr;
	}
	public String getSendway() {
		return sendway;
	}
	public void setSendway(String sendway) {
		this.sendway = sendway;
	}

	public String getSmsid() {
		return smsid;
	}
	public void setSmsid(String smsid) {
		this.smsid = smsid;
	}
	public Map<String, Object> getMap() {
		return map;
	}
	public void setMap(Map<String, Object> map) {
		this.map = map;
	}
	public String getJsonStr() {
		return jsonStr;
	}
	public void setJsonStr(String jsonStr) {
		this.jsonStr = jsonStr;
	}
	
}
