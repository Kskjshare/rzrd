package com.cloudrich.ereader.meeting.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.cloudrich.ereader.common.dao.PageHelper;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.common.dao.PageHelper.PageCall;
import com.cloudrich.ereader.dict.service.DictDataService;
import com.cloudrich.ereader.meeting.dao.MeetFileMainDao;
import com.cloudrich.ereader.meeting.dao.MeetFileScopeDao;
import com.cloudrich.ereader.meeting.dao.MeetFileUserDao;
import com.cloudrich.ereader.meeting.dao.MeetGroupMainDao;
import com.cloudrich.ereader.meeting.dao.MeetMainDao;
import com.cloudrich.ereader.meeting.dao.MeetProcessLogDao;
import com.cloudrich.ereader.meeting.dao.MeetRichenFileDao;
import com.cloudrich.ereader.meeting.dao.MeetRichenMainDao;
import com.cloudrich.ereader.meeting.dao.MeetRichenYitiDao;
import com.cloudrich.ereader.meeting.dao.MeetYichenFileDao;
import com.cloudrich.ereader.meeting.dao.MeetYichenMainDao;
import com.cloudrich.ereader.meeting.entity.MeetFileMainEntity;
import com.cloudrich.ereader.meeting.entity.MeetFileScopeEntity;
import com.cloudrich.ereader.meeting.entity.MeetFileUserEntity;
import com.cloudrich.ereader.meeting.entity.MeetGroupMainEntity;
import com.cloudrich.ereader.meeting.entity.MeetMainEntity;
import com.cloudrich.ereader.meeting.entity.MeetProcessLogEntity;
import com.cloudrich.ereader.meeting.entity.MeetRichenFileEntity;
import com.cloudrich.ereader.meeting.entity.MeetRichenMainEntity;
import com.cloudrich.ereader.meeting.entity.MeetRichenYitiEntity;
import com.cloudrich.ereader.meeting.entity.MeetYichenFileEntity;
import com.cloudrich.ereader.meeting.entity.MeetYichenMainEntity;
import com.cloudrich.ereader.meetpub.dao.MeetPubFileDao;
import com.cloudrich.ereader.meetpub.dao.MeetPubGroupDao;
import com.cloudrich.ereader.meetpub.dao.MeetPubPubtimeDao;
import com.cloudrich.ereader.meetpub.dao.MeetPubRichenDao;
import com.cloudrich.ereader.meetpub.dao.MeetPubRichenYitiDao;
import com.cloudrich.ereader.meetpub.dao.MeetPubYichenDao;
import com.cloudrich.ereader.meetpub.entity.MeetPubFileEntity;
import com.cloudrich.ereader.meetpub.entity.MeetPubGroupEntity;
import com.cloudrich.ereader.meetpub.entity.MeetPubPubtimeEntity;
import com.cloudrich.ereader.meetpub.entity.MeetPubRichenEntity;
import com.cloudrich.ereader.meetpub.entity.MeetPubYichenEntity;
import com.cloudrich.ereader.system.service.ScopeMainService;
import com.cloudrich.ereader.system.service.UserService;

@Service
public class MeetingViewServiceImpl  implements MeetingViewService{
	
	private Logger log = Logger.getLogger(MeetingViewServiceImpl.class);

	@Resource MeetMainDao meetMainDao;
	@Resource MeetYichenMainDao yichenMainDao;
	@Resource MeetRichenMainDao richenMainDao;
	@Resource MeetRichenYitiDao richenYitiDao;
	@Resource MeetFileMainDao meetFileMainDao;
	@Resource MeetGroupMainDao meetGroupMainDao;
	@Resource DictDataService dictDataService;
	
	
	@Resource MeetPubYichenDao pubYichenDao;
	@Resource MeetPubRichenDao pubRichenDao;
	@Resource MeetPubFileDao pubFileDao;
	@Resource MeetPubRichenYitiDao pubRichenYitiDao;
	@Resource MeetProcessLogDao meetProcessLogDao;
	
	@Resource MeetPubFileDao pubMeetFileDao;
	@Resource MeetPubYichenDao pubyichenDao;
	@Resource MeetPubFileDao meetPubFileDao;
	@Resource UserService userService;
	@Resource MeetFileScopeDao meetFileScopeDao;	
	@Resource ScopeMainService scopeMainService;
	@Resource  MeetPubGroupDao meetPubGroupDao;
	@Resource  MeetPubPubtimeDao meetPubPubtimeDao;
	@Resource MeetRichenFileDao meetRichenFileDao;
	@Resource MeetYichenFileDao meetYichenFileDao;
	@Resource MeetFileUserDao meetFileUserDao;


	@Override
	public MeetMainEntity selectEntityById(int id) {
		return meetMainDao.selectByPrimaryKey(id);
	}

	@Override
	public List<MeetMainEntity> selectAll() {
			List<MeetMainEntity> list = meetMainDao.selectAll();
			return list;
		
	}
	
	@Override
	 public List<MeetMainEntity> selectAllMeetBasicByMtype(String mtype){
		return meetMainDao.selectALLMeetingByMtype(mtype);
	}

	/**
	 * 根据会议类型获取当前会议信息
	 */
	@Override
	 public MeetMainEntity selectCurMeeting(String mtype){
		MeetMainEntity meet=null;
		List<MeetMainEntity> list=meetMainDao.selectCurMeeting(mtype);
	    System.out.print(list.size());
	    if(list!=null&&list.size()!=0){
	    	meet=list.get(0);
	    }
	    return meet;
	}
	
	/**
	 * 根据会议类型获取当前会议信息
	 */
	@Override
	 public List<MeetMainEntity> selectHisMeeting(String mtype){
	    	
		 return meetMainDao.selectHisMeeting(mtype);
	    	
	    }
	
	@Override
	public MeetMainEntity selectMeetBasicByMeetId(int meetid){
		 return meetMainDao.selectByPrimaryKey(meetid);
		
	}
	/**
	 * 删除历史会议
	 */
	@Override
	public int deletemeetLS(int meetid){
		int i = meetMainDao.deletemeetLS(meetid);
		meetMainDao.deletemeetLS(meetid);
		return i;
		
	}
	@Override
	 public List<MeetYichenMainEntity> selectAllYichenByMeetid(int meetid){
		return yichenMainDao.selectAllByMeetid(meetid);
		
	}
	
	@Override
	public MeetYichenMainEntity selectYichenByYichenId(int yichenid){
		return yichenMainDao.selectByPrimaryKey(yichenid);
	}
	
	@Override
	 public List<MeetFileMainEntity> selectAllFileByYichenid(int yichenid){
	      return yichenMainDao.selectFilesByYichenid(yichenid);
	}
	
	
	 /**
     * 获取日程信息
     * @param briefid
     * @return
     */
	@Override
    public  List<MeetRichenMainEntity>  selectAllRichenByMeetid(int meetid){
		return richenMainDao.selectAllRichenByMeetid(meetid);
		
	}
    
	@Override
    public List<MeetRichenYitiEntity>  selectAllYitiByRichenid(int richenid){
		return richenYitiDao.selectAllYitiByRichenid(richenid);
		
	}
	
	@Override
    public Page selectALLMeetFileByMeetid1(final HashMap<String,Object> map1,int pageNo, int pageSize){
		
		Page page1=PageHelper.pagedQuery(new PageCall() {
			@Override
			public void executeQuery() {
				meetFileMainDao.selectAllFileByMeetidAndFileOwn(map1);
			}
		}, pageNo,pageSize);
		
		  List<MeetFileMainEntity> list=page1.getResult();
		  List<MeetFileMainEntity> finallist=new ArrayList<MeetFileMainEntity>();
		  MeetFileMainEntity entity=null;
		  List<MeetYichenMainEntity> listyichen=null;
		  List<MeetFileScopeEntity> listscope=null;
		  for(int i=0;i<list.size();i++){
			  entity=list.get(i);
			  if("8".equals(entity.getFiletype())){
				  List<MeetRichenMainEntity> richenlist=richenMainDao.selectRichenFileByFileid(entity.getFileid());
				  if(richenlist!=null&&richenlist.size()!=0){
					  MeetYichenMainEntity entitys=new MeetYichenMainEntity();
					  listyichen=new ArrayList<MeetYichenMainEntity>();
					  listyichen.add(entitys);
				  }else{
					  listyichen=null;
				  }
			  }else{
				  listyichen=yichenMainDao.selectBindYichenByFileid(entity.getFileid());
			  }
			  //文件推送用户
			  	List<MeetFileUserEntity> listuserscope=null;
				listuserscope=meetFileUserDao.selectUserByFileid(entity.getFileid());
				if(listuserscope!=null&&listuserscope.size()!=0){
					  String scopename="";
					  for (int j = 0; j <listuserscope.size(); j++) {
						    scopename+=listuserscope.get(j).getTruename()+",";
					   }
					  scopename=scopename.substring(0, scopename.lastIndexOf(","));
					  entity.setFilescopes(scopename);
				}
			  if(listyichen!=null&&listyichen.size()!=0){
				  entity.setBindyichenlist(listyichen);
			  }
			  finallist.add(entity);
		  }
		  page1.setResult(finallist);
		return page1;
	}
	
	
	/**
	 //map.put("meetid", meetid);
	//map.put("fileown", "1");
	//map.put("filetype","1");
	 * fileown 1代表会议文件  2代表会中主任会议文件  3代表闭幕会
	 * 
	 */
	@Override
	public List<MeetFileMainEntity> selectALLMeetFileByMeetid1(int meetid,String fileown,String filetype){
		HashMap<String,Object> map=new HashMap<String,Object>();
		map.put("meetid", meetid);
		map.put("fileown", fileown);
		map.put("filetype", filetype);
		List<MeetFileScopeEntity> listscope=null;
		List<MeetFileUserEntity> listuserscope=null;
		List<MeetFileMainEntity> list=meetFileMainDao.selectAllFileByMeetidAndFileOwn(map);
		System.out.println("list="+list);
		for (int i = 0; i < list.size(); i++) {
			MeetFileMainEntity entity=list.get(i);
/*				  listscope=meetFileScopeDao.selectByFileid(entity.getFileid());
			  if(listscope!=null&&listscope.size()!=0){
				  String scopename="";
			  for (int j = 0; j <listscope.size(); j++) {
					Integer scopeid=listscope.get(j).getScopeid();
				    scopename+=userService.selectEntityById(scopeid).getTruename()+",";
				  }
				  scopename=scopename.substring(0, scopename.lastIndexOf(","));
				  entity.setFilescopes(scopename);
			  }*/
			//获取推送范围中的用户名
			System.out.println("1当前文件ID："+entity.getFileid());
			listuserscope=meetFileUserDao.selectUserByFileid(entity.getFileid());
			System.out.println("1获取推送范围中的用户名");
			if(listuserscope!=null&&listuserscope.size()!=0){
				  String scopename="";
				  for (int j = 0; j <listuserscope.size(); j++) {
					  System.out.println(listuserscope.get(j).getTruename());
					    scopename+=listuserscope.get(j).getTruename()+",";
				   }
				  scopename=scopename.substring(0, scopename.lastIndexOf(","));
				  System.out.println(scopename);
				  entity.setFilescopes(scopename);
			}
		}
		System.out.println(list);
		return list;	
	}
    
    
	/**
	 //map.put("meetid", meetid);
	//map.put("fileown", "1");
	//map.put("filetype","1");
	 * fileown 1代表会议文件  2代表会中主任会议文件  3代表闭幕会
	 * 
	 */
    @Override
   public List<MeetFileMainEntity> selectALLMeetFileByMeetid(int meetid,String fileown,String filetype){
		HashMap<String,Object> map=new HashMap<String,Object>();
		map.put("meetid", meetid);
		map.put("fileown", fileown);
		map.put("filetype", filetype);
		List<MeetFileScopeEntity> listscope=null;
		List<MeetFileUserEntity> listuserscope=null;
		List<MeetFileMainEntity> list=meetFileMainDao.selectAllFileByMeetidAndFileOwn(map);
		System.out.println("list="+list);
		for (int i = 0; i < list.size(); i++) {
			MeetFileMainEntity entity=list.get(i);
/*				  listscope=meetFileScopeDao.selectByFileid(entity.getFileid());
			  if(listscope!=null&&listscope.size()!=0){
				  String scopename="";
			  for (int j = 0; j <listscope.size(); j++) {
					Integer scopeid=listscope.get(j).getScopeid();
				    scopename+=userService.selectEntityById(scopeid).getTruename()+",";
				  }
				  scopename=scopename.substring(0, scopename.lastIndexOf(","));
				  entity.setFilescopes(scopename);
			  }*/
			//获取推送范围中的用户名
			System.out.println("当前文件ID："+entity.getFileid());
			listuserscope=meetFileUserDao.selectFileUsersByFileid(entity.getFileid());
			System.out.println("获取推送范围中的用户名");
			if(listuserscope!=null&&listuserscope.size()!=0){
				  String scopename="";
				  for (int j = 0; j <listuserscope.size(); j++) {
					  System.out.println(listuserscope.get(j).getTruename());
					    scopename+=listuserscope.get(j).getTruename()+",";
				   }
				  scopename=scopename.substring(0, scopename.lastIndexOf(","));
				  System.out.println(scopename);
				  entity.setFilescopes(scopename);
			}
			
			/**
			 * 
			 */
			
			
			
			/**
			 * 
			 */
			
		}
		return list;	
	}
	
	
	//根据推送范围获取文件列表
	@Override
    public List<MeetFileMainEntity> selectALLMeetFileByMeetidAndUserid(int meetid,String fileown,String filetype,int userid){
		HashMap<String,Object> map=new HashMap<String,Object>();
		System.out.println("meetid:"+meetid+" fileown:"+fileown+" filetype"+filetype+" userid"+userid);
		map.put("meetid", meetid);
		map.put("fileown", fileown);
		map.put("filetype", filetype);
		map.put("userid", userid);
		return meetPubFileDao.selectAllFileByMeetidAndFileOwnAndVersionAndUserid(map);	
	}
	
	
	@Override
    public List<MeetFileMainEntity> selectALLPubMeetFileByMeetid(int meetid,String fileown,String filetype){
//		int version=0;
//		try{
//			version=meetPubFileDao.selectMeetMaxVersion(meetid);
//			}catch(Exception e){
//				e.printStackTrace();
//				version=0;
//			}
		
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("meetid", meetid);
		map.put("fileown", fileown);
		map.put("filetype", filetype);
		//map.put("version", version);
		return pubMeetFileDao.selectAllFileByMeetidAndFileOwnAndVersion(map);
	}
    
	/**
	 * 获取参阅文件
	 */
	@Override
    public List<MeetFileMainEntity> selectALLPubMeetFileByMeetidAndVersionAndUserid(int meetid,String fileown,String filetype,int userid){
		int version=0;
//		try{
//			version=meetPubFileDao.selectMeetMaxVersion(meetid);
//			}catch(Exception e){
//				e.printStackTrace();
//				version=0;
//			}
		
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("meetid", meetid);
		map.put("fileown", fileown);
		map.put("filetype", filetype);
		map.put("userid", userid);
//		map.put("version", version);
		return pubMeetFileDao.selectAllFileByMeetidAndFileOwnAndVersionAndUserid(map);
	}
    
    /**
     * 
     */
	@Override
    public Page selectALLMeetFileByMeetid(final HashMap<String,Object> map1,int pageNo, int pageSize){
		
		Page page1=PageHelper.pagedQuery(new PageCall() {
			@Override
			public void executeQuery() {
				meetFileMainDao.selectAllFileByMeetidAndFileOwn(map1);
			}
		}, pageNo,pageSize);
		
		  List<MeetFileMainEntity> list=page1.getResult();
		  List<MeetFileMainEntity> finallist=new ArrayList<MeetFileMainEntity>();
		  MeetFileMainEntity entity=null;
		  List<MeetYichenMainEntity> listyichen=null;
		  List<MeetFileScopeEntity> listscope=null;
		  for(int i=0;i<list.size();i++){
			  entity=list.get(i);
			  if("8".equals(entity.getFiletype())){
				  List<MeetRichenMainEntity> richenlist=richenMainDao.selectRichenFileByFileid(entity.getFileid());
				  if(richenlist!=null&&richenlist.size()!=0){
					  MeetYichenMainEntity entitys=new MeetYichenMainEntity();
					  listyichen=new ArrayList<MeetYichenMainEntity>();
					  listyichen.add(entitys);
				  }else{
					  listyichen=null;
				  }
			  }else{
				  listyichen=yichenMainDao.selectBindYichenByFileid(entity.getFileid());
			  }
/*			  listscope=meetFileScopeDao.selectByFileid(entity.getFileid());
			  if(listscope!=null&&listscope.size()!=0){
				  String scopename="";
				  for (int j = 0; j <listscope.size(); j++) {
					Integer scopeid=listscope.get(j).getScopeid();
				    //scopename+=scopeMainService.selectEntityById(scopeid).getScopename()+",";
					scopename+=userService.selectEntityById(scopeid).getTruename()+",";
				  }
				  scopename=scopename.substring(0, scopename.lastIndexOf(","));
				  entity.setFilescopes(scopename);
			  }*/
			  //文件推送用户
			  	List<MeetFileUserEntity> listuserscope=null;
				listuserscope=meetFileUserDao.selectUserByFileid(entity.getFileid());
				if(listuserscope!=null&&listuserscope.size()!=0){
					  String scopename="";
					  for (int j = 0; j <listuserscope.size(); j++) {
						    scopename+=listuserscope.get(j).getTruename()+",";
					   }
					  scopename=scopename.substring(0, scopename.lastIndexOf(","));
					  entity.setFilescopes(scopename);
				}
			  if(listyichen!=null&&listyichen.size()!=0){
				  entity.setBindyichenlist(listyichen);
			  }
/*			  if(map1.get("bindtype")!=null){
				  if("1".equals(map1.get("bindtype").toString())){
					  if(listyichen==null||listyichen.size()==0){
						  finallist.add(entity);
					  }
				  }else{
					  if(listyichen!=null&&listyichen.size()!=0){
						  finallist.add(entity);
					  }
				  }
			  }else{
				  finallist.add(entity);
			  }*/
			  finallist.add(entity);
		  }
		  page1.setResult(finallist);
		return page1;
	}
	/**
     * 历史会议获取闭幕会文件
     * @param meetid
     * @return
     */  
    public Page selectALLPubMeetFileByMeetid(final HashMap<String,Object> map1,int pageNo, int pageSize){
		
		Page page1=PageHelper.pagedQuery(new PageCall() {
			@Override
			public void executeQuery() {
				meetPubFileDao.selectAllFileByMeetidAndFileOwn(map1);
			}
		}, pageNo,pageSize);
		return page1;
    }
	/**
     * 获取分组列表  "1"代表第一组,"2"代表第二组
     * @param meetid
     * @return
     */
	@Override
   public MeetGroupMainEntity selectGroupByMeetidAndGrpno(int meetid,String grpno){
		HashMap<String,Object> map=new HashMap<String,Object>();
		map.put("meetid", meetid);
		map.put("groupno", grpno);
		return meetGroupMainDao.selectGroupByMeetidAndGroupno(map);
	}
	
	/**
     * 获取发布分组列表  "1"代表第一组,"2"代表第二组
     * @param meetid
     * @return
     */
	@Override
   public List<MeetPubGroupEntity> selectPubGroupByMeetidAndGrpno(int meetid){
		HashMap<String,Object> map=new HashMap<String,Object>();
		map.put("meetid", meetid);
		//map.put("groupno", grpno);
		return meetPubGroupDao.selectGroupByMeetidAndGroupnoClient(map);
	}
	
	/**
     * 删除分组
     * @param groupid
     * @return
     */
	@Override
   public int deleteGroupByGroupid(int groupid){
		return meetGroupMainDao.deleteByPrimaryKey(groupid);
	}
	
	/**
     * 根据会议id获取会议议程树,服务端使用
     * @param meetid
     * @return
     */
	  @Override
	 public List<Map<String,Object>>  getMeetTreeYichen(int meetid){
		 List<Map<String,Object>> treelist=new ArrayList<Map<String,Object>>();
		
		 MeetYichenMainEntity yichen=null;
		 //一级议程
		 List<MeetYichenMainEntity> parentlist=yichenMainDao.selectAllParentYichenByMeetid(meetid);
		 if(parentlist==null||parentlist.size()==0){
			 return treelist;
		 }
		 for(int t1=0;t1<parentlist.size();t1++){
			 yichen=parentlist.get(t1);
			 treelist.add(yichenToMap(yichen,0));
			 
			//增加文件到树
			 YichenFileToTree(treelist,yichen.getYichenid());
			 
			 //二级议程
			 List<MeetYichenMainEntity> sublist=yichenMainDao.selectAllSubYichenByYichenid(yichen.getYichenid());
			 if(sublist==null||sublist.size()==0){
				 continue;
			 }
			 for(int t2=0;t2<sublist.size();t2++){
				 yichen=null;
				 yichen=sublist.get(t2);
				 treelist.add(yichenToMap(yichen,0));
				 
				 //增加文件
				 YichenFileToTree(treelist,yichen.getYichenid());
				 
				//三级议程
				 List<MeetYichenMainEntity> threelist=yichenMainDao.selectAllSubYichenByYichenid(yichen.getYichenid());
				 if(threelist==null||threelist.size()==0){
					 continue;
				 }
				 for(int t3=0;t3<threelist.size();t3++){
					 yichen=null;
					 yichen=threelist.get(t3);
					 treelist.add(yichenToMap(yichen,0));
					 
					 //增加文件
					 YichenFileToTree(treelist,yichen.getYichenid());
					 
					//for()
					//四级议程
					 List<MeetYichenMainEntity> fourlist=yichenMainDao.selectAllSubYichenByYichenid(yichen.getYichenid());
					 if(fourlist==null||fourlist.size()==0){
						 continue;
					 }
					 for(int t4=0;t4<fourlist.size();t4++){
						 yichen=null;
						 yichen=fourlist.get(t4);
						 treelist.add(yichenToMap(yichen,4));
						 
						 //增加文件
						 YichenFileToTree(treelist,yichen.getYichenid());
						 
						//for()
//						//五集议程
//						 List<MeetYichenMainEntity> fivelist=yichenMainDao.selectAllSubYichenByYichenid(yichen.getYichenid());
//						 if(fivelist==null||fivelist.size()==0){
//							 continue;
//						 }
//						 for(int t5=0;t5<fivelist.size();t5++){
//							 yichen=null;
//							 yichen=fivelist.get(t5);
//							 treelist.add(yichenToMap(yichen));
//							 
//							 //增加文件
//							 YichenFileToTree(treelist,yichen.getYichenid());
//							 
//						  }
					  }
				  }
			  }
		 }
		 return treelist;
		 
	 }
	  
	  
	  /**
	     * 根据会议id获取会议议程树,服务端使用
	     * @param meetid
	     * @return
	     */
		  @Override
		 public List<Map<String,Object>>  getMeetTreeYichenNoFile(int meetid){
			 List<Map<String,Object>> treelist=new ArrayList<Map<String,Object>>();
			
			 MeetYichenMainEntity yichen=null;
			 //一级议程
			 List<MeetYichenMainEntity> parentlist=yichenMainDao.selectAllParentYichenByMeetid(meetid);
			 if(parentlist==null||parentlist.size()==0){
				 return treelist;
			 }
			 for(int t1=0;t1<parentlist.size();t1++){
				 yichen=parentlist.get(t1);
				 treelist.add(yichenToMap(yichen,0));
				 
				
				 
				 //二级议程
				 List<MeetYichenMainEntity> sublist=yichenMainDao.selectAllSubYichenByYichenid(yichen.getYichenid());
				 if(sublist==null||sublist.size()==0){
					 continue;
				 }
				 for(int t2=0;t2<sublist.size();t2++){
					 yichen=null;
					 yichen=sublist.get(t2);
					 treelist.add(yichenToMap(yichen,0));
					 
					 
					//三级议程
					 List<MeetYichenMainEntity> threelist=yichenMainDao.selectAllSubYichenByYichenid(yichen.getYichenid());
					 if(threelist==null||threelist.size()==0){
						 continue;
					 }
					 for(int t3=0;t3<threelist.size();t3++){
						 yichen=null;
						 yichen=threelist.get(t3);
						 treelist.add(yichenToMap(yichen,0));
						 
						 
						//for()
						//四级议程
						 List<MeetYichenMainEntity> fourlist=yichenMainDao.selectAllSubYichenByYichenid(yichen.getYichenid());
						 if(fourlist==null||fourlist.size()==0){
							 continue;
						 }
						 for(int t4=0;t4<fourlist.size();t4++){
							 yichen=null;
							 yichen=fourlist.get(t4);
							 treelist.add(yichenToMap(yichen,4));
							 
							 
//							//for()
//							//五集议程
//							 List<MeetYichenMainEntity> fivelist=yichenMainDao.selectAllSubYichenByYichenid(yichen.getYichenid());
//							 if(fivelist==null||fivelist.size()==0){
//								 continue;
//							 }
//							 for(int t5=0;t5<threelist.size();t5++){
//								 yichen=null;
//								 yichen=fourlist.get(t5);
//								 treelist.add(yichenToMap(yichen,0));
//								 
//								 
//							  }
						  }
					  }
				  }
			 }
			 return treelist;
			 
		 }
	
	  /**
	     * 根据会议id获取会议议程树,客户端使用
	     * @param meetid
	     * @return
	     */
		  @Override
		 public List<Map<String,Object>>  getMeetTreeYichenClient(int meetid){
			
			  //获取会议类型和议程 版本
			  List<Map<String,Object>> treelist=new ArrayList<Map<String,Object>>();
			 String mtype=this.getMtypeByMeetid(meetid);
			 int version=0;
			
//			 if(mtype.trim().equals("2")){
//				 version=this.getVersionByMeetid(meetid, "yichen");
//			 }
			 
			 treelist=getMeetTreeYichenClientByVersion(meetid, version);
			 return treelist; 
		 }
		  
		  @Override
			 public List<Map<String,Object>>  getMeetTreeYichenClient(int meetid,int userid){
				
				  //获取会议类型和议程 版本
				  List<Map<String,Object>> treelist=new ArrayList<Map<String,Object>>();
//				 String mtype=this.getMtypeByMeetid(meetid);
//				 int version=0;
//				
//				 if(mtype.trim().equals("2")){
//					 version=this.getVersionByMeetid(meetid, "yichen");
//				 }
				 int version=0;
				 treelist=getMeetTreeYichenClientByVersion(meetid, version,userid);
				 return treelist; 
			 }

		/**
		 * 
		 */
		  @Override
		  public List<Map<String,Object>>  getMeetTreeYichenClientByVersion(int meetid,int version){
			  return getMeetTreeYichenClientByVersion(meetid,version,0);
		  }
		  
		  
		  /**
		     * 根据会议id获取会议议程树,客户端使用
		     * @param meetid
		     * @param version
		     * @return
		     */
			
			 public List<Map<String,Object>>  getMeetTreeYichenClientByVersion(int meetid,int version,int userid){
				 if(log.isDebugEnabled()){
					 log.debug("getMeetTreeYichenClient(int meetid) is entering");
				 }
				 
				 
				  
				  //获取会议类型和议程 版本
//				/ String mtype=this.getMtypeByMeetid(meetid);
				 boolean iscwh=true;
				 
//				 if(mtype.trim().equals("2")){
//					 iscwh=true;
//				 }
				 
			     //定义树的List
				 List<Map<String,Object>> treelist=new ArrayList<Map<String,Object>>();
				 //一级议程
				 List<MeetYichenMainEntity> parentlist=null;
				 MeetYichenMainEntity yichen=null;
				 Map<String,Object> map1=null;
				 //是否常委会
				 if(iscwh){
					 map1=new HashMap<String,Object>();
					 map1.put("meetid", meetid);
					 map1.put("version", version);
					 parentlist=pubYichenDao.selectAllParentYichenByMeetid(map1);
				 }else{
					parentlist=yichenMainDao.selectAllParentYichenByMeetid(meetid);
					 
				 }
				 
				 if(log.isDebugEnabled()){
					 log.debug("meetid="+meetid);
					 log.debug("version="+version);
					 log.debug("iscwh="+iscwh);
					 log.debug("mtype="+version);
					 log.debug("parentlist="+parentlist.size());
				 }
				 
				 
				 if(parentlist==null||parentlist.size()==0){
					 return treelist;
				 }
				 for(int t1=0;t1<parentlist.size();t1++){
					 yichen=parentlist.get(t1);
					 
					 treelist.add(yichenToMap(yichen,0));
					//增加文件到树
					 YichenFileToTreeClient(treelist,yichen.getYichenid(),iscwh,version,userid);
					 
					 //二级议程
					 List<MeetYichenMainEntity> sublist=getAllSubYichenClient(yichen.getYichenid(),iscwh,version);
					 
					 if(sublist==null||sublist.size()==0){
						 continue;
					 }
					 for(int t2=0;t2<sublist.size();t2++){
						 yichen=null;
						 yichen=sublist.get(t2);
						
						 treelist.add(yichenToMap(yichen,0));
						 //增加文件
						 YichenFileToTreeClient(treelist,yichen.getYichenid(),iscwh,version,userid);
						 
						//三级议程
						// List<MeetYichenMainEntity> threelist=yichenMainDao.selectAllSubYichenByYichenid(yichen.getYichenid());
						 List<MeetYichenMainEntity> threelist=getAllSubYichenClient(yichen.getYichenid(),iscwh,version);
						 
						 if(threelist==null||threelist.size()==0){
							 continue;
						 }
						 for(int t3=0;t3<threelist.size();t3++){
							 yichen=null;
							 yichen=threelist.get(t3);
							 treelist.add(yichenToMap(yichen,0));
							 
							 //增加文件
							 YichenFileToTreeClient(treelist,yichen.getYichenid(),iscwh,version,userid);
							 
							
							//四级议程
							// List<MeetYichenMainEntity> fourlist=yichenMainDao.selectAllSubYichenByYichenid(yichen.getYichenid());
							 List<MeetYichenMainEntity> fourlist=getAllSubYichenClient(yichen.getYichenid(),iscwh,version);
							 
							 
							 if(fourlist==null||fourlist.size()==0){
								 continue;
							 }
							 for(int t4=0;t4<fourlist.size();t4++){
								 yichen=null;
								 yichen=fourlist.get(t4);
								 treelist.add(yichenToMap(yichen,4));
								 
								 //增加文件
								 YichenFileToTreeClient(treelist,yichen.getYichenid(),iscwh,version,userid);
								 
								
							  }
						  }
					  }
				 }
				 return treelist; 
			 }
			  
	  /**
	   * 根据议程id获取子树
	   */
	  @Override
		 public List<Map<String,Object>>  getMeetSubTreeYichen(int yichenid){
			 List<Map<String,Object>> treelist=new ArrayList<Map<String,Object>>();
			 MeetYichenMainEntity yichen=null;	 
				//增加文件到树
				 YichenFileToTree(treelist,yichenid);
				 
				 //二级议程
				 List<MeetYichenMainEntity> sublist=yichenMainDao.selectAllSubYichenByYichenid(yichenid);
				 if(sublist==null||sublist.size()==0){
					 return treelist;
				 }
				 for(int t2=0;t2<sublist.size();t2++){
					 yichen=null;
					 yichen=sublist.get(t2);
					 treelist.add(yichenToMap(yichen,0));
			 }
			 return treelist;
			 
		 }
	
	  /**
	   * 根据议程id获取子树
	   */
	  @Override
		 public List<Map<String,Object>>  getMeetSubTreeYichenClient(int yichenid,int meetid){
			 List<Map<String,Object>> treelist=new ArrayList<Map<String,Object>>();
			 MeetYichenMainEntity yichen=null;
			 
			//获取会议类型和议程 版本
			// String mtype=this.getMtypeByMeetid(meetid);
			 int version=0;
			 boolean iscwh=true;
//			 if(mtype.trim().equals("2")){
//				 version=this.getVersionByMeetid(meetid, "yichen");
//				 iscwh=true;
//			 }
				//增加文件到树
				 YichenFileToTreeClient(treelist,yichenid,iscwh,version);
				 
				 //二级议程
				 List<MeetYichenMainEntity> sublist=this.getAllSubYichenClient(yichenid, iscwh, version);
				 if(sublist==null||sublist.size()==0){
					 return treelist;
				 }
				 for(int t2=0;t2<sublist.size();t2++){
					 yichen=null;
					 yichen=sublist.get(t2);
					 treelist.add(yichenToMap(yichen,0));
			 }
			 return treelist;
			 
		 }
		
	
	  /**
	     * 根据会议id获取会议日程树
	     * @param meetid
	     * @return
	     */
//		  @Override
		 public List<Map<String,Object>>  getMeetTreeRichen(int meetid){
			 List<Map<String,Object>> treelist=new ArrayList<Map<String,Object>>();
			 
			 MeetRichenMainEntity richen=null;
			
			 //一级日程
			 List<MeetRichenMainEntity> parentlist=richenMainDao.selectParentRichenByMeetid(meetid);
			 if(parentlist==null||parentlist.size()==0){
				 return treelist;
			 }
			 for(int t1=0;t1<parentlist.size();t1++){
				 richen=parentlist.get(t1);
				 treelist.add(richenToMap(richen,5));
		 
				 //二级日程
				 List<MeetRichenMainEntity> sublist=richenMainDao.selectSubRichenByRichenid(richen.getRichenid());
				 if(sublist==null||sublist.size()==0){
					 continue;
				 }
				 for(int t2=0;t2<sublist.size();t2++){
					 richen=null;
					 richen=sublist.get(t2);
					 treelist.add(richenToMap(richen,6));
					 
				  //三级议题
					 List<MeetRichenYitiEntity> threelist=richenYitiDao.selectAllYitiByRichenid(richen.getRichenid());
					 if(threelist==null||threelist.size()==0){
						 continue;
					 }
					 MeetRichenYitiEntity yiti=null;
					 for(int t3=0;t3<threelist.size();t3++){
						 yiti=threelist.get(t3);
						 treelist.add(richenYitiToMap(yiti,7));
//							 System.out.println("-yiti.getBindyichenid()--"+yiti.getBindyichenid());
							
						 System.out.println("----:"+yiti.getBindyichenid());   
						 	//根据字段判断是否显示绑定的闭幕会文件
						 System.out.println(yiti.getBindbimu()+"-----------++++++++------------------");
						 if("0".equals(yiti.getBindbimu())){						 
							 if(yiti.getBindyichenid()!=null&&yiti.getBindyichenid().trim().length()!=0){
								 String[] strbind=yiti.getBindyichenid().split(",");
	
							       for(int s=0;s<strbind.length;s++){
									 System.out.println("-zzzzzzzzzzz--"+strbind[s]);
									 if(strbind[s]!=null&&strbind[s].trim().length()!=0){
											 RichenYitiFileToTree(treelist,yiti.getYitiid(),new Integer(strbind[s]).intValue());
									 }							 
								   }
					       
							 }
						 }else{
							 treelist=RichenFileToTree(treelist,yiti.getYitiid());
						 }						 
				   }
				 }
			 }
			 return treelist;
			 
		 }

		  /**
		     * 根据会议id获取会议日程树 服务端使用
		     * @param meetid
		     * @return
		     */
			 public List<Map<String,Object>>  getMeetTreeRichenNoFileJson(int meetid){
				 List<Map<String,Object>> treelist=new ArrayList<Map<String,Object>>();
				 
				 MeetRichenMainEntity richen=null;
				
				 //一级日程
				 List<MeetRichenMainEntity> parentlist=richenMainDao.selectParentRichenByMeetid(meetid);
				 if(parentlist==null||parentlist.size()==0){
					 return treelist;
				 }
				 for(int t1=0;t1<parentlist.size();t1++){
					 richen=parentlist.get(t1);
					 treelist.add(richenToMap(richen,5));
			 
					 //二级日程
					 List<MeetRichenMainEntity> sublist=richenMainDao.selectSubRichenByRichenid(richen.getRichenid());
					 if(sublist==null||sublist.size()==0){
						 continue;
					 }
					 for(int t2=0;t2<sublist.size();t2++){
						 richen=null;
						 richen=sublist.get(t2);
						 treelist.add(richenToMap(richen,6));
						 
					  //三级议题
						 List<MeetRichenYitiEntity> threelist=richenYitiDao.selectAllYitiByRichenid(richen.getRichenid());
						 if(threelist==null||threelist.size()==0){
							 continue;
						 }
						 MeetRichenYitiEntity yiti=null;
						 for(int t3=0;t3<threelist.size();t3++){
							 yiti=threelist.get(t3);
							 treelist.add(richenYitiToMap(yiti,7));								
/*							 if(yiti.getBindyichenid()!=null&&yiti.getBindyichenid().trim().length()!=0){
								 String[] strbind=yiti.getBindyichenid().split(",");
							       for(int s=0;s<strbind.length;s++){
									 if(strbind[s]!=null&&strbind[s].trim().length()!=0){
											 RichenYitiFileToTree(treelist,yiti.getYitiid(),new Integer(strbind[s]).intValue());
									 }							 
								   }
					       
							 }*/
						 
					   }
					 }
				 }
				 return treelist;
				 
			 }		 
			/**
			 * 内部调用方法
			 * 闭幕会文件加入到树形中
			 * @param treelist
			 * @param yichenid
			 */
			private List<Map<String,Object>> RichenFileToTree(List<Map<String,Object>> treelist,int richenid){
				 MeetRichenFileEntity ycfile=null;
				 Map<String,Object> mapfile=null;
				 List<MeetRichenFileEntity> filelist=null;
				 filelist=meetRichenFileDao.selectFilesByRichenid(richenid); 
				 if(filelist!=null&&filelist.size()!=0){
					 for(int filet=0;filet<filelist.size();filet++){
						 mapfile=new HashMap<String,Object>();
						 ycfile=filelist.get(filet);
						if(!"9".equals(ycfile.getFiletype())&&!"10".equals(ycfile.getFiletype())){
						 mapfile.put("name", ycfile.getFilename());
						 mapfile.put("id", ycfile.getFileid());
						 mapfile.put("nid", ycfile.getFileid());
						 mapfile.put("pid", richenid);
						 mapfile.put("sort", ycfile.getSort());
						 mapfile.put("filepath", ycfile.getFilepath());
						 mapfile.put("state", "other");
						 mapfile.put("filetype", ycfile.getFiletype());
						 mapfile.put("md5", ycfile.getFileguid());
						 
						 treelist.add(mapfile);
						}
					 }
				 }
				 return treelist;
			}		 
		 /**
		     * 根据会议id获取会议日程树
		     * @param meetid
		     * @return
		     */
			  @Override
			 public List<Map<String,Object>>  getMeetTreeRichenClient(int meetid){
				 
				  List<Map<String,Object>> treelist=new ArrayList<Map<String,Object>>();
				//获取会议类型和议程 版本
				 System.out.println("meetid is:"+meetid);
				 //String mtype=this.getMtypeByMeetid(meetid);
				 int version=0;
			
//				 if(mtype.trim().equals("2")){
//					 version=this.getVersionByMeetid(meetid, "richen");
//				 }
				 
				 treelist=getMeetTreeRichenClientByVersion(meetid,version);
				 return treelist;
				 
			 }
			  
			  @Override
				 public List<Map<String,Object>>  getMeetTreeRichenClient(int meetid,int userid){
					 
					  List<Map<String,Object>> treelist=new ArrayList<Map<String,Object>>();
					//获取会议类型和议程 版本
					 int version=0;
					 
					 treelist=getMeetTreeRichenClientByVersion(meetid,version,userid);
					 return treelist;
					 
				 }
			  
             @Override
			  public List<Map<String,Object>>  getMeetTreeRichenClientByVersion(int meetid,int version){
			     return getMeetTreeRichenClientByVersion(meetid,version,0);
			  }
				 /**
			     * 根据会议id获取会议日程树
			     * @param meetid
			     * @return
			     */
			
				 public List<Map<String,Object>>  getMeetTreeRichenClientByVersion(int meetid,int version,int userid){
					 List<Map<String,Object>> treelist=new ArrayList<Map<String,Object>>();
					 
					 
					//获取会议类型和议程 版本
					 System.out.println("meetid is:"+meetid);

					 boolean iscwh=true;
					 Map<String,Object> map1=null;
					 
					 MeetRichenMainEntity richen=null;
					 MeetRichenMainEntity prichen=null;
					 //一级日程
					 List<MeetRichenMainEntity> parentlist=null;
					// if(iscwh){
						 map1=new HashMap<String,Object>();
						 map1.put("meetid", meetid);
						// map1.put("version", version);
						 parentlist=pubRichenDao.selectParentRichenByMeetid(map1);
		             
					 if(log.isDebugEnabled()){
						 log.debug("parentlist="+parentlist.size());
						 
					 }
					 if(parentlist==null||parentlist.size()==0){
						 return treelist;
					 }
					 for(int t1=0;t1<parentlist.size();t1++){
						 prichen=parentlist.get(t1);
						 treelist.add(richenToMap(prichen,5));
				 
						 //二级日程
						 List<MeetRichenMainEntity> sublist=null;
						
//						 if(iscwh){
							// map1=new HashMap<String,Object>();
							 map1.put("richenid", prichen.getRichenid());
							// map1.put("version", version);
							 System.out.println("richen.getRichenid():"+prichen.getRichenid());
							 sublist=pubRichenDao.selectSubRichenByRichenid(map1);

						 
						 if(sublist==null||sublist.size()==0){
							 continue;
						 }
						 
						 for(int t2=0;t2<sublist.size();t2++){
							 richen=null;
							 richen=sublist.get(t2);
							 System.out.println("-------------------"+richen.getName());
							 
							 treelist.add(richenToMap(richen,6));
							 
						  //三级议题
							 List<MeetRichenYitiEntity> threelist=null;
//							// if(iscwh){
								 map1.put("richenid", richen.getRichenid());
								 threelist=pubRichenYitiDao.selectAllYitiByRichenid(map1);
							
							 
							 if(threelist==null||threelist.size()==0){
								 continue;
							 }
							 
							 MeetRichenYitiEntity yiti=null;
							 for(int t3=0;t3<threelist.size();t3++){
								 yiti=threelist.get(t3);
								 treelist.add(richenYitiToMap(yiti,7));
								 //四级挂接文件
								 if("0".equals(yiti.getBindbimu())){ 
									 if(yiti.getBindyichenid()!=null){
										 String[] strbind=yiti.getBindyichenid().split(",");
										 
										 for(int s=0;s<strbind.length;s++){
											 //if(log)
											 if(strbind[s]!=null&&strbind[s].trim().length()!=0){
											    this.YichenFileToTreeClient(treelist, new Integer(strbind[s]).intValue(), iscwh, version,yiti.getYitiid(),true,userid);
											 }
										 }
										 
									 }
									
								 }else{
									 treelist=RichenFileToTree(treelist,yiti.getYitiid());
								 }	
		                     }
							 
					 }
					 }
					 return treelist;
					 
				 }

			  
	@Override
	public Page selectHisMeeting(final String type, int pageNo, int pageSize) {
		return PageHelper.pagedQuery(new PageCall() {
			@Override
			public void executeQuery() {
				meetMainDao.selectHisMeeting(type);
			}
		}, pageNo,pageSize);
	}
	
	/**
	 * 内部调用方法
	 * 议程文件加入到树形中
	 * @param treelist
	 * @param yichenid
	 */
	private void YichenFileToTree(List<Map<String,Object>> treelist,int yichenid){
		 MeetFileMainEntity ycfile=null;
		 Map<String,Object> mapfile=null;
		 List<MeetFileMainEntity> filelist=null;
		 filelist=yichenMainDao.selectFilesByYichenid(yichenid); 
		 System.out.println("filelist is-------:"+filelist.size());
		 
		 if(filelist!=null&&filelist.size()!=0){
			 for(int filet=0;filet<filelist.size();filet++){
				 //议程下不能有日程、议程、闭幕会文件
					 mapfile=new HashMap<String,Object>();
					 ycfile=filelist.get(filet);
				 if(!"8".equals(ycfile.getFiletype())&&!"9".equals(ycfile.getFiletype())&&!"10".equals(ycfile.getFiletype()) ){
					 mapfile.put("name", ycfile.getFilename());
					 mapfile.put("id", ycfile.getFileid());
					 mapfile.put("nid", ycfile.getFileid());
					 mapfile.put("pid", yichenid);
					 mapfile.put("sort", ycfile.getSort());
					 mapfile.put("state", "other");
					 mapfile.put("filetype", ycfile.getFiletype());
					 mapfile.put("fileselect", ycfile.getFiletype());
					 //System.out.println("二级yichenid="+subyichen.getYichenid()+"---pyichenid="+subyichen.getPyichenid());
					 treelist.add(mapfile);
				 }
			 }
		 }
	}
	
	/**
	 * 内部调用方法
	 * 议程文件加入到树形中
	 * @param treelist
	 * @param yichenid
	 */
	private void RichenYitiFileToTree(List<Map<String,Object>> treelist,int yitiid,int yichenid){
		 MeetFileMainEntity ycfile=null;
		 Map<String,Object> mapfile=null;
		 List<MeetFileMainEntity> filelist=null;
		 filelist=yichenMainDao.selectFilesByYichenid(yichenid); 
		 System.out.println("filelist is-------:"+filelist.size());
		 
		 if(filelist!=null&&filelist.size()!=0){
			 for(int filet=0;filet<filelist.size();filet++){
				 mapfile=new HashMap<String,Object>();
				 ycfile=filelist.get(filet);
				if(!"9".equals(ycfile.getFiletype())&&!"10".equals(ycfile.getFiletype())){
				 mapfile.put("name", ycfile.getFilename());
				 mapfile.put("id", ycfile.getFileid());
				 mapfile.put("pid", yitiid);
				 mapfile.put("sort", ycfile.getSort());
				 mapfile.put("state", "other");
				 mapfile.put("filetype", ycfile.getFiletype());
				 mapfile.put("fileselect", ycfile.getFiletype());
				 //System.out.println("二级yichenid="+subyichen.getYichenid()+"---pyichenid="+subyichen.getPyichenid());

				 treelist.add(mapfile);
				}
			 }
		 }
	}

	/**
	 * 根据推送范围
	 * @param treelist
	 * @param yichenid
	 * @param iscwh
	 * @param version
	 */
	private void YichenFileToTreeClient(List<Map<String,Object>> treelist,int yichenid,boolean iscwh,int version,int userid){

		this.YichenFileToTreeClient(treelist,yichenid,iscwh,version,0,false,userid);
	}
	/**
	 * 议程调用
	 * @param treelist
	 * @param yichenid
	 * @param iscwh
	 * @param version
	 */
	private void YichenFileToTreeClient(List<Map<String,Object>> treelist,int yichenid,boolean iscwh,int version){

		this.YichenFileToTreeClient(treelist,yichenid,iscwh,version,0,false,0);
	}
	/**
	 * 内部调用方法h
	 * 议程文件加入到树形中
	 * @param treelist
	 * @param yichenid
	 */
	private void YichenFileToTreeClient(List<Map<String,Object>> treelist,int yichenid,boolean iscwh,int version,int yitiid,boolean isrichen,int userid){
		 MeetFileMainEntity ycfile=null;
		 Map<String,Object> mapfile=null;
		 List<MeetFileMainEntity> filelist=null;
		 Map<String,Object> map1=null;
		 int fileversion=version;
		 int yichenversion=version;
//		 
		 if(iscwh){
			 map1=new HashMap<String,Object>();
			 map1.put("yichenid", yichenid);
			// map1.put("yichenversion", yichenversion);
			 map1.put("fileversion",fileversion );
			 
			 System.out.println("yichenid is----:"+yichenid);
			 System.out.println("yichenversion is----:"+version);
			 System.out.println("fileversion is----:"+fileversion);
			 if(userid!=0){
			     map1.put("userid", userid);
			     //filelist=pubYichenDao.selectFilesByYichenid(map1);
			     filelist=pubYichenDao.selectFilesByYichenidAndUseridLHG(map1);
			 }else{
				 filelist=pubYichenDao.selectFilesByYichenid(map1);
			 }
			 System.out.println("filelist is----:"+filelist.size());
		 }else{
			 if(userid!=0){
				 map1=new HashMap<String,Object>();
				 map1.put("yichenid", yichenid);
				 map1.put("userid", userid);
				 filelist=yichenMainDao.selectFilesByYichenidAndUserid(map1);
			 }else{
				 filelist=yichenMainDao.selectFilesByYichenid(yichenid);
			 }
		 }
		 
		 if(filelist!=null&&filelist.size()!=0){
			 for(int filet=0;filet<filelist.size();filet++){
				 mapfile=new HashMap<String,Object>();
				 ycfile=filelist.get(filet);
				 mapfile.put("name", ycfile.getFilename());
				 mapfile.put("id", ycfile.getFileid());
				 mapfile.put("nid", ycfile.getFileid());
				 mapfile.put("sort", ycfile.getSort());
				 mapfile.put("state", "other");
				 mapfile.put("filetype", ycfile.getFiletype());
				 mapfile.put("filepath", ycfile.getFilepath());
				 mapfile.put("md5", ycfile.getFileguid());
				 //是否日程
				 if(isrichen&&yitiid!=0){
					 mapfile.put("pid", yitiid);
					 if(!"9".equals(ycfile.getFiletype())&&!"10".equals(ycfile.getFiletype())){
						 treelist.add(mapfile);
					  }
				 }else{
					 mapfile.put("pid", yichenid);
					 if(!"8".equals(ycfile.getFiletype())&&!"9".equals(ycfile.getFiletype())&&!"10".equals(ycfile.getFiletype())){
						 treelist.add(mapfile);
					 }
				 }

				 //System.out.println("二级yichenid="+subyichen.getYichenid()+"---pyichenid="+subyichen.getPyichenid());

			 }
		 }
	}

	
	@Override
	public String getMeetTypeByCode(String code){
		String entity=dictDataService.getNameByTypeAndcode("mtype", code);
		System.out.println(entity);
		return entity;
	}
	
	
	/**
	 * 根据会议id获取会议类型
	 * @param meetid
	 * @return
	 */
	private  String getMtypeByMeetid(int meetid){
		MeetMainEntity entity = meetMainDao.selectEntityBymeetid(meetid);
		return entity.getMtype();
	}
	
	/**
	 * 根据meetid获取常委会的议程的版本号
	 * @param meetid
	 * @return 
	 */
	private  int getVersionByMeetid(int meetid,String submodulecode){
		int version=0;
		try{
//			if(submodulecode!=null&&submodulecode.trim().equals("yichen")){
				
			  version=pubYichenDao.selectMaxVersion(meetid);
//			}else if(submodulecode!=null&&submodulecode.trim().equals("richen")){
//				version=pubRichenDao.selectMaxVersion();
//			}else if(submodulecode!=null&&submodulecode.trim().equals("file")){
//				version=pubFileDao.selectMaxVersion();
//			}
		}catch(Exception e){
			e.printStackTrace();
			version=0;
		}
		return version;
	}
	
	/**
	 * 议程对象转换成Map
	 * @param yichen
	 * @return
	 */
	private Map<String,Object> yichenToMap(MeetYichenMainEntity yichen,int jibie){
		 java.util.Map<String,Object> map=new HashMap<String,Object>();
		 map.put("name", yichen.getTitle());
		 map.put("id", yichen.getYichenid());
		 map.put("pid", yichen.getPyichenid());
		 map.put("sort", yichen.getSort());
		 map.put("state", "closed");
		 if(jibie==4){
			 map.put("filetype", "4");
		 }else{
			 map.put("filetype", "0");
		 }
		 return map;
	}
	
	
	/**
	 * 日程对象转换成Map
	 * @param yichen
	 * @return
	 */
	private Map<String,Object> richenToMap(MeetRichenMainEntity richen,int level){
		 java.util.Map<String,Object> map=new HashMap<String,Object>();
		 map=new HashMap<String,Object>();
		 map.put("name", richen.getName());
		 map.put("id", richen.getRichenid());
		 map.put("pid", richen.getPrichenid());
		 map.put("sort", richen.getSort());
		 map.put("state", "closed");
		 map.put("filetype", level);
		 System.out.println(richen.getName());
		 return map;
	}
	
	/**
	 * 日程对象转换成Map
	 * @param yichen
	 * @return
	 */
	private Map<String,Object> richenYitiToMap(MeetRichenYitiEntity yiti,int level ){
		 java.util.Map<String,Object> map=new HashMap<String,Object>();
		 map=new HashMap<String,Object>();
		 map.put("name", yiti.getTitle());
		 map.put("id", yiti.getYitiid());
		 map.put("nid", yiti.getYitiid());
		 //map.put("id", yiti.getYitiid());
		 map.put("pid", yiti.getRichenid());
		 map.put("sort", yiti.getSort());
		 map.put("state", "closed");
		 map.put("filetype", level);
		 return map;
	}
	
	/**
	 * 获取子议程
	 * @param yichenid
	 * @param b
	 * @param version
	 * @return
	 */
	private List<MeetYichenMainEntity> getAllSubYichenClient(int yichenid,boolean iscwh,int version)	{
		 Map<String,Object> map1=null;
		 List<MeetYichenMainEntity> templist=null;
		 //是否常委会
		 if(iscwh){
			 map1=new HashMap<String,Object>();
			 map1.put("yichenid", yichenid);
			 map1.put("version", version);
			 templist=pubYichenDao.selectAllSubYichenByYichenid(map1);
		 }else{
			 templist=yichenMainDao.selectAllSubYichenByYichenid(yichenid);
		 }
		 
		 return templist;
	}
	
	
	@Override
	public List<MeetYichenMainEntity> selectAllParentYichenByMeetid(int meetid){
	   return yichenMainDao.selectAllParentYichenByMeetid(meetid);
	}
	
	@Override
	public MeetRichenYitiEntity getMeetRichenYitiByYitiid(int yitiid){
		 return richenYitiDao.selectByPrimaryKey(yitiid);
	}
	
	@Override
	public MeetRichenMainEntity getMeetRichenByRichenid(int richenid){
		 return richenMainDao.selectByPrimaryKey(richenid);
	}
	
	@Override
	public List<MeetMainEntity> selectJnumByMtype(String mtype){
		return meetMainDao.selectJnumByMtype(mtype);
	}
	
	@Override
	 public List<MeetFileMainEntity> searchFilesByKeywordAndFiletype(String keyword,String filetype,int userid){
		        Map<String,Object> map=new java.util.HashMap<String,Object>();
		        map.put("filetype", filetype);
		        map.put("keyword", keyword);
		        map.put("userid", userid);
		        
		        //List<MeetFileMainEntity> listbasic=meetFileMainDao.searchFileByKeyword(map);
		        List<MeetFileMainEntity> listpub=pubFileDao.searchPubFileByKeyword(map);
//		        for(int i=0;i<listpub.size();i++){
//		        	listbasic.add(listpub.get(i));
//		        }
		        
		        return listpub;
		
	}
	
	@Override
	public List<MeetProcessLogEntity> selectProcessLogByMeetid(int meetid){
		List<MeetProcessLogEntity> list= meetProcessLogDao.selectProcessLogByMeetid(meetid);
		List<MeetProcessLogEntity> list1=new ArrayList<MeetProcessLogEntity>();
		
		System.out.println("size:"+list.size());
		MeetProcessLogEntity entity=null;
		for(int i=0;i<list.size();i++){
			entity=list.get(i);
			System.out.println("usrid:"+entity.getTjuserid());
			entity.setTjuser(userService.selectEntityById(entity.getTjuserid()).getUsername());
			entity.setShenheuser((userService.selectEntityById(entity.getShenheren()).getUsername()));
			
			list1.add(entity);
		}
		return list1;
	}
	
	
	@Override
	public Page selectProcessLogByMeetid(final int meetid,int pageNo, int pageSize){
		return PageHelper.pagedQuery(new PageCall() {
			@Override
			public void executeQuery() {
				meetProcessLogDao.selectProcessLogByMeetid(meetid);
			}
		}, pageNo,pageSize);
	}
	
	/**
	 * 
	 */
	@Override
    public Page selectAllFileByMeetidAndFileOwnAndVersion(final Map<String,Object> map,int pageNo,int pageSize){
		Page page=PageHelper.pagedQuery(new PageCall() {
			@Override
			public void executeQuery() {
				pubMeetFileDao.selectAllFileByMeetidAndFileOwnAndVersion(map);
			}
		}, pageNo,pageSize);
         return page;
	}
	
	@Override
	public String getCurrentMeetProcess(int meetid){
		MeetMainEntity entity=meetMainDao.selectByPrimaryKey(meetid);
		Date sdate=entity.getSdate();
		Date bmhdate=entity.getBmhdate();
		Date curdate=new Date();
		
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(sdate);
		calendar.set(Calendar.HOUR,0); //获取小时; 
		calendar.set(Calendar.MINUTE,0); //获取分钟; 
		calendar.set(Calendar.SECOND,0); //获取秒钟; 
		sdate=calendar.getTime();
		System.out.println("sdate"+sdate);
		
		if(curdate.before(sdate)){
			return "0";
		}else if(curdate.after(sdate)&&curdate.before(bmhdate)){
			return "1";
		}else{
			return "2";
		}
	}

	
	/**
	 * 获取新建会议次数
	 * @param jnum
	 * @param mtype
	 */
	
/*	public int selectMaxCnumByMtypeAndJnum(Map<String,Object> map){
		List<MeetMainEntity> list=meetMainDao.selectHisMeetingCnum(map);
		int num=0;
		if(list.size()>0){
			for (MeetMainEntity meetMainEntity : list) {
				String cnum=meetMainEntity.getCnum();
				int cishu=Integer.parseInt(cnum.substring(0,cnum.indexOf('次')));
				if(cishu>num){
					num=cishu;
				}
			}
		}
		++num;
		return num;
	}*/

	@Override
	public MeetPubYichenEntity selectPubtimeByMeetid(Map<String, Object> map) {
		
		return pubYichenDao.selectPubtimeByMeetid(map);
	}

	@Override
	public MeetPubRichenEntity selectRichenPubtimeByMeetid(Map<String, Object> map) {
		
		return pubRichenDao.selectRichenPubtimeByMeetid(map);
	}

	@Override
	public MeetPubFileEntity selectFilePubtimeByMeetid(Map<String, Object> map) {
		
		return pubFileDao.selectFilePubtimeByMeetid(map);
	}

	@Override
	public int insertMeetPubPubtime(MeetPubPubtimeEntity entity) {
		Map<String,Object> map=new HashMap<String, Object>();
		map.put("moduleid",entity.getModuleid());
		map.put("meetid",entity.getMeetid());
		System.out.println(entity.getModuleid()+entity.getMeetid());
		MeetPubPubtimeEntity pubentity=meetPubPubtimeDao.selectByModuleidAndMtype(map);
		int i;
		if(pubentity!=null){
			entity.setPubtime(new Date());
			i=meetPubPubtimeDao.updateByModuleidAndMtype(entity);
		}else{
			i=meetPubPubtimeDao.insert(entity);
		}
		return i;
	}

	@Override
	public MeetPubPubtimeEntity selectMeetPubPubtime(Map<String, Object> map) {		
		return meetPubPubtimeDao.selectByModuleidAndMtype(map);
	}
	
	@Override
	public int updateMeetPubPubtime(MeetPubPubtimeEntity entity) {		
		return meetPubPubtimeDao.updateByModuleidAndMtype(entity);
	}

	@Override
	public List<MeetRichenFileEntity> selectAllFileByRichenid(int richenid) {
		return meetRichenFileDao.selectFilesByRichenid(richenid);
	}

	@Override
	public int deletePubGroupByGroupid(int groupid) {
		// TODO Auto-generated method stub
		return meetPubGroupDao.deleteByPrimaryKey(groupid);
	}

	@Override
	public List<MeetYichenMainEntity> selectBindYichenByFileid(Integer fileid) {
		// TODO Auto-generated method stub
		return yichenMainDao.selectBindYichenByFileid(fileid);
	}

	@Override
	public List<MeetRichenMainEntity> selectBindRichenByFileid(Integer fileid) {
		// TODO Auto-generated method stub
		return richenMainDao.selectRichenFileByFileid(fileid);
	}

	@Override
	public List<MeetYichenFileEntity> selectYichenFileByFileidAndYichenid(Map<String, Object> map) {
		return meetYichenFileDao.selectYichenFileByFileidAndYichenid(map);
	}

	@Override
	public List<MeetRichenFileEntity> selectRichenFileByFileid(Integer fileid) {
		return meetRichenFileDao.selectRichenFileByFileid(fileid);
	}
	
	@Override
	public boolean isMeetingMiddle(int meetid){
		MeetMainEntity meet=meetMainDao.selectByPrimaryKey(meetid);
		Date sdate=meet.getSdate();
		Date edate=meet.getEdate();
		Date now=new Date();
		if(now.getTime()>sdate.getTime()&&now.getTime()<edate.getTime()){
			return true;
		}else{
			return false;
		}
	}

	@Override
	public List<MeetFileMainEntity> selectMeetFileByMeetid(int meetid) {
		HashMap<String,Object> map=new HashMap<String,Object>();
		System.out.println("meetid:"+meetid);
		map.put("meetid", meetid);
		return meetPubFileDao.selectAllFileByMeetid(map);	
	}
	
	@Override
	public List<MeetFileMainEntity> selectRcFileByMeetid(int meetid) {
		HashMap<String,Object> map=new HashMap<String,Object>();
		System.out.println("meetid:"+meetid);
		map.put("meetid", meetid);
		return meetPubFileDao.selectRcFileByMeetid(map);	
	}
	
	
}
