package com.cloudrich.ereader.system.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cloudrich.ereader.system.dao.SysScopeUserDao;
import com.cloudrich.ereader.system.entity.SysScopeUserEntity;
@Service("ScopeUserServiceImpl")
public class ScopeUserServiceImpl implements ScopeUserService{
    
	@Resource
	private SysScopeUserDao sysScopeUserDao;
	@Override
	public int deleteByScopeId(Integer scopeid) {
		int i =sysScopeUserDao.deleteByScopeId(scopeid);
		return i;
	}

	@Override
	public int insert(SysScopeUserEntity record) {
		 int i=sysScopeUserDao.insert(record);
		 return i;
	}

	@Override
	public SysScopeUserEntity selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<SysScopeUserEntity> selectAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateByPrimaryKey(SysScopeUserEntity record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<SysScopeUserEntity> selectByScopeId(Integer id) {
		List<SysScopeUserEntity> list=sysScopeUserDao.selectByScopeId(id);
		return list;
	}

	@Override
	public int deleteByUserId(Integer id) {
		int i =sysScopeUserDao.deleteByUserId(id);
		return i;
	}

   
}
