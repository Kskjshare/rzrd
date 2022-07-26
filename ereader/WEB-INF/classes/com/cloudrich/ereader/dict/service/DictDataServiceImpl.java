package com.cloudrich.ereader.dict.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cloudrich.ereader.common.dao.PageHelper;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.common.dao.PageHelper.PageCall;
import com.cloudrich.ereader.dict.dao.DictDataDao;
import com.cloudrich.ereader.dict.dao.DictProcessDefDao;
import com.cloudrich.ereader.dict.entity.DictDataEntity;
import com.cloudrich.ereader.dict.entity.DictProcessDefEntity;



@Service("DictDataServiceImpl")
public class DictDataServiceImpl implements DictDataService {
    
	@Resource DictDataDao dictDataDao; 
	@Resource DictProcessDefDao dictProcessDefDao; 
	
		
		
		@Override
		public List<DictDataEntity> getDictDataByType(String type) {
			
			return dictDataDao.getDictDataByType(type);
		}

		@Override
		public List<DictDataEntity> getDictDataByTypeAndParentcode(String type,String parentcode) {
			
			return dictDataDao.getDictDataByTypeAndParent(type,parentcode);
		}
		
		
		@Override
		public String getNameByTypeAndcode(String type,String code) {
			
			return dictDataDao.getNameByTypeAndCode(type, code).getName();
		}
		
		/**
		 * 获取子流程定义
		 * @return
		 */
		@Override
		public List<DictProcessDefEntity> selectCurProcessDef(String proccode,String curstate){
			Map<String,Object> map=new java.util.HashMap<String, Object>();
			map.put("proccode", proccode);
			map.put("curstate", curstate);
			return dictProcessDefDao.selectCurProcessDef(map);
			
		}
		
	   
		public DictProcessDefEntity selectNextProcessDef(String proccode,String curstate,String action){
			Map<String,Object> map=new java.util.HashMap<String, Object>();
			map.put("proccode", proccode);
			map.put("curstate", curstate);
			map.put("action", action);
			return dictProcessDefDao.selectNextProcessState(map);
		}
		
		@Override
		public Page selectByPage(int pageNo, int pageSize,final Map<String, Object> map) {
			return PageHelper.pagedQuery(new PageCall() {
				@Override
				public void executeQuery() {
					dictDataDao.getAllDictData(map);
				}
			}, pageNo, pageSize);
		}
		
		@Override
		public List<DictDataEntity> getAllDictDataType() {
			
			return dictDataDao.getAllDictDataType();
		}

		@Override
		public int insert(DictDataEntity entity) {
			int i=dictDataDao.insert(entity);
			return i;
		}

		@Override
		public int updateByPrimaryKey(DictDataEntity entity) {
			int i=dictDataDao.updateByPrimaryKey(entity);
			entity=new DictDataEntity();
			return i;
		}

		@Override
		public DictDataEntity getDictDataById(int id) {
			DictDataEntity entity= dictDataDao.getDictDataById(id);
			return entity;
		}
		
		@Override
		public DictDataEntity getDictByTypeAndcode(String type,String code) {
			
			return dictDataDao.getNameByTypeAndCode(type, code);
		}
		
}
