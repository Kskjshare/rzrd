package com.cloudrich.ereader.chuqueqin.dao;

import com.cloudrich.ereader.chuqueqin.entity.ChuqueqinMainEntity;
import com.cloudrich.ereader.chuqueqin.entity.ChuqueqinPubEntity;

import java.util.List;
import java.util.Map;

public interface ChuqueqinPubDao {
	
    int deleteByAbsentid(Integer absentid);

    int insert(ChuqueqinPubEntity record);

    ChuqueqinPubEntity selectByAbsentid(Integer absentid);

    List<ChuqueqinMainEntity> selectAll(Map<String,Object> map);

    int updateByAbsentid(ChuqueqinPubEntity record);
    
    ChuqueqinPubEntity selectLatestPubtime(int absentid);
    
    int  deleteAll();
    
    List<ChuqueqinPubEntity> selectAllAbsent();
}