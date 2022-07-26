package com.cloudrich.ereader.system.service;

import java.util.List;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cloudrich.ereader.common.dao.PageHelper;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.common.dao.PageHelper.PageCall;
import com.cloudrich.ereader.system.dao.SysScopeMainDao;
import com.cloudrich.ereader.system.dao.SysScopeUserDao;
import com.cloudrich.ereader.system.entity.SysScopeMainEntity;
import com.cloudrich.ereader.system.entity.SysScopeUserEntity;

@Service("ScopeMainServiceImpl")
public class ScopeMainServiceImpl implements ScopeMainService{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Resource SysScopeMainDao sysScopeMainDao;
	@Resource SysScopeUserDao sysScopeUserDao;
	@Override
	public int delete(Integer scopeid){
		int i=sysScopeMainDao.deleteByPrimaryKey(scopeid);
		return i;
		
	}

	@Override
	public SysScopeMainEntity selectEntityById(Integer scopeid) {
		return sysScopeMainDao.selectByPrimaryKey(scopeid);
	}

	@Override
	public List<SysScopeMainEntity> selectAll() {
			List<SysScopeMainEntity> list = sysScopeMainDao.selectAll();
			return list;
		
	}

	 public int insert(SysScopeMainEntity entiry){
		 int i=sysScopeMainDao.insert(entiry);
		 return i;
		 
	 }
	   
	 public int update(SysScopeMainEntity entiry){
		 int i=sysScopeMainDao.updateByPrimaryKey(entiry);
		 return i;
	 }
		@Override
		public Page selectByPage(int pageNo, int pageSize) {
			return PageHelper.pagedQuery(new PageCall() {
				@Override
				public void executeQuery() {
					sysScopeMainDao.selectAll();
				}
			}, pageNo, pageSize);
		}
		@Override
		public Page selectByPageUser(int pageNo, int pageSize,final int scopeid) {
			return PageHelper.pagedQuery(new PageCall() {
				@Override
				public void executeQuery() {
					sysScopeUserDao.selectByScopeId(scopeid);
				}
			}, pageNo, pageSize);
		}


		@Override
		public int updateByPrimaryKey(SysScopeMainEntity record) {
			 int i=sysScopeMainDao.updateByPrimaryKey(record);
			 return i;
		}
		
		@Override
		public List<SysScopeUserEntity> selectByScopeId(int scopeid) {
				List<SysScopeUserEntity> list = sysScopeUserDao.selectByScopeId(scopeid);
				return list;
			
		}
}
