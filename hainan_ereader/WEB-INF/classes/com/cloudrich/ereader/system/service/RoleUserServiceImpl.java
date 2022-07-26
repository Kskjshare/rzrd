package com.cloudrich.ereader.system.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cloudrich.ereader.system.dao.SysRoleUserDao;
import com.cloudrich.ereader.system.entity.SysRoleUserEntity;

@Service("RoleUserServiceImpl")
public class RoleUserServiceImpl implements RoleUserService{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Resource SysRoleUserDao sysRoleUserDao;
	@Override
	public SysRoleUserEntity selectEntityById(int briefid) {
		SysRoleUserEntity sysRoleUserEntity=sysRoleUserDao.selectByPrimaryKey(briefid);
		return sysRoleUserEntity;
	}

	@Override
	public List<SysRoleUserEntity> selectAll() {
		List<SysRoleUserEntity> list=sysRoleUserDao.selectAll();
		return list;
	}

	@Override
	public int insert(SysRoleUserEntity briefing) {
		int i=sysRoleUserDao.insert(briefing);
		return i;
	}

	@Override
	public int update(SysRoleUserEntity briefing) {
		int i=sysRoleUserDao.updateByPrimaryKey(briefing);
		return i;
	}

	@Override
	public int delete(int id) {
		int i=sysRoleUserDao.deleteByPrimaryKey(id);
		return i;
	}

	@Override
	public int deleteByRoleid(int id) {
		int i=sysRoleUserDao.deleteByRoleid(id);
		return i;
	}

	@Override
	public List<SysRoleUserEntity> selectByRoleid(Integer id) {
		List<SysRoleUserEntity> list=sysRoleUserDao.selectByRoleid(id);
		return list;
	}
	
	@Override
	 public List<SysRoleUserEntity> selectByRuserid(Integer userid){
		return sysRoleUserDao.selectByUserid(userid);
	}

	@Override
	public int deleteByUserid(int id) {
		int i=sysRoleUserDao.deleteByUserid(id);
		return i;
	}
	
}
