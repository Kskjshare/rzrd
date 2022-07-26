package com.cloudrich.ereader.system.action;

import java.io.File;
import java.io.FileInputStream;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.cloudrich.ereader.common.action.BaseAction;
import com.cloudrich.ereader.remind.service.RemindService;
import com.cloudrich.ereader.system.entity.SysScopeUserEntity;
import com.cloudrich.ereader.system.entity.SysUserMainEnity;
import com.cloudrich.ereader.system.service.RoleUserService;
import com.cloudrich.ereader.system.service.ScopeUserService;
import com.cloudrich.ereader.system.service.UserService;
import com.cloudrich.ereader.util.DoWorkUtil;
import com.opensymphony.xwork2.ActionSupport;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.framework.util.GlobalConst;
import com.cloudrich.framework.util.Md5Utils;
@Controller("SysUserAction")
@Scope("prototype")
public class UserAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Resource
	private UserService userService;
	@Resource
	private ScopeUserService scopeUserService;	
	@Resource
	private RoleUserService roleUserService;	
    private Page page;
    private String usertype;
	private int pageNo;
	private int pageSize=8;
	private long totalPage;
	private String username;
	private SysUserMainEnity entity;
	private int userid;
	private String users;
	private String padmobile;
	private String imeinum;
	private File file;
	private String sex;
    public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getTruename() {
		return truename;
	}
	public void setTruename(String truename) {
		this.truename = truename;
	}
	public Integer getIsdel() {
		return isdel;
	}
	public void setIsdel(Integer isdel) {
		this.isdel = isdel;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getOfficetel() {
		return officetel;
	}
	public void setOfficetel(String officetel) {
		this.officetel = officetel;
	}
	public String getZhiwu() {
		return zhiwu;
	}
	public void setZhiwu(String zhiwu) {
		this.zhiwu = zhiwu;
	}
	public String getDanwei() {
		return danwei;
	}
	public void setDanwei(String danwei) {
		this.danwei = danwei;
	}
	public Integer getIsdestroy() {
		return isdestroy;
	}
	public void setIsdestroy(Integer isdestroy) {
		this.isdestroy = isdestroy;
	}
	public RemindService getRemindService() {
		return remindService;
	}
	public void setRemindService(RemindService remindService) {
		this.remindService = remindService;
	}
	private String truename;
    private Integer isdel;
    private String tel;
    private String email;
    private String officetel;
    private String zhiwu;
    private String danwei;
    private Integer isdestroy;
    private String passwd;
    
	    
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	@Resource RemindService remindService;

	public String selectList(){
		Map<String,Object> map=new HashMap<String,Object>();
		if(usertype!=null&&!"".equals(usertype)&&!"0".equals(usertype)){
			map.put("usertype", usertype.charAt(0));
		}
		
		if(username!=null&&!"".equals(username)){
			map.put("username", username);
		}
		page=userService.selectByPage(pageNo, pageSize, map);;
		totalPage=page.getPages();
		jsonSuccess("查询成功");
		return ActionSupport.SUCCESS;
	}
	public String updateUser(){
		try {
			if(entity!=null){
				entity.setId(userid);
				//entity.setPasswd(Md5Utils.MD5_32(entity.getPasswd()));
				SysUserMainEnity  userentity=userService.selectEntityById(entity.getId());
				if(entity.getPasswd().equals(userentity.getPasswd())){
					entity.setPasswd(userentity.getPasswd());
				}else{
					entity.setPasswd(Md5Utils.MD5_32(entity.getPasswd()));
				}
			}

	        //System.out.println(entity.getUsername());
			int id=userService.update(entity);
			if(id>0){
				//当用户为Pad端用户时，用户销毁向Pad端发送消息
				if(entity.getIsdestroy()==1&&entity.getUsertype().equals("3")){
					  try{
							remindService. PadUserIsDestroyRemindHandler(userid, entity.getPadmobile(),"4");
						}catch(Exception e){
							e.printStackTrace();
						}				
				}else if(entity.getIsdestroy()==0&&entity.getUsertype().equals("3")){
					try{
						remindService. PadUserIsDestroyRemindHandler(userid, entity.getPadmobile(),"5");
					}catch(Exception e){
						e.printStackTrace();
					}	
				}
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
	public String saveUser(){
		try {
			if(entity!=null){
				entity.setPasswd(Md5Utils.MD5_32(entity.getPasswd()));
			}
			int id=userService.insert(entity);
			if(id>0){
				SysScopeUserEntity record=new SysScopeUserEntity();
				if(entity.getUsertype().equals("3")){
					record.setScopeid(1);
					record.setUserid(entity.getId());
					scopeUserService.insert(record);
				}
				//当用户为Pad端用户时，用户销毁向Pad端发送消息
				if(entity.getIsdestroy()==1&&entity.getUsertype().equals("3")){
					  try{
							remindService. PadUserIsDestroyRemindHandler(userid, entity.getPadmobile(),"4");
						}catch(Exception e){
							e.printStackTrace();
						}				
				}else if(entity.getIsdestroy()==0&&entity.getUsertype().equals("3")){
					try{
						remindService. PadUserIsDestroyRemindHandler(userid, entity.getPadmobile(),"5");
					}catch(Exception e){
						e.printStackTrace();
					}	
				}
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
			int line=userService.delete(userid);
			if(line==0){
				jsonError("删除失败");
			}else{
				scopeUserService.deleteByUserId(userid);
				roleUserService.deleteByUserid(userid);
				jsonSuccess("删除成功");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ActionSupport.SUCCESS;
	}
	public String selectById(){
		entity=userService.selectEntityById(userid);
		return ActionSupport.SUCCESS;
	}
	public String checkUsername(){
		List<SysUserMainEnity> list=userService.selectAllUsers();
		boolean flag=true;
		if(users!=null&&!"".equals(users)){
			for (SysUserMainEnity sysUserMainEnity : list) {
				if(sysUserMainEnity.getUsername().equals(users)){
					flag=false;
					break;
				}
			}
		}
		jsonSuccess(flag+"");
		return ActionSupport.SUCCESS;
	}
	public String checkPadmobile(){
		List<SysUserMainEnity> mobilelist=userService.selectAllUsers();
		System.out.println(mobilelist.size());
		boolean flag=true;
		if(padmobile!=null&&!"".equals(padmobile)){
			for (SysUserMainEnity sysUserMainEnity : mobilelist) {
				if(padmobile.equals(sysUserMainEnity.getPadmobile())){
					flag=false;
					break;
				}
			}
		}
		jsonSuccess(flag+"");
		return ActionSupport.SUCCESS;
	}	
	public String checkImeiNum(){
		List<SysUserMainEnity> mobilelist=userService.selectAllUsers();
		System.out.println(mobilelist.size());
		boolean flag=true;
		if(imeinum!=null&&!"".equals(imeinum)){
			for (SysUserMainEnity sysUserMainEnity : mobilelist) {
				if(imeinum.equals(sysUserMainEnity.getTel())){
					flag=false;
					break;
				}
			}
		}
		jsonSuccess(flag+"");
		return ActionSupport.SUCCESS;
	}	
	
	//导入用户（用户管理）
	public String autoImportUser(){
		try {
			System.out.println("*****************------------------------------************************");
			System.out.println(file);
			HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(file));	
			HSSFSheet sheet = wb.getSheetAt(0);
			Map<String,String> content=DoWorkUtil.getInfoInHSSF(1,sheet,11);
				int totalRowNums=Integer.parseInt(content.get("totalRowNums"));//行数
				int totalColNums=Integer.parseInt(content.get("totalColNums"));//列数
				for (int i = 1; i <=totalRowNums-1; i++) {
					SysUserMainEnity entity=new SysUserMainEnity();
						//用户名 username
						entity.setUsername(content.get(i+"-"+0));
						//真实姓名 truename
						entity.setTruename(content.get(i+"-"+1));
						//性别 sex
						if ("男".equals(content.get(i+"-"+2))) {
							entity.setSex("0");
						}else {
							entity.setSex("1");
						}
						//办公电话 officetel
						String Office=content.get(i+"-"+3);
						if(content.get(i+"-"+3).indexOf(".")>-1){
							 Office=new BigDecimal(content.get(i+"-"+3)).toPlainString();
						}
						entity.setOfficetel(Office);
						//平板号码 tel
						entity.setTel(content.get(i+"-"+4));
						//手机号码padmobile
						String padmobile=content.get(i+"-"+5);
						if(content.get(i+"-"+5).indexOf(".")>-1){
							padmobile=new BigDecimal(content.get(i+"-"+5)).toPlainString();	
						}
						entity.setPadmobile(padmobile);
						//用户类型 usertype
						if ("PAD端用户".equals(content.get(i+"-"+6))) {
							entity.setUsertype("3");
						}else if ("系统管理员".equals(content.get(i+"-"+6))) {
							entity.setUsertype("1");
						}else if ("后台用户".equals(content.get(i+"-"+6))) {
							entity.setUsertype("2");
						}
						//isdestory（0）是否销毁
						if("否".equals(content.get(i+"-"+7))){
							entity.setIsdestroy(Integer.parseInt("0"));
						}else{
							entity.setIsdestroy(Integer.parseInt("1"));
						}
						//单位 danwei
						entity.setDanwei(content.get(i+"-"+8));
						//职务 zhiwu
						entity.setZhiwu(content.get(i+"-"+9));
						//电子邮箱 email
						entity.setEmail(content.get(i+"-"+10));
						//登录密码
						GlobalConst pwd=new GlobalConst();
						entity.setPasswd(Md5Utils.MD5_32(pwd.REGPASSWORD));
						//isdel（0）
						entity.setIsdel(0);
						int id=userService.insert(entity);
						if(id>0){
							SysScopeUserEntity record=new SysScopeUserEntity();
							if(entity.getUsertype().equals("3")){
								record.setScopeid(1);
								record.setUserid(entity.getId());
								scopeUserService.insert(record);
							}
							//当用户为Pad端用户时，用户销毁向Pad端发送消息
							if(entity.getIsdestroy()==1&&entity.getUsertype().equals("3")){
								  try{
										remindService. PadUserIsDestroyRemindHandler(userid, entity.getPadmobile(),"4");
									}catch(Exception e){
										e.printStackTrace();
									}				
							}else if(entity.getIsdestroy()==0&&entity.getUsertype().equals("3")){
								try{
									remindService. PadUserIsDestroyRemindHandler(userid, entity.getPadmobile(),"5");
								}catch(Exception e){
									e.printStackTrace();
								}	
							}
						}
			}			
				
			jsonSuccess("导入成功");
		} catch (Exception e) {
			e.printStackTrace();
			jsonError("导入失败");
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
	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	public String getUsertype() {
		return usertype;
	}
	public void setUsertype(String usertype) {
		this.usertype = usertype;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public SysUserMainEnity getEntity() {
		return entity;
	}
	public void setEntity(SysUserMainEnity entity) {
		this.entity = entity;
	}
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public String getUsers() {
		return users;
	}
	public void setUsers(String users) {
		this.users = users;
	}
	public String getPadmobile() {
		return padmobile;
	}
	public void setPadmobile(String padmobile) {
		this.padmobile = padmobile;
	}
	public String getImeinum() {
		return imeinum;
	}
	public void setImeinum(String imeinum) {
		this.imeinum = imeinum;
	}
	public File getFile() {
		return file;
	}
	public void setFile(File file) {
		this.file = file;
	}
}
