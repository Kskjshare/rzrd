package com.cloudrich.ereader.meeting.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.Cache;
import org.springframework.stereotype.Service;

import com.cloudrich.ereader.common.action.BaseAction;
import com.cloudrich.ereader.common.dao.PageHelper;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.common.dao.PageHelper.PageCall;
import com.cloudrich.ereader.common.util.ValidateUtil;
import com.cloudrich.ereader.dict.entity.DictProcessDefEntity;
import com.cloudrich.ereader.dict.service.DictDataService;
import com.cloudrich.ereader.meeting.dao.MeetFileMainDao;
import com.cloudrich.ereader.meeting.dao.MeetFileScopeDao;
import com.cloudrich.ereader.meeting.dao.MeetFileUserDao;
import com.cloudrich.ereader.meeting.dao.MeetGroupMainDao;
import com.cloudrich.ereader.meeting.dao.MeetMainDao;
import com.cloudrich.ereader.meeting.dao.MeetProcessDao;
import com.cloudrich.ereader.meeting.dao.MeetProcessLogDao;
import com.cloudrich.ereader.meeting.dao.MeetRichenFileDao;
import com.cloudrich.ereader.meeting.dao.MeetRichenMainDao;
import com.cloudrich.ereader.meeting.dao.MeetRichenYitiDao;
import com.cloudrich.ereader.meeting.dao.MeetYichenFileDao;
import com.cloudrich.ereader.meeting.dao.MeetYichenMainDao;
import com.cloudrich.ereader.meeting.entity.MeetFileMainEntity;
import com.cloudrich.ereader.meeting.entity.MeetFileRemindEntity;
import com.cloudrich.ereader.meeting.entity.MeetFileScopeEntity;
import com.cloudrich.ereader.meeting.entity.MeetFileUserEntity;
import com.cloudrich.ereader.meeting.entity.MeetGroupMainEntity;
import com.cloudrich.ereader.meeting.entity.MeetMainEntity;
import com.cloudrich.ereader.meeting.entity.MeetProcessEntity;
import com.cloudrich.ereader.meeting.entity.MeetProcessLogEntity;
import com.cloudrich.ereader.meeting.entity.MeetRichenFileEntity;
import com.cloudrich.ereader.meeting.entity.MeetRichenMainEntity;
import com.cloudrich.ereader.meeting.entity.MeetRichenYitiEntity;
import com.cloudrich.ereader.meeting.entity.MeetYichenFileEntity;
import com.cloudrich.ereader.meeting.entity.MeetYichenMainEntity;
import com.cloudrich.ereader.meetpub.dao.MeetPubFileDao;
import com.cloudrich.ereader.meetpub.dao.MeetPubGroupDao;
import com.cloudrich.ereader.meetpub.entity.MeetPubGroupEntity;
import com.cloudrich.ereader.meetpub.entity.MeetPubPubtimeEntity;
import com.cloudrich.ereader.remind.service.RemindService;
import com.cloudrich.ereader.system.dao.SysScopeUserDao;
import com.cloudrich.ereader.system.entity.SysScopeUserEntity;
import com.cloudrich.ereader.util.FileAutoRelaYichenUtil;
import com.cloudrich.ereader.util.RichenConvertObject;
import com.cloudrich.ereader.util.WordToRichenUtil;
import com.cloudrich.ereader.util.WordToYichenUtil;

@Service
public class MeetingServiceImpl implements MeetingService {
	
	private Logger log = Logger.getLogger(MeetingServiceImpl.class);
	
	@Resource MeetMainDao meetMainDao;
	@Resource MeetYichenMainDao yichenMainDao;
	@Resource MeetYichenFileDao yichenFileDao;
	@Resource MeetRichenMainDao richenMainDao;
	@Resource MeetRichenYitiDao richenYitiDao;
	@Resource MeetFileMainDao meetFileMainDao;
	@Resource MeetGroupMainDao meetGroupMainDao;
	@Resource MeetProcessDao meetProcessDao;
	@Resource MeetProcessLogDao meetProcessLogDao;
	@Resource MeetFileScopeDao filescopeDao;
	@Resource DictDataService dictDataService;
	@Resource MeetingProcPubService  meetPubService;
	@Resource RemindService  remindService;
	@Resource MeetPubFileDao pubMeetFileDao;
	@Resource MeetPubGroupDao meetPubGroupDao;
	@Resource MeetingViewService meetingViewService;
	@Resource MeetRichenFileDao meetRichenFileDao;
	@Resource MeetFileUserDao meetFileUserDao;
	@Resource SysScopeUserDao sysScopeUserDao;
	
	
	
	public static Map<String,Object> timeMap=new HashMap<String,Object> ();
	
	@Override
	public void deleteMeet(int id) throws Exception{
		meetMainDao.deleteByPrimaryKey(id);	
	}
	
	/**
	 * 批量删除
	 * @param ids
	 * @param filetypes
	 */
	@Override
	public String deleteBashYitiAndRichen(String ids,String filetypes){
		String[] arrayids=null;
		String[] arrayfiletypes=null;
		if(filetypes!=null&&filetypes.trim().length()!=0){
			arrayfiletypes=filetypes.split(",");
		}
		
		if(ids!=null&&ids.trim().length()!=0){
			arrayids=ids.split(",");
			if(arrayids.length!=arrayfiletypes.length){
				System.err.println("delete bash yiti and richen,length is not equals.");
				return "lengtherror";
				
			}
			
			for(int i=0;i<arrayids.length;i++){
					if(arrayfiletypes[i]!=null){
							if(arrayfiletypes[i].trim().equals("0")||arrayfiletypes[i].trim().equals("4")){
									yichenMainDao.deleteByPrimaryKey(Integer.parseInt(arrayids[i]));
									yichenFileDao.deleteYichFileByYichenid(Integer.parseInt(arrayids[i]));
							}
							
							if(arrayfiletypes[i].trim().equals("5")||arrayfiletypes[i].trim().equals("6")){
								   richenMainDao.deleteByPrimaryKey(Integer.parseInt(arrayids[i]));
								   richenYitiDao.deleteYitiByRichenId(Integer.parseInt(arrayids[i]));
							}
							
							if(arrayfiletypes[i].trim().equals("7")){
								  richenYitiDao.deleteByPrimaryKey(Integer.parseInt(arrayids[i]));
							}
					}
					
			}
		}
		return "success";
	}
	/**
	 * 增加一个会议基本信息
	 */
		@Override
		 public void addMeetBasic(MeetMainEntity entity) throws Exception {
			if(log.isDebugEnabled()){
				log.debug("addMeetBasic is entering:"+entity.getMname());
			}
			    System.out.println("addMeetBasic is entering:"+entity.getJnum());
			  meetMainDao.insert(entity);
		 }
		 
		@Override
		 public void updateMeetBasic(MeetMainEntity entiry) throws Exception{
			  meetMainDao.updateByPrimaryKey(entiry);
			  System.out.println("update MeetBasic is entering:");
		 }
		
		@Override
		/**
		 * 保存至数据库
		 */
		public void AutoSaveFile(MeetFileMainEntity obj, int meetid) {
			;
		};
		/**
		 * 一键生成议程,暂且只支持word文档
		 */
		@Override
		public void  AutoGeneMeetYichen(String filename,int meetid){
			//更新流程状态
			meetPubService.chgMeetProcState("yichen",meetid);
			MeetYichenMainEntity yichen=null;
			List<Map<String,Object>> list=WordToYichenUtil.readYichenFromFile(filename);
			Map<String,Object> map1=null;
			int oneyichenid=0;
			int twoyichenid=0;
			int threeyichenid=0;
			System.out.println("listsize=" + list.size());
			for(int i=0;i<list.size();i++){
				
				yichen=new MeetYichenMainEntity();
				map1=list.get(i);
				System.out.println("map1内容" + map1.toString());
				if(map1.get("level").toString().trim().equals("1")){
					yichen.setPyichenid(0);
				}else if(map1.get("level").toString().trim().equals("2")){
					yichen.setPyichenid(oneyichenid);
				}else if(map1.get("level").toString().trim().equals("3")){
					yichen.setPyichenid(twoyichenid);
				}
				System.out.println("******" + map1.get("level").toString());
				yichen.setTitle((String)map1.get("content"));
				System.out.println("******" + map1.get("content").toString());
//				yichen.setTitle(filename);
				yichen.setMeetid(meetid);
				yichen.setSort(i*5);
				
				//只要序号一致即覆盖
				Map<String,Object> map=new java.util.HashMap<String,Object>();
				String tmptitle=(String)map1.get("content");
				tmptitle=tmptitle.substring(0, 2);
				System.out.println("自动生成议程，是否覆盖："+tmptitle);
				map.put("meetid", meetid);
				map.put("title", tmptitle);
				map.put("pyichenid", yichen.getPyichenid());
				MeetYichenMainEntity temp=yichenMainDao.selectYichenByTitleAndMeetid(map);
							
				System.out.println("自动生成议程，是否覆盖-object："+yichen);
				System.out.println("yichen title"+yichen.getTitle());
				//System.out.println("yichen yichenid"+yichen.getYichenid());
				
				if(temp==null){
					yichenMainDao.insert(yichen);
				}else{
					yichen.setYichenid(temp.getYichenid());
					yichen.setSort(temp.getSort());
					yichenMainDao.updateByPrimaryKey(yichen);
				}
				
				if(map1.get("level").toString().trim().equals("1")){
					oneyichenid=yichen.getYichenid();
				}else if(map1.get("level").toString().trim().equals("2")){
					twoyichenid=yichen.getYichenid();
				}else if(map1.get("level").toString().trim().equals("3")){
					threeyichenid=yichen.getYichenid();
				}
			}
		}
		
		//增加会议议程
		@Override
		public MeetYichenMainEntity addMeetYichen(MeetYichenMainEntity yichen){
			 
			//如果是已发布状态，则更新状态
			meetPubService.chgMeetProcState("yichen",yichen.getMeetid());
			yichenMainDao.insert(yichen);
			 return yichen;
		}
		
		//更新会议议程
		@Override
		public void updateMeetYichen(MeetYichenMainEntity yichen){
			//如果是已发布状态，则更新状态
			meetPubService.chgMeetProcState("yichen",yichen.getMeetid());
			yichenMainDao.updateByPrimaryKey(yichen);
		}
		
		//删除会议议程
		@Override
		public void delMeetYichen(int yichenid){
			//如果是已发布状态，则更新状态
			MeetYichenMainEntity yichen=yichenMainDao.selectByPrimaryKey(yichenid);
			meetPubService.chgMeetProcState("yichen",yichen.getMeetid());
			yichenMainDao.deleteByPrimaryKey(yichenid);
			yichenMainDao.deleteSubYichenByPid(yichenid);
		}
		
		//绑定议程文件
		@Override
		public void bindYichenFile(int yichenid,String[] fileids){
			MeetYichenFileEntity yichenFile=null;
			
			yichenFileDao.deleteYichFileByYichenid(yichenid);
			for(int i=0;i<fileids.length;i++){
				if(ValidateUtil.isValid(fileids[i])){
					yichenFile=new MeetYichenFileEntity();
					yichenFile.setFileid(Integer.parseInt(fileids[i]));
					yichenFile.setYichenid(yichenid);
					yichenFile.setSort(0);	
					yichenFileDao.insert(yichenFile);
				}
			}
		}
		
		//日程绑定闭幕会文件
		@Override
		public void bindRichenFile(int richenid,String[] fileids){
			MeetRichenFileEntity richenFile=null;		
			meetRichenFileDao.deleteRichFileByRichenid(richenid);
			for(int i=0;i<fileids.length;i++){
				if(ValidateUtil.isValid(fileids[i])){
					richenFile=new MeetRichenFileEntity();
					richenFile.setFileid(Integer.parseInt(fileids[i]));
					richenFile.setRichenid(richenid);
					richenFile.setSort(0);	
					meetRichenFileDao.insert(richenFile);
				}
			}
		}
		//日程绑定闭幕会文件
		@Override
		public void relativeRichenFile(int fileid,String[] richenid){
			MeetRichenFileEntity richenFile=null;		
			meetRichenFileDao.deleteRichFileByFileid(fileid);
			for(int i=0;i<richenid.length;i++){
				if(ValidateUtil.isValid(richenid[i])){
					richenFile=new MeetRichenFileEntity();
					richenFile.setFileid(fileid);
					richenFile.setRichenid(Integer.parseInt(richenid[i]));
					richenFile.setSort(0);	
					meetRichenFileDao.insert(richenFile);
					richenYitiDao.updateYitiBindBimu(Integer.parseInt(richenid[i]));
				}
			}
		}		
		//一键生成日程
		@Override
		public void AutoGeneMeetRichen(String filename,int meetid){
			
			//如果是已发布状态，则更新状态
			meetPubService.chgMeetProcState("richen",meetid);
			
			List<RichenConvertObject> list=WordToRichenUtil.readRichenFromFile(filename);
			RichenConvertObject object=null;
			MeetRichenMainEntity richenEntity=null;
			MeetRichenYitiEntity yitiEntity=null;
		    
			MeetRichenMainEntity tempRichen=null;
			MeetRichenYitiEntity tempYiti=null;
			int richenid=0;
			int subrichenid=0;
			Map<String,Object> map=new HashMap<String,Object>();
			
			for(int i=0;i<list.size();i++){
				object=list.get(i);
				String dateName=object.getDateName();
				String timeName=object.getTimeName();
				String yitiName=object.getYitiName();
				//System.out.println("dateName=="+dateName+"+++++TimeName="+timeName+"++++yitiName="+yitiName);
				//插入日程
				if(dateName!=null&&dateName.trim().length()!=0){
					richenEntity=new MeetRichenMainEntity();
					richenEntity.setMeetid(meetid);
					richenEntity.setName(dateName);
					richenEntity.setSort(i*5);
					
					//日程判空
					
					String tmpname=dateName.trim();
					tmpname=tmpname.substring(0, 6);
					
					map.put("meetid", meetid);
					map.put("name", tmpname);
					
					tempRichen=richenMainDao.selectParentRichenByNameAndMeetid(map);
					if(tempRichen!=null){
						richenid=tempRichen.getRichenid();
						richenEntity.setRichenid(richenid);
						richenEntity.setSort(tempRichen.getSort());
						richenMainDao.updateByPrimaryKey(richenEntity);
						
					}else{
						richenMainDao.insertAndGetId(richenEntity);
						richenid=richenEntity.getRichenid();
					}
					//System.out.println("1111--richenid="+richenid+"--name="+richenEntity.getName());
					continue;
				}
				
				//插入时间日程
				if(timeName!=null&&timeName.trim().length()!=0){
					richenEntity=new MeetRichenMainEntity();
					richenEntity.setMeetid(meetid);
					richenEntity.setName(timeName);
					richenEntity.setSort(i*5);
					if(richenid!=0){
						richenEntity.setPrichenid(richenid);
					}
					
					//时间日程判空
					String tmptime=timeName.trim();
					tmptime=tmptime.substring(0, 5);
					map.put("meetid", meetid);
					map.put("name", tmptime);
					map.put("prichenid", richenid);
					tempRichen=richenMainDao.selectSubRichenByNameAndMeetid(map);
					if(tempRichen!=null){
						subrichenid=tempRichen.getRichenid();
						richenEntity.setRichenid(subrichenid);
						richenEntity.setSort(tempRichen.getSort());
						richenMainDao.updateByPrimaryKey(richenEntity);
					}else{
						richenMainDao.insertAndGetId(richenEntity);
						subrichenid=richenEntity.getRichenid();
					}
					
					//System.out.println("2222--richenid="+richenid+"--subrichenid="+subrichenid+"--name="+richenEntity.getName());
				    continue;
				}
				
				//插入议题
				if(yitiName!=null&&yitiName.trim().length()!=0){
					yitiEntity=new MeetRichenYitiEntity();
					yitiEntity.setRichenid(subrichenid);
					yitiEntity.setTitle(yitiName);
					yitiEntity.setSort(i*5);
					
					//议题判空根据日程id和议题name查询
					String tmptitle=yitiName.trim();
					tmptitle=tmptitle.substring(0, 2);
					
					map.put("title", tmptitle);
					map.put("richenid", subrichenid);
					tempYiti=richenYitiDao.selectYitiByYtTitleAndRichenid(map);
					if(tempYiti==null){
						richenYitiDao.insert(yitiEntity);
					}else{
						yitiEntity.setYitiid(tempYiti.getYitiid());
						yitiEntity.setSort(tempYiti.getSort());
						richenYitiDao.updateByPrimaryKey(yitiEntity);
					}
					//System.out.println("333---subrichenid="+yitiEntity.getRichenid()+"--yitiname:"+yitiEntity.getTitle());

				}
			}
			
		}
		
		//增加日程
		@Override
		public void addRichen(MeetRichenMainEntity richen){
			//如果是已发布状态，则更新状态
			meetPubService.chgMeetProcState("richen",richen.getMeetid());
			richenMainDao.insert(richen);
		}
		
		//更新日程
		@Override
		public void updateRichen(MeetRichenMainEntity richen){
			//如果是已发布状态，则更新状态
			meetPubService.chgMeetProcState("richen",richen.getMeetid());
			richenMainDao.updateByPrimaryKey(richen);
		}
		
		//删除日程
		@Override
		public void deleteRichen(int richenid){
			
			//如果是已发布状态，则更新状态
			MeetRichenMainEntity richen=richenMainDao.selectByPrimaryKey(richenid);
			meetPubService.chgMeetProcState("richen",richen.getMeetid());
			richenMainDao.deleteByPrimaryKey(richenid);
			richenYitiDao.deleteYitiByRichenId(richenid);
		}
		
		//增加日程议题
		@Override
		public void addRichenYiti(MeetRichenYitiEntity richyiti){
			
			//如果是已发布状态，则更新状态
			//richenMainDao.richyiti.getRichenid()
			MeetRichenMainEntity entity=richenMainDao.selectByPrimaryKey(richyiti.getRichenid());
			meetPubService.chgMeetProcState("richen",entity.getMeetid());
			
			richenYitiDao.insert(richyiti);
		}
		
		//更新日程议题
		@Override
		public void updateRichenYiti(MeetRichenYitiEntity richyiti){
			//如果是已发布状态，则更新状态
			//richenMainDao.richyiti.getRichenid()
			MeetRichenMainEntity entity=richenMainDao.selectByPrimaryKey(richyiti.getRichenid());
			
			meetPubService.chgMeetProcState("richen",entity.getMeetid());
			
			richenYitiDao.updateByPrimaryKey(richyiti);
			meetRichenFileDao.deleteRichFileByRichenid(richyiti.getRichenid());
		}
		
		//删除日程议题
		@Override
		public void deleteRichenYiti(int yitiid){
            
		   //更新流程状态
		    MeetRichenMainEntity entity=richenMainDao.selectMeetIdByRichenYiyiid(yitiid);
			meetPubService.chgMeetProcState("richen",entity.getMeetid());
			richenYitiDao.deleteByPrimaryKey(yitiid);
		}
		//增加会议文件
		@Override
		public List<MeetFileMainEntity> addMeetFiles(List<MeetFileMainEntity> list){
			List<MeetFileMainEntity> list1=new ArrayList<MeetFileMainEntity>();
			int meetid=0;
			MeetFileMainEntity entity=null;
			for(int i=0;i<list.size();i++){
				entity=(MeetFileMainEntity)list.get(i);
				entity.setSort(i*5);
				meetFileMainDao.insertAndGetId(entity);
				list1.add(entity);
				meetid=entity.getMeetid();
			}
			//如果是已发布状态，则更新状态
			meetPubService.chgMeetProcState("file",meetid);
			return list1;
			
		}
		
		//增加会议文件单个
		@Override
		public MeetFileMainEntity addMeetFile(MeetFileMainEntity meetfile){
			//如果是已发布状态，则更新
			System.out.println("meetfile:"+meetfile.toString());
			 meetPubService.chgMeetProcState("file",meetfile.getMeetid());
			    int t=this.getMeetFileMaxSort(meetfile.getMeetid(),meetfile.getFileown());
			    t=t+5;
			    System.out.println("t:"+t);
			    meetfile.setSort(t);
			    meetFileMainDao.insertAndGetId(meetfile);
			    //插入文件推送范围
			    //MeetFileScopeEntity scope=null;
			    MeetFileUserEntity scope=null;
			    String filescope=meetfile.getFilescopes();
			    
			    
			    if(filescope!=null&&filescope.trim().length()!=0){
			    	String[] scopes=filescope.split(",");
			    	
			    	if(scopes==null){
		    		return meetfile;
			    	}
			    	
			    
			    	
			    	for(int j=0;j<scopes.length;j++){
			    		if(scopes[j]!=null&&scopes[j].trim().length()!=0){
			    			/*scope=new MeetFileScopeEntity();
				    		scope.setFileid(meetfile.getFileid());
				    		scope.setScopeid(Integer.valueOf(scopes[j]));
				    		filescopeDao.insert(scope);*/
			    			scope=new MeetFileUserEntity();
			    			scope.setFileid(meetfile.getFileid());
			    			scope.setIsdel(0);
			    			scope.setUserid(Integer.valueOf(scopes[j]));
			    			meetFileUserDao.insert(scope);
			    			
		    		}
		    		
			    	}
			    	
			    }
			    
				return meetfile;
		}
		
		
		//多個會中会议文件单个
				@Override
				public MeetFileMainEntity addMeetFileHzzrhy(MeetFileMainEntity meetfile){
					//如果是已发布状态，则更新
					System.out.println("meetfile:"+meetfile.toString());
					 meetPubService.chgMeetProcState("file",meetfile.getMeetid());
					    int t=this.getMeetFileMaxSort(meetfile.getMeetid(),meetfile.getFileown());
					    t=t+5;
					    System.out.println("t:"+t);
					    meetfile.setSort(t);
					    meetFileMainDao.insertAndGetId(meetfile);
					    //插入文件推送范围
					    //MeetFileScopeEntity scope=null;
					    MeetFileUserEntity scope=null;
					    String filescope=meetfile.getFilescopes();
					    
					    
					    if(filescope!=null&&filescope.trim().length()!=0){
					    	String[] scopes=filescope.split(",");
					    	
					    	if(scopes==null){
				    		return meetfile;
					    	}
					    	
					    /**
					     * 
					     * 	
					     */
					    	for(int i=0;i<scopes.length;i++){
					    		List<SysScopeUserEntity> selectByScopeId = sysScopeUserDao.selectByScopeId(Integer.valueOf(scopes[i]));
							    for(SysScopeUserEntity s:selectByScopeId){
							    	scope=new MeetFileUserEntity();
					    			scope.setFileid(meetfile.getFileid());
					    			scope.setIsdel(0);
					    			scope.setUserid(s.getUserid());
					    			meetFileUserDao.insert(scope);
							    }
					    	}
					    }
					    return meetfile ;
				}
		
		//删除会议文件
		@Override
		public void deleteMeetFile(int fileid){
			MeetFileMainEntity entity=meetFileMainDao.selectByPrimaryKey(fileid);
			meetPubService.chgMeetProcState("file",entity.getMeetid());
			meetFileMainDao.deleteByPrimaryKey(fileid);
		}
		
		
		//删除会议文件
		@Override
		public void deleteMeetFiles(String fileids){
			if(fileids!=null&&fileids.trim().length()!=0){
				String[] arraystr=fileids.split(",");
				for(int i=0;i<arraystr.length;i++){
					if(arraystr[i]!=null&&arraystr[i].trim().length()!=0){
						int fileid=Integer.parseInt(arraystr[i]);
						
						MeetFileMainEntity entity=meetFileMainDao.selectByPrimaryKey(fileid);
						meetPubService.chgMeetProcState("file",entity.getMeetid());
						meetFileMainDao.deleteByPrimaryKey(fileid);
					}
				}
				
			}
		}
		
		/**
		 * /自动关联会议文件和议程
		 */
		@Override
		public Map<String,Object> autoRelaMeetFileAndYichen(int meetid){
			Map<String,Object> resultmap=new java.util.HashMap<String,Object>();
			//resultmap.
			List<String> sucesslist=new ArrayList<String>();
			
			int bindsucess=0;
			int bindfail=0;
			int filetotal=0;
			
			//如果是已发布状态，则更新状态
			meetPubService.chgMeetProcState("file",meetid);
			
			List<MeetYichenMainEntity> listyichen=yichenMainDao.selectAllByMeetid(meetid);
			System.out.println("auto rela meetFile ");
			if(log.isInfoEnabled()){
				log.info("auto rela meetFile ");
			}
			
			HashMap<String,Object> map=new HashMap<String,Object>();
			map.put("meetid", meetid);
			map.put("fileown", "1");
			List<MeetFileMainEntity> listfile=meetFileMainDao.selectAllFileByMeetidAndFileOwn(map);
			filetotal=listfile.size();
			
			
			List<MeetRichenYitiEntity> listyiti=richenYitiDao.selectYitiByMeetid(meetid);
			
			MeetYichenMainEntity yichen=null;
			MeetFileMainEntity   file=null;
			MeetRichenYitiEntity richenyiti=null;
			String yitiname=null;
			String yichenname=null;
			List<String> keywords=null;
			String fileTitle=null;
            MeetYichenFileEntity record=null;
            MeetYichenFileEntity temp=null;
			
			
			if(listyichen==null||listyichen.size()==0){
				return resultmap;
			}
			if(listfile==null||listfile.size()==0){
				return resultmap;
			}
			for(int i=0;i<listyichen.size();i++){
				yichen=listyichen.get(i);
                yichenname=yichen.getTitle();
               // keywords=new ArrayList();
               //包括文件名称
               
                System.out.println("yichenname=" +yichenname);
                if(log.isInfoEnabled()){
                	log.info("yichenname is :"+yichenname);
                }
              
              //生成关键字
    			keywords=FileAutoRelaYichenUtil.generalKeyWords(yichenname);
    			if(keywords==null||keywords.size()==0){
    				continue;
    			}
                //所有文件
    			if(log.isInfoEnabled()){
    				
    				log.info("keyword is:"+keywords);
    			}
    				System.out.println("keyword is:"+keywords);
	              
	                //议题和文件关联
	                for(int j=0;j<listfile.size();j++){
	                	file=listfile.get(j);
	                	System.out.println("绕过参阅文件");
	                	if(!"3".equals(file.getFiletype())){
	                		fileTitle=file.getTitle();
		                	boolean b=true;
		                	for(int k=0;k<keywords.size();k++){
		                		if(fileTitle.indexOf(keywords.get(k))>=0){
		                			record=new MeetYichenFileEntity();
		                			record.setYichenid(yichen.getYichenid());
		                			record.setFileid(file.getFileid());
		                			
		                			if(b&&sucesslist.contains(file.getFileid().toString().trim())==false){
		                			    bindsucess++;
		                			    sucesslist.add(file.getFileid().toString().trim());
		                			    b=false;
		                			}
		                			
		                			temp=yichenFileDao.selectByYichenFileEntity(record);
		                			if(temp!=null){
		                				record.setId(temp.getId());
		                				yichenFileDao.updateByPrimaryKey(record);
		                			}else{
		                				yichenFileDao.insert(record);
		                			}
		                			
		                			if(log.isInfoEnabled()){
		                				log.info("bind yichen and file,file is:"+file.getFilename());
		                				log.info("bind yichen and file,yichen is:"+yichen.getTitle());
		                			}
		                			break;
		                		}
		                	} 
	                	}
	                	
	                	
	                }
	                
	                
	                bindfail=filetotal-bindsucess;
	                System.out.println("bind file totla is:"+filetotal);
	                System.out.println("bind file sucess is:"+bindsucess);
	                System.out.println("bind file failure is:"+bindfail);
	                
	                resultmap.put("bindsucess", bindsucess);
	                resultmap.put("bindfailure", bindfail);
	                
	              //议程和议题关联
	                StringBuffer buffer=null;
	                System.out.println("bind yiti and yichen ,yiti list is:"+listyiti.size());
	                for(int t=0;t<listyiti.size();t++){
	                	richenyiti=listyiti.get(t);
	                	yitiname=richenyiti.getTitle();
	                	String bindyichenid=richenyiti.getBindyichenid();
	                	buffer=new StringBuffer();
	                	
	                	for(int k1=0;k1<keywords.size();k1++){
			                		
	                		     if(yitiname.indexOf(keywords.get(k1))>=0){               			
	                		    	 System.out.println("------bindyichenid.indexOf(yichen.getYichenid())--bindyichenid--"+bindyichenid);
		                			System.out.println("------bindyichenid.indexOf(yichen.getYichenid())-yichen.getYichenid()-"+yichen.getYichenid());
		                			System.out.println("------bindyichenid.indexOf(yichen.getYichenid())-yichen.getYichenid()-"+yichen.getYichenid());
		                			
		                			if(bindyichenid!=null&&bindyichenid.trim().length()!=0){
		                				System.out.println("------bindyichenid.indexOf(yichen.getYichenid())-isindexof-"+bindyichenid.indexOf(yichen.getYichenid().toString()));
	
		                				if(bindyichenid.indexOf(yichen.getYichenid().toString())>=0){
				                					break;
				                			}else{
				                				buffer.append(yichen.getYichenid());
					                			richenyiti.setBindyichenid(buffer.toString());
						                		richenYitiDao.updateByPrimaryKey(richenyiti);
					                			break;
				                			}
		                			}else{
		                				
			                				buffer.append(yichen.getYichenid());
			                				richenyiti.setBindyichenid(buffer.toString());
					                		richenYitiDao.updateByPrimaryKey(richenyiti);
			                			    break;
		                			}
	                		}
	                	} 
	                	
	                }
	                
                
			}
			return resultmap;
		}
		
		
		/**
		 * 根据文件id更新文件类型
		 */
		@Override
		public MeetFileMainEntity updateFileTypeByFileId(MeetFileMainEntity meetfile){
			
			//如果是已发布状态，则更新状态
			meetPubService.chgMeetProcState("file",meetfile.getMeetid());
			meetFileMainDao.updateFileTypeByFileId(meetfile);
			return meetfile;
		}
		
		//更新会议分组
		@Override
		public int upddateMeetGrp(MeetGroupMainEntity grp){
			String grpno=grp.getGroupno();
			int meetid=grp.getMeetid();
			HashMap<String,Object> map=null;
			int i=0;
			if(grpno!=null&&grpno.trim().length()!=0){
				map=new java.util.HashMap<String,Object>();
				map.put("meetid", meetid);
				map.put("groupno",grpno);
				MeetGroupMainEntity group=meetGroupMainDao.selectGroupByMeetidAndGroupno(map);
				if(group==null){
					i=meetGroupMainDao.insert(grp);
				}else{
					grp.setGroupid(group.getGroupid());
					i=meetGroupMainDao.updateByPrimaryKey(grp);
				}
			}
			return i;
			
		}
     
		
		//获取当前流程状态及下一步动作
		@Override
		public MeetProcessEntity getCurMeetProcess(int meetid,String submodulecode){
			
			return this.getCurMeetProcessByState(meetid,submodulecode,"1");
		}
		
		/**
		 * 内部方法
		 * @param meetid
		 * @param submodulecode
		 * @param cursate
		 * @return
		 */
		private MeetProcessEntity getCurMeetProcessByState(int meetid,String submodulecode,String curState){
			MeetProcessEntity processEntity=null;
			String proccode="subproc";
			String curstate=null;
			Map<String,Object> map=new java.util.HashMap<String,Object>();
			map.put("meetid", meetid);
			
			//三个流程合成一个流程
			map.put("submodulecode", "yichen");
			processEntity=meetProcessDao.selectCurProcessByMeetidAndSubmodulecode(map);
			
			if(processEntity!=null){
				curstate=processEntity.getCurstate();
			}else{
				processEntity=new MeetProcessEntity();
				curstate=curState;
			}
			
			if(submodulecode!=null&&submodulecode.trim().equals("meet")){
				proccode="mainproc";
			}
				
				List<DictProcessDefEntity> listprocess=null;
				listprocess=dictDataService.selectCurProcessDef(proccode,curstate);
				//转换对象
				
				processEntity.setMeetid(meetid);
				processEntity.setSubmodulecode(submodulecode);
				System.out.println("get current processEntity commint is:"+processEntity.getComment());
				
				if(listprocess!=null&&listprocess.size()>0){
					processEntity.setCurstate(listprocess.get(0).getCurstate());
					String stateName=dictDataService.getNameByTypeAndcode("procstate", processEntity.getCurstate());
					processEntity.setCurstatename(stateName);
					
					List<Map<String,Object>> actionList=new java.util.ArrayList<Map<String,Object>>();
					Map<String,Object> actionMap=null;
					String actionName=null;
					for(int i=0;i<listprocess.size();i++){
						actionMap=new java.util.HashMap<String,Object>();
						actionMap.put("action",listprocess.get(i).getAction());
						actionName=dictDataService.getNameByTypeAndcode("procaction", listprocess.get(i).getAction());
						actionMap.put("actionname",actionName);
						actionList.add(actionMap);
					}
					processEntity.setActionlist(actionList);
				}
			
			return processEntity;
		}
		
		/**
		 * 提交当前流程状态----submodule
		 * yichen
		 * richen
		 * file
		 * huizhong
		 * bimu
		 * fenzu
		 */
		@Override
		public boolean submitMeetPub(int meetid, String submodule){
			      
			  MeetFileRemindEntity fileentity=new MeetFileRemindEntity();
			  fileentity.setMeetid(meetid);
			  String mtype= meetMainDao.selectMtypeByMeetid(meetid);
			  fileentity.setMtype(mtype);
			  MeetPubPubtimeEntity pubtimeentity=new MeetPubPubtimeEntity();
			  pubtimeentity.setMeetid(meetid);
				    try{
				    	 if(submodule!=null&&submodule.trim().equals("yichen")){
				    		 meetPubService.pubMeetYichen(meetid);
				    		 pubtimeentity.setModuleid(1);
				    		 meetingViewService.insertMeetPubPubtime(pubtimeentity);
				    		 
				    	 }else if(submodule!=null&&submodule.trim().equals("richen")){
						     meetPubService.pubMeetRichen(meetid);
				    		 pubtimeentity.setModuleid(2);
				    		 meetingViewService.insertMeetPubPubtime(pubtimeentity);
						     
				    	 }else if(submodule!=null&&submodule.trim().equals("file")){
				    		  meetPubService.pubMeetFiles(meetid,"1");
				    		  //文件管理发布短信提醒
				    		  fileentity.setFileown("1");
				    		  fileentity.setModuleid("1");
				    		  remindService.MeetFileRemindHandler("insert",fileentity,0);
					    	  pubtimeentity.setModuleid(3);
					    	  meetingViewService.insertMeetPubPubtime(pubtimeentity);
				    	 }else if(submodule!=null&&submodule.trim().equals("huizhong")){
				    		  meetPubService.pubMeetFiles(meetid,"2");
				    		  
				    		  fileentity.setFileown("2");
				    		  fileentity.setModuleid("2");
				    		  remindService.MeetFileRemindHandler("insert",fileentity,0);
				    		  
					    	  pubtimeentity.setModuleid(5);
					    	  meetingViewService.insertMeetPubPubtime(pubtimeentity);
				    	 }else if(submodule!=null&&submodule.trim().equals("bimu")){
				    		 meetPubService.pubMeetFiles(meetid,"3");
				    		  
				    		 fileentity.setFileown("3");
				    		  fileentity.setModuleid("3");
				    		  remindService.MeetFileRemindHandler("insert",fileentity,0);
				    		  
				    		  pubtimeentity.setModuleid(6);
					    	  meetingViewService.insertMeetPubPubtime(pubtimeentity);
				    	 }
				    }catch (Exception e) {
						e.printStackTrace();
						return false;
					}
			return true;
			
		}
		
		
		/**
		 * 提交当前流程状态----submodule
		 * yichen
		 * richen
		 * file
		 * huizhong
		 * bimu
		 * fenzu
		 */
		@Override
		public boolean submitFenzuPub(int meetid, String groupno){
			try {
				meetPubService.pubMeetGroup(meetid,groupno);
			} catch (Exception e) {
				e.printStackTrace();
				return false;
			}
			 return true;
		}


		
		@Override
		public Page selectByPage(int pageNo, int pageSize) {
			return PageHelper.pagedQuery(new PageCall() {
				@Override
				public void executeQuery() {
					meetMainDao.selectAll();
				}
			}, pageNo, pageSize);
		}
		
		@Override
		public List<MeetMainEntity>  selectAllTypeCurMeeting(){
			return  meetMainDao.selectAllTypeCurMeeting();
		}
		
		
		//更新排序
		@Override
		public boolean  updateSort(int id,String filetype,int sort){
			Map<String,Object> map=new java.util.HashMap<String,Object>();
			
			try{
				//议程
				if(filetype!=null&&(filetype.trim().equals("0")||filetype.trim().equals("4"))){
					map.put("yichenid", id);
					map.put("sort", sort);
					yichenMainDao.updateYichenSort(map);
				//日程
				}else if(filetype!=null&&(filetype.trim().equals("5")||filetype.trim().equals("6"))){
					map.put("richenid", id);
					map.put("sort", sort);
					richenMainDao.updateRichenSort(map);
				
				//议题	
				}else if(filetype!=null&&(filetype.trim().equals("7"))){
					map.put("yitiid", id);
					map.put("sort", sort);
					richenYitiDao.updateYitiSort(map);
				//文件管理
				}else if(filetype!=null&&(filetype.trim().equals("1")||filetype.trim().equals("2")||filetype.trim().equals("3")||filetype.trim().equals("8")||filetype.trim().equals("9")||filetype.trim().equals("10"))){
					map.put("fileid", id);
					map.put("sort", sort);
					meetFileMainDao.updateFileSort(map);
				}
			}catch(Exception e){
				e.printStackTrace();
				return false;
			}
			
			return true;
		}
		
		
		
		@Override
		public boolean  updateSortZD(int id,String filetype,int sort){
			Map<String,Object> map=new java.util.HashMap<String,Object>();
			
			try{
				//议程
				if(filetype!=null&&(filetype.trim().equals("0")||filetype.trim().equals("4"))){
					map.put("yichenid", id);
					map.put("sort", sort);
					yichenMainDao.updateYichenSort(map);
				//日程
				}else if(filetype!=null&&(filetype.trim().equals("5")||filetype.trim().equals("6"))){
					map.put("richenid", id);
					map.put("sort", sort);
					richenMainDao.updateRichenSort(map);
				
				//议题	
				}else if(filetype!=null&&(filetype.trim().equals("7"))){
					map.put("yitiid", id);
					map.put("sort", sort);
					richenYitiDao.updateYitiSort(map);
				//文件管理
				}else if(filetype!=null&&(filetype.trim().equals("1")||filetype.trim().equals("2")||filetype.trim().equals("3")||filetype.trim().equals("8")||filetype.trim().equals("9")||filetype.trim().equals("10"))){
					map.put("fileid", id);
					map.put("sort", sort);
					meetFileMainDao.updateFileSortZD(map);
				}
			}catch(Exception e){
				e.printStackTrace();
				return false;
			}
			
			return true;
		}
		
		/**
		 * 内部调用
		 * @return
		 */
		private int selectProcessLogGlobalid(){
			int i=0;
			try{
				i=meetProcessLogDao.selectMaxProcessLogGlobalid();
				System.out.println("selectMaxProcessLogGlobalid() is :"+i);
			}catch(Exception e){
				System.out.println(e.toString());
				i=0;
			}
			  return i;	
		}
		
		/**
		 * 内部调用
		 * @param meetid
		 * @return
		 */
		private int getMeetFileMaxSort(int meetid,String fileown){
			int i=0;
			Map<String,Object> map=new java.util.HashMap<String,Object>();
			map.put("meetid", meetid);
			map.put("fileown", fileown);
			try{
				i=meetFileMainDao.getMeetFileMaxSort(map);
			}catch(Exception e){
				System.out.println(e.toString());
				i=0;
			}
			  return i;	
		}
		
		@Override
		public int selectFileCountByMeetidAndFileOwn(Map<String,Object>  map){
			int count=0;
			try{
			count=meetFileMainDao.selectFileCountByMeetidAndFileOwnAndUserid(map);
			}catch(Exception e){
				e.printStackTrace();
				count=0;
			}
			return count;
		}

		@Override
		public MeetPubGroupEntity selectGroupPubTime(Map<String,Object> map) {	
			return meetPubGroupDao.selectGroupByMeetidAndGroupno(map);
		}

		@Override
		public List<MeetGroupMainEntity> getMeetGrp(int meetid) {
			
			return meetGroupMainDao.selectAll(meetid);
		}
		
		@Override
		public List<MeetPubGroupEntity> getPubMeetGrp(Map<String,Object> map) {
			
			return meetPubGroupDao.selectGroupByMeetidAndGroupnoClient(map);
		}

		@Override
		public MeetFileMainEntity selecMeetFileByFileid(int fileid) {
			return 	meetFileMainDao.selectByPrimaryKey(fileid);
		}

		@Override
		public void relativeYichenFile(String[] yichenids, int fileid) {
			MeetYichenFileEntity yichenFile=null;	
			yichenFileDao.deleteYichFileByFileid(fileid);
			for(int i=0;i<yichenids.length;i++){
				if(ValidateUtil.isValid(yichenids[i])){
					yichenFile=new MeetYichenFileEntity();
					yichenFile.setFileid(fileid);
					yichenFile.setYichenid(Integer.parseInt(yichenids[i]));
					yichenFile.setSort(0);	
					yichenFileDao.insert(yichenFile);
				}
			}
			
		}
		
	
}
