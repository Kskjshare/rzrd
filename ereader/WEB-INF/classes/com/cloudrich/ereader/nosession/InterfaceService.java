package com.cloudrich.ereader.nosession;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.cloudrich.ereader.briefing.entity.MeetBriefingMainEntity;
import com.cloudrich.ereader.briefing.service.BriefingService;
import com.cloudrich.ereader.briefingpub.entity.MeetPubBriefingEntity;
import com.cloudrich.ereader.calendar.entity.CalendarMainEntity;
import com.cloudrich.ereader.calendar.entity.CalendarPadEntity;
import com.cloudrich.ereader.calendar.service.CalendarService;
//import com.cloudrich.ereader.chuqueqin.entity.BookMarkerEntity;
import com.cloudrich.ereader.chuqueqin.entity.ChuqueqinMainEntity;
import com.cloudrich.ereader.chuqueqin.service.ChuqueqinService;
import com.cloudrich.ereader.common.action.BaseAction;
import com.cloudrich.ereader.dict.service.DictDataService;
import com.cloudrich.ereader.filemonitor.entity.FileMonitorEntity;
import com.cloudrich.ereader.filemonitor.service.FileMonitorService;
import com.cloudrich.ereader.groupmember.entity.GroupmemberMainEntity;
import com.cloudrich.ereader.groupmember.service.GroupMemberService;
import com.cloudrich.ereader.login.entity.LoginClientUser;
import com.cloudrich.ereader.login.service.LoginService;
import com.cloudrich.ereader.meeting.entity.MeetFileMainEntity;
import com.cloudrich.ereader.meeting.entity.MeetMainEntity;
import com.cloudrich.ereader.meeting.service.FileMd5ToolService;
import com.cloudrich.ereader.meeting.service.MeetingService;
import com.cloudrich.ereader.meeting.service.MeetingViewService;
import com.cloudrich.ereader.meetpub.entity.MeetPubGroupEntity;
import com.cloudrich.ereader.notice.entity.NoticePubEntity;
import com.cloudrich.ereader.notice.entity.NoticeReplyEntity;
import com.cloudrich.ereader.notice.service.NoticeService;
import com.cloudrich.ereader.system.entity.SysHelpMainEntity;
import com.cloudrich.ereader.system.entity.SysVersionMainEnity;
import com.cloudrich.ereader.system.service.HelpService;
import com.cloudrich.ereader.system.service.VersionService;
import com.cloudrich.ereader.tongxunlun.entity.TongxunluPubEntity;
import com.cloudrich.ereader.tongxunlun.service.TongxunluService;
import com.cloudrich.ereader.util.Base64Util;
import com.cloudrich.ereader.ziliaoku.entity.ZiliaokuMainEntity;
import com.cloudrich.ereader.ziliaoku.entity.ZiliaokuTypeEntity;
import com.cloudrich.ereader.ziliaoku.service.ZiliaokuMainService;
import com.cloudrich.ereader.ziliaoku.service.ZiliaokuTypeService;
import com.cloudrich.framework.common.util.RandomID;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * @author hc
 */
@Controller("InterfaceService")
public class InterfaceService extends BaseAction{
	//问卷调查
	private static final long serialVersionUID = 1L;
	@Resource LoginService   loginService;
	@Resource NoticeService  noticeService;
	@Resource GroupMemberService  grpMemberService;
	@Resource DictDataService  dictdataService;
	@Resource ChuqueqinService  chuqueqinService;
	@Resource TongxunluService  tongxunluService;
	@Resource ZiliaokuTypeService  ziliaokuTypeService;
	@Resource ZiliaokuMainService  ziliaokuService;
	@Resource MeetingViewService meetingViewService;
	@Resource CalendarService  calendarService;
	@Resource MeetingViewService  meetviewService;
	@Resource BriefingService  briefingService;
	@Resource CalendarService  calendardService;
	@Resource MeetingService meetingService;
	@Resource FileMonitorService fileMonitorService;
	@Resource VersionService versionService;	
	@Resource HelpService helpService;
	@Resource FileMd5ToolService fileMd5ToolService;

	
	private String username;
	private String password;
	private String danweitype;
	private String id;
	private int  meetingid;
	private String type;
	private String submeetingid;
	private String fenzuid;
	private String name;
	private String filetype;
	
	private String state;
	private String userid;
	private String noticeid;
	
	
	private String filenameid,moduleid;
	private double versionname;
	private String filepath;
	private String content;
	private String date;
	private int createuserid;
	private int eventid;
	private String filename;
	private int page;
	private  RandomID r=new RandomID();
	
	public void fileMd5(){
		JSONObject data = new JSONObject();
		String path=this.getClass().getClassLoader().getResource("/").getPath();
		String uploadpath=path+"../../upload/";
		System.out.println("path:"+uploadpath);
		try{
			fileMd5ToolService.updateBriefFileMd5(uploadpath);
			fileMd5ToolService.updateChuqueFileMd5(uploadpath);
			fileMd5ToolService.updateGroupFileMd5(uploadpath);
			fileMd5ToolService.updateHelpFileMd5(uploadpath);
			fileMd5ToolService.updateNoticeFileMd5(uploadpath);
			fileMd5ToolService.updatePubFileMd5(uploadpath);
			fileMd5ToolService.updateZiliaokuFileMd5(uploadpath);
			data.put("state", true);
			data.put("msg", "成功");	
		}catch (Exception e) {
			data.put("state", false);
			data.put("msg", "失败");
			e.printStackTrace();
		}
		this.outJsonString(data.toString());
	}

	public void uploadText(){
		JSONObject data = new JSONObject();
//		try{
//			BookMarkerEntity entity=new BookMarkerEntity();
//			entity.setFilename(filename);
//			entity.setCreatetime(r.dateDay());
//			entity.setContent(content);
//			entity.setPage(page);
//			entity.setUserid(Integer.parseInt(userid));
//			System.out.println("entity:"+entity);
//			chuqueqinService.insertBM(entity);
////			int fc=fileMonitorService.selectTotalMeetFileCount(meetingid,"");//会议总文件数量
//			//updateUserFileMoniter(entity);
//			data.put("state", true);
//			data.put("msg", "上传成功");	
//		}catch (Exception e) {
//			data.put("state", false);
//			data.put("msg", "上传失败");
//			e.printStackTrace();
//		}
		this.outJsonString(data.toString());
	}
	public void getPdfFile(){
		JSONObject data = new JSONObject();
		try{
			data.put("state", true);
			data.put("msg", "查询成功");
			String path=InterfaceService.class.getResource("/").getPath();
			//InterfaceService.class.getResource("/").getPath();
			filepath=path+"../../"+filepath;
			System.out.println("filepath:"+filepath);
			if(filepath!=null){
				 String fileContent=Base64Util.encodeBase64File(filepath);
				// File f=new File(filepath);
			     data.put("filepath", filepath);
			     data.put("filecontent",fileContent);
			    // System.out.println(fileContent);
			}
		}catch (Exception e) {
			data.put("state", false);
			data.put("msg", "查询失败");
			e.printStackTrace();
		}
		this.outJsonString(data.toString());
	}
	
	
	//获得会议进程
	//0 是会前，1是会中，2是闭幕会
	public void getMeetProcess(){
		JSONObject data = new JSONObject();
		try{
			data.put("state", true);
			data.put("msg", "查询成功");
			String tag=meetingViewService.getCurrentMeetProcess(meetingid);
							// File f=new File(filepath);
			     data.put("meetid", meetingid);
			     data.put("process",tag);
			    // System.out.println(fileContent);
		}catch (Exception e) {
			data.put("state", false);
			data.put("msg", "查询失败");
			e.printStackTrace();
		}
		this.outJsonString(data.toString());
	}
	
	//模块文件监控
	public void noticeReceiveFile(){
		JSONObject data = new JSONObject();
		try{
			FileMonitorEntity entity=new FileMonitorEntity();
			entity.setAccepttime(new Date());
			entity.setMeetid(meetingid);
			entity.setUserid(Integer.parseInt(userid));
			entity.setModuleid(Integer.parseInt(moduleid));
//			int filecount=fileMonitorService.selectUserAcceptFileCount(meetingid, Integer.parseInt(userid));
			//会议接收情况
//			entity.setFilecount(filecount);
			System.out.println("entity:"+entity);
			fileMonitorService.updateUserFileMoniter(entity);
//			int fc=fileMonitorService.selectTotalMeetFileCount(meetingid,"");//会议总文件数量
			//updateUserFileMoniter(entity);
			data.put("state", true);
			data.put("msg", "更新成功");	
		}catch (Exception e) {
			data.put("state", false);
			data.put("msg", "更新失败");
			e.printStackTrace();
		}
		this.outJsonString(data.toString());
	}
	/**
	 * 通知回调
	 */
	public void noticeReplay(){
		JSONObject data = new JSONObject();
		try{
			//NoticeMainEntity notice=noticeService.selectNoticeByFilename(filenameid.trim());
			int noticeid=Integer.parseInt(filenameid.trim());
			int useridint=Integer.parseInt(userid);
			String statecode="1";
			if(state!=null&&state.trim().length()!=0){
				if(state.trim().equals("参加会议")){
					statecode="2";
				}else if(state.trim().equals("需要请假")){
					statecode="1";
				}else if(state.trim().equals("待定")){
					statecode="3";
				}
			}
				
			
			NoticeReplyEntity reply=new NoticeReplyEntity();
			reply.setNoticeid(noticeid);
			reply.setUserid(useridint);
			reply.setNoticereplycode(statecode);
			
			noticeService.addNoticeReply(reply);
			
			data.put("state", true);
			data.put("msg", "更新成功");		
		}catch (Exception e) {
			data.put("state", false);
			data.put("msg", "更新失败");
			e.printStackTrace();
		}
		this.outJsonString(data.toString());
		
	}

	//客户端版本
	public void getVersion(){
		JSONObject data = new JSONObject();
		try{
			List<SysVersionMainEnity> list= versionService.selectVersionByType(type);
			String version="0";
			
			SysVersionMainEnity entity=null;
			if(list!=null){
				for (int i = 0; i < list.size(); i++) {
					if(Double.parseDouble(list.get(i).getVersionnum())>Double.parseDouble(version)){
						version=list.get(i).getVersionnum();
						entity=list.get(i);
					}
				}
			}
			if(entity==null){
				data.put("state", false);
			}else{
				 version=entity.getVersionnum();
				 RandomID r=new RandomID();
				if(Double.parseDouble(version)>versionname){
					data.put("state", true);
					data.put("fileurl", entity.getPath().substring(entity.getPath().indexOf("/")+1));
					data.put("versionname", entity.getVersionnum());
					data.put("createtime", r.dateToString(entity.getCreatetime()));
					data.put("md5", entity.getFileguid());
				}else{
					data.put("state", false);
				}
			}
		}catch (Exception e) {
			data.put("state", false);
			data.put("msg", "查询失败");
			e.printStackTrace();
		}
		this.outJsonString(data.toString());
	}
	
	/**
	 * 获得年历表
	 */
	public void getCalendar(){
		JSONObject data = new JSONObject();
		JSONArray array=new JSONArray();
		JSONArray array1=new JSONArray();

		try{
			List<CalendarMainEntity> list=calendarService.selectPubEvent();
			data.put("state", true);
			data.put("msg", "查询成功");
			RandomID r=new RandomID();
				JSONObject userdata = null;
				for(int i=0;i<list.size();i++){
					userdata=new JSONObject();
					//"content":"国庆","createtime":"20161006","fromuser":"typeid":6
					Calendar calendar = Calendar. getInstance(); 
					calendar.setTime(list.get(i).getShowdate());
					//在客户端源代码中将createtime作为显示日期，为快速发布，暂时未修改
					//System.out.println("显示日期："+list.get(i).getShowdate());
					//截取年份信息
					//String syear=String.valueOf(list.get(i).getShowdate());
					//syear=syear.substring(syear.lastIndexOf(' ')+1);
					String month=String.valueOf(calendar.get(Calendar.MONTH)+1);
					String day=String.valueOf(calendar.get(Calendar.DAY_OF_MONTH));
					System.out.println("month"+month);
					if(month.trim().length()==1){
						month="0"+month;
					}
					if(day.trim().length()==1){
						day="0"+day;
					}
					String showdate=month+day;
					//String showdate=syear+month+day;
					userdata.put("id", list.get(i).getEventid());
					userdata.put("isdel", list.get(i).getIsdel());
					userdata.put("sdate", r.dateToString(list.get(i).getShowdate()));
					userdata.put("fromuser",list.get(i).getCreateuserid());
					userdata.put("createtime",showdate);
					userdata.put("content",list.get(i).getEventname());
					userdata.put("type", list.get(i).getEventtype());
					array.add(userdata);
				}
					data.put("data", array);
					Map<String,Object> map=new HashMap<String, Object>();
					map.put("createuserid",createuserid);							
					SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");		
					List<CalendarPadEntity> lists=calendarService.selectByUserid(map);
					if(lists.size()>0){
						Calendar calendar2 = Calendar. getInstance(); 
						for(int i=0;i<lists.size();i++){
							userdata=new JSONObject();
							userdata.put("content",lists.get(i).getContent());
							userdata.put("createdate", sdf.format(lists.get(i).getCreatedate()));
							userdata.put("name", lists.get(i).getEventname());
							userdata.put("date", lists.get(i).getShowdate());
							userdata.put("createuserid", lists.get(i).getCreateuserid());
							array1.add(userdata);
						}
					}
				data.put("data1", array1);						
		}catch (Exception e) {
			data.put("state", false);
			data.put("msg", "查询失败");
			e.printStackTrace();
		}
		this.outJsonString(data.toString());
		
	}
	public void getCalendarPersonal(){
		JSONObject data = new JSONObject();
		JSONArray array1=new JSONArray();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");		
		try{
				JSONObject userdata = null;				
				Map<String,Object> map=new HashMap<String, Object>();
				map.put("createuserid",createuserid);							
				map.put("showdate",date);
				List<CalendarPadEntity> lists=calendarService.selectByUserid(map);
				if(lists.size()>0){
					for(int i=0;i<lists.size();i++){
						userdata=new JSONObject();
						userdata.put("content",lists.get(i).getContent());
						userdata.put("createdate", sdf.format(lists.get(i).getCreatedate()));
						userdata.put("name", lists.get(i).getEventname());
						userdata.put("date", lists.get(i).getShowdate());
						userdata.put("createuserid", lists.get(i).getCreateuserid());
						array1.add(userdata);
					}
				}
			data.put("data1", array1);			
		}catch (Exception e) {
			data.put("state", false);
			data.put("msg", "查询失败");
			e.printStackTrace();
		}
		this.outJsonString(data.toString());
	}
	/**
	 * 保存pad年历表个人事件
	 */
	public void insertCalendarPad(){
		JSONObject data = new JSONObject();
		try{
			CalendarPadEntity entity=new CalendarPadEntity();
				entity.setContent(content);
				entity.setCreatedate(new Date());
				entity.setEventname(name);
				entity.setCreateuserid(createuserid);
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
				entity.setShowdate(date);
			int i=calendarService.insertEvent(entity);
			if(i>0){
				data.put("state", true);
				data.put("msg", "保存成功");				
			}else{
				data.put("state", false);
				data.put("msg", "保存失败");				
			}		
		}catch (Exception e) {
			data.put("state", false);
			data.put("msg", "保存失败");
			e.printStackTrace();
		}
		this.outJsonString(data.toString());
		
	}
	/**
	 * 更新pad年历表个人事件
	 */
	public void updateCalendarPad(){
		JSONObject data = new JSONObject();
		try{
			CalendarPadEntity entity=new CalendarPadEntity();
			entity.setContent(content);
			entity.setCreatedate(new Date());
			entity.setEventname(name);
			entity.setCreateuserid(createuserid);
			entity.setId(eventid);
			entity.setShowdate(date);
			System.out.println("name:"+name);
			System.out.println("createuserid:"+createuserid);
			System.out.println("date:"+date);
			int i=calendarService.updatePadCalendar(entity);
			if(i>0){
				data.put("state", true);
				data.put("msg", "更新成功");				
			}else{
				data.put("state", true);
				data.put("msg", "更新失败");				
			}		
		}catch (Exception e) {
			data.put("state", false);
			data.put("msg", "更新失败");
			e.printStackTrace();
		}
		this.outJsonString(data.toString());
		
	}
	public String getDate() {
		return date;
	}


	public void setDate(String date) {
		this.date = date;
	}


	/**
	 * 删除pad年历表个人事件
	 */
	public void deleteCalendarPad(){
		JSONObject data = new JSONObject();
		try{	
			int i=0;
			Map<String,Object> map=new HashMap<String, Object>();
			if(createuserid!=0&&date!=null&&!"".equals(date)){
				map.put("createuserid",createuserid);				
				map.put("showdate",date);	
				i=calendarService.deletePadCalendar(map);
			}	
				if(i>0){
					data.put("state", true);
					data.put("msg", "删除成功");
				}else{
					data.put("state", true);
					data.put("msg", "删除失败");				
				}	
		}catch (Exception e) {
			data.put("state", false);
			data.put("msg", "删除失败");
			e.printStackTrace();
		}
		this.outJsonString(data.toString());	
	}
	/**
	 * 分组
	 */
	public void getFenzu(){
		JSONObject json=new JSONObject();
		JSONObject data=new JSONObject();
		JSONArray arry=new JSONArray();
		try{
			List<MeetPubGroupEntity> groupEntity=meetingViewService.selectPubGroupByMeetidAndGrpno(meetingid);
			if(groupEntity!=null&&groupEntity.size()>0){
				for (int i = 0; i < groupEntity.size(); i++) {
					json=new JSONObject();
					json.put("id", groupEntity.get(i).getGroupid());
					json.put("groupno", groupEntity.get(i).getGroupno());
					json.put("filepath", groupEntity.get(i).getFilepath());
					json.put("content", groupEntity.get(i).getTitle());
					json.put("md5", groupEntity.get(i).getFileguid());
					
					arry.add(json);
				}
				data.put("state", true);
			}else{
				data.put("state", false);
			}
			data.put("data", arry);
		}catch (Exception e) {
			e.printStackTrace();
			data.put("state", false);
		}
		System.out.println("json:"+data.toString());
		this.outJsonString(data.toString());
	}

	
	//login
	public void login(){
		
		JSONObject data = new JSONObject();
		LoginClientUser user=null;
		
		try {
			user=loginService.LoginClient(username, password);
			System.out.println(user.getIsdestory());
			if(user.getIsdestory()==0){
				data.put("state", true);
				//登录成功
				data.put("msg", "0");
			}else{
				data.put("state", false);
				//用户销毁
				data.put("msg", "2");
			}
			
			JSONObject userdata = new JSONObject();
			userdata.put("mobileno", user.getPadmobile());
			userdata.put("name", user.getTruename());
			userdata.put("id", user.getId());
			userdata.put("cmid", "5");
			data.put("data",userdata);
			System.out.println("login is sucess");
		} catch (Exception e) {
			data.put("state", false);
			//登录失败
			data.put("msg", "1");
			e.printStackTrace();
		}
		System.out.println("login is sucess"+data.toString());
		this.outJsonString(data.toString());
	}
	
	
	
	/**
	 * 插入已读通知和用户
	 */
	public void insertYdNotice(){
		JSONObject data = new JSONObject();
		try{
			int m=noticeService.insertYdNotice(Integer.parseInt(userid), Integer.parseInt(noticeid));			
			data.put("data", "ok");
			data.put("state", true);
			data.put("msg", "插入成功");
			
		}catch (Exception e) {
			data.put("state", false);
			data.put("msg", "查询失败");
			e.printStackTrace();
		}
		this.outJsonString(data.toString());
		
	}

	/**
	 * 获取通知总数量
	 */
	public void getAnncount(){
		JSONObject data = new JSONObject();
		try{
			int m=noticeService.getNoticeCount(Integer.parseInt(userid));
			int n=noticeService.getYdNoticeCount(Integer.parseInt(userid));
			
			int i=m-n;
			if(i<0){
				i=0;
			}
			data.put("data", "ok");
			data.put("state", true);
			data.put("msg", "查询成功");
			
				JSONObject userdata = new JSONObject();
				userdata.put("count(1)", i);
				
				data.put("data", userdata);
		}catch (Exception e) {
			data.put("state", false);
			data.put("msg", "查询失败");
			e.printStackTrace();
		}
		this.outJsonString(data.toString());
		
	}
	
	/**
	 * 获得通知的具体记录
	 * @return
	 */
	
	public void getAnn(){
		JSONObject data = new JSONObject();
		JSONArray array=new JSONArray();
		try{
			List<NoticePubEntity> list=noticeService.selectAllNoticeByUserid(Integer.parseInt(userid));
			data.put("state", true);
			data.put("msg", "查询成功");
			RandomID r=new RandomID();
				JSONObject userdata = null;
				for(int i=0;i<list.size();i++){
					userdata=new JSONObject();

					userdata.put("createtime",r.dateToString(list.get(i).getPubtime()));
					userdata.put("id", list.get(i).getNoticeid());
					userdata.put("filepath", list.get(i).getPath());
					userdata.put("title", list.get(i).getTitle());
					userdata.put("filename", list.get(i).getFilename());
					userdata.put("md5", list.get(i).getFileguid());
					userdata.put("replycode", list.get(i).getNoticereplycode());
					array.add(userdata);
				}

				data.put("data", array);

		}catch (Exception e) {
			data.put("state", false);
			data.put("msg", "查询失败");
			e.printStackTrace();
		}
		this.outJsonString(data.toString());
		
	}
	
	/**
	 * 查询组成人员
	 * @return
	 */
	public void getGroupmember(){
		JSONObject data = new JSONObject();
		JSONArray array=new JSONArray();
		try{
			List<GroupmemberMainEntity> list=grpMemberService.selectAllMemberPub();
			System.out.println("list is "+list.size());
			data.put("state", true);;
			data.put("msg", "查询成功");

			JSONObject userdata = null;
				for(int i=0;i<list.size();i++){
					userdata=new JSONObject();
                    System.out.println("membertype"+list.get(i).getMembertype().toString());
					userdata.put("id",list.get(i).getMemberid());
					
					//临时注销
					String zhiwu="主任";
							//dictdataService.getNameByTypeAndcode("membertype", list.get(i).getMembertype().toString());
							
					userdata.put("post", zhiwu);
					userdata.put("truename", list.get(i).getTruename());
					userdata.put("xulie", list.get(i).getSort());
					userdata.put("type", list.get(i).getGroupcode());
					array.add(userdata);
				}

				data.put("data", array);

		}catch (Exception e) {
			data.put("state", false);
			data.put("msg", "查询失败");
			e.printStackTrace();
		}
		this.outJsonString(data.toString());
	}
	
	
	/**
	 * 出缺勤
	 * @return
	 */
	public void getLeave(){
		JSONObject data = new JSONObject();
		JSONArray array=new JSONArray();
		try{
			Map<String,Object> map=new java.util.HashMap<String,Object>();
			
			List<ChuqueqinMainEntity> list=chuqueqinService.selectAllPub(map);
			System.out.println("list is "+list.size());
			data.put("state", true);;
			data.put("msg", "查询成功");
			RandomID r=new RandomID();
			JSONObject userdata = null;
				for(int i=0;i<list.size();i++){
					userdata=new JSONObject();

					userdata.put("createtime",r.dateToString(list.get(i).getPubtime()));
					userdata.put("id", list.get(i).getAbsentid());
					userdata.put("filepath", list.get(i).getPath());
					userdata.put("filename", list.get(i).getFilename());
					userdata.put("md5", list.get(i).getFileguid());
					array.add(userdata);
				}

				data.put("data", array);

		}catch (Exception e) {
			data.put("state", false);
			data.put("msg", "查询失败");
			e.printStackTrace();
		}
		this.outJsonString(data.toString());
	}
	
	
	
	/**
	 * 通讯录
	 * @return
	 */
	public void getTongxunlu(){
		JSONObject data = new JSONObject();
		JSONArray array=new JSONArray();
		try{

			System.out.println("userid:+"+Integer.parseInt(userid));
			boolean b=tongxunluService.selectPermisssionByUserid(Integer.parseInt(userid));
			if(b){
			List<TongxunluPubEntity> list=tongxunluService.selectComp(Integer.valueOf(danweitype));
			System.out.println("list is "+list.size());
			data.put("state", true);;
			data.put("msg", "查询成功");

			JSONObject userdata = null;
				for(int i=0;i<list.size();i++){
					userdata=new JSONObject();

					userdata.put("username",list.get(i).getName());
					userdata.put("danwei", list.get(i).getCompCode());
					userdata.put("dianhua_bg", list.get(i).getPhoneOffice());
					userdata.put("dianhua_zz", list.get(i).getPhoneHome());
					userdata.put("dianhua_sj", list.get(i).getMobile());
					userdata.put("youxiang", list.get(i).getMail());
					userdata.put("zhiwei", list.get(i).getDept());
					userdata.put("beizhu", list.get(i).getComment());
					
					
					
					array.add(userdata);
				}

				data.put("data", array);
			}
		}catch (Exception e) {
			data.put("state", false);
			data.put("msg", "查询失败");
			e.printStackTrace();
		}
		this.outJsonString(data.toString());
	}
	
	/**
	 * 资料库分类
	 * @return
	 */
	public void getziliaokufenlei(){
		JSONObject data = new JSONObject();
		JSONArray array=new JSONArray();
		try{

			
			List<ZiliaokuTypeEntity> list=ziliaokuTypeService.selectFirstType();
			System.out.println("list is "+list.size());
			data.put("state", true);;
			data.put("msg", "查询成功");

			JSONObject userdata = null;
				for(int i=0;i<list.size();i++){
					userdata=new JSONObject();

					userdata.put("id",list.get(i).getTypeid());
					userdata.put("title", list.get(i).getName());
					userdata.put("sort", list.get(i).getSort());
					userdata.put("isdel", list.get(i).getIsdel());
					userdata.put("pid", list.get(i).getPtypeid());
					userdata.put("type", "1");

					array.add(userdata);
				}

				data.put("data", array);

		}catch (Exception e) {
			data.put("state", false);
			data.put("msg", "查询失败");
			e.printStackTrace();
		}
		this.outJsonString(data.toString());
	}
	
	
	/**
	 * 资料库二级分类和资料
	 * @return
	 */
	public void getziliaotwo(){
		JSONObject data = new JSONObject();
		JSONArray array=new JSONArray();
		try{

			RandomID r=new RandomID();
			List<ZiliaokuTypeEntity> list=ziliaokuTypeService.selectSecondType(Integer.parseInt(id));
			
			if(list!=null&&list.size()!=0){
			
					//	List<ZiliaokuTypeEntity> list=ziliaokuTypeService.selectSecondType(Integer.parseInt(id));
						
						System.out.println("list is "+list.size());
						data.put("state", true);;
						data.put("msg", "查询成功");
						
						JSONObject userdata = null;
							for(int i=0;i<list.size();i++){
								userdata=new JSONObject();
			
								userdata.put("id",list.get(i).getTypeid());
								userdata.put("name", list.get(i).getName());
								userdata.put("pid", list.get(i).getPtypeid());
								userdata.put("createtime", "");
								userdata.put("upload", "");
								
								array.add(userdata);
							
								System.out.println("list is "+list.get(i).getTypeid()+"---i-"+i);
							   List<ZiliaokuMainEntity> list1=ziliaokuService.selectByType(list.get(i).getTypeid());
							   System.out.println("list1 is "+list1.size()+"---i-"+i);

							   if(list1!=null&&list1.size()!=0){
									JSONObject userdata1 = null;
										for(int j=0;j<list1.size();j++){
											userdata1=new JSONObject();
											 System.out.println("list1 is "+list1.size()+"---j-"+j);
											userdata1.put("id",list1.get(j).getZiliaoid());
											userdata1.put("name", list1.get(j).getFilename());
											userdata1.put("pid", list1.get(j).getTypeid());
											userdata1.put("createtime",r.dateToString(list1.get(j).getCreatetime()));
											userdata1.put("upload", list1.get(j).getPath());
											userdata1.put("md5", list1.get(j).getFileguid());
											System.out.println("md5:"+list1.get(j).getFileguid());
											array.add(userdata1);
										}
									
							      }
						}
			      }
			
				data.put("data", array);

		}catch (Exception e) {
			data.put("state", false);
			data.put("msg", "查询失败");
			e.printStackTrace();
		}
		this.outJsonString(data.toString());
	}
	
	
	
	
	//getMeetingcwijieshu
	
	/**
	 * 获取当前和历史会议
	 */
	public void getMeetingcwijieshu(){
		JSONObject data = new JSONObject();
		JSONArray array=new JSONArray();
		JSONArray curarray=new JSONArray();
		JSONArray jieshuarray=new JSONArray();
		RandomID r=new RandomID();
		try{
	        System.out.println("pad get current meeting,type is"+type);
			MeetMainEntity curmeet=meetviewService.selectCurMeeting(type);
			  if(curmeet!=null){
					JSONObject curdata = new JSONObject();
					curdata.put("createtime",r.dateToString(curmeet.getCreatetime()));
					curdata.put("cwjieshu", "");
					curdata.put("edate", r.dateToString(curmeet.getEdate()));
					curdata.put("id", curmeet.getMeetid());
					curdata.put("isdel", curmeet.getIsdel());
					curdata.put("jieshu", curmeet.getJnum());
					curdata.put("mname", curmeet.getMname());
					curdata.put("mtype", type);
					curdata.put("mtypestr", "");
					curdata.put("name", "");
					curdata.put("sdate", r.dateToString(curmeet.getSdate()));
					curdata.put("state", "0");
					curdata.put("type", "0");
					curdata.put("typename", "");
					curdata.put("userid", curmeet.getUserid());
					curarray.add(curdata);
			  }
					data.put("data", curarray);
					
			
			List<MeetMainEntity> list=meetviewService.selectHisMeeting(type);
			System.out.println("list is "+list.size());
			data.put("state", true);
			data.put("msg", "查询成功");
			
			JSONObject userdata = null;
				if(list!=null&&list.size()!=0){
					for(int i=0;i<list.size();i++){
						userdata=new JSONObject();
						
						userdata.put("createtime",r.dateToString(list.get(i).getCreatetime()));
						userdata.put("cwjieshu", "");
						userdata.put("edate", r.dateToString(list.get(i).getEdate()));
						userdata.put("id", list.get(i).getMeetid());
						userdata.put("isdel", list.get(i).getIsdel());
						userdata.put("jieshu", list.get(i).getJnum());
						userdata.put("mname", list.get(i).getMname());
						userdata.put("mtype", type);
						userdata.put("mtypestr", "");
						userdata.put("name", "");
						userdata.put("sdate", r.dateToString(list.get(i).getSdate()));
						userdata.put("state", "0");
						userdata.put("type", "0");
						userdata.put("typename", "");
						userdata.put("userid", list.get(i).getUserid());
	
						array.add(userdata);
					}
				}

				data.put("data1", array);
				
				//届数
				List<MeetMainEntity> listj=meetviewService.selectJnumByMtype(type);
				JSONObject jieshudata =null;
				if(listj!=null&&listj.size()!=0){
					for(int j=0;j<listj.size();j++){
						jieshudata=new JSONObject();
						jieshudata.put("createtime","");
						jieshudata.put("cwjieshu", "");
						jieshudata.put("edate", "");
						jieshudata.put("id","");
						jieshudata.put("isdel", 0);
						jieshudata.put("jieshu", listj.get(j).getJnum());
						jieshudata.put("mname", "");
						jieshudata.put("mtype", "");
						jieshudata.put("mtypestr", "");
						jieshudata.put("name", "");
						jieshudata.put("sdate", "");
						jieshudata.put("state", "0");
						jieshudata.put("type", "0");
						jieshudata.put("typename", "");
						jieshudata.put("userid", "");
						
						jieshuarray.add(jieshudata);
					}
				}
					
					data.put("jieshu", jieshuarray);

		}catch (Exception e) {
			data.put("state", false);
			data.put("msg", "查询失败");
			e.printStackTrace();
		}
		this.outJsonString(data.toString());
	}
	
	//http://112.33.5.56:13080/ereader/service/interfaceService!getMonitorJy.action?meetingid=754&userid=11
	/**
	 * 获取议程
	 * @return
	 */
	public void getMonitorJy(){
		JSONObject data = new JSONObject();
		JSONArray array=new JSONArray();
		JSONArray array1=new JSONArray();
		try{
	               	
					//this.setSubmeetingid("11");
					List<Map<String,Object>> list=meetviewService.getMeetTreeYichenClient(meetingid,Integer.parseInt(userid));
					System.out.println("list is :"+list.size());
					data.put("state", true);;
					data.put("msg", "查询成功");
					System.out.println("获取议程");
					JSONObject userdata = null;
					JSONObject userdata2 =null;
						for(int i=0;i<list.size();i++){
							userdata=new JSONObject();
		
							String upload=(String)list.get(i).get("filepath");
							if(upload==null){
								upload="";
							}
								userdata.put("id",list.get(i).get("id"));
								userdata.put("name", list.get(i).get("name"));
								userdata.put("filetype", list.get(i).get("filetype"));
								userdata.put("pid", list.get(i).get("pid"));
								userdata.put("upload", upload);  
								userdata.put("md5", list.get(i).get("md5"));
							array.add(userdata);
						} 
						//议程文件  路径下载
						/*List<MeetFileMainEntity> lists=meetviewService.selectALLMeetFileByMeetidAndUserid(meetingid, null, null, Integer.parseInt(userid));
						if(lists!=null){
							for(int t=0;t<lists.size();t++){
								userdata2= new JSONObject();
								userdata2.put("id",lists.get(t).getFileid());
								userdata2.put("name", lists.get(t).getFilename());
								userdata2.put("filetype", lists.get(t).getFiletype());
								userdata2.put("upload", lists.get(t).getFilepath());
								userdata2.put("md5", lists.get(t).getFileguid());
								array1.add(userdata2);
							}
						}*/
						
						//议程文件
						List<MeetFileMainEntity> listyichen=meetviewService.selectALLMeetFileByMeetidAndUserid(meetingid, null, "9", Integer.parseInt(userid));
						if(listyichen!=null){
							for(int t1=0;t1<listyichen.size();t1++){
								userdata2= new JSONObject();
								userdata2.put("id",listyichen.get(t1).getFileid());
								userdata2.put("name", listyichen.get(t1).getFilename());
								userdata2.put("filetype", listyichen.get(t1).getFiletype());
								userdata2.put("upload", listyichen.get(t1).getFilepath());
								userdata2.put("md5", listyichen.get(t1).getFileguid());
								array1.add(userdata2);
							}
						}
						data.put("data1", array1);
						data.put("data", array);
	       

		}catch (Exception e) {
			data.put("state", false);
			data.put("msg", "查询失败");
			e.printStackTrace();
		}
		this.outJsonString(data.toString());
	}	
	/**
	 * 根据会议ID获取所有文件
	 * @return
	 */
	public void getMonitorYc(){
		JSONObject data = new JSONObject();
		JSONArray array=new JSONArray();
		JSONArray array1=new JSONArray();
		try{
	               	
					//this.setSubmeetingid("11");
					List<Map<String,Object>> list=meetviewService.getMeetTreeYichenClient(meetingid,Integer.parseInt(userid));
					System.out.println("list is :"+list.size());
					data.put("state", true);;
					data.put("msg", "查询成功");
					System.out.println("获取议程");
					JSONObject userdata = null;
					JSONObject userdata2 =null;
						for(int i=0;i<list.size();i++){
							userdata=new JSONObject();
		
							String upload=(String)list.get(i).get("filepath");
							if(upload==null){
								upload="";
							}
								userdata.put("id",list.get(i).get("id"));
								userdata.put("name", list.get(i).get("name"));
								userdata.put("filetype", list.get(i).get("filetype"));
								userdata.put("pid", list.get(i).get("pid"));
								userdata.put("upload", upload);  
								userdata.put("md5", list.get(i).get("md5"));
							array.add(userdata);
						} 
						//议程文件  路径下载
						/*List<MeetFileMainEntity> lists=meetviewService.selectALLMeetFileByMeetidAndUserid(meetingid, null, null, Integer.parseInt(userid));
						if(lists!=null){
							for(int t=0;t<lists.size();t++){
								userdata2= new JSONObject();
								userdata2.put("id",lists.get(t).getFileid());
								userdata2.put("name", lists.get(t).getFilename());
								userdata2.put("filetype", lists.get(t).getFiletype());
								userdata2.put("upload", lists.get(t).getFilepath());
								userdata2.put("md5", lists.get(t).getFileguid());
								array1.add(userdata2);
							}
						}*/
						
						//议程文件
						List<MeetFileMainEntity> listyichen=meetviewService.selectMeetFileByMeetid(meetingid);
						System.out.println("获得 议程文件");
						if(listyichen!=null){
							for(int t1=0;t1<listyichen.size();t1++){
								userdata2= new JSONObject();
								System.out.println(listyichen.get(t1).toString());
								userdata2.put("id",listyichen.get(t1).getFileid());
								userdata2.put("pid", listyichen.get(t1).getYichenid());
								userdata2.put("name", listyichen.get(t1).getFilename());
								userdata2.put("filetype", listyichen.get(t1).getFiletype());
								userdata2.put("upload", listyichen.get(t1).getFilepath());
								userdata2.put("md5", listyichen.get(t1).getFileguid());
								array1.add(userdata2);
							}
						}
						data.put("data1", array1);
						data.put("data", array);
	       

		}catch (Exception e) {
			data.put("state", false);
			data.put("msg", "查询失败");
			e.printStackTrace();
		}
		this.outJsonString(data.toString());
	}
	
	
	/**
	 * 会中主任会议
	 * @return
	 */
	public void getHuizhongzhuren(){
		JSONObject data = new JSONObject();
		JSONArray array=new JSONArray();
		try{
	
			//this.setSubmeetingid("11");
			System.out.println(meetingid+" "+userid);
			List<MeetFileMainEntity> list=meetviewService.selectALLPubMeetFileByMeetidAndVersionAndUserid(meetingid, "2", null,Integer.parseInt(userid));
			System.out.println("list is :"+list.size());
			data.put("state", true);;
			data.put("msg", "查询成功");
			JSONObject userdata = null;
				for(int i=0;i<list.size();i++){
					userdata=new JSONObject();

					userdata.put("id",list.get(i).getFileid());
					userdata.put("content", list.get(i).getTitle());
					userdata.put("filetype", list.get(i).getFiletype());
					userdata.put("pid", "");
					userdata.put("filepath", list.get(i).getFilepath());
					userdata.put("md5", list.get(i).getFileguid());
					array.add(userdata);
				}

				data.put("data", array);

		}catch (Exception e) {
			data.put("state", false);
			data.put("msg", "查询失败");
			e.printStackTrace();
		}
		this.outJsonString(data.toString());
	}	
	
	/**
	 * 闭幕会
	 * @return
	 */
	public void getBimuhui(){
		JSONObject data = new JSONObject();
		JSONArray array=new JSONArray();
		try{
	
			//this.setSubmeetingid("11");
			List<MeetFileMainEntity> list=meetviewService.selectALLMeetFileByMeetidAndUserid(meetingid, "1", "8",Integer.parseInt(userid));
			System.out.println("list is :"+list.size());
			data.put("state", true);;
			data.put("msg", "查询成功");
			JSONObject userdata = null;
				for(int i=0;i<list.size();i++){
					userdata=new JSONObject();

					userdata.put("id",list.get(i).getFileid());
					userdata.put("content", list.get(i).getTitle());
					userdata.put("filetype", list.get(i).getFiletype());
					userdata.put("pid", "");
					userdata.put("filepath", list.get(i).getFilepath());
					userdata.put("md5", list.get(i).getFileguid());
					array.add(userdata);
				}

				data.put("data", array);

		}catch (Exception e) {
			data.put("state", false);
			data.put("msg", "查询失败");
			e.printStackTrace();
		}
		this.outJsonString(data.toString());
	}	
	/**
	 * 获取日程
	 * @return
	 */
	public void getMeetingRc(){
		JSONObject data = new JSONObject();
		JSONArray array=new JSONArray();
		JSONArray array1=new JSONArray();
		try{
	
			//this.setSubmeetingid("11");
			
			List<Map<String,Object>> list=meetviewService.getMeetTreeRichenClient(meetingid,Integer.parseInt(userid));
			System.out.println("list is :"+list.size());
			data.put("state", true);;
			data.put("msg", "查询成功");

			JSONObject userdata = null;
			JSONObject userdata2=null;
				for(int i=0;i<list.size();i++){
					userdata=new JSONObject();

					String upload=(String)list.get(i).get("filepath");
					if(upload==null){
						upload="";
					}
					userdata.put("id",list.get(i).get("id"));
					userdata.put("name", list.get(i).get("name"));
					userdata.put("filetype", list.get(i).get("filetype"));
					userdata.put("pid", list.get(i).get("pid"));
					userdata.put("upload", upload);
					userdata.put("type", "");
					userdata.put("md5", list.get(i).get("md5"));
					array.add(userdata);
				}
				//获取日程文件
				/*List<MeetFileMainEntity> lists=meetviewService.selectALLMeetFileByMeetidAndUserid(meetingid, null, "10", Integer.parseInt(userid));
				if(lists!=null){
					for(int t=0;t<lists.size();t++){
						userdata2= new JSONObject();
						userdata2.put("id",lists.get(t).getFileid());
						userdata2.put("name", lists.get(t).getFilename());
						userdata2.put("filetype", lists.get(t).getFiletype());
						userdata2.put("upload", lists.get(t).getFilepath());
						userdata2.put("md5", lists.get(t).getFileguid());
						array1.add(userdata2);
					}
				}*/
				//日程文件
				List<MeetFileMainEntity> listyichen=meetviewService.selectALLMeetFileByMeetidAndUserid(meetingid, null, "10", Integer.parseInt(userid));
				if(listyichen!=null){
					for(int t1=0;t1<listyichen.size();t1++){
						userdata2= new JSONObject();
						userdata2.put("id",listyichen.get(t1).getFileid());
						userdata2.put("name", listyichen.get(t1).getFilename());
						userdata2.put("filetype", listyichen.get(t1).getFiletype());
						userdata2.put("upload", listyichen.get(t1).getFilepath());
						userdata2.put("md5", listyichen.get(t1).getFileguid());
						array1.add(userdata2);
					}
				}
				data.put("data1", array1);
				data.put("data", array);

		}catch (Exception e) {
			data.put("state", false);
			data.put("msg", "查询失败");
			e.printStackTrace();
		}
		this.outJsonString(data.toString());
	}	
	//selectALLMeetFileByMeetid
	/**
	 * 获取日程文件（PAD端右上角点击使用）
	 * @return
	 */
	public void getMeetingFileRc(){
		JSONObject data = new JSONObject();
		JSONArray array=new JSONArray();
		JSONArray array1=new JSONArray();
		try{
	
			//this.setSubmeetingid("11");
			
			List<Map<String,Object>> list=meetviewService.getMeetTreeRichenClient(meetingid,Integer.parseInt(userid));
			System.out.println("list is :"+list.size());
			data.put("state", true);;
			data.put("msg", "查询成功");

			JSONObject userdata = null;
			JSONObject userdata2=null;
				for(int i=0;i<list.size();i++){
					userdata=new JSONObject();

					String upload=(String)list.get(i).get("filepath");
					if(upload==null){
						upload="";
					}
					userdata.put("id",list.get(i).get("id"));
					userdata.put("name", list.get(i).get("name"));
					userdata.put("filetype", list.get(i).get("filetype"));
					userdata.put("pid", list.get(i).get("pid"));
					userdata.put("upload", upload);
					userdata.put("type", "");
					userdata.put("md5", list.get(i).get("md5"));
					array.add(userdata);
				}
				//获取日程文件
				List<MeetFileMainEntity> lists=meetviewService.selectALLMeetFileByMeetidAndUserid(meetingid, null, "10", Integer.parseInt(userid));
				if(lists!=null){
					for(int t=0;t<lists.size();t++){
						userdata2= new JSONObject();
						userdata2.put("id",lists.get(t).getFileid());
						userdata2.put("name", lists.get(t).getFilename());
						userdata2.put("filetype", lists.get(t).getFiletype());
						userdata2.put("upload", lists.get(t).getFilepath());
						userdata2.put("md5", lists.get(t).getFileguid());
						array1.add(userdata2);
					}
				}
				//日程文件
				/*List<MeetFileMainEntity> listRichen=meetviewService.selectRcFileByMeetid(meetingid);
				System.out.println("获得 日程文件");
				if(listRichen!=null){
					for(int t1=0;t1<listRichen.size();t1++){
						userdata2= new JSONObject();
						System.out.println(listRichen.get(t1).toString());
						userdata2.put("id",listRichen.get(t1).getFileid());
						userdata2.put("pid", listRichen.get(t1).getYichenid());
						userdata2.put("name", listRichen.get(t1).getFilename());
						userdata2.put("filetype", listRichen.get(t1).getFiletype());
						userdata2.put("upload", listRichen.get(t1).getFilepath());
						userdata2.put("md5", listRichen.get(t1).getFileguid());
						array1.add(userdata2);
					}
				}*/
				data.put("data1", array1);
				data.put("data", array);

		}catch (Exception e) {
			data.put("state", false);
			data.put("msg", "查询失败");
			e.printStackTrace();
		}
		this.outJsonString(data.toString());
	}	
	/**
	 * 简报
	 * @return
	 */
	
	public void getJianbao(){
		JSONObject data = new JSONObject();
		JSONArray array=new JSONArray();
		try{
			List<MeetPubBriefingEntity> list=briefingService.selectAllPubBriefingbyMeetidAndUserid(meetingid,Integer.parseInt(userid));
			data.put("state", true);
			data.put("msg", "查询成功");
			RandomID r=new RandomID();
				JSONObject userdata = null;
				for(int i=0;i<list.size();i++){
					userdata=new JSONObject();

					userdata.put("content",list.get(i).getBriefname());
					userdata.put("id", list.get(i).getBriefid());
					userdata.put("filepath", list.get(i).getFilepath());
					userdata.put("periodes", "");
					userdata.put("pid", "");
					userdata.put("datetime",r.dateToString1(list.get(i).getSendtime()));
					userdata.put("md5", list.get(i).getFileguid());
					array.add(userdata);
					
				}

				data.put("data", array);

		}catch (Exception e) {
			data.put("state", false);
			data.put("msg", "查询失败");
			e.printStackTrace();
		}
		this.outJsonString(data.toString());
		
	}
	
	/**
	 * 获得参阅文件
	 * @return
	 */
	
	public void getCYFile(){
		JSONObject data = new JSONObject();
		JSONArray array=new JSONArray();
		try{
	
			//this.setSubmeetingid("11");
			List<MeetFileMainEntity> list=meetviewService.selectALLPubMeetFileByMeetidAndVersionAndUserid(meetingid, "1", "3",Integer.parseInt(userid));
			System.out.println("list is :"+list.size());
			data.put("state", true);
			data.put("msg", "查询成功");
			JSONObject userdata = null;
				for(int i=0;i<list.size();i++){
					userdata=new JSONObject();

					userdata.put("id",list.get(i).getFileid());
					userdata.put("content", list.get(i).getTitle());
					userdata.put("filetype", list.get(i).getFiletype());
					userdata.put("pid", "");
					userdata.put("filepath", list.get(i).getFilepath());
					userdata.put("md5", list.get(i).getFileguid());
					array.add(userdata);
				}

				data.put("data", array);

		}catch (Exception e) {
			data.put("state", false);
			data.put("msg", "查询失败");
			e.printStackTrace();
		}
		this.outJsonString(data.toString());
	}

	/**
	 * 主任会议及其他会议的会议文件
	 * @return
	 */
	
	public void getMeetFiles(){
		JSONObject data = new JSONObject();
		JSONArray array=new JSONArray();
		try{
	
			//this.setSubmeetingid("11");
			List<MeetFileMainEntity> list=meetviewService.selectALLMeetFileByMeetidAndUserid(meetingid, "1",null,Integer.parseInt(userid));
			System.out.println("list is :"+list.size());
			data.put("state", true);;
			data.put("msg", "查询成功");
			JSONObject userdata = null;
				for(int i=0;i<list.size();i++){
					userdata=new JSONObject();

					userdata.put("id",list.get(i).getFileid());
					userdata.put("content", list.get(i).getTitle());
					userdata.put("filetype", list.get(i).getFiletype());
					userdata.put("pid", "");
					userdata.put("filepath", list.get(i).getFilepath());
					userdata.put("md5", list.get(i).getFileguid());
					array.add(userdata);
				}

				data.put("data", array);

		}catch (Exception e) {
			data.put("state", false);
			data.put("msg", "查询失败");
			e.printStackTrace();
		}
		this.outJsonString(data.toString());
	}

	/**
	 * 帮助文件
	 * @return
	 */
	
	public void getMeetingfilehelp(){
		JSONObject data = new JSONObject();
		JSONArray array=new JSONArray();
		try{
	
			//this.setSubmeetingid("11");
			Map<String,Object> map=new HashMap<String, Object>();
			map.put("filetype", "2");
			List<SysHelpMainEntity> list=helpService.selectAll(map);
			System.out.println("list is :"+list.size());
			data.put("state", true);;
			data.put("msg", "查询成功");
			JSONObject userdata = null;
				for(int i=0;i<list.size();i++){
					userdata=new JSONObject();
					userdata.put("id",list.get(i).getId());
					userdata.put("title", list.get(i).getTitle());
					userdata.put("filetype", list.get(i).getFiletype());
					userdata.put("filename",list.get(i).getFilename());
					userdata.put("filepath", list.get(i).getFilepath());
					userdata.put("md5", list.get(i).getFileguid());
					array.add(userdata);
				}

				data.put("data", array);

		}catch (Exception e) {
			data.put("state", false);
			data.put("msg", "查询失败");
			e.printStackTrace();
		}
		this.outJsonString(data.toString());
	}	

/**
 * 文件搜索
 */
	public void getMeetingfilesousuo(){
		JSONObject data = new JSONObject();
		JSONArray array=new JSONArray();
		try{
						
			//文件搜索
			System.out.println("filetype---:"+filetype);
			System.out.println("userid---:"+userid);
			if(filetype!=null&&filetype.trim().length()==0){
				filetype=null;
			}
			
			List<MeetFileMainEntity> list=meetviewService.searchFilesByKeywordAndFiletype(name, filetype,Integer.parseInt(userid));
			data.put("state", true);
			data.put("msg", "查询成功");
			RandomID r=new RandomID();
				JSONObject userdata = null;
				for(int i=0;i<list.size();i++){
					userdata=new JSONObject();

					userdata.put("filepath",list.get(i).getFilepath());
					userdata.put("sort", list.get(i).getSort());
					userdata.put("tongzhiid", "");
					userdata.put("chongzhi", "");
					userdata.put("pushtype", "");
					userdata.put("briefingid","");
					
					userdata.put("xuhao", "");
					userdata.put("submeetingid", "");
					userdata.put("id",list.get(i).getFileid());
					
					
					userdata.put("createtime",r.dateToString1(list.get(i).getUploadtime()));
					userdata.put("meetingid",list.get(i).getMeetid());
					userdata.put("ziliaokuid","");
					userdata.put("tuisong","");
					
					userdata.put("cmid","");
					userdata.put("isdel",list.get(i).getIsdel());
					userdata.put("filename",list.get(i).getFilename());
					userdata.put("md5",list.get(i).getFileguid());
					array.add(userdata);
					
					//"tongzhiid":null,"chongzhi":0,
					//"pushtype":1,"briefingid":0,"xuhao":0,"submeetingid":1430,"id":3155,"createtime":"2016-01-08 18:09:31",
					//"meetingid":0,"ziliaokuid":null,"tuisong":2,"cmid":5,"isdel":0,"filename":"3fd54819-e8bd-47ab-8604-f80edeff7037.doc","filetype":1}],"state":true,"msg":"查询成功"}
					
				}
				
				if(filetype!=null&&filetype.trim().length()==0){
					filetype="";
				}
				if(filetype!=null){
					
				}else{
				//简报搜索
				List<MeetBriefingMainEntity> list1=briefingService.searchBriefByKeyword(name,Integer.parseInt(userid));
					for(int i=0;i<list1.size();i++){
						userdata=new JSONObject();

						userdata.put("filepath",list1.get(i).getFilepath());
						userdata.put("sort", "");
						userdata.put("tongzhiid", "");
						userdata.put("chongzhi", "");
						userdata.put("pushtype", "");
						userdata.put("briefingid",list1.get(i).getBriefid());
						
						
						userdata.put("xuhao", "");
						userdata.put("submeetingid", "");
						userdata.put("id","");
						
						
						userdata.put("createtime",r.dateToString1(list1.get(i).getSendtime()));
						userdata.put("meetingid",list1.get(i).getMeetid());
						userdata.put("ziliaokuid","");
						userdata.put("tuisong","");
						
						userdata.put("cmid","");
						userdata.put("isdel",0);
						userdata.put("filename",list1.get(i).getFilename());
						userdata.put("md5",list1.get(i).getFileguid());
						array.add(userdata);
					}
					//通知搜索
					List<NoticePubEntity> list2=noticeService.searchNoticeByKeyword(name,Integer.parseInt(userid));
						for(int i=0;i<list2.size();i++){
							userdata=new JSONObject();

							userdata.put("filepath",list2.get(i).getPath());
							userdata.put("sort", "");
							userdata.put("tongzhiid", list2.get(i).getNoticeid());
							userdata.put("chongzhi", "");
							userdata.put("pushtype", "");
							userdata.put("briefingid","");
							
							
							userdata.put("xuhao", "");
							userdata.put("submeetingid", "");
							userdata.put("id","");
							
							
							userdata.put("createtime",r.dateToString1(list2.get(i).getSendtime()));
							userdata.put("meetingid","");
							userdata.put("ziliaokuid","");
							userdata.put("tuisong","");
							
							userdata.put("cmid","");
							userdata.put("isdel",0);
							userdata.put("filename",list2.get(i).getFilename());
							userdata.put("md5",list2.get(i).getFileguid());
							array.add(userdata);
							
						}
						//资料库搜索
						List<ZiliaokuMainEntity> list3=ziliaokuService.searchZiliaoByKeyword(name);
							for(int i=0;i<list3.size();i++){
								userdata=new JSONObject();

								userdata.put("filepath",list3.get(i).getPath());
								userdata.put("sort", "");
								userdata.put("tongzhiid","");
								userdata.put("chongzhi", "");
								userdata.put("pushtype", "");
								userdata.put("briefingid","");
								
								
								userdata.put("xuhao", "");
								userdata.put("submeetingid", "");
								userdata.put("id","");
								
								
								userdata.put("createtime",r.dateToString1(list3.get(i).getCreatetime()));
								userdata.put("meetingid","");
								userdata.put("ziliaokuid", list3.get(i).getZiliaoid());
								userdata.put("tuisong","");
								
								userdata.put("cmid","");
								userdata.put("isdel",0);
								userdata.put("filename",list3.get(i).getFilename());
								userdata.put("md5", list3.get(i).getFileguid());

								array.add(userdata);
								
							}
				      }


				data.put("data", array);

		}catch (Exception e) {
			data.put("state", false);
			data.put("msg", "查询失败");
			e.printStackTrace();
		}
		this.outJsonString(data.toString());
		
	}
	
	//set and get  method
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getDanweitype() {
		return danweitype;
	}

	public void setDanweitype(String danweitype) {
		this.danweitype = danweitype;
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getMeetingid() {
		return meetingid;
	}

	public void setMeetingid(int meetingid) {
		this.meetingid = meetingid;
	}

	public String getSubmeetingid() {
		return submeetingid;
	}

	public void setSubmeetingid(String submeetingid) {
		this.submeetingid = submeetingid;
	}
	public String getFenzuid() {
		return fenzuid;
	}


	public void setFenzuid(String fenzuid) {
		this.fenzuid = fenzuid;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getFiletype() {
		return filetype;
	}


	public void setFiletype(String filetype) {
		this.filetype = filetype;
	}


	public String getState() {
		return state;
	}


	public void setState(String state) {
		this.state = state;
	}


	public String getUserid() {
		return userid;
	}


	public void setUserid(String userid) {
		this.userid = userid;
	}


	public String getFilenameid() {
		return filenameid;
	}


	public void setFilenameid(String filenameid) {
		this.filenameid = filenameid;
	}
	public String getModuleid() {
		return moduleid;
	}
	public void setModuleid(String moduleid) {
		this.moduleid = moduleid;
	}
	public double getVersionname() {
		return versionname;
	}
	public void setVersionname(double versionname) {
		this.versionname = versionname;
	}

	public String getFilepath() {
		return filepath;
	}

	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}	
	public int getCreateuserid() {
		return createuserid;
	}


	public void setCreateuserid(int createuserid) {
		this.createuserid = createuserid;
	}

	public int getEventid() {
		return eventid;
	}

	public String getNoticeid() {
		return noticeid;
	}


	public void setNoticeid(String noticeid) {
		this.noticeid = noticeid;
	}
	
	public void setEventid(int eventid) {
		this.eventid = eventid;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
public static void main(String[] args) {
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	String date="2015-12-12";
	try {
		System.out.println(sdf.parse(date));
	} catch (ParseException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
}
}
