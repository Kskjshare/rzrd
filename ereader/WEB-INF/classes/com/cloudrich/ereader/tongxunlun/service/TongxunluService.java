package com.cloudrich.ereader.tongxunlun.service;

import java.util.List;

import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.tongxunlun.entity.TongxunluMainEntity;
import com.cloudrich.ereader.tongxunlun.entity.TongxunluPermissionEntity;
import com.cloudrich.ereader.tongxunlun.entity.TongxunluPubEntity;

public interface TongxunluService {
	
	public TongxunluMainEntity selectEntityById(int briefid);
	public List<TongxunluMainEntity> selectAll();
	public int insert(TongxunluMainEntity briefing);
    public int update(TongxunluMainEntity briefing); 
    public int delete(int id); 
    public void deleteAll(String ids); 
    public Page selectByPage(int pageNo,int pageSize,String name);
    public List<TongxunluPubEntity> selectComp(int compCode);
    public void insertPush();
    public TongxunluPubEntity selectPubtime();
    public List<TongxunluPermissionEntity> selectAllPermission();
    public int deleteAllPermission();
    public int savePermission(TongxunluPermissionEntity entity);
    public boolean selectPermisssionByUserid(int userid);
}
 