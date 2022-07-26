package com.cloudrich.ereader.system.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cloudrich.ereader.common.dao.PageHelper;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.common.dao.PageHelper.PageCall;
import com.cloudrich.ereader.meeting.entity.MeetMainEntity;
import com.cloudrich.ereader.system.dao.SysRoleMainDao;
import com.cloudrich.ereader.system.dao.SysRoleUserDao;
import com.cloudrich.ereader.system.entity.SysRoleMainEntity;

@Service("RoleServiceImpl")
public class RoleServiceImpl implements RoleService{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Resource SysRoleMainDao sysRoleMainDao;
	@Resource SysRoleUserDao sysRoleUserDao;
	@Override
	public int delete(int id){
		int i=sysRoleMainDao.deleteByPrimaryKey(id);
		return i;
		
	}

	@Override
	public SysRoleMainEntity selectEntityById(int id) {
		return sysRoleMainDao.selectByPrimaryKey(id);
	}

	@Override
	public List<SysRoleMainEntity> selectAll() {
			List<SysRoleMainEntity> list = sysRoleMainDao.selectAll();
			return list;
		
	}

	 public int insert(SysRoleMainEntity entiry){
		 int i=sysRoleMainDao.insert(entiry);
		 return i;
		 
	 }
	   
	 public int update(SysRoleMainEntity entiry){
		 int i=sysRoleMainDao.updateByPrimaryKey(entiry);
		 return i;
	 }
		@Override
		public Page selectByPage(int pageNo, int pageSize) {
			return PageHelper.pagedQuery(new PageCall() {
				@Override
				public void executeQuery() {
					sysRoleMainDao.selectAll();
				}
			}, pageNo, pageSize);
		}
		@Override
		public Page selectByPageUser(int pageNo, int pageSize,final Integer roleid) {
			return PageHelper.pagedQuery(new PageCall() {
				@Override
				public void executeQuery() {
					List list=sysRoleUserDao.selectByRoleid(roleid);
					//System.out.println(list.size());
				}
			}, pageNo, pageSize);
		}
		
}
