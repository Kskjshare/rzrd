package com.cloudrich.ereader.system.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.cloudrich.ereader.common.dao.PageHelper;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.common.dao.PageHelper.PageCall;
import com.cloudrich.ereader.system.dao.SysUserMainDao;
import com.cloudrich.ereader.system.entity.SysUserMainEnity;

@Service("UserServiceImpl")
public class UserServiceImpl implements UserService {
	
	private Logger log = Logger.getLogger(UserServiceImpl.class);
	@Resource SysUserMainDao sysUserMainDao;
	
	@Override
	public int delete(int id){
		//String padmobile=sysUserMainDao.selectByPrimaryKey(id).getPadmobile();
		int i=sysUserMainDao.deleteByPrimaryKey(id);
		
		return i;
		
	}

	@Override
	public SysUserMainEnity selectEntityById(int id) {
		return sysUserMainDao.selectByPrimaryKey(id);
	}

	@Override
	public List<SysUserMainEnity> selectAll(Map<String,Object> map) {
			List<SysUserMainEnity> list = sysUserMainDao.selectAll(map);
			return list;
		
	}
    @Override
	 public int insert(SysUserMainEnity entiry){
		 int i=sysUserMainDao.insert(entiry);
		// String padmobile=entiry.getPadmobile();
		 return i;
	 }
	   
	 public int update(SysUserMainEnity entiry){
		 int i=sysUserMainDao.updateByPrimaryKey(entiry);
		 return i;
	 }

	@Override
	public SysUserMainEnity selectEntityByName(String username) {
		return sysUserMainDao.selectByUserName(username);
	}
	@Override
	public Page selectByPage(int pageNo, int pageSize,final Map<String, Object> map) {
		return PageHelper.pagedQuery(new PageCall() {
			@Override
			public void executeQuery() {
				System.out.println("map:" + map);
				sysUserMainDao.selectAll(map);
			}
		}, pageNo, pageSize);
	}

	@Override
	public List<SysUserMainEnity> selectAllPadUser() {
		List<SysUserMainEnity> list=sysUserMainDao.selectAllPadUser();
		return list;
	}

	@Override
	public List<SysUserMainEnity> selectAllUsers() {
		List<SysUserMainEnity> list=sysUserMainDao.selectAllUsers();
		return list;
	}
	
}
