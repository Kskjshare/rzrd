package com.cloudrich.ereader.meeting.action;

import java.io.File;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;

import com.cloudrich.ereader.briefing.entity.MeetBriefingMainEntity;
import com.cloudrich.ereader.briefing.entity.MeetBriefingSendscopeEntity;
import com.cloudrich.ereader.briefing.service.BriefingSendscopeService;
import com.cloudrich.ereader.briefing.service.BriefingService;
import com.cloudrich.ereader.briefingpub.entity.MeetPubBriefingEntity;
import com.cloudrich.ereader.chuqueqin.entity.ChuqueqinMainEntity;
import com.cloudrich.ereader.common.action.BaseAction;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.common.util.ValidateUtil;
import com.cloudrich.ereader.dict.entity.DictDataEntity;
import com.cloudrich.ereader.dict.service.DictDataService;
import com.cloudrich.ereader.meeting.entity.Attachment;
import com.cloudrich.ereader.meeting.entity.FileSelect;
import com.cloudrich.ereader.meeting.entity.MeetFileMainEntity;
import com.cloudrich.ereader.meeting.entity.MeetGroupMainEntity;
import com.cloudrich.ereader.meeting.entity.MeetMainEntity;
import com.cloudrich.ereader.meeting.entity.MeetProcessEntity;
import com.cloudrich.ereader.meeting.entity.MeetProcessLogEntity;
import com.cloudrich.ereader.meeting.entity.MeetRichenFileEntity;
import com.cloudrich.ereader.meeting.entity.MeetRichenMainEntity;
import com.cloudrich.ereader.meeting.entity.MeetRichenYitiEntity;
import com.cloudrich.ereader.meeting.entity.MeetYichenFileEntity;
import com.cloudrich.ereader.meeting.entity.MeetYichenMainEntity;
import com.cloudrich.ereader.meeting.entity.ProcessSelectEntity;
import com.cloudrich.ereader.meeting.entity.SelectEntity;
import com.cloudrich.ereader.meeting.service.MeetingService;
import com.cloudrich.ereader.meeting.service.MeetingViewService;
import com.cloudrich.ereader.meetpub.entity.MeetPubFileEntity;
import com.cloudrich.ereader.meetpub.entity.MeetPubGroupEntity;
import com.cloudrich.ereader.meetpub.entity.MeetPubPubtimeEntity;
import com.cloudrich.ereader.meetpub.entity.MeetPubRichenEntity;
import com.cloudrich.ereader.meetpub.entity.MeetPubYichenEntity;
import com.cloudrich.ereader.notice.constant.NotifyConstant;
import com.cloudrich.ereader.system.dao.SysScopeMainDao;
import com.cloudrich.ereader.system.entity.SysScopeMainEntity;
import com.cloudrich.ereader.system.entity.SysScopeUserEntity;
import com.cloudrich.ereader.system.entity.SysUserMainEnity;
import com.cloudrich.ereader.system.service.ScopeMainService;
import com.cloudrich.ereader.system.service.ScopeUserService;
import com.cloudrich.ereader.util.Md5GuidUtil;
import com.cloudrich.framework.common.util.RandomID;
import com.opensymphony.xwork2.ActionSupport;

@Controller("MeetingAction")
public class MeetingAction extends BaseAction{
	/**
	 */
	private Page page;
	private int pageNo;
	private int pageSize=8;
	private int totalPage;
	private int id,meetid,briefid;
	private MeetMainEntity meeting;
	private String jieshu,cishu,fileFileName;
	private int type;
	private String filetype;
	private File file;
	private String jsonStr;
	
	private static final long serialVersionUID = 1534625612334334297L;
	@Resource MeetingService meetingService;
	@Resource MeetingViewService meetingViewService;
	@Resource DictDataService dictDataService;
	@Resource BriefingService briefingService;
	@Resource BriefingSendscopeService briefingSendscopeService;	
	@Resource SysScopeMainDao sysScopeMainDao;
	@Resource ScopeMainService scopeMainService;
	@Resource ScopeUserService scopeUserService;
	private MeetYichenMainEntity yitiEntity;
	private MeetRichenMainEntity richenEntity;
	private List<MeetFileMainEntity> fileMainList;
	private List<MeetBriefingMainEntity>briefinglist;
	private MeetBriefingMainEntity briefEntity;
	private int fileid,deleteid,yitiid,yichenid,richenyitiid,richenid,yichenidTreeid,sort;
	private String fileown,fileids,ftype,scopeids,filetypeSel,filetypes;
	private String sendType,groupid,groupcontent,groupno,fileName;
	private List<SelectEntity>cishuList;
	private List<SelectEntity>jieshuList;
	private String sendTimeStr;
	private String processType,comment,curstate,action,firstIn,showStateName;
	private MeetRichenYitiEntity richenYitiEntity;
	private List<MeetProcessLogEntity> processLogs;
	private List<ProcessSelectEntity>processList;
	private String fmtype;
	private List<Map<String,Object>> yichenglist;	
	private List<Map<String,Object>> richenglist;
	private List<MeetGroupMainEntity> meetgrouplist;	
	private List<MeetPubGroupEntity> meetpubgrouplist;	
	private String meettitle;
	private String[] sendScopes;
	private Map<String,Object> 	briefsendmap;	
	private List<FileSelect>fileSelect;
	private int version;
	private String statename;
	private String noTX;
    private String bindflag;

	private String pushflag;
	private String bindtype;
	private String hideBindType;
	private String yichenids,richenids;
	private String filePath;
	private List<MeetFileMainEntity> sortlist;
	public void getExistFileByName(){
			String fPath=getFindClasPathByFileName("");
			if(filePath.indexOf("upload")>-1){
				fPath=fPath+"/"+filePath;
			}else{
				fPath=fPath+"/upload/"+filePath;
			}
			File file=new File(fPath);
			System.out.println(file.exists()+","+fPath);
			if(file.exists()){
				printEditSuccess();
			}else{
				printEditError("没有文件");
			}
	}
	public void benchDelete(){
		try{
			l(fileids+","+filetypes+","+sort);
			meetingService.deleteBashYitiAndRichen(fileids, filetypes);
			id=0;
			printDeleteSuccess();
		}catch (Exception e) {
			printDeleteError("修改失败");
			e.printStackTrace();
		}
	}
	public void updateFileSort(){
		try{
			l(id+","+ftype+","+sort);
			meetingService.updateSort(id, ftype, sort);
			printEditSuccess();
		}catch (Exception e) {
			printEditError("修改失败");
			e.printStackTrace();
		}
	}
	
	//置顶
	public void updateFileSortZD(){
		try{
			l(id+","+ftype+","+sort);
			meetingService.updateSortZD(id, ftype, sort);
			printEditSuccess();
		}catch (Exception e) {
			printEditError("修改失败");
			e.printStackTrace();
		}
	}
	
	public void updateSort(){
		try{
			meetingService.updateSort(id, ftype, sort);
			System.out.println(id+","+ftype+","+sort);
			if("05".indexOf(ftype)>-1){
				System.out.println("根");
				id=0;
			}
			printEditSuccess();
		}catch (Exception e) {
			id=0;
			printEditError("修改失败");
			e.printStackTrace();
		}
	}
	
	/**
	 * 置顶
	 */
	public void updateSortZD(){
		try{
			meetingService.updateSortZD(id, ftype, sort);
			System.out.println(id+","+ftype+","+sort);
			if("05".indexOf(ftype)>-1){
				System.out.println("根");
				id=0;
			}
			printEditSuccess();
		}catch (Exception e) {
			id=0;
			printEditError("修改失败");
			e.printStackTrace();
		}
	}
	
	
	
	public String selectProcessLogByMeetid(){
		System.out.println("meetid:"+meetid);
		if(meetingViewService.selectMeetBasicByMeetId(meetid)!=null){
			meettitle=meetingViewService.selectMeetBasicByMeetId(meetid).getMname();		
		}
		page=meetingViewService.selectProcessLogByMeetid(meetid, pageNo, pageSize);
		totalPage=page.getPages();
		return "selectProcessLogByMeetid";
	}
	public void relativeRiccheng(){
		JSONObject json=new JSONObject();
		try{
			l("meetid:"+meetid);
			Map<String, Object> map = meetingService.autoRelaMeetFileAndYichen(meetid);
            json.put("bindsuccess", map.get("bindsucess"));
            json.put("bindfailure", map.get("bindfailure"));
			json.put("state", true);
		}catch (Exception e) {
			json.put("state", false);
			e.printStackTrace();
		}
		System.out.println("json:"+json.toString());
		printMyJsonInfoSuccess(json.toString());
	}
	public void selectALLMeetFileByMeetid(){
		System.out.println(meetid+","+fileown+","+filetype+","+yichenid);
		List<MeetFileMainEntity> allFiles=meetingViewService.selectALLMeetFileByMeetid(meetid, fileown, null);
		List<MeetFileMainEntity> existFiles=meetingViewService.selectAllFileByYichenid(yichenidTreeid);
		System.out.println("exist:"+existFiles);
		List<Map<String,Object>> paramsQuery = new ArrayList<Map<String,Object>>();
		Map<String, Object>map2=null;
		for(MeetFileMainEntity f:allFiles){
			map2=new HashMap<String, Object>();
			if(!"8".equals( f.getFiletype())&&!"9".equals( f.getFiletype())&&!"10".equals( f.getFiletype())){
			map2.put("id", f.getFileid());
			map2.put("name",f.getFilename());
			map2.put("checked",iscontains(f,existFiles));
			map2.put("filetype", f.getFiletype());
			map2.put("pid",0);
			paramsQuery.add(map2);
			}
		}
		System.out.println("paramsQuery:"+paramsQuery);
		JSONArray jsonArray =  JSONArray.fromObject(paramsQuery);
		outJsonString(jsonArray.toString());
	}
	private boolean iscontains(MeetFileMainEntity f, List<MeetFileMainEntity> existFiles) {
		boolean flag=false;
		for(int i=0;i<existFiles.size();i++){
			System.out.println(f.getFileid()+","+existFiles.get(i).getFileid());
			System.out.println(f.getFileid()==existFiles.get(i).getFileid());
			System.out.println(f.getFileid().equals(existFiles.get(i).getFileid()));
			if((f.getFileid()==existFiles.get(i).getFileid())||f.getFileid().equals(existFiles.get(i).getFileid())){
				flag=true;
			}
		}
		System.out.println("flag:"+flag);
		return flag;
	}
/*	public void submitMeetProcess(){
		JSONObject json=null;
		try{
			MeetProcessEntity entity=new MeetProcessEntity();
			entity.setMeetid(meetid);
			entity.setSubmodulecode(processType);
			entity.setCurstate(curstate);
			entity.setSubmitaction(action);
			entity.setTjuserid(getUseridInSession());
			entity.setComment(comment);
			entity.setTjdatetime(new Date());
			System.out.println("entity:"+entity);
			meetingService.submitMeetProcess(entity);
			System.out.println(meetid+","+processType);
			json=getCurMeetProcessJson(meetid,processType);
			json.put("state", true);
		}catch (Exception e) {
			json.put("state", false);
			e.printStackTrace();
		}
		System.out.println("json:"+json.toString());
		printMyJsonInfoSuccess(json.toString());
	}*/
	@SuppressWarnings("unchecked")
	public void getCurMeetProcess(){
		//yichen 代表议程的流程状态
		//richen 代表日程的流程状态
		//file   代表文件管理的议程状态
		//meet  代表整个会议的流程状态（流程记录中）
		JSONObject json=getCurMeetProcessJson(meetid,processType);
		System.out.println("json:"+json.toString());
		outJsonString(json.toString());
	}
	public void getSelects(){
		JSONObject json=getSelectJson();
		outJsonString(json.toString());
	}
	private JSONObject getCurMeetProcessJson(int meetid2, String processType2) {
		JSONObject json=new JSONObject();
		try{
			MeetProcessEntity process=null;
			process=meetingService.getCurMeetProcess(meetid2,processType2);
			json.put("curstate", process.getCurstate());
			json.put("statename", process.getCurstatename());
			json.put("comment", process.getComment());
			System.out.println(process.getCurstate());
			System.out.println(process.getCurstatename());
			System.out.println(process.getComment());
			List<Map<String,Object>> list=process.getActionlist();
			JSONArray array=new JSONArray();
			for(int i=0;i<list.size();i++){
				JSONObject js=new JSONObject();
				js.put("action",list.get(i).get("action") );
				js.put("actionname",list.get(i).get("actionname") );
				array.add(js);
			}
			json.put("list", JSONArray.fromObject(array).toString());
			json.put("state", true);
		}catch (Exception e) {
			json.put("state", false);
			e.printStackTrace();
		}
		return json;
	}
	private JSONObject getSelectJson() {
		JSONObject json=new JSONObject();
		try{
			List<DictDataEntity> meetjnumlist=dictDataService.getDictDataByType("meetjnum");
			List<DictDataEntity> meetcnumlist=dictDataService.getDictDataByType("meetcnum");
			json.put("jslist", JSONArray.fromObject(meetjnumlist).toString());
			//json.put("cslist", JSONArray.fromObject(meetcnumlist).toString());
			Map<String,Object> map=new HashMap<String, Object>();
			map.put("jnum",jieshu );
			map.put("mtype",fmtype);
			//json.put("cslist", meetingViewService.selectMaxCnumByMtypeAndJnum(map));
			json.put("state", true);
//			System.out.println(meetjnumlist+","+meetcnumlist);
		}catch (Exception e) {
			json.put("state", false);
			e.printStackTrace();
		}
		return json;
	}
	public void addFenzu(){
		try{
			MeetGroupMainEntity groupMain=new MeetGroupMainEntity();
			groupMain.setMeetid(meetid);
			groupMain.setGroupno(groupno);
			groupMain.setFilename(fileName);
			groupMain.setTitle(fileName.substring(0,fileName.indexOf(".")));
			groupMain.setUploadtime(new Date());	
			if(ValidateUtil.isValid(groupid)&&Integer.parseInt(groupid)!=0){
				groupMain.setGroupid(Integer.parseInt(groupid));
			}
			System.out.println("file:"+file+","+fileName);
			if(file!=null){
				if(file.exists()){
					String upFile=saveUploadFile(file, fileName, true);
					String uppath=upFile.substring(upFile.indexOf("upload")).replace("\\", "/");	
					groupMain.setFilepath(uppath);	
					groupMain.setFileguid(Md5GuidUtil.getMd5Guid(file));
				}
			}
			int i=meetingService.upddateMeetGrp(groupMain);
			JSONObject json=new JSONObject();
			if(pushflag.equals("1")){//保存并发布
				boolean b=meetingService.submitFenzuPub(meetid,groupno);
				if(b){
					json.put("msg", "发布成功");
					json.put("state", true);
				}else{
					json.put("msg", "发布失败");
					json.put("state", false);			
				}
			}else{
				if(i>0){
					json.put("msg", "保存成功");
					json.put("state", true);
				}else{
					json.put("msg", "保存失败");
					json.put("state", false);				
				}
			}

			this.outJsonString(json.toString());
		}catch (Exception e) {
			printMyJsonError("录入错误");
			e.printStackTrace();
			printAddError("error");
		}	
	}
	public String getFenzuList(){
		try {
			meetgrouplist=meetingService.getMeetGrp(meetid);
			for (int i = 0; i < meetgrouplist.size(); i++) {
				MeetGroupMainEntity entity=meetgrouplist.get(i);
				Map<String,Object> map=new HashMap<String, Object>();
				map.put("meetid",meetid);
				map.put("groupno", entity.getGroupno());
				MeetPubGroupEntity pubentity=meetingService.selectGroupPubTime(map);
				if(pubentity!=null){
					entity.setPushtime(pubentity.getPushtime());
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "getFenzuList";
	}
	public String getPubFenzuList(){
		try {
			Map<String,Object> map=new HashMap<String, Object>();
			map.put("meetid",meetid);
			meetpubgrouplist=meetingService.getPubMeetGrp(map);

			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "getPubFenzuList";
	}
	public void getFenzu(){
		JSONObject json=new JSONObject();
		try{
			System.out.println(meetid+","+groupno);
			MeetGroupMainEntity groupEntity=meetingViewService.selectGroupByMeetidAndGrpno(meetid, groupno);
/*			Map<String,Object> map=new HashMap<String, Object>();
			map.put("meetid",meetid);
			map.put("groupno", groupno);
			MeetPubGroupEntity entity=meetingService.selectGroupPubTime(map);
			if(entity!=null){
				SimpleDateFormat sd=new SimpleDateFormat("yyyy-MM-dd HH:mm");
				json.put("pushtime",sd.format(entity.getPushtime()));
			}else{
				json.put("pushtime","");
			}
			if(groupEntity!=null){
				//json.put("groupcontent",groupEntity.getGroupcontent());
				json.put("groupid", groupEntity.getGroupid());
				json.put("state", true);
			}else{
				json.put("state", false);
			}*/
			if(groupEntity!=null){
				json.put("groupno", groupEntity.getGroupno());
				json.put("filename", groupEntity.getFilename());
				json.put("groupid", groupEntity.getGroupid());
				json.put("state", true);
			}else{
				json.put("state", false);
			}

		}catch (Exception e) {
			e.printStackTrace();
			json.put("state", false);
		}
		System.out.println("json:"+json.toString());
		this.outJsonString(json.toString());
	}
	public void deleteFenzu(){
		JSONObject json=new JSONObject();
		try {
			int i=meetingViewService.deleteGroupByGroupid(Integer.parseInt(groupid));
			if(i>0){
				meetingViewService.deletePubGroupByGroupid(Integer.parseInt(groupid));
				json.put("msg","删除成功");
				json.put("state", true);
			}else{
				json.put("state", false);
				json.put("msg","删除失败");
			}			
		} catch (Exception e) {
			e.printStackTrace();
			json.put("state", false);
			json.put("msg", "操作失败");
		}
		this.outJsonString(json.toString());
	}
	public String updateJiyao() throws Exception{
		try{
			MeetBriefingMainEntity entity = briefingService.selectBriefingById(briefid);
			if(file!=null&&file.exists()&&ValidateUtil.isValid(fileFileName)){
				String upFile = saveUploadFile(file, fileFileName,true);
				entity.setFilename(fileFileName);
				String uppath=upFile.substring(upFile.indexOf("upload")).replace("\\", "/");
				entity.setFilepath(uppath);
				entity.setBriefname((fileFileName.indexOf(".")>-1)?fileFileName.substring(0, fileFileName.indexOf(".")):fileFileName);
			}
			entity.setMeetid(meetid);
			entity.setSendtime(new Date());
			if(NotifyConstant.SENDTYPE_CUSTOM.equals(sendType)){
				entity.setSendtime(parseDataStr(sendTimeStr));
			}else{
				entity.setSendtime(entity.getSendtime());
			}
			entity.setSendtype(sendType);
			System.out.println("entity:"+entity);
			briefingService.update(entity);
			jsonSuccess("更新成功");
		}catch (Exception e) {
			jsonError("更新失败");
			e.printStackTrace();
		}
		return "updateJiyao";
	}
	public String updateBriefing() throws Exception{
		try{
		MeetBriefingMainEntity entity = briefingService.selectBriefingById(briefid);
		if(file!=null&&file.exists()&&ValidateUtil.isValid(fileFileName)){
			String upFile = saveUploadFile(file, fileFileName,true);
			String uppath=upFile.substring(upFile.indexOf("upload")).replace("\\", "/");
			entity.setFilename(fileFileName);
			entity.setFilepath(uppath);
			entity.setFileguid(Md5GuidUtil.getMd5Guid(file));
			entity.setBriefname((fileFileName.indexOf(".")>-1)?fileFileName.substring(0, fileFileName.indexOf(".")):fileFileName);
		}

		entity.setMeetid(meetid);
		entity.setPubtime(new Date());
		entity.setSendtime(new Date());
		if(NotifyConstant.SENDTYPE_CUSTOM.equals(sendType)){
			entity.setSendtime(parseDataStr(sendTimeStr));
		}else{
			entity.setSendtime(entity.getSendtime());
		}
		entity.setSendtype(sendType);
		System.out.println("entity:"+entity);
		int j=briefingService.update(entity);
		if(j>0){
			MeetBriefingSendscopeEntity noticeSendscopeEntity=new MeetBriefingSendscopeEntity(); 
			briefingSendscopeService.deleteByBriefid(briefid);
			if(sendScopes!=null&&sendScopes.length>0){
				for (int i = 0; i < sendScopes.length; i++) {
					noticeSendscopeEntity.setScopeid(Integer.valueOf(sendScopes[i]));
					noticeSendscopeEntity.setBriefid(briefid);
					briefingSendscopeService.insert(noticeSendscopeEntity);	
				}
			}
		}
		if(pushflag.equals("1")){
			int i=briefingService.insertPush(entity,"update");
			if(i>0){
				jsonSuccess("发布成功");
			}else{
				jsonError("发布失败");
			}
		}	
		jsonSuccess("更新成功");
		}catch (Exception e) {
			jsonError("更新失败");
			e.printStackTrace();
		}
		return "updateBriefing";
	}
	public String getBriefing(){
		briefEntity=briefingService.selectBriefingById(briefid);
		System.out.println("loadBriefing:"+briefEntity);
		List<MeetBriefingSendscopeEntity> briefsendscopelist=briefingSendscopeService.selectByBriefid(briefid);
		briefsendmap=new HashMap<String, Object>();
		briefsendmap.put("briefEntity", briefEntity);
		briefsendmap.put("briefsendscopelist", briefsendscopelist);
		return "getBriefing";
	}
	public String getJiyao(){
		briefEntity=briefingService.selectBriefingById(briefid);
		System.out.println("loadBriefing:"+briefEntity);
		return "getJiyao";
	}
	public String deleteJiyao() throws Exception{
		try{
			System.out.println("briefid:"+briefid);
			briefingService.delete(briefid);
			jsonSuccess("删除成功");
		}catch (Exception e) {
			jsonSuccess("删除失败");
			e.printStackTrace();
		}
		return "deleteJiyao";
	}
	public String deleteBriefing() throws Exception{
		try{
			System.out.println("briefid:"+briefid);
			int i=briefingService.delete(briefid);
			if(i>0){
				briefingSendscopeService.deleteByBriefid(briefid);
			}
			jsonSuccess("删除成功");
		}catch (Exception e) {
			jsonSuccess("删除失败");
			e.printStackTrace();
		}
		return "deleteBriefing";
	}
	
	/**
	 * 删除历史会议
	 * @return
	 * @throws Exception
	 */
	public String deletemeetLS() throws Exception{
		try{
			System.out.println("meetid:"+meetid);
			int i=meetingViewService.deletemeetLS(meetid);
			jsonSuccess("删除成功");
		}catch (Exception e) {
			jsonSuccess("删除失败");
			e.printStackTrace();
		}
		return "deletemeetLS";
	}
	public String addJiyao() throws Exception{
		try{
			String upFile = saveUploadFile(file, fileFileName,true);
			MeetBriefingMainEntity entity = new MeetBriefingMainEntity();
			entity.setBriefname((fileFileName.indexOf(".")>-1)?fileFileName.substring(0, fileFileName.indexOf(".")):fileFileName);
			entity.setFilename(fileFileName);
			entity.setFilepath(upFile);
			entity.setSendtype(sendType);
			entity.setMeetid(meetid);
			entity.setSendtime(new Date());
			if(NotifyConstant.SENDTYPE_CUSTOM.equals(sendType)){
				entity.setSendtime(parseDataStr(sendTimeStr));
			}else{
				entity.setSendtime(entity.getSendtime());
			}
			entity.setSendtype(sendType);
			System.out.println("entity:"+entity);
			briefingService.insert(entity);
			jsonSuccess("发布成功");
		}catch (Exception e) {
			jsonSuccess("发布失败");
			System.out.println("error");
			e.printStackTrace();
		}
		return "addJiyao";
	}
	//保存与发布简报 ,保存简报pushflag为0 ,发布简报pushflag为1
	public String addBriefing() throws Exception{
		try{
			System.out.println("=========保存与发布简报=========");
			String upFile = saveUploadFile(file, fileFileName,true);
			MeetBriefingMainEntity entity = new MeetBriefingMainEntity();
			entity.setBriefname((fileFileName.indexOf(".")>-1)?fileFileName.substring(0, fileFileName.indexOf(".")):fileFileName);
			entity.setFilename(fileFileName);
			String uppath=upFile.substring(upFile.indexOf("upload")).replace("\\", "/");
			entity.setFilepath(uppath);
			entity.setSendtype(sendType);
			entity.setMeetid(meetid);
			entity.setPubtime(new Date());
			entity.setSendtime(new Date());
			entity.setFileguid(Md5GuidUtil.getMd5Guid(file));
			if(NotifyConstant.SENDTYPE_CUSTOM.equals(sendType)){
				entity.setSendtime(parseDataStr(sendTimeStr));
			}else{
				entity.setSendtime(entity.getSendtime());
			}
			entity.setSendtype(sendType);
			int num=briefingService.insert(entity);
			if(num>0){
				MeetBriefingSendscopeEntity noticeSendscopeEntity=new MeetBriefingSendscopeEntity(); 
				if(sendScopes!=null&&sendScopes.length>0){
					for (int i = 0; i < sendScopes.length; i++) {
						noticeSendscopeEntity.setScopeid(Integer.valueOf(sendScopes[i]));
						noticeSendscopeEntity.setBriefid(entity.getBriefid());
						briefingSendscopeService.insert(noticeSendscopeEntity);
					}
				}
			}
			System.out.println("是否发布："+pushflag);
			if(pushflag.equals("1")){
				System.out.println("==Action层 发布简报==");
				int i=briefingService.insertPush(entity,"insert");
				if(i>0){
					jsonSuccess("发布成功");
				}else{
					jsonError("发布失败");
				}
			}else{
				jsonSuccess("保存成功");
			}
		}catch (Exception e) {
			jsonSuccess("保存失败");
			e.printStackTrace();
		}
		return "addBriefing";
	}
	private Date parseDataStr(String dateStr) throws Exception{
		SimpleDateFormat format = new SimpleDateFormat(DATE_PATTERN);
		return format.parse(dateStr);
	}
	private static final String DATE_PATTERN = "yyyy-MM-dd HH:mm:ss";
	public String getBriefingList(){
		briefinglist=briefingService.selectAllBriefingbyMeetid(meetid);
		if(briefinglist!=null&&briefinglist.size()>0){
			for (int i = 0; i < briefinglist.size(); i++) {
				int briefId=briefinglist.get(i).getBriefid();
				MeetPubBriefingEntity pubentity=briefingService.selectLastPubBrief(briefinglist.get(i).getBriefid());
				briefinglist.get(i).setSendtime(pubentity==null?null:pubentity.getPubtime());//最后一次发布时间
				String scopename="";
				List<MeetBriefingSendscopeEntity> briefsendscopelist=briefingSendscopeService.selectByBriefid(briefId);
				for (int j = 0; j < briefsendscopelist.size(); j++) {
					scopename+=sysScopeMainDao.selectByPrimaryKey(briefsendscopelist.get(j).getScopeid()).getScopename()+",";
				}
				briefinglist.get(i).setScopename(scopename.substring(0,scopename.lastIndexOf(",")));
			}

		}
		return "getBriefingList";
	}
	public String getJiyaoList(){
		System.out.println("meetid:"+meetid);
		briefinglist=briefingService.selectAllBriefingbyMeetid(meetid);
		if(briefinglist!=null&&briefinglist.size()>0){
			for (int i = 0; i < briefinglist.size(); i++) {
				int briefId=briefinglist.get(i).getBriefid();
				MeetPubBriefingEntity pubentity=briefingService.selectLastPubBrief(briefinglist.get(i).getBriefid());
				briefinglist.get(i).setSendtime(pubentity==null?null:pubentity.getPubtime());//最后一次发布时间
				String scopename="";
				List<MeetBriefingSendscopeEntity> briefsendscopelist=briefingSendscopeService.selectByBriefid(briefId);
				for (int j = 0; j < briefsendscopelist.size(); j++) {
					scopename+=sysScopeMainDao.selectByPrimaryKey(briefsendscopelist.get(j).getScopeid()).getScopename()+",";
				}
				briefinglist.get(i).setScopename(scopename.substring(0,scopename.lastIndexOf(",")));
			}

		}		
		System.out.println("briefinglist:"+briefinglist);
		return "getJiyaoList";
	}
	public void loadMeeting(){
		MeetMainEntity meet=meeting=meetingViewService.selectEntityById(meetid);
		JSONObject json=new JSONObject();
		RandomID r=new RandomID();
		json.put("meeting.sdateStr",r.dateToString(meet.getSdate()));
		json.put("meeting.edateStr",r.dateToString(meet.getEdate()));
		json.put("cishu",getCishu(meeting.getMname(), type));
		json.put("jieshu",getJieshu(meeting.getMname(), type));
		this.outJsonString(json.toString());
	}
	public void loadYichen(){
		MeetYichenMainEntity entity=meetingViewService.selectYichenByYichenId(yichenid);
		JSONObject json=new JSONObject();
		json.put("yitiEntity.title",entity.getTitle());
		json.put("yitiEntity.sort",entity.getSort());
		this.outJsonString(json.toString());
	}
	public void loadRichenYiti(){
		MeetRichenYitiEntity entity=meetingViewService.getMeetRichenYitiByYitiid(richenyitiid);
		JSONObject json=new JSONObject();
		System.out.println("entity:"+entity);
		json.put("richenYitiEntity.title",entity.getTitle());
		json.put("richenYitiEntity.sort",entity.getSort());
		json.put("richenYitiEntity.bindbimu",entity.getBindbimu());	
		this.outJsonString(json.toString());
	}
	public void getRichenBimuFlag(){
		MeetRichenYitiEntity entity=meetingViewService.getMeetRichenYitiByYitiid(richenyitiid);
		JSONObject json=new JSONObject();
		json.put("flag",entity.getBindbimu());	
		this.outJsonString(json.toString());
	}
	public void loadRichen(){
		MeetRichenMainEntity entity=meetingViewService.getMeetRichenByRichenid(richenid);
		JSONObject json=new JSONObject();
		json.put("richenEntity.name",entity.getName());
		json.put("richenEntity.sort",entity.getSort());
		this.outJsonString(json.toString());
	}
	public void deleteRichen(){
		try{
			System.out.println("deleteid:"+deleteid);
//			MeetYichenMainEntity entity=new MeetYichenMainEntity();
			meetingService.deleteRichen(deleteid);
			id=0;
			this.printDeleteSuccess();
		} catch (Exception e) {
			e.printStackTrace();
			this.printDeleteError("删除失败");
		}
	}
	public void deleteRichenYiti(){
		try{
			System.out.println("richenyitiid:"+richenyitiid);
//			MeetYichenMainEntity entity=new MeetYichenMainEntity();
			meetingService.deleteRichenYiti(richenyitiid);
			id=0;
			this.printDeleteSuccess();
		} catch (Exception e) {
			e.printStackTrace();
			this.printDeleteError("删除失败");
		}
	}
	
	public void deleteYichen(){
		try{
			System.out.println("deleteid:"+deleteid);
//			MeetYichenMainEntity entity=new MeetYichenMainEntity();
			meetingService.delMeetYichen(deleteid);
			id=0;
			this.printDeleteSuccess();
		} catch (Exception e) {
			e.printStackTrace();
			this.printDeleteError("删除失败");
		}
	}
	public void selectRichen(){
		System.out.println(meetid+","+id+","+firstIn+","+("0".equals(firstIn)));
		List<Map<String, Object>>tasks=meetingViewService.getMeetTreeRichen(meetid);
		System.out.println("task:"+tasks);
		List<Map<String, Object>>tasks1=new ArrayList<Map<String,Object>>();
		if(id!=0){
			for(int i=0;i<tasks.size();i++){
				if(!"0".equals(String.valueOf(tasks.get(i).get("pid")))){
					String tpid=tasks.get(i).get("pid")+"";
					if((id+"").equals(tpid)){
						tasks1.add(tasks.get(i));
					}
				}
			}
			System.out.println("task:"+tasks1);
		}else{
			//第一次进入
			for(int i=0;i<tasks.size();i++){
				if("0".equals(String.valueOf(tasks.get(i).get("pid")))){
//					System.out.println("remove");
//					System.out.println("i:"+i);
					tasks1.add(tasks.get(i));
//					System.out.println(tasks.size());
				}
			}
		}
		//System.out.println("tasks1:"+tasks1.toString());
		this.outJsonString(JSONArray.fromObject(tasks1).toString());
	}
	public void selectYichen(){
		System.out.println(meetid+","+id+","+firstIn+","+("0".equals(firstIn)));
		List<Map<String, Object>>tasks=meetingViewService.getMeetTreeYichen(meetid);
		//System.out.println("task:"+tasks);
		List<Map<String, Object>>tasks1=new ArrayList<Map<String,Object>>();
			if(id!=0){
				for(int i=0;i<tasks.size();i++){
					if(!"0".equals(String.valueOf(tasks.get(i).get("pid")))){
						String tpid=tasks.get(i).get("pid")+"";
						if((id+"").equals(tpid)){
							tasks1.add(tasks.get(i));
						}
					}
				}
			}else{
				//第一次进入
				for(int i=0;i<tasks.size();i++){
					if("0".equals(String.valueOf(tasks.get(i).get("pid")))){
//						System.out.println("remove");
//						System.out.println("i:"+i);
							tasks1.add(tasks.get(i));
//							System.out.println(tasks.size());
					}
				}
			}
			//System.out.println("tasks1:"+tasks1.toString());
			this.outJsonString(JSONArray.fromObject(tasks1).toString());
	}
	public String selectPubtimeYichen(){
		Map<String ,Object> map=new HashMap<String, Object>();
		map.put("meetid", meetid);
		map.put("moduleid", 1);
		MeetPubPubtimeEntity entity=meetingViewService.selectMeetPubPubtime(map);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
		if(entity!=null){
			jsonSuccess(sdf.format(entity.getPubtime()));
		}else{
			jsonSuccess("");
		}
		return "selectPubtimeYichen";
	}
	public String selectPubtimeRichen(){
		Map<String ,Object> map=new HashMap<String, Object>();
		map.put("moduleid", 2);
		map.put("meetid", meetid);
		MeetPubPubtimeEntity entity=meetingViewService.selectMeetPubPubtime(map);
		//MeetPubRichenEntity entity=meetingViewService.selectRichenPubtimeByMeetid(map);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
		if(entity!=null){
			jsonSuccess(sdf.format(entity.getPubtime()));				
		}else{
			jsonSuccess("");						
		}
		return "selectPubtimeRichen";
	}
	public String selectPubtimeFile(){
		Map<String ,Object> map=new HashMap<String, Object>();
		map.put("meetid", meetid);
		if("1".equals(fileown)){
			map.put("moduleid", 3);			
		}else if("2".equals(fileown)){
			map.put("moduleid", 5);
		}else if("3".equals(fileown)){
			map.put("moduleid", 6);
		}
		MeetPubPubtimeEntity entity=meetingViewService.selectMeetPubPubtime(map);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
		if(entity!=null){
			jsonSuccess(sdf.format(entity.getPubtime()));
		}else{
			jsonSuccess("");
		}
		return "selectPubtimeFile";
	}
	public String deleteFileAction(){
		System.out.println("fileid:"+fileid);
		meetingService.deleteMeetFile(fileid);
		return "deleteFileAction";
	}
	public void deleteMeetFiles(){
		try{
			l(id+","+fileids+","+sort);
			meetingService.deleteMeetFiles(fileids);
			printEditSuccess();
		}catch (Exception e) {
			printEditError("删除失败");
			e.printStackTrace();
		}
	}
	public void deleteFile(){
		System.out.println("deleteFile-----"+fileid);
		PrintWriter out = null;
		try {
			out= this.getResponse().getWriter();
			meetingService.deleteMeetFile(fileid);
			out.print("success");
		} catch (Exception e) {
			e.printStackTrace();
			out.print("fail");
		}
	}
	public void uploadFileType(){
		MeetFileMainEntity entity=new MeetFileMainEntity();
		entity.setFileid(fileid);
		entity.setFiletype(filetype);
		entity.setMeetid(meetid);
		System.out.println("title="+fileid+"----filetype="+entity.getFiletype()+","+meetid);
//		String result=subMeetingService.uploadFileType(params);
		try{
			 meetingService.updateFileTypeByFileId(entity);
			 this.outJsonString(this.getJsonEditSuccess());
		}catch (Exception e) {
			e.printStackTrace();
			this.outJsonString(this.getJsonEditError("修改失败"));
		}
	}
	//获取所有推送范围
	public void selectFiledefineMainList(){
		/*txlist=userService.selectAll(new HashMap<String, Object>());
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
		totalPage=page.getPages();*/
		System.out.println("发送范围");
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
		System.out.println("推送jsonStr");
		System.out.println(jsonStr);
		//return ActionSupport.SUCCESS;
		//return jsonStr;
		outJsonString(jsonStr);
	}
	public String getMeetFile2(){
		
		HashMap<String,Object>map=new HashMap<String, Object>();
		if(meetid!=0){
			map.put("meetid", meetid);
		}
		if(ValidateUtil.isValid(filetype)){
			map.put("filetype", filetype);
		}
		if(ValidateUtil.isValid(fileown)){
			map.put("fileown", fileown);
		}
		if("1".equals(fileown)){
			fileSelect=getFileSel();
		}else{
			fileSelect=getFileSel2();
		}
		if(!"0".equals(bindtype)&&"1".equals(fileown)){
			map.put("bindtype", bindtype);
		}	
		//hideBindType=bindtype;
//		if("1".equals(fileown)){
//			MeetProcessEntity process=meetingService.getCurMeetProcess(meetid,"file");
//			System.out.println("process:"+process);
//			System.out.println(process.getCurstate());
//			System.out.println(process.getCurstatename());
//			List<Map<String,Object>> list=process.getActionlist();
//			processList=new ArrayList<ProcessSelectEntity>();
//			ProcessSelectEntity pse=null;
//			for(int i=0;i<list.size();i++){
//				pse=new ProcessSelectEntity();
//				pse.setAction(list.get(i).get("action").toString());
//				pse.setActionname(list.get(i).get("actionname").toString());
//				processList.add(pse);
//			}
//			curstate=process.getCurstate();
//			showStateName="状态:"+process.getCurstatename();
//		}
		//System.out.println("map:"+map);
		page=meetingViewService.selectALLMeetFileByMeetid1(map, pageNo, pageSize);
		System.out.println("page:"+page.getResult());
		totalPage=page.getPages();
		sortlist =meetingViewService.selectALLMeetFileByMeetid1(meetid,fileown,null);
		//System.out.println("fileMainList:"+page.getResult()+","+pageNo+","+meetid+","+pageSize+","+type);
		return getFileManagerIndex(type,fileown);
	}
	
	public String getMeetFile(){
		HashMap<String,Object>map=new HashMap<String, Object>();
		if(meetid!=0){
			map.put("meetid", meetid);
		}
		if(ValidateUtil.isValid(filetype)){
			map.put("filetype", filetype);
		}
		if(ValidateUtil.isValid(fileown)){
			map.put("fileown", fileown);
		}
		if("1".equals(fileown)){
			fileSelect=getFileSel();
		}else{
			fileSelect=getFileSel2();
		}
		if(!"0".equals(bindtype)&&"1".equals(fileown)){
			map.put("bindtype", bindtype);
		}	
		//hideBindType=bindtype;
//		if("1".equals(fileown)){
//			MeetProcessEntity process=meetingService.getCurMeetProcess(meetid,"file");
//			System.out.println("process:"+process);
//			System.out.println(process.getCurstate());
//			System.out.println(process.getCurstatename());
//			List<Map<String,Object>> list=process.getActionlist();
//			processList=new ArrayList<ProcessSelectEntity>();
//			ProcessSelectEntity pse=null;
//			for(int i=0;i<list.size();i++){
//				pse=new ProcessSelectEntity();
//				pse.setAction(list.get(i).get("action").toString());
//				pse.setActionname(list.get(i).get("actionname").toString());
//				processList.add(pse);
//			}
//			curstate=process.getCurstate();
//			showStateName="状态:"+process.getCurstatename();
//		}
		//System.out.println("map:"+map);
		page=meetingViewService.selectALLMeetFileByMeetid(map, pageNo, pageSize);
		System.out.println("page:"+page.getResult());
		totalPage=page.getPages();
		sortlist =meetingViewService.selectALLMeetFileByMeetid(meetid,fileown,null);
		//System.out.println("fileMainList:"+page.getResult()+","+pageNo+","+meetid+","+pageSize+","+type);
		return getFileManagerIndex(type,fileown);
	}
	public List<FileSelect> getFileSel(){
		List<FileSelect> fileSelect1=new ArrayList<FileSelect>();
		FileSelect f0=new FileSelect("", "全部");
		FileSelect f=new FileSelect("1", "正式文件");
		FileSelect f2=new FileSelect("2", "延伸阅读");
		FileSelect f3=new FileSelect("3", "参阅文件");
		FileSelect f4=new FileSelect("8", "闭幕会文件");
		FileSelect f5=new FileSelect("9", "议程文件");
		FileSelect f6=new FileSelect("10", "日程文件");
		fileSelect1.add(f0);
		fileSelect1.add(f);
		fileSelect1.add(f2);
		fileSelect1.add(f3);
		fileSelect1.add(f4);
		fileSelect1.add(f5);
		fileSelect1.add(f6);
		for(int i=0;i<fileSelect1.size();i++){
			if(fileSelect1.get(i).getFvalue().equals(filetype)){
				System.out.println(filetype+","+fileSelect1.get(i).getFvalue());
				fileSelect1.set(0, fileSelect1.set(i, fileSelect1.get(0)));
			}
		}
		return fileSelect1;
	}
	public List<FileSelect> getFileSel2(){
		List<FileSelect> fileSelect1=new ArrayList<FileSelect>();
		FileSelect f0=new FileSelect("","全部");
		FileSelect f=new FileSelect("1","正式文件");
		FileSelect f2=new FileSelect("2","延伸阅读");
		//FileSelect f5=new FileSelect("9", "议程文件");
		fileSelect1.add(f0);
		fileSelect1.add(f);
		fileSelect1.add(f2);
		//fileSelect1.add(f5);
		for(int i=0;i<fileSelect1.size();i++){
			if(fileSelect1.get(i).getFvalue().equals(filetype)){
				fileSelect1.set(0, fileSelect1.set(i, fileSelect1.get(0)));
			}
		}
		return fileSelect1;
	}
	private String getFileManagerIndex(int type, String fileown) {
		System.out.println("getFileManagerIndex:"+type+","+fileown);
		if(type==1){
			return "getMeetFilezrh1";
		}else if(type==2){
			if("1".equals(fileown)){
				return "getMeetFilecwh1";
			}else if("2".equals(fileown)){
				return "getMeetFilecwh2";
			}
		}else if(type==3){
			return "getMeetFilezrh1";
		}else if(type==4){
			return "getMeetFilezrh1";
		}else if(type==5){
			return "getMeetFilezrh1";
		}
		return SUCCESS;
	}
	
	public void addRichenYiti(){
		try{
//			MeetYichenMainEntity entity=new MeetYichenMainEntity();
			//System.out.println("richenYitiEntity:"+richenYitiEntity);
			meetingService.addRichenYiti(richenYitiEntity);
//			if(richenYitiEntity.getPrichenid()==0){
//				id=0;
//			}
			printAddSuccess();
		}catch (Exception e) {
			e.printStackTrace();
			printAddError("新增失败");
		}
	}
	public void updateRichenYiti(){
		try{
			richenYitiEntity.setYitiid(richenYitiEntity.getYitiid());
			if("1".equals(richenYitiEntity.getBindbimu())){
				meetingService.bindRichenFile(richenYitiEntity.getYitiid(), fileids.split(","));
			}
			meetingService.updateRichenYiti(richenYitiEntity);				
			printAddSuccess();
		}catch (Exception e) {
			e.printStackTrace();
			printAddError("新增失败");
		}
	}
	
	public void getMeetTreeYichenNoFileJson(){
		//System.out.println("meetid:"+meetid+","+yitiid+","+yichenidTreeid);
		List<Map<String, Object>> allFiles=meetingViewService.getMeetTreeYichenNoFile(meetid);
		MeetRichenYitiEntity existYichens=meetingViewService.getMeetRichenYitiByYitiid(yichenidTreeid);
		//System.out.println("existYichens:"+existYichens);	
		List<Map<String,Object>> paramsQuery = new ArrayList<Map<String,Object>>();
		for(Map<String, Object> f:allFiles){
			f.put("checked",iscontainsYiChen(String.valueOf(f.get("id")),existYichens));
			paramsQuery.add(f);
		}
		//System.out.println("paramsQuery:"+paramsQuery);
		JSONArray jsonArray =  JSONArray.fromObject(paramsQuery);
		outJsonString(jsonArray.toString());
	}
	private boolean iscontainsYiChen(String id, MeetRichenYitiEntity existYichens) {
		boolean flag=false;
		if(existYichens!=null&&existYichens.getBindyichenid()!=null){
			String[] yitiidArr=existYichens.getBindyichenid().split(",");
			for(int i=0;i<yitiidArr.length;i++){
//				System.out.println(f.getFileid()+","+existFiles.get(i).getFileid());
				if(id.equals(yitiidArr[i])){
					flag=true;
				}
			}
		}
		return flag;
	}
	public void getMeetTreeCloseFileJson(){
		List<MeetFileMainEntity> list=meetingViewService.selectALLMeetFileByMeetid(meetid,"1","8");
		List<Map<String,Object>> paramsQuery = new ArrayList<Map<String,Object>>();
		List<MeetRichenFileEntity> existFiles=meetingViewService.selectAllFileByRichenid(richenid);
		for (int i = 0; i < list.size(); i++) {
			 java.util.Map<String,Object> map=new HashMap<String,Object>();
			 map.put("name", list.get(i).getTitle());
			 map.put("id",  list.get(i).getFileid());
			 map.put("sort", list.get(i).getSort());
			 map.put("filetype", list.get(i).getFiletype());
			 map.put("checked", iscontainsFile(list.get(i),existFiles));
			paramsQuery.add(map);
		}

		JSONArray jsonArray =  JSONArray.fromObject(paramsQuery);
		outJsonString(jsonArray.toString());		
	}

	//判断日程是否已绑定闭幕会文件
	private boolean iscontainsFile(MeetFileMainEntity f, List<MeetRichenFileEntity> existFiles) {
		boolean flag=false;
		for(int i=0;i<existFiles.size();i++){
			if((f.getFileid()==existFiles.get(i).getFileid())||f.getFileid().equals(existFiles.get(i).getFileid())){
				flag=true;
			}
		}
		System.out.println("flag:"+flag);
		return flag;
	}
	public void selectBindFile(){
		 MeetFileMainEntity fileEntity=meetingService.selecMeetFileByFileid(fileid);
		 JSONObject json=new JSONObject();
		 json.put("title", fileEntity.getTitle());
		 this.outJsonString(json.toString());
	}
	public void addRichen(){
		try{
//			MeetYichenMainEntity entity=new MeetYichenMainEntity();
			//System.out.println("richenEntity:"+richenEntity);
			richenEntity.setMeetid(meetid);
			meetingService.addRichen(richenEntity);
			if(richenEntity.getPrichenid()==0){
				id=0;
			}
			printAddSuccess();
		}catch (Exception e) {
			e.printStackTrace();
			printAddError("新增失败");
		}
	}
	public void updateRichen(){
		try{
//			MeetYichenMainEntity entity=new MeetYichenMainEntity();
			richenEntity.setMeetid(meetid);
			richenEntity.setRichenid(richenid);
			//System.out.println("updateYiti:"+richenEntity+","+fileids);
			meetingService.updateRichen(richenEntity);
			System.out.println("updateYiti2:"+richenEntity+","+fileids);
			if(richenEntity.getPrichenid()==0){
				id=0;
			}
			//System.out.println("updateRichen:"+richenEntity+","+fileids);
			printAddSuccess();
		}catch (Exception e) {
			e.printStackTrace();
			printAddError("新增失败");
		}
	}
	public void updateYiti(){
		try{
//			MeetYichenMainEntity entity=new MeetYichenMainEntity();
			//System.out.println("updateYiti:"+yitiEntity+","+fileids);
			yitiEntity.setMeetid(meetid);
			yitiEntity.setIsdel(0);
			yitiEntity.setYichenid(yichenid);
			//System.out.println("updateYiti:"+yitiEntity+","+fileids);
			meetingService.updateMeetYichen(yitiEntity);
			if(yitiEntity.getPyichenid()==0){
				id=0;
			}
			//System.out.println("updateYiti:"+yitiEntity+","+fileids);
			System.out.println(yichenid);
//			if(ValidateUtil.isValid(fileids)&&fileids.split(",").length>0)
			meetingService.bindYichenFile(yichenid, fileids.split(","));
			printAddSuccess();
		}catch (Exception e) {
			e.printStackTrace();
			printAddError("新增失败");
		}
	}
	public void updateYichenBindFile(){
		try{
			if("1".equals(bindflag)){
				meetingService.relativeRichenFile(fileid,yichenids.split(","));
			}else{
				meetingService.relativeYichenFile(yichenids.split(","), fileid);
			}
			printAddSuccess();
		}catch (Exception e) {
			e.printStackTrace();
			printAddError("新增失败");
		}	
	}
	public void addYiti(){
		try{
//			MeetYichenMainEntity entity=new MeetYichenMainEntity();
			//System.out.println("yitiEntity:"+yitiEntity+","+fileids);
			yitiEntity.setMeetid(meetid);
			MeetYichenMainEntity entity=meetingService.addMeetYichen(yitiEntity);
			if(yitiEntity.getPyichenid()==0){
				id=0;
				
			}
			int ycid=entity.getYichenid();
			//System.out.println(yichenid+","+ycid);
			meetingService.bindYichenFile(ycid, fileids.split(","));
			printAddSuccess();
		}catch (Exception e) {
			e.printStackTrace();
			printAddError("新增失败");
		}
	}
	public void benchRichenAddByFile(){
		try{
			String upFile = saveUploadFileLHG(file, fileFileName,true);
			System.out.println((file==null)+","+fileFileName+","+upFile+","+meetid);
			meetingService.AutoGeneMeetRichen(upFile,meetid);
			id=0;
			printAddSuccess();
		}catch (Exception e) {
			e.printStackTrace();
			printAddError("新增失败");
		}
//		return getRichenPage(type);
	}
	private String getRichenPage(int type) {
		System.out.println("getRichenPage:"+type);
		if(1==type){
			return "benchRichenAddByFilezrh";
		}else if(2==type){
			System.out.println(type);
			return "benchRichenAddByFilecwh";
		}else if(3==type){
			return "benchRichenAddByFilefzw";
		}else if(4==type){
			return "benchRichenAddByFilecjw";
		}else if(5==type){
			return "benchRichenAddByFilerdjg";
		}
		return SUCCESS;
	}
	//会中主任会文件增加
	public void hzbenchAddByFile(){
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		try{
			String upFile = saveUploadFile(file, fileFileName,false);
			System.out.println("文件上传");
			System.out.println((file==null)+","+fileFileName+","+upFile+","+meetid);
			String mid = this.getRequest().getParameter("meetid");
			System.out.println("mid---"+mid);
			MeetFileMainEntity obj=new MeetFileMainEntity();
			obj.setUploadtime(sdf.parse(sdf.format(new Date())));
			obj.setFilename(fileFileName);
			obj.setFilepath(upFile);
			obj.setFileown(fileown);
			obj.setFiletype(filetypeSel);
			obj.setMtype(fmtype);
			obj.setTitle((fileFileName.indexOf(".")>-1)?fileFileName.substring(0, fileFileName.indexOf(".")):fileFileName);
			obj.setMeetid(Integer.parseInt(mid));
			obj.setFilescopes(scopeids);
			obj.setFileguid(Md5GuidUtil.getMd5Guid(file));
			System.out.println("推送范围:"+scopeids);
			System.out.println(scopeids+","+fmtype+",obj:"+obj);
			meetingService.addMeetFileHzzrhy(obj);
			//meetingService.AutoSaveFile(obj, meetid);
			//meetingService.AutoGeneMeetYichen(upFile,meetid);
			id=0;
			printAddSuccess();
		}catch (Exception e) {
			e.printStackTrace();
			printAddError("新增失败");
		}
	}
	//批量增加文件
	public void benchAddByFile(){
			try{
				String upFile = saveUploadFileLHG(file, fileFileName,true);
				System.out.println((file==null)+","+fileFileName+","+upFile+","+meetid);
				meetingService.AutoGeneMeetYichen(upFile,meetid);
				id=0;
				printAddSuccess();
			}catch (Exception e) {
				e.printStackTrace();
				printAddError("新增失败");
			}
//		return getYichenPage(type);
	}
	private String getYichenPage(int type) {
		System.out.println("getYichenPage:"+type);
		if(1==type){
			return "benchAddByFilezrh";
		}else if(2==type){
			System.out.println(Integer.valueOf(type));
			return "benchAddByFilecwh";
		}else if(3==type){
			return "benchAddByFilefzw";
		}else if(4==type){
			return "benchAddByFilecjw";
		}else if(5==type){
			return "benchAddByFilerdjg";
		}
		return SUCCESS;
	}
	public String listMeeting(){
		page = meetingService.selectByPage(pageNo, pageSize);
		System.out.println("page:"+page.getResult().toString());
		jsonSuccess("listMeeting");
		return SUCCESS;
	}
	
	public String getYichengInfo(){
		System.out.println("meetid:"+meetid);

		
			
		return SUCCESS;
	}
	public String getRichengInfo(){
		System.out.println("meetid:"+meetid);
		return "getRichengInfo";
	}
	public String selectHisMeeting(){
		System.out.println(type+","+pageNo+","+pageSize);
		page=meetingViewService.selectHisMeeting(type+"",pageNo,pageSize);
		totalPage=page.getPages();
		System.out.println(totalPage+","+page.getTotal());
		return "success";
	}
	public void saveOrUpdateMeeting(){
		System.out.println("meetingid:"+meeting);
		RandomID r=new RandomID();
//		r.getNewDate1(date)
		meeting.setUserid(getUseridInSession());
		meeting.setIsdel(0);
		meeting.setMname(getBaseMeetingName(meeting.getMtype(),jieshu,cishu));
		meeting.setSdate(r.getNewDate1(meeting.getSdateStr(),FORMAT));
		meeting.setEdate(r.getNewDate1(meeting.getEdateStr(),FORMAT));
		meeting.setCnum(cishu+"次");
		meeting.setJnum(jieshu+"届");
//		String currMeetingid=(String) ServletActionContext.getServletContext().getAttribute("currMeetingid");
		JSONObject json=new JSONObject();
		try {
			//修改
			System.out.println("meetid:"+meetid);
		if(meetid!=0&&ValidateUtil.isValid(meetid+"")){
			meetingService.updateMeetBasic(meeting);
		}else{//新增 
			System.out.println("meetingid:"+meetid);
			meetingService.addMeetBasic(meeting);
			meetid=meeting.getMeetid();
		}
			json.put("state", true);
			json.put("meetid", meetid);
			printMyJsonSuccess(meetid+"");
			System.out.println("meeting:"+","+jieshu+","+cishu+meeting.toString());
			System.out.println(meeting.getMtype());
		} catch (Exception e) {
			json.put("state", false);
			printMyJsonError("操作失败");
			e.printStackTrace();
		}
//		outJsonString(json.toString());
//		return getIndexPage(meeting.getMtype());
	}
	public String getIndexPage(String type) {
		if("1".equals(type)){
			return "zhurenhindex";
		}else if("2".equals(type)){
			System.out.println(type);
			return "changwhindex";
		}else if("3".equals(type)){
			return "fazhiwhindex";
		}else if("4".equals(type)){
			return "chaijwhindex";
		}else if("5".equals(type)){
			return "rendajgindex";
		}
		return SUCCESS;
	}
	public String getMeetingInfo(){
//		String currMeetingid=(String) ServletActionContext.getServletContext().getAttribute("currMeetingid");
		cishuList=getCiShuLists();
		jieshuList=getJieshuLists();
		System.out.println("次数：----------------"+cishuList.size()+",界数：--------------"+jieshuList.size());
		if(meetid!=0){
			RandomID r=new RandomID();
			meeting=meetingViewService.selectEntityById(meetid);
//			meeting.setSdate(r.dateToString(meeting.getSdate()))
			System.out.println("meeting:"+meeting);
			if(meeting!=null){
				meeting.setSdateStr(r.dateToString(meeting.getSdate()));
				meeting.setEdateStr(r.dateToString(meeting.getEdate()));
				jieshu=(type==5?null:getJieshu(meeting.getMname(), type));
				cishu=getCishu(meeting.getMname(), type);
			}
		}else{
			
		}
		System.out.println("meeting:"+(ValidateUtil.isValid(meeting+"")?meeting.toString():0)+","+jieshu+","+cishu+","+type);
		System.out.println("2".equals(type)+","+meetid);
		System.out.println("cishu:" + cishu);
		if(1==type){
			return "zhurenhindex";
		}else if(2==type){
			System.out.println(Integer.valueOf(type));
			return "changwhindex";
		}else if(3==type){
			return "zhurenhindex";
		}else if(4==type){
			return "zhurenhindex";
		}else if(5==type){
			return "zhurenhindex";
		}
		return SUCCESS;
	}
	public String selectCurMeeting(){
		System.out.println("type:"+type+","+meetid);
		meeting=meetingViewService.selectCurMeeting(type+"");
		System.out.println("meeting:"+meeting);
		if(meeting==null){
			meetid=0;
		}
		return SUCCESS;
	}
	public void meetingfileadd(){
		try{
			try {
				System.out.println("=========文件管理——文件上传========");
				//				int cmid = getSessionUser().getCmid();
				String mid = this.getRequest().getParameter("meetid");
				System.out.println("mid---"+mid);
				MeetFileMainEntity obj=new MeetFileMainEntity();
				obj.setFilename(fileFileName);
				obj.setFilepath(saveUploadFile(file, fileFileName,false));
				obj.setFileown(fileown);
				obj.setFiletype(filetypeSel);
				obj.setMtype(fmtype);
				obj.setTitle((fileFileName.indexOf(".")>-1)?fileFileName.substring(0, fileFileName.indexOf(".")):fileFileName);
				obj.setMeetid(Integer.parseInt(mid));
				obj.setFilescopes(scopeids);
				obj.setFileguid(Md5GuidUtil.getMd5Guid(file));
				System.out.println("推送范围"+scopeids+"+++"+fmtype+",obj:"+obj);
				MeetFileMainEntity fileMain=meetingService.addMeetFile(obj);
//				String ID=subMeetingService.addSubMeeting(this.getFindClasPathByFileName("upload/fileleave"), file, fileFileName,filetype1,Integer.parseInt(aa),Integer.parseInt(cmid));
				Attachment attachment = new Attachment();
				attachment.setID((fileMain!=null?fileMain.getFileid():0)+"");
				attachment.setFilename(fileFileName);
				attachment.setMemberID("111");
				attachment.setContenttype("application/octet-stream");
				attachment.setDescription("这是描述");
					if(file!=null){
						attachment.setFilelength(file.length());
					}else{
						attachment.setFilelength(0);
					}
					attachment.setFilenameindisk(getUploadFileBasePath()+"/"+fileFileName);
					attachment.setNeedwatermark(1);
//					System.out.println("attachment=="+attachment.toString());
					JSONObject jsonObj = JSONObject.fromObject(attachment);
					jsonObj.accumulate("saveDataId", "saveDataId1");
					//PushService.pushTag6(fileFileName);
					this.getResponse().getWriter().print(jsonObj);
			} catch (Exception e) {
				jsonError("新增失败");
				e.printStackTrace();
			}
		}catch (Exception e) {
			e.printStackTrace();
			jsonError("");
		}
	}	

	public String selectYichengList(){
		yichenglist=meetingViewService.getMeetTreeYichenClient(meetid);
		return ActionSupport.SUCCESS;
	}
	public String selectRichengList(){
		richenglist=meetingViewService.getMeetTreeRichenClient(meetid);
		return ActionSupport.SUCCESS;
	}
	public String showHistoryMeet(){
		meettitle=meetingViewService.selectMeetBasicByMeetId(meetid).getMname();
		return ActionSupport.SUCCESS;
	}
	/*public String deleteHistoryMeet(){
		meetingViewService.deleteMeetBasicByMeetId(meetid);
		return ActionSupport.SUCCESS;
	}*/
	public String selectMeetFileList(){
		fileMainList= meetingViewService.selectALLPubMeetFileByMeetid(meetid, "1", "3");
		return ActionSupport.SUCCESS;
	}
	public String getHistoryBriefingList(){
		page=briefingService.selectBriefingbyMeetid(meetid, pageNo, pageSize);
		totalPage=page.getPages();
		return ActionSupport.SUCCESS;
	}
	public String selectMeetDirectorList(){
		HashMap<String,Object>params=new HashMap<String, Object>();
		params.put("meetid", meetid);
		if(type==2){
			params.put("fileown", "2");
		}else{
			params.put("fileown", "1");
		}
		page = meetingViewService.selectALLPubMeetFileByMeetid(params, pageNo, pageSize);
		totalPage=page.getPages();
		return ActionSupport.SUCCESS;
	}	
	public String selectFinalMeetList(){
		HashMap<String,Object>params=new HashMap<String, Object>();
		params.put("meetid", meetid);
		params.put("fileown", "1");
		params.put("filetype", "8");
		page = meetingViewService.selectALLPubMeetFileByMeetid(params, pageNo, pageSize);
		totalPage=page.getPages();
		return ActionSupport.SUCCESS;
	}		
	public void selectFenzuList(){		
		JSONObject json=new JSONObject();
		try{
			System.out.println(meetid+","+groupno);
			MeetGroupMainEntity groupEntity=meetingViewService.selectGroupByMeetidAndGrpno(meetid, groupno);
			if(groupEntity!=null){
				json.put("groupid", groupEntity.getGroupid());
				json.put("state", true);
			}else{
				json.put("state", false);
			}
		}catch (Exception e) {
			e.printStackTrace();
			json.put("state", false);
		}
		System.out.println("json:"+json.toString());
		this.outJsonString(json.toString());
	}
	
	public String selectYichengListByVersion(){
		yichenglist=meetingViewService.getMeetTreeYichenClientByVersion(meetid,version);
		System.out.println(meettitle);
		return ActionSupport.SUCCESS;
	}
	public String selectRichengListByVersion(){
		richenglist=meetingViewService.getMeetTreeRichenClientByVersion(meetid,version);
		return ActionSupport.SUCCESS;
	}
	public String selectMeetFileListByVersion(){
		HashMap<String,Object>params=new HashMap<String, Object>();
		params.put("meetid", meetid);
		params.put("fileown", "1");
		params.put("version", version);
		page = meetingViewService.selectAllFileByMeetidAndFileOwnAndVersion(params, pageNo, pageSize);
		totalPage=page.getPages();
		return ActionSupport.SUCCESS;
	}	
	//会议推送和提醒
	public void submitMeetProcess(){
		JSONObject json=new JSONObject();
		try{
			boolean b=meetingService.submitMeetPub(meetid, statename,noTX);	
			if(b){
				json.put("state", true);
			}else{
				json.put("state", false);
			}
		}catch (Exception e) {
			json.put("state", false);
			e.printStackTrace();
		}
		System.out.println("json:"+json.toString());
		printMyJsonInfoSuccess(json.toString());
	}
	public void getMeetTreeYichenOrRichenFileJson(){
		MeetFileMainEntity fileEntity=meetingService.selecMeetFileByFileid(fileid);
		//议程树
		List<Map<String, Object>> allFiles=meetingViewService.getMeetTreeYichenNoFile(meetid);
		//日程树
		List<Map<String, Object>> allRiChenFiles=meetingViewService.getMeetTreeRichenNoFileJson(meetid);
		String fileType=fileEntity.getFiletype();
		List<Map<String,Object>> paramsQuery = new ArrayList<Map<String,Object>>();
		Map<String,Object> map2=null;
		//判断是否是闭幕会文件，根据文件类型判断加载议程树或者是日程树
		if("8".equals(fileType)){
			//所有已关联的文件
			//List<MeetRichenMainEntity> existRichenFiles=meetingViewService.selectBindRichenByFileid(fileEntity.getFileid());
			List<MeetRichenFileEntity> existRichenFiles=meetingViewService.selectRichenFileByFileid(fileEntity.getFileid());
			for (Map<String,Object> f : allRiChenFiles) {
				
				f.put("checked", iscontainsRichenFile(f, existRichenFiles));
				paramsQuery.add(f);
			}
		}else{
			//所有已关联的文件
			//List<MeetYichenMainEntity> existFiles=meetingViewService.selectBindYichenByFileid(fileEntity.getFileid());
			Map<String,Object> map=new HashMap<String, Object>();
			map.put("fileid", fileEntity.getFileid());
			List<MeetYichenFileEntity> existYichenFiles=meetingViewService.selectYichenFileByFileidAndYichenid(map);
			for(Map<String,Object> f:allFiles){
				f.put("checked", iscontainsYichenFile(f, existYichenFiles));
				paramsQuery.add(f);
			}
		}

		JSONArray jsonArray =  JSONArray.fromObject(paramsQuery);
		outJsonString(jsonArray.toString());
	}	
	private boolean iscontainsYichenFile(Map<String,Object> map,List<MeetYichenFileEntity> list){
		boolean flag=false;
		for (int i = 0; i < list.size(); i++) {
			if((map.get("id").toString()).equals(list.get(i).getYichenid()+"")){
				flag=true;
			}
		}
		return flag;
	}
	private boolean iscontainsRichenFile(Map<String,Object> map,List<MeetRichenFileEntity> list){
		boolean flag=false;
		for (int i = 0; i < list.size(); i++) {
			if((map.get("id").toString()).equals(list.get(i).getRichenid()+"")){
				flag=true;
			}
		}
		return flag;
	}
	public String getMeettitle() {
		return meettitle;
	}
	public void setMeettitle(String meettitle) {
		this.meettitle = meettitle;
	}
	public List<MeetGroupMainEntity> getMeetgrouplist() {
		return meetgrouplist;
	}
	public void setMeetgrouplist(List<MeetGroupMainEntity> meetgrouplist) {
		this.meetgrouplist = meetgrouplist;
	}
	public List<Map<String, Object>> getRichenglist() {
		return richenglist;
	}
	public void setRichenglist(List<Map<String, Object>> richenglist) {
		this.richenglist = richenglist;
	}
	public List<Map<String, Object>> getYichenglist() {
		return yichenglist;
	}
	public void setYichenglist(List<Map<String, Object>> yichenglist) {
		this.yichenglist = yichenglist;
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
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public MeetMainEntity getMeeting() {
		return meeting;
	}
	public void setMeeting(MeetMainEntity meeting) {
		this.meeting = meeting;
	}

	public String getJieshu() {
		return jieshu;
	}

	public void setJieshu(String jieshu) {
		this.jieshu = jieshu;
	}

	public String getCishu() {
		return cishu;
	}

	public void setCishu(String cishu) {
		this.cishu = cishu;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getMeetid() {
		return meetid;
	}

	public void setMeetid(int meetid) {
		this.meetid = meetid;
	}

	public String getFileFileName() {
		return fileFileName;
	}

	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}
	public MeetYichenMainEntity getYitiEntity() {
		return yitiEntity;
	}
	public void setYitiEntity(MeetYichenMainEntity yitiEntity) {
		this.yitiEntity = yitiEntity;
	}
	public MeetRichenMainEntity getRichenEntity() {
		return richenEntity;
	}
	public void setRichenEntity(MeetRichenMainEntity richenEntity) {
		this.richenEntity = richenEntity;
	}
	public List<MeetFileMainEntity> getFileMainList() {
		return fileMainList;
	}
	public void setFileMainList(List<MeetFileMainEntity> fileMainList) {
		this.fileMainList = fileMainList;
	}
	public int getFileid() {
		return fileid;
	}
	public void setFileid(int fileid) {
		this.fileid = fileid;
	}
	public String getFiletype() {
		return filetype;
	}
	public void setFiletype(String filetype) {
		this.filetype = filetype;
	}
	public String getFileown() {
		return fileown;
	}
	public void setFileown(String fileown) {
		this.fileown = fileown;
	}
	public int getDeleteid() {
		return deleteid;
	}
	public void setDeleteid(int deleteid) {
		this.deleteid = deleteid;
	}
	public List<SelectEntity> getCishuList() {
		return cishuList;
	}
	public void setCishuList(List<SelectEntity> cishuList) {
		this.cishuList = cishuList;
	}
	public List<SelectEntity> getJieshuList() {
		return jieshuList;
	}
	public void setJieshuList(List<SelectEntity> jieshuList) {
		this.jieshuList = jieshuList;
	}
	public String getSendType() {
		return sendType;
	}
	public void setSendType(String sendType) {
		this.sendType = sendType;
	}
	public String getSendTimeStr() {
		return sendTimeStr;
	}
	public void setSendTimeStr(String sendTimeStr) {
		this.sendTimeStr = sendTimeStr;
	}
	public List<MeetBriefingMainEntity> getBriefinglist() {
		return briefinglist;
	}
	public void setBriefinglist(List<MeetBriefingMainEntity> briefinglist) {
		this.briefinglist = briefinglist;
	}
	public int getBriefid() {
		return briefid;
	}
	public void setBriefid(int briefid) {
		this.briefid = briefid;
	}
	public MeetBriefingMainEntity getBriefEntity() {
		return briefEntity;
	}
	public void setBriefEntity(MeetBriefingMainEntity briefEntity) {
		this.briefEntity = briefEntity;
	}
	public String getGroupid() {
		return groupid;
	}
	public void setGroupid(String groupid) {
		this.groupid = groupid;
	}
	public String getGroupcontent() {
		return groupcontent;
	}
	public void setGroupcontent(String groupcontent) {
		this.groupcontent = groupcontent;
	}
	public String getGroupno() {
		return groupno;
	}
	public void setGroupno(String groupno) {
		this.groupno = groupno;
	}
	public String getProcessType() {
		return processType;
	}
	public void setProcessType(String processType) {
		this.processType = processType;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getCurstate() {
		return curstate;
	}
	public void setCurstate(String curstate) {
		this.curstate = curstate;
	}
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}
	public String getFirstIn() {
		return firstIn;
	}
	public void setFirstIn(String firstIn) {
		this.firstIn = firstIn;
	}
	public int getYitiid() {
		return yitiid;
	}
	public void setYitiid(int yitiid) {
		this.yitiid = yitiid;
	}
	public int getYichenid() {
		return yichenid;
	}
	public void setYichenid(int yichenid) {
		this.yichenid = yichenid;
	}
	public String getFileids() {
		return fileids;
	}
	public void setFileids(String fileids) {
		this.fileids = fileids;
	}
	public MeetRichenYitiEntity getRichenYitiEntity() {
		return richenYitiEntity;
	}
	public void setRichenYitiEntity(MeetRichenYitiEntity richenYitiEntity) {
		this.richenYitiEntity = richenYitiEntity;
	}
	public int getRichenyitiid() {
		return richenyitiid;
	}
	public void setRichenyitiid(int richenyitiid) {
		this.richenyitiid = richenyitiid;
	}
	public int getRichenid() {
		return richenid;
	}
	public void setRichenid(int richenid) {
		this.richenid = richenid;
	}
	public int getYichenidTreeid() {
		return yichenidTreeid;
	}
	public void setYichenidTreeid(int yichenidTreeid) {
		this.yichenidTreeid = yichenidTreeid;
	}
	public List<ProcessSelectEntity> getProcessList() {
		return processList;
	}
	public void setProcessList(List<ProcessSelectEntity> processList) {
		this.processList = processList;
	}
	public String getShowStateName() {
		return showStateName;
	}
	public void setShowStateName(String showStateName) {
		this.showStateName = showStateName;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public String getFtype() {
		return ftype;
	}
	public void setFtype(String ftype) {
		this.ftype = ftype;
	}
	public String getFmtype() {
		return fmtype;
	}
	public void setFmtype(String fmtype) {
		this.fmtype = fmtype;
	}
	public String getScopeids() {
		return scopeids;
	}
	public void setScopeids(String scopeids) {
		this.scopeids = scopeids;
	}
	public String getFiletypeSel() {
		return filetypeSel;
	}
	public void setFiletypeSel(String filetypeSel) {
		this.filetypeSel = filetypeSel;
	}
	public String getFiletypes() {
		return filetypes;
	}
	public void setFiletypes(String filetypes) {
		this.filetypes = filetypes;
	}
	public String[] getSendScopes() {
		return sendScopes;
	}
	public void setSendScopes(String[] sendScopes) {
		this.sendScopes = sendScopes;
	}	
	public Map<String, Object> getBriefsendmap() {
		return briefsendmap;
	}
	public void setBriefsendmap(Map<String, Object> briefsendmap) {
		this.briefsendmap = briefsendmap;
	}
	public List<FileSelect> getFileSelect() {
		return fileSelect;
	}
	public void setFileSelect(List<FileSelect> fileSelect) {
		this.fileSelect = fileSelect;
	}
	public int getVersion() {
		return version;
	}
	public void setVersion(int version) {
		this.version = version;
	}
	public String getStatename() {
		return statename;
	}
	public void setStatename(String statename) {
		this.statename = statename;
	}	
	public String getPushflag() {
		return pushflag;
	}
	public void setPushflag(String pushflag) {
		this.pushflag = pushflag;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getBindtype() {
		return bindtype;
	}
	public void setBindtype(String bindtype) {
		this.bindtype = bindtype;
	}	
	public String getHideBindType() {
		return hideBindType;
	}
	public void setHideBindType(String hideBindType) {
		this.hideBindType = hideBindType;
	}
	public String getYichenids() {
		return yichenids;
	}
	public void setYichenids(String yichenids) {
		this.yichenids = yichenids;
	}
	public String getRichenids() {
		return richenids;
	}
	public void setRichenids(String richenids) {
		this.richenids = richenids;
	}
	public String getBindflag() {
		return bindflag;
	}
	public void setBindflag(String bindflag) {
		this.bindflag = bindflag;
	}
	public List<MeetPubGroupEntity> getMeetpubgrouplist() {
		return meetpubgrouplist;
	}
	public void setMeetpubgrouplist(List<MeetPubGroupEntity> meetpubgrouplist) {
		this.meetpubgrouplist = meetpubgrouplist;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public List<MeetFileMainEntity> getSortlist() {
		return sortlist;
	}
	public void setSortlist(List<MeetFileMainEntity> sortlist) {
		this.sortlist = sortlist;
	}	
	public String getJsonStr() {
		return jsonStr;
	}
	public void setJsonStr(String jsonStr) {
		this.jsonStr = jsonStr;
	}
	public String getNoTX() {
		return noTX;
	}
	public void setNoTX(String noTX) {
		this.noTX = noTX;
	}
	
}
