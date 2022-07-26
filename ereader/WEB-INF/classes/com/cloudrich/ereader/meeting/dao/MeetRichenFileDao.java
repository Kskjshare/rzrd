package com.cloudrich.ereader.meeting.dao;

import java.util.List;

import com.cloudrich.ereader.meeting.entity.MeetRichenFileEntity;

public interface MeetRichenFileDao {
    int deleteByPrimaryKey(Integer id);

    int insert(MeetRichenFileEntity record);

    MeetRichenFileEntity selectByPrimaryKey(Integer id);

    List<MeetRichenFileEntity> selectAll();

    int updateByPrimaryKey(MeetRichenFileEntity record);
    
    
    int deleteRichFileByRichenid(Integer yichenid);
    
    int deleteRichFileByFileid(Integer fileid);
    
    MeetRichenFileEntity selectByRichenFileEntity(MeetRichenFileEntity entity);
    
    /**
     * 根据议程id获取议程file
     * @param yichenid
     * @return
     */
    List<MeetRichenFileEntity> selectByRichenid(Integer richenid);
    
    List<MeetRichenFileEntity> selectRichenFileBymeetid(Integer meetid);
    
    List<MeetRichenFileEntity> selectFilesByRichenid(Integer richenid);
    
    List<MeetRichenFileEntity> selectRichenFileByFileid(Integer fileid);
}