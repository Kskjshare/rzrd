package com.cloudrich.ereader.chuqueqin.dao;

import com.cloudrich.ereader.chuqueqin.entity.BookMarkerEntity;
import com.cloudrich.ereader.chuqueqin.entity.BookMarkerVO;
import com.cloudrich.ereader.chuqueqin.entity.ChuqueqinMainEntity;

import java.util.List;
import java.util.Map;

public interface ChuqueqinMainDao {
    int deleteByPrimaryKey(Integer absentid);

    int insert(ChuqueqinMainEntity record);

    ChuqueqinMainEntity selectByPrimaryKey(Integer absentid);

    List<ChuqueqinMainEntity> selectAll(Map<String,Object> map);

    int updateByPrimaryKey(ChuqueqinMainEntity record);

	int insertBM(BookMarkerEntity entity);
	
	List<BookMarkerVO> selectBm(Map<String, Object> map);

	List<ChuqueqinMainEntity> selectBookMeeting();
}