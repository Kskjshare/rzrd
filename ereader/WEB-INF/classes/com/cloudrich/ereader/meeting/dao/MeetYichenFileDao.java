package com.cloudrich.ereader.meeting.dao;

import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.meeting.entity.MeetYichenFileEntity;

public interface MeetYichenFileDao {
    int deleteByPrimaryKey(Integer id);

    int insert(MeetYichenFileEntity record);

    MeetYichenFileEntity selectByPrimaryKey(Integer id);

    List<MeetYichenFileEntity> selectAll();

    int updateByPrimaryKey(MeetYichenFileEntity record);
    
    
    int deleteYichFileByYichenid(Integer yichenid);
    
    int deleteYichFileByFileid(Integer fileid);
    
    MeetYichenFileEntity selectByYichenFileEntity(MeetYichenFileEntity entity);
    
    /**
     * 根据议程id获取议程file
     * @param yichenid
     * @return
     */
    List<MeetYichenFileEntity> selectByYichenid(Integer yichenid);
    
    List<MeetYichenFileEntity> selectYichenFileBymeetid(Integer meetid);
    
    List<MeetYichenFileEntity> selectYichenFileByFileidAndYichenid(Map<String,Object> map);
    
}