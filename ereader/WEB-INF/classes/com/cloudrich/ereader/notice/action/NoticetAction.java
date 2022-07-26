package com.cloudrich.ereader.notice.action;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import com.cloudrich.framework.util.file.ToolsUtils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.cloudrich.ereader.common.action.BaseAction;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.common.util.ValidateUtil;
import com.cloudrich.ereader.notice.constant.NotifyConstant;
import com.cloudrich.ereader.notice.entity.NoticeMainEntity;
import com.cloudrich.ereader.notice.entity.NoticePubEntity;
import com.cloudrich.ereader.notice.entity.NoticeReplyEntity;
import com.cloudrich.ereader.notice.entity.NoticeSendscopeEntity;
import com.cloudrich.ereader.notice.service.NoticeSendscopeService;
import com.cloudrich.ereader.notice.service.NoticeService;
import com.cloudrich.ereader.system.entity.SysScopeMainEntity;
import com.cloudrich.ereader.system.service.ScopeMainService;
import com.cloudrich.ereader.util.Md5GuidUtil;
import com.opensymphony.xwork2.ActionSupport;
import com.cloudrich.framework.util.file.DownloadBaseAction;

@Controller("NoticetAction")
@Scope("prototype")
public class NoticetAction extends BaseAction{
	
	private static final long serialVersionUID = 1L;
	
	@Resource
	private NoticeService noticeService;
	
	@Resource NoticeSendscopeService noticeSendscopeService;

	@Resource ScopeMainService scopeMainService;
	
	private File notifyFile;
	//提交过来的file的名字 
	private String notifyFileFileName;
	
	private String name;
	private String sendType;
	private String sendTimeStr;
	private Page page;
	private int pageNo;
	private int pageSize=8;
	private Integer noticeId;
	private long totalPage;
	private String title;
	private NoticeMainEntity noticeMainEntity;
	private String startTime;
	
	private String endTime;
    private String noticereplycode;
    private Map<String,Object> replymap;
    private String[] scopeids;
    private List<NoticeSendscopeEntity> scopelist;
    private Map<String ,Object> map;
    private String pushflag;

	public void listScope(){
    	List<SysScopeMainEntity> list=scopeMainService.selectAll();
        String s="[";
    	for (int i = 0; i < list.size(); i++) {
    		SysScopeMainEntity sysScopeMainEntity=list.get(i);
    		int scopeid=sysScopeMainEntity.getScopeid();
           s+="{\"id\":"+scopeid+",\"text\":\""+sysScopeMainEntity.getScopename()+"\"},";
		}
    	s=s.substring(0,s.lastIndexOf(","))+"]";
		outJsonString(s);
    }
	public void listHistoryNotify(){
		JSONObject data = new JSONObject();
		JSONArray array=new JSONArray();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
		try{
			data.put("state", true);
			data.put("msg", "查询成功");
			List<NoticeMainEntity> list=noticeService.selectHistory();
			JSONObject notifydata = null;
			for (int i = 0; i < list.size(); i++) {
				notifydata=new JSONObject();
				NoticeMainEntity noticeMainEntity=list.get(i);
				notifydata.put("noticeid", noticeMainEntity.getNoticeid());
				notifydata.put("title", noticeMainEntity.getTitle());
				notifydata.put("isdel", noticeMainEntity.getIsdel());
				notifydata.put("filename", noticeMainEntity.getFilename());
				notifydata.put("filepath", noticeMainEntity.getPath());
				notifydata.put("sendtime", sdf.format(noticeMainEntity.getSendtime()));
				notifydata.put("pubtime", sdf.format(noticeMainEntity.getPubtime()));
				array.add(notifydata);
			}
			data.put("hnotice", array);
		}catch (Exception e) {
			data.put("state", false);
			data.put("msg", "查询失败");
			e.printStackTrace();
		}
		this.outJsonString(data.toString());
	}
	public String listNotify(){
		HashMap<String,Object>params=new HashMap<String, Object>();
		if(ValidateUtil.isValid(title)){
			params.put("title", title);
		}
		page = noticeService.selectByPage(pageNo, pageSize,params);
		totalPage=page.getPages();
		jsonSuccess("listNotify");
		return ActionSupport.SUCCESS;
	}
	
	public String selectNotifyReply(){
		replymap=new HashMap<String, Object>();
		Map<String,Object> map=new HashMap<String, Object>();
		map.put("noticeId", Integer.valueOf(noticeId));
		map.put("noticereplycode", '2');
		List<NoticeReplyEntity> attendList=noticeService.selectReplysByType(map);
		replymap.put("attendSize",attendList==null?0:attendList.size());
		replymap.put("attendList",attendList);
		map.clear();
		map.put("noticeId",Integer.valueOf(noticeId));
		map.put("noticereplycode", '1');
		List<NoticeReplyEntity> absenceList=noticeService.selectReplysByType(map);
		replymap.put("absenceSize",absenceList==null?0:absenceList.size());
		replymap.put("absenceList",absenceList);
		map.clear();
		map.put("noticeId",Integer.valueOf(noticeId));
		map.put("noticereplycode", '3');
		List<NoticeReplyEntity> unconfirmList=noticeService.selectReplysByType(map);
		System.out.println(unconfirmList.size());
		replymap.put("unconfirmSize",unconfirmList==null?0:unconfirmList.size());
		replymap.put("unconfirmList",unconfirmList);
		replymap.put("totalSize", unconfirmList.size()+absenceList.size()+attendList.size());
		return ActionSupport.SUCCESS;
	}


	public String listSearch(){
		HashMap<String,Object>params=new HashMap<String, Object>();
		if(ValidateUtil.isValid(title)){
			params.put("title", title);
		}
		if(ValidateUtil.isValid(startTime)){
			params.put("startTime", startTime);
		}else{
			params.put("startTime", "1900-01-01 00:00:00");
		}
		if(ValidateUtil.isValid(endTime)){
			params.put("endTime", endTime);
		}else{
			params.put("endTime", "2100-01-01 00:00:00");
		}
		page = noticeService.selectByPage(pageNo, pageSize,params);
		List<NoticeMainEntity> list=page.getResult();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
		for (int i = 0; i < list.size(); i++) {
			NoticePubEntity entity=noticeService .selectPubByNoticeid(list.get(i).getNoticeid());
			if(entity!=null){
				list.get(i).setPushdate(sdf.format(entity.getPubtime()));
			}else{
				list.get(i).setPushdate("");
			}
		}
		page.setResult(list);
		if(page.getResult().size()>0){
			for (int i = 0; i <page.getResult().size(); i++) {
				String scopenames="";
				NoticeMainEntity ent=(NoticeMainEntity)(page.getResult().get(i));
				List<NoticeSendscopeEntity> scopeent=noticeSendscopeService.selectByNoticeId(ent.getNoticeid());
				if(scopeent.size()>0){
					for (int j = 0; j < scopeent.size(); j++) {
						if(scopeMainService.selectEntityById(scopeent.get(j).getScopeid())!=null){
							scopenames+=scopeMainService.selectEntityById(scopeent.get(j).getScopeid()).getScopename()+",";
						}
					}
					ent.setScopenames(scopenames.length()==0?"":scopenames.substring(0,scopenames.length()-1));
				}
			}
		}
		totalPage=page.getPages();
		jsonSuccess("listSearch");
		return ActionSupport.SUCCESS;
	}
	public String listNotifyById(){
		noticeMainEntity=noticeService.selectEntityById(noticeId);
		scopelist=noticeSendscopeService.selectByNoticeId(noticeId);
		map=new HashMap<String, Object>();
		map.put("noticeMainEntity", noticeMainEntity);
		map.put("scopelist", scopelist);
		return ActionSupport.SUCCESS;
	}
	
	public String pushNotify() throws Exception{
		String upFile = saveUploadFile(notifyFile, notifyFileFileName,true);
		NoticeMainEntity entity = new NoticeMainEntity();
		entity.setTitle(name);
		entity.setNoticeid(noticeId);
		entity.setFilename(notifyFileFileName);
		String uppath=upFile.substring(upFile.indexOf("upload")).replace("\\", "/");
		entity.setPath(uppath);
		entity.setPubtime(new Date());
		entity.setSendtype(sendType);
		entity.setIsdel(0);//0代表未删除
		entity.setFileguid(Md5GuidUtil.getMd5Guid(new File(upFile)));
		if(NotifyConstant.SENDTYPE_CUSTOM.equals(sendType)){//2代表定时发送
			entity.setSendtime(parseDataStr(sendTimeStr));
		}else{
			entity.setSendtime(entity.getPubtime());
		}
		if(getCurrentUser()==null){
			entity.setPubuserid(0);
		}else{
			entity.setPubuserid(getCurrentUser().getId());
		}	
		entity.setSendway("11");
		int b=noticeService.insert(entity);
		int noticeid=entity.getNoticeid();
		NoticeSendscopeEntity noticeSendscopeEntity=new NoticeSendscopeEntity(); 
		if(scopeids!=null&&scopeids.length>0){
			for (int i = 0; i < scopeids.length; i++) {
				noticeSendscopeEntity.setScopeid(Integer.valueOf(scopeids[i]));
				noticeSendscopeEntity.setNoticeid(noticeid);
				noticeSendscopeService.insert(noticeSendscopeEntity);
			}
		}
		if(b>0){
			jsonSuccess("保存成功");
		}else{
			jsonError("保存失败");
		}
		if(pushflag.equals("1")){
			int j=noticeService.insertPush(entity,"insert");
			if(j>0){
				jsonSuccess("发布成功");
			}else{
				jsonSuccess("发布失败");
			}
		}		
		return ActionSupport.SUCCESS;
	}
	
	public String updateNotify() throws Exception{
		NoticeMainEntity entity = new NoticeMainEntity();
		entity.setNoticeid(noticeId);
		entity.setTitle(name);
		if(notifyFile!=null&&notifyFileFileName!=null){
			String upFile = saveUploadFile(notifyFile, notifyFileFileName,true);
			entity.setFilename(notifyFileFileName);
			String uppath=upFile.substring(upFile.indexOf("upload")).replace("\\", "/");
			entity.setPath(uppath);
			entity.setFileguid(Md5GuidUtil.getMd5Guid(new File(upFile)));
		}
		entity.setPubtime(new Date());
		entity.setSendtype(sendType);
		if(NotifyConstant.SENDTYPE_CUSTOM.equals(sendType)){
			entity.setSendtime(parseDataStr(sendTimeStr));
		}else{
			entity.setSendtime(entity.getPubtime());
		}
		if(getCurrentUser()==null){
			entity.setPubuserid(0);
		}else{
			entity.setPubuserid(getCurrentUser().getId());
		}
		entity.setIsdel(0);//0代表未删除	
		entity.setSendway("11");		
		int j=noticeService.update(entity);
		if(j>0){
			NoticeSendscopeEntity noticeSendscopeEntity=new NoticeSendscopeEntity(); 
			noticeSendscopeService.deleteByNoticeId(noticeId);
			if(scopeids!=null&&scopeids.length>0){
				for (int i = 0; i < scopeids.length; i++) {
					noticeSendscopeEntity.setScopeid(Integer.valueOf(scopeids[i]));
					noticeSendscopeEntity.setNoticeid(entity.getNoticeid());
					noticeSendscopeService.insert(noticeSendscopeEntity);	
				}
			}
		}
		if(j>0){
			jsonSuccess("更新成功");
		}else{
			jsonError("更新失败");
		}
		if(pushflag.equals("1")){
			int b=noticeService.insertPush(entity,"update");
			if(b>0){
				jsonSuccess("发布成功");
			}else{
				jsonSuccess("发布失败");
			}
		}
		return ActionSupport.SUCCESS;
	}
	
	public String delete(){
		noticeService.delete(noticeId);
		noticeSendscopeService.deleteByNoticeId(noticeId);
		jsonSuccess("删除成功");
		return ActionSupport.SUCCESS;
	}	
	private Date parseDataStr(String dateStr) throws Exception{
		SimpleDateFormat format = new SimpleDateFormat(DATE_PATTERN);
		return format.parse(dateStr);
	}
	public void downFile(){
		try{
			NoticeMainEntity noticeMain=noticeService.selectEntityById(noticeId);
			HttpServletResponse response = ServletActionContext.getResponse();
			DownloadBaseAction down = new DownloadBaseAction();
			down.prototypeDowload(new File(new String(noticeMain.getPath().getBytes("ISO8859-1"), "utf-8")), noticeMain.getFilename(), response, false);
		}catch (Exception e) {
			jsonError("下载失败");
			e.printStackTrace();
		}
		
	}
	private static final String DATE_PATTERN = "yyyy-MM-dd HH:mm:ss";
	public long getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(long totalPage) {
		this.totalPage = totalPage;
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
	public Page getPage() {
		return page;
	}
	public File getNotifyFile() {
		return notifyFile;
	}
	public void setNotifyFile(File notifyFile) {
		this.notifyFile = notifyFile;
	}
	
	public String getNotifyFileFileName() {
		return notifyFileFileName;
	}
	public void setNotifyFileFileName(String notifyFileFileName) {
		this.notifyFileFileName = notifyFileFileName;
	}
	
	public Integer getNoticeId() {
		return noticeId;
	}
	public void setNoticeId(Integer noticeId) {
		this.noticeId = noticeId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public NoticeMainEntity getNoticeMainEntity() {
		return noticeMainEntity;
	}
	public void setNoticeMainEntity(NoticeMainEntity noticeMainEntity) {
		this.noticeMainEntity = noticeMainEntity;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	
	public String getNoticereplycode() {
		return noticereplycode;
	}

	public void setNoticereplycode(String noticereplycode) {
		this.noticereplycode = noticereplycode;
	}
	
	public Map<String, Object> getReplymap() {
		return replymap;
	}

	public void setReplymap(Map<String, Object> replymap) {
		this.replymap = replymap;
	}

	public String[] getScopeids() {
		return scopeids;
	}
	public void setScopeids(String[] scopeids) {
		this.scopeids = scopeids;
	}
	
	public String getPushflag() {
		return pushflag;
	}
	
	public void setPushflag(String pushflag) {
		this.pushflag = pushflag;
	}
	
	public Map<String, Object> getMap() {
		return map;
	}
	
	public void setMap(Map<String, Object> map) {
		this.map = map;
	}
	
	public List<NoticeSendscopeEntity> getScopelist() {
		return scopelist;
	}
	
	public void setScopelist(List<NoticeSendscopeEntity> scopelist) {
		this.scopelist = scopelist;
	}
}
