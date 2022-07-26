package com.cloudrich.ereader.dict.dao;

import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.dict.entity.DictDataEntity;



public interface DictDataDao {
	
	//根据类型数据数据字典
	 public List<DictDataEntity> getDictDataByType(String type);
	 
	 //根据类型和父parentcode获取数据字典
	 public List<DictDataEntity> getDictDataByTypeAndParent(String type,String parentcode);
	 
	 //根据Type和Code获取数据字典信息
	 DictDataEntity getNameByTypeAndCode (String type,String code);
	 
	//获取所有数据字典
	  List<DictDataEntity> getAllDictData(Map<String,Object> map);
	 
	//获取所有类型
	  List<DictDataEntity> getAllDictDataType();
	  
	  int insert(DictDataEntity record);
	  
	  int updateByPrimaryKey(DictDataEntity record);
	  
	  DictDataEntity getDictDataById(int id);
}