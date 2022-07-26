package com.cloudrich.ereader.meeting.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cloudrich.ereader.briefingpub.dao.MeetPubBriefingDao;
import com.cloudrich.ereader.briefingpub.entity.MeetPubBriefingEntity;
import com.cloudrich.ereader.chuqueqin.dao.ChuqueqinPubDao;
import com.cloudrich.ereader.chuqueqin.entity.ChuqueqinPubEntity;
import com.cloudrich.ereader.meetpub.dao.MeetPubFileDao;
import com.cloudrich.ereader.meetpub.dao.MeetPubGroupDao;
import com.cloudrich.ereader.meetpub.entity.MeetPubFileEntity;
import com.cloudrich.ereader.meetpub.entity.MeetPubGroupEntity;
import com.cloudrich.ereader.notice.dao.NoticePubDao;
import com.cloudrich.ereader.notice.entity.NoticePubEntity;
import com.cloudrich.ereader.system.dao.SysHelpMainDao;
import com.cloudrich.ereader.system.entity.SysHelpMainEntity;
import com.cloudrich.ereader.util.Md5GuidUtil;
import com.cloudrich.ereader.ziliaoku.dao.ZiliaokuMainDao;
import com.cloudrich.ereader.ziliaoku.entity.ZiliaokuMainEntity;

@Service
public class FileMd5ToolServiceImp implements FileMd5ToolService {
   
	@Resource MeetPubFileDao meetPubFileDao;
    @Resource MeetPubBriefingDao  meetPubBriefDao;
    @Resource MeetPubGroupDao   meetPubGroupDao;
    @Resource NoticePubDao   noticePubDao;
    @Resource ChuqueqinPubDao chuqueqinPubDao;
    @Resource ZiliaokuMainDao  ziliaokuMainDao;
    @Resource SysHelpMainDao  sysHelpMainDao;
   
   
   @Override
   public boolean updatePubFileMd5(String uploadpath){ 
	  List<MeetPubFileEntity> listFile= meetPubFileDao.selectAll();
	  if(listFile!=null&&listFile.size()!=0){
		  MeetPubFileEntity entity=null;
		  for(int i=0;i<listFile.size();i++){
			  entity=listFile.get(i);
			  String filename=filenameHandle(entity.getFilepath());
			  String filepath=uploadpath+"/"+filename;
			  System.out.println("file filepath----"+filepath);
			  File f=new File(filepath);
			  String md5=null;
			  if(f.exists()){
					 md5=Md5GuidUtil.getMd5Guid(f);
					 entity.setFileguid(md5);
					 meetPubFileDao.updateByPrimaryKey(entity); 
			  }  
		  }
	  }
	  
	  return true;
   }
   
   @Override
   public boolean updateBriefFileMd5(String uploadpath){
	   List<MeetPubBriefingEntity> listFile= meetPubBriefDao.selectAll();
		  if(listFile!=null&&listFile.size()!=0){
			  MeetPubBriefingEntity entity=null;
			  for(int i=0;i<listFile.size();i++){
				  entity=listFile.get(i);
				  String filename=filenameHandle(entity.getFilepath());
				  String filepath=uploadpath+"/"+filename;
				  System.out.println("brief filepath----"+filepath);
				  File f=new File(filepath);
				  String md5=null;
				  if(f.exists()){
						 md5=Md5GuidUtil.getMd5Guid(f);
						 entity.setFileguid(md5);
						 meetPubBriefDao.updateByPrimaryKey(entity); 
				  }
				  
				  
			  }
		  }
		  
		  return true;
   }
   
   
   @Override
   public boolean updateGroupFileMd5(String uploadpath){
	  
	   List<MeetPubGroupEntity> listFile= meetPubGroupDao.selectAll();
		  if(listFile!=null&&listFile.size()!=0){
			  MeetPubGroupEntity entity=null;
			  for(int i=0;i<listFile.size();i++){
				  entity=listFile.get(i);
				  String filename=filenameHandle(entity.getFilepath());
				  String filepath=uploadpath+"/"+filename;
				  System.out.println("grp filepath----"+filepath);
				  File f=new File(filepath);
				  String md5=null;
				  if(f.exists()){
						 md5=Md5GuidUtil.getMd5Guid(f);
						 entity.setFileguid(md5);
						 meetPubGroupDao.updateByPrimaryKey(entity); 
				  }
				  
				  
			  }
		  }
		  
		  return true;
   }
   
   @Override
   public boolean updateNoticeFileMd5(String uploadpath){
	  
	   List<NoticePubEntity> listFile= noticePubDao.selectAllNotice();
		  if(listFile!=null&&listFile.size()!=0){
			  NoticePubEntity entity=null;
			  for(int i=0;i<listFile.size();i++){
				  entity=listFile.get(i);
				  String filename=filenameHandle(entity.getPath());
				  String filepath=uploadpath+"/"+filename;
				  System.out.println("notice filepath----"+filepath);
				  File f=new File(filepath);
				  String md5=null;
				  if(f.exists()){
						 md5=Md5GuidUtil.getMd5Guid(f);
						 entity.setFileguid(md5);
						 noticePubDao.updateByPrimaryKey(entity); 
				  }
				  
				  
			  }
		  }
		  
		  return true;
   }
   
   
   //出
   @Override
   public boolean updateChuqueFileMd5(String uploadpath){
	  
	  
	   List<ChuqueqinPubEntity> listFile= chuqueqinPubDao.selectAllAbsent();
		  if(listFile!=null&&listFile.size()!=0){
			  ChuqueqinPubEntity entity=null;
			  for(int i=0;i<listFile.size();i++){
				  entity=listFile.get(i);
				  String filename=filenameHandle(entity.getPath());
				  String filepath=uploadpath+"/"+filename;
				  System.out.println("chuqueqin filepath----"+filepath);
				  File f=new File(filepath);
				  String md5=null;
				  if(f.exists()){
						 md5=Md5GuidUtil.getMd5Guid(f);
						 entity.setFileguid(md5);
						 chuqueqinPubDao.updateByAbsentid(entity);
				  }
				  
				  
			  }
		  }
		  
		  return true;
   }
   
   
   //资料库
   @Override
   public boolean updateZiliaokuFileMd5(String uploadpath){
	  
	  
	   List<ZiliaokuMainEntity> listFile= ziliaokuMainDao.selectAll();
		  if(listFile!=null&&listFile.size()!=0){
			  ZiliaokuMainEntity entity=null;
			  for(int i=0;i<listFile.size();i++){
				  entity=listFile.get(i);
				  String filename=filenameHandle(entity.getPath());
				  String filepath=uploadpath+"/"+filename;
				  System.out.println("ziliaku filepath----"+filepath);
				  File f=new File(filepath);
				  String md5=null;
				  if(f.exists()){
						 md5=Md5GuidUtil.getMd5Guid(f);
						 entity.setFileguid(md5);
						 ziliaokuMainDao.updateByPrimaryKey(entity);
				  }
			  }
		  }
		  
		  return true;
   }
   
 //资料库
   @Override
   public boolean updateHelpFileMd5(String uploadpath){
	  
	  Map<String,Object> map=new HashMap<String,Object>();
	   List<SysHelpMainEntity> listFile= sysHelpMainDao.selectAll(map);
		  if(listFile!=null&&listFile.size()!=0){
			  SysHelpMainEntity entity=null;
			  for(int i=0;i<listFile.size();i++){
				  entity=listFile.get(i);
				  String filename=filenameHandle(entity.getFilepath());
				  String filepath=uploadpath+"/"+filename;
				  System.out.println("help filepath----"+filepath);
				  File f=new File(filepath);
				  String md5=null;
				  if(f.exists()){
						 md5=Md5GuidUtil.getMd5Guid(f);
						 entity.setFileguid(md5);
						 sysHelpMainDao.updateByPrimaryKey(entity);
				  }
			  }
		  }
		  
		  return true;
   }
   
   /**
    * 
    * @param filename
    * @return
    */
   private String filenameHandle(String filename){
	    
	   if(filename!=null){
	    	if(filename.indexOf("/")>=0){
	    		filename=filename.substring(filename.indexOf("/"));
	    	}
	    }
	    return filename;
   }
}
