package com.cloudrich.ereader.system.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.cloudrich.ereader.common.dao.PageHelper;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.common.dao.PageHelper.PageCall;
import com.cloudrich.ereader.system.dao.SysVersionMainDao;
import com.cloudrich.ereader.system.entity.SysVersionMainEnity;
import com.google.gson.JsonObject;


@Service("VersionServiceImpl")
public class VersionServiceImpl implements VersionService {
	
	private Logger log = Logger.getLogger(VersionServiceImpl.class);
	@Resource SysVersionMainDao sysVersionMainDao;
	
	@Override
	public int delete(int id){
		int i=0;
		try{
			 i=sysVersionMainDao.deleteByPrimaryKey(id);		
		}catch(Exception e){
			e.printStackTrace();
		}
		return i;
		
	}

	@Override
	public SysVersionMainEnity selectEntityById(int id) {
		return sysVersionMainDao.selectByPrimaryKey(id);
	}

	@Override
	public List<SysVersionMainEnity> selectAll(Map<String,Object> map) {
			List<SysVersionMainEnity> list = sysVersionMainDao.selectAll(map);
			return list;
	}
    @Override
	 public int insert(SysVersionMainEnity entiry){
		 int i=0;	
		 try{
			 i=sysVersionMainDao.insert(entiry);
		 }catch(Exception e){
			 e.printStackTrace();
		 }
		 return i;
		 
	 }
	   
	 public int update(SysVersionMainEnity entiry){
		 int i=sysVersionMainDao.updateByPrimaryKey(entiry);
		 return i;
	 }

	@Override
	public Page selectByPage(int pageNo, int pageSize,final Map<String, Object> map) {
		return PageHelper.pagedQuery(new PageCall() {
			@Override
			public void executeQuery() {
				System.out.println("map:" + map);
				sysVersionMainDao.selectAll(map);
			}
		}, pageNo, pageSize);
	}	
	
	@Override
	public List<SysVersionMainEnity> selectVersionByType(String type) {
			List<SysVersionMainEnity> list = sysVersionMainDao.selectVersionByType(type);
			return list;
	}
	
	@Override
	public SysVersionMainEnity selectMaxVersion() {
		return sysVersionMainDao.selectMaxVersion();
	}

	
}
