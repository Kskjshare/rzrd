package com.cloudrich.ereader.dict.service;


import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.dict.entity.DictDataEntity;
import com.cloudrich.ereader.dict.entity.DictProcessDefEntity;
public interface DictDataService {
	
	public  List<DictDataEntity>  getDictDataByType(String type);
	
	public  List<DictDataEntity>  getDictDataByTypeAndParentcode(String type,String parentcode);
	
	public String getNameByTypeAndcode(String type,String code);
	
	
	/**
	 * 获取当前流程定义
	 * @return
	 */
	public List<DictProcessDefEntity> selectCurProcessDef(String proccode,String curstate);
	
	
	
	/**
	 * 获取下一个流程定义
	 * @param map
	 * @return
	 */
	public DictProcessDefEntity selectNextProcessDef(String proccode,String curstate,String action);
	
	
	/**
	 * 根据字典类型分页
	 * @return
	 */
	public Page selectByPage(int pageNo, int pageSize, final Map<String, Object> map) ;
	
	
	public List<DictDataEntity> getAllDictDataType();
	
	public int insert(DictDataEntity entity);
	
	public int updateByPrimaryKey(DictDataEntity entity);
	
	public DictDataEntity getDictDataById(int id);
	
	public DictDataEntity getDictByTypeAndcode(String type,String code);

}
