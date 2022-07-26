package com.cloudrich.ereader.filemonitor.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.cloudrich.ereader.common.action.BaseAction;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.common.util.ValidateUtil;
import com.cloudrich.ereader.dict.entity.DictDataEntity;
import com.cloudrich.ereader.dict.service.DictDataService;
import com.cloudrich.ereader.filemonitor.entity.FileMonitorUserEntity;
import com.cloudrich.ereader.filemonitor.service.FileMonitorService;
import com.cloudrich.ereader.meeting.entity.MeetMainEntity;
import com.cloudrich.ereader.meeting.service.MeetingViewService;
import com.cloudrich.ereader.system.service.UserService;


@Controller("FileMonitorAction")
public class FileMonitorAction extends BaseAction{
	@Resource DictDataService dictDataService;
	@Resource MeetingViewService meetingViewService;
	@Resource FileMonitorService fileMonitorService;
	@Resource UserService userService;
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String mtype;
	private int meetid;
	//对于每个用户
	private int shouldReceive;//应收文件数量
	private int notReceived;//未收到的文件数量
	private List<FileMonitorUserEntity> userList;
	//对于所有文件
	private int total;//总人数
	private int allReceived;//全部已接收人数
	private int allNotReceived;//全部未接收人数
	private int notAllReceived;//未全部接收人数
	private List<DictDataEntity> dictList;
	private List<MeetMainEntity> meetList;
	private Map<DictDataEntity,List<MeetMainEntity>> map;
	private Page page;
	private int pageNo=1;
	private int pageSize=8;
	private long totalPage;
	private long offset;
	private List<FileMonitorUserEntity> ulist;
	private List<FileMonitorUserEntity> uslist;
	private String flag="0";
	List<Map<String,Object>> fmList;//新增字段

	public String select() {
		flag="0";
		System.out.println("mtype:"+mtype);
		dictList=dictDataService.getDictDataByType("mtype");
		map=new HashMap<DictDataEntity, List<MeetMainEntity>>();
		for (DictDataEntity e : dictList) {
			map.put(e, meetingViewService.selectAllMeetBasicByMtype(e.getCode()));
		}
		mtype=mtype==null?dictList.get(0).getCode():mtype;
		System.out.println("mtype:"+mtype);
		meetList=meetingViewService.selectAllMeetBasicByMtype(mtype);
		if(meetList!=null&&meetList.size()!=0){
			meetid=meetid==0?meetList.get(0).getMeetid():meetid;
		}
		//userList=new ArrayList<FileMonitorUserEntity>();
		//根据meetid获取文件推送用户总数
	    Map<String,Object> params=new HashMap<String,Object>();
	    params.put("meetid", meetid);
	    
	    if (fmList == null || fmList.size() == 0 || fmList.get(fmList.size()-1) == null) {
	    	fmList=fileMonitorService.selectAllUsersByMeetid(params);
	    	userList = null;
	    	userList = new ArrayList<FileMonitorUserEntity>();
	    	for (Map<String,Object> e : fmList) {
	    		FileMonitorUserEntity entity=new FileMonitorUserEntity();
	    		String name=ValidateUtil.isValid(e.get("truename")+"")?e.get("truename").toString():"";
	    		//获取用户应接受的文件总数
	    		int filetotal=fileMonitorService.selectTotalMeetFileCount(meetid,mtype,Integer.parseInt(e.get("userid").toString()));
	    		//用户接收到的文件总数
	    		int filecount=fileMonitorService.selectUserAcceptFileCount(meetid, Integer.parseInt(e.get("userid").toString()));
//					List<FileMonitorEntity> fList=fileMonitorService.selectByUseridAndAccept(e.getUserid(), 0);
	    		entity.setName(name);
	    		entity.setId(Integer.parseInt(e.get("userid").toString()));
	    		notReceived=filetotal-filecount;
	    		entity.setNotReceived(notReceived);//用户未接受的文件总数
	    		entity.setShouldReceive(filetotal);//用户应该接收到的文件总数
	    		entity.setHaveReceived(filecount);//用户已接受的文件总数
	    		userList.add(entity);
	    	}
		}
	    total=fmList.size();
	    //userList.removeAll(userList);
	    
		System.out.println("fmList:"+fmList);
		System.out.println(meetid+","+mtype);
		
		allReceived=0;
		allNotReceived=0;
		for (FileMonitorUserEntity u : userList) {
			if (u.getHaveReceived()==u.getShouldReceive()) {
				allReceived++;
			}else if (u.getHaveReceived()==0&&u.getShouldReceive()!=0) {
				allNotReceived++;
			}
		}
		notAllReceived=total-allReceived-allNotReceived;
//			}
//		}else {
//			if(userList!=null&&userList.size()!=0){
//				userList.removeAll(userList);
//		    }
//			total=0;
//			allReceived=0;
//			allNotReceived=0;
//			notAllReceived=0;
//		}
		if(userList!=null){
			if (userList.size()%pageSize==0) {
				totalPage=userList.size()/pageSize;
			}else {
				totalPage=userList.size()/pageSize+1;
			}
		}
		offset=(pageNo-1)*pageSize;
		ulist=new ArrayList<FileMonitorUserEntity>();
		ulist.removeAll(ulist);
		System.out.println("userList.size()" + userList);
		if(userList!=null&&userList.size()!=0){
			for (int i = 0; i < userList.size(); i++) {
				if (i>=offset&&i<offset+pageSize) {
					ulist.add(userList.get(i));
				}
			}
		}
		System.out.println(totalPage);
		System.out.println(ulist.toString());
		uslist=ulist;
		return SUCCESS;
	}
	
	public String allReceived() {
		dictList=dictDataService.getDictDataByType("mtype");
		map=new HashMap<DictDataEntity, List<MeetMainEntity>>();
		for (DictDataEntity e : dictList) {
			map.put(e, meetingViewService.selectAllMeetBasicByMtype(e.getCode()));
		}
		mtype=mtype==null?dictList.get(0).getCode():mtype;
		meetList=meetingViewService.selectAllMeetBasicByMtype(mtype);
		if(meetList!=null&&meetList.size()!=0){
			meetid=meetid==0?meetList.get(0).getMeetid():meetid;
		}
		userList=new ArrayList<FileMonitorUserEntity>();
				//根据meetid获取文件推送用户总数
			    Map<String,Object> params=new HashMap<String,Object>();
			    params.put("meetid", meetid);
		        List<Map<String,Object>> fmList=fileMonitorService.selectAllUsersByMeetid(params);
				total=fmList.size();
				System.out.println("fmList:"+fmList);
				System.out.println(meetid+","+mtype);
				userList.removeAll(userList);
				for (Map<String,Object> e : fmList) {
					FileMonitorUserEntity entity=new FileMonitorUserEntity();
					String name=ValidateUtil.isValid(e.get("truename")+"")?e.get("truename").toString():"";
					//获取用户应接受的文件总数
					int filetotal=fileMonitorService.selectTotalMeetFileCount(meetid,mtype,Integer.parseInt(e.get("userid").toString()));
					//用户接收到的文件总数
					int filecount=fileMonitorService.selectUserAcceptFileCount(meetid, Integer.parseInt(e.get("userid").toString()));
//					List<FileMonitorEntity> fList=fileMonitorService.selectByUseridAndAccept(e.getUserid(), 0);
					entity.setName(name);
					entity.setId(Integer.parseInt(e.get("userid").toString()));
					notReceived=filetotal-filecount;
					entity.setNotReceived(notReceived);//用户未接受的文件总数
					entity.setShouldReceive(filetotal);//用户应该接收到的文件总数
					entity.setHaveReceived(filecount);//用户已接受的文件总数
					userList.add(entity);
				}
				allReceived=0;
				allNotReceived=0;
				for (FileMonitorUserEntity u : userList) {
					if (u.getHaveReceived()==u.getShouldReceive()) {
						allReceived++;
					}else if (u.getHaveReceived()==0&&u.getShouldReceive()!=0) {
						allNotReceived++;
					}
				}
				notAllReceived=total-allReceived-allNotReceived;
				
				flag="1";
				List<FileMonitorUserEntity> ualist=new ArrayList<FileMonitorUserEntity>();
				for (FileMonitorUserEntity user : userList) {
					if (user.getHaveReceived()==user.getShouldReceive()) {
						ualist.add(user);
					}
				}
				if(ualist!=null){
					if (ualist.size()%pageSize==0) {
						totalPage=ualist.size()/pageSize;
					}else {
						totalPage=ualist.size()/pageSize+1;
					}
				}
				offset=(pageNo-1)*pageSize;
				ulist=new ArrayList<FileMonitorUserEntity>();
				ulist.removeAll(ulist);
				if(ualist!=null&&ualist.size()!=0){
					for (int i = 0; i < ualist.size(); i++) {
						if (i>=offset&&i<offset+pageSize) {
							ulist.add(ualist.get(i));
						}
					}
				}
				return SUCCESS;
	}
	
	public String allNotReceived() {
		dictList=dictDataService.getDictDataByType("mtype");
		map=new HashMap<DictDataEntity, List<MeetMainEntity>>();
		for (DictDataEntity e : dictList) {
			map.put(e, meetingViewService.selectAllMeetBasicByMtype(e.getCode()));
		}
		mtype=mtype==null?dictList.get(0).getCode():mtype;
		meetList=meetingViewService.selectAllMeetBasicByMtype(mtype);
		if(meetList!=null&&meetList.size()!=0){
			meetid=meetid==0?meetList.get(0).getMeetid():meetid;
		}
		userList=new ArrayList<FileMonitorUserEntity>();
		
				//根据meetid获取文件推送用户总数
			    Map<String,Object> params=new HashMap<String,Object>();
			    params.put("meetid", meetid);
		        List<Map<String,Object>> fmList=fileMonitorService.selectAllUsersByMeetid(params);
				total=fmList.size();
				System.out.println("fmList:"+fmList);
				System.out.println(meetid+","+mtype);
				userList.removeAll(userList);
				for (Map<String,Object> e : fmList) {
					FileMonitorUserEntity entity=new FileMonitorUserEntity();
					String name=ValidateUtil.isValid(e.get("truename")+"")?e.get("truename").toString():"";
					//获取用户应接受的文件总数
					int filetotal=fileMonitorService.selectTotalMeetFileCount(meetid,mtype,Integer.parseInt(e.get("userid").toString()));
					//用户接收到的文件总数
					int filecount=fileMonitorService.selectUserAcceptFileCount(meetid, Integer.parseInt(e.get("userid").toString()));
//					List<FileMonitorEntity> fList=fileMonitorService.selectByUseridAndAccept(e.getUserid(), 0);
					entity.setName(name);
					entity.setId(Integer.parseInt(e.get("userid").toString()));
					notReceived=filetotal-filecount;
					entity.setNotReceived(notReceived);//用户未接受的文件总数
					entity.setShouldReceive(filetotal);//用户应该接收到的文件总数
					entity.setHaveReceived(filecount);//用户已接受的文件总数
					userList.add(entity);
				}
				allReceived=0;
				allNotReceived=0;
				for (FileMonitorUserEntity u : userList) {
					if (u.getHaveReceived()==u.getShouldReceive()) {
						allReceived++;
					}else if (u.getHaveReceived()==0&&u.getShouldReceive()!=0) {
						allNotReceived++;
					}
				}
				notAllReceived=total-allReceived-allNotReceived;		
		
				flag="2";
				List<FileMonitorUserEntity> ualist=new ArrayList<FileMonitorUserEntity>();
				for (FileMonitorUserEntity user : userList) {
					if (user.getHaveReceived()==0&&user.getShouldReceive()!=0) {
						ualist.add(user);
					}
				}
				if(ualist!=null){
					if (ualist.size()%pageSize==0) {
						totalPage=ualist.size()/pageSize;
					}else {
						totalPage=ualist.size()/pageSize+1;
					}
				}
				offset=(pageNo-1)*pageSize;
				ulist=new ArrayList<FileMonitorUserEntity>();
				ulist.removeAll(ulist);
				if(ualist!=null&&ualist.size()!=0){
					for (int i = 0; i < ualist.size(); i++) {
						if (i>=offset&&i<offset+pageSize) {
							ulist.add(ualist.get(i));
						}
					}
				}		
				return SUCCESS;
	}
	
	public String notAllReceived() {
		dictList=dictDataService.getDictDataByType("mtype");
		map=new HashMap<DictDataEntity, List<MeetMainEntity>>();
		for (DictDataEntity e : dictList) {
			map.put(e, meetingViewService.selectAllMeetBasicByMtype(e.getCode()));
		}
		mtype=mtype==null?dictList.get(0).getCode():mtype;
		meetList=meetingViewService.selectAllMeetBasicByMtype(mtype);
		if(meetList!=null&&meetList.size()!=0){
			meetid=meetid==0?meetList.get(0).getMeetid():meetid;
		}
		userList=new ArrayList<FileMonitorUserEntity>();
		//根据meetid获取文件推送用户总数
	    Map<String,Object> params=new HashMap<String,Object>();
	    params.put("meetid", meetid);
        List<Map<String,Object>> fmList=fileMonitorService.selectAllUsersByMeetid(params);
		total=fmList.size();
		System.out.println("fmList:"+fmList);
		System.out.println(meetid+","+mtype);
		userList.removeAll(userList);
		for (Map<String,Object> e : fmList) {
			FileMonitorUserEntity entity=new FileMonitorUserEntity();
			String name=ValidateUtil.isValid(e.get("truename")+"")?e.get("truename").toString():"";
			//获取用户应接受的文件总数
			int filetotal=fileMonitorService.selectTotalMeetFileCount(meetid,mtype,Integer.parseInt(e.get("userid").toString()));
			//用户接收到的文件总数
			int filecount=fileMonitorService.selectUserAcceptFileCount(meetid, Integer.parseInt(e.get("userid").toString()));
//			List<FileMonitorEntity> fList=fileMonitorService.selectByUseridAndAccept(e.getUserid(), 0);
			entity.setName(name);
			entity.setId(Integer.parseInt(e.get("userid").toString()));
			notReceived=filetotal-filecount;
			entity.setNotReceived(notReceived);//用户未接受的文件总数
			entity.setShouldReceive(filetotal);//用户应该接收到的文件总数
			entity.setHaveReceived(filecount);//用户已接受的文件总数
			userList.add(entity);
		}
		allReceived=0;
		allNotReceived=0;
		for (FileMonitorUserEntity u : userList) {
			if (u.getHaveReceived()==u.getShouldReceive()) {
				allReceived++;
			}else if (u.getHaveReceived()==0&&u.getShouldReceive()!=0) {
				allNotReceived++;
			}
		}
		notAllReceived=total-allReceived-allNotReceived;			
		
		flag="3";
		List<FileMonitorUserEntity> ualist=new ArrayList<FileMonitorUserEntity>();
		for (FileMonitorUserEntity user : userList) {
			if (user.getHaveReceived()<user.getShouldReceive()&&user.getHaveReceived()>0) {
				ualist.add(user);
			}
		}
		if(ualist!=null){
			if (ualist.size()%pageSize==0) {
				totalPage=ualist.size()/pageSize;
			}else {
				totalPage=ualist.size()/pageSize+1;
			}
		}
		offset=(pageNo-1)*pageSize;
		ulist=new ArrayList<FileMonitorUserEntity>();
		ulist.removeAll(ulist);
		if(ualist!=null&&ualist.size()!=0){
			for (int i = 0; i < ualist.size(); i++) {
				if (i>=offset&&i<offset+pageSize) {
					ulist.add(ualist.get(i));
				}
			}
		}		
		return SUCCESS;
	}

	public List<FileMonitorUserEntity> getUlist() {
		return ulist;
	}

	public void setUlist(List<FileMonitorUserEntity> ulist) {
		this.ulist = ulist;
	}

	public int getShouldReceive() {
		return shouldReceive;
	}

	public void setShouldReceive(int shouldReceive) {
		this.shouldReceive = shouldReceive;
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

	public Map<DictDataEntity, List<MeetMainEntity>> getMap() {
		return map;
	}

	public void setMap(Map<DictDataEntity, List<MeetMainEntity>> map) {
		this.map = map;
	}

	public List<DictDataEntity> getDictList() {
		return dictList;
	}

	public void setDictList(List<DictDataEntity> dictList) {
		this.dictList = dictList;
	}

	public List<MeetMainEntity> getMeetList() {
		return meetList;
	}

	public void setMeetList(List<MeetMainEntity> meetList) {
		this.meetList = meetList;
	}

	public List<FileMonitorUserEntity> getUserList() {
		return userList;
	}

	public void setUserList(List<FileMonitorUserEntity> userList) {
		this.userList = userList;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getAllReceived() {
		return allReceived;
	}

	public void setAllNotReceived(int allNotReceived) {
		this.allNotReceived = allNotReceived;
	}

	public int getAllNotReceived() {
		return allNotReceived;
	}

	public void setAllReceived(int allReceived) {
		this.allReceived = allReceived;
	}

	public int getNotAllReceived() {
		return notAllReceived;
	}

	public void setNotAllReceived(int notAllReceived) {
		this.notAllReceived = notAllReceived;
	}

	public String getMtype() {
		return mtype;
	}

	public void setMtype(String mtype) {
		this.mtype = mtype;
	}

	public int getMeetid() {
		return meetid;
	}

	public void setMeetid(int meetid) {
		this.meetid = meetid;
	}

	public int getNotReceived() {
		return notReceived;
	}

	public void setNotReceived(int notReceived) {
		this.notReceived = notReceived;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public List<Map<String, Object>> getFmList() {
		return fmList;
	}

	public void setFmList(List<Map<String, Object>> fmList) {
		this.fmList = fmList;
	}

}
