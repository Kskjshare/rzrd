package com.cloudrich.ereader.notice.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.notice.entity.NoticeMainEntity;
import com.cloudrich.ereader.notice.entity.NoticePubEntity;

public interface NoticePubDao {
    int deleteByPrimaryKey(Integer noticeid);

    
    int insert(NoticePubEntity record);

    NoticePubEntity selectByPrimaryKey(Integer noticeid);

    List<NoticePubEntity> selectAll(HashMap<String, Object> params);
    
    int updateByPrimaryKey(NoticePubEntity record);
    
    int selectNoticeCount();
        
    List<NoticePubEntity> selectNoticeByFilename(String filename);
    
    List<NoticePubEntity> selectAllNoticeByUserid(int userid);
    
     int selectNoticeCountByUserid(int userid);
     
     List<NoticePubEntity> searchNoticeByKeyword(Map<String,Object> map);
     
     int selectYdNoticeCountByUserid(int userid);
     
     int insertYdNotice(java.util.Map<String,Object> map);
     
     int selectYdNotice(java.util.Map<String,Object> map);
     
     List<NoticePubEntity> selectAllNotice();

    
    
}