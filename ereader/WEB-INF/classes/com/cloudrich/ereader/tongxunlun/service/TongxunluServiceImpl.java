package com.cloudrich.ereader.tongxunlun.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cloudrich.ereader.common.dao.PageHelper;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.common.dao.PageHelper.PageCall;
import com.cloudrich.ereader.meeting.entity.MeetFileMainEntity;
import com.cloudrich.ereader.tongxunlun.dao.TongxunluMainDao;
import com.cloudrich.ereader.tongxunlun.dao.TongxunluPermissionDao;
import com.cloudrich.ereader.tongxunlun.dao.TongxunluPubDao;
import com.cloudrich.ereader.tongxunlun.entity.TongxunluMainEntity;
import com.cloudrich.ereader.tongxunlun.entity.TongxunluPermissionEntity;
import com.cloudrich.ereader.tongxunlun.entity.TongxunluPubEntity;

@Service("TongxunluServiceImpl")
public class TongxunluServiceImpl implements TongxunluService{

	@Resource TongxunluMainDao tongxunluMainDao;
	@Resource TongxunluPubDao tongxunluPubDao;
	@Resource TongxunluPermissionDao tongxunluPermissionDao;
	
	@Override
	public int delete(int id){
		int i=tongxunluMainDao.deleteByPrimaryKey(id);
		//tongxunluPubDao.deleteByTxlid(id);
		return i;
	}

	@Override
	public TongxunluMainEntity selectEntityById(int id) {
		return tongxunluMainDao.selectByPrimaryKey(id);
	}

	@Override
	public List<TongxunluMainEntity> selectAll() {
			List<TongxunluMainEntity> list = tongxunluMainDao.selectAll(null);
			return list;
	}

	 public int insert(TongxunluMainEntity entiry){
		 int i=tongxunluMainDao.insert(entiry);
		 return i;
		 
	 }
	   
	 public int update(TongxunluMainEntity entiry){
		 int i=tongxunluMainDao.updateByPrimaryKey(entiry);
		 return i;
	 }
	
	 @Override
	public Page selectByPage(int pageNo, int pageSize,final String name) {
		return PageHelper.pagedQuery(new PageCall() {
			@Override
			public void executeQuery() {
				tongxunluMainDao.selectAll(name);
			}
		}, pageNo, pageSize);
	}

	 
	 @Override
	public List<TongxunluPubEntity> selectComp(int compCode) {
		return tongxunluPubDao.selectByComp(compCode);
	}

	@Override
	public void insertPush() {
		try {
			List<TongxunluMainEntity> list=tongxunluMainDao.selectAll("");
			//全部删除以后发布，将所有的数据变为删除
			//if(list==null||list.size()==0){
				tongxunluPubDao.deleteAll();
			//}
			for (int i = 0; i < list.size(); i++) {
				TongxunluMainEntity briefing=list.get(i);
				//tongxunluPubDao.deleteByTxlid(briefing.getId());
				TongxunluPubEntity pubentity=new TongxunluPubEntity();
					pubentity.setComment(briefing.getComment());
					pubentity.setCompCode(briefing.getCompCode());
					pubentity.setDept(briefing.getDept());
					pubentity.setJobtitle(briefing.getJobtitle());
					pubentity.setMail(briefing.getMail());
					pubentity.setMobile(briefing.getMobile());
					pubentity.setName(briefing.getName());
					pubentity.setPhoneHome(briefing.getPhoneHome());
					pubentity.setPhoneOffice(briefing.getPhoneOffice());
					pubentity.setPubtime(new Date());
					pubentity.setSort(briefing.getSort());
					pubentity.setTxlid(briefing.getId());
					pubentity.setIsdel(briefing.getIsdel());
				tongxunluPubDao.insert(pubentity);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public TongxunluPubEntity selectPubtime() {
		return tongxunluPubDao.selectPubtime();
	}

	@Override
	public void deleteAll(String ids) {
		if(ids!=null&&ids.trim().length()!=0){
			String[] arraystr=ids.split(",");
			for(int i=0;i<arraystr.length;i++){
				if(arraystr[i]!=null&&arraystr[i].trim().length()!=0){
					int id=Integer.parseInt(arraystr[i]);
					tongxunluMainDao.deleteByPrimaryKey(id);
				}
			}
			
		}
	}

	@Override
	public List<TongxunluPermissionEntity> selectAllPermission() {
		
		return tongxunluPermissionDao.selectAll();
	}

	@Override
	public int deleteAllPermission() {
		
		return tongxunluPermissionDao.deleteAllPermission();
	}

	@Override
	public int savePermission(TongxunluPermissionEntity record) {
		return tongxunluPermissionDao.insert(record);
	}

	@Override
	public boolean selectPermisssionByUserid(int userid) {
		int i=0;
		try{
		i= tongxunluPermissionDao.selectPermisssionByUserid(userid);
		}catch(Exception e){
			e.printStackTrace();
			i=0;
		}
		if(i>0){
			return true;
		}else{
			return false;
		}
	}
}
