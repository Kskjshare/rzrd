package com.cloudrich.ereader.dict.dao;

import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.dict.entity.DictProcessDefEntity;

public interface DictProcessDefDao {
    int deleteByPrimaryKey(Integer id);

    int insert(DictProcessDefEntity record);

    DictProcessDefEntity selectByPrimaryKey(Integer id);

    List<DictProcessDefEntity> selectAll();

    int updateByPrimaryKey(DictProcessDefEntity record);
   /**
    * 获取当前流程定义
    * @param map
    * @return
    */
    List<DictProcessDefEntity> selectCurProcessDef(Map<String,Object> map);
    
    /**
     * 获取下一个流程状态
     * @param map
     * @return
     */
    DictProcessDefEntity selectNextProcessState(Map<String,Object> map);
}