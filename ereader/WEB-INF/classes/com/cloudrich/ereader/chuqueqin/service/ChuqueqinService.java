package com.cloudrich.ereader.chuqueqin.service;


import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.chuqueqin.entity.BookMarkerEntity;
import com.cloudrich.ereader.chuqueqin.entity.ChuqueqinMainEntity;
import com.cloudrich.ereader.chuqueqin.entity.ChuqueqinPubEntity;
import com.cloudrich.ereader.common.dao.PageHelper.Page;

public interface ChuqueqinService {
	
	ChuqueqinMainEntity selectEntityById(int briefid);
	
	List<ChuqueqinMainEntity> selectAll(Map<String, Object> map);
	
    int insert(ChuqueqinMainEntity briefing);
    
    int update(ChuqueqinMainEntity briefing);
    
    int delete(int id);
    
    public Page selectByPage(int pageNo, int pageSize,Map<String, Object> map) ;
    
    //出缺勤文件发布
    public int  insertAndPush(ChuqueqinMainEntity briefing);
    
    //获取最后的发布时间
    public ChuqueqinPubEntity selectLatestPubtime(int absentid);
   
	List<ChuqueqinMainEntity> selectAllPub(Map<String, Object> map);
	
	int insertBM(BookMarkerEntity entity);
	
	Page selectBm(int pageNo, int pageSize, Map<String, Object> map);

	List<ChuqueqinMainEntity> selectBookMeeting();

}
