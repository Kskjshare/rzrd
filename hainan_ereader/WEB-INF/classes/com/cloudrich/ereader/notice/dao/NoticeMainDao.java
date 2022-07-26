package com.cloudrich.ereader.notice.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.notice.entity.NoticeMainEntity;

public interface NoticeMainDao {
    int deleteByPrimaryKey(Integer noticeid);

    
    int insert(NoticeMainEntity record);

    NoticeMainEntity selectByPrimaryKey(Integer noticeid);

    List<NoticeMainEntity> selectAll(HashMap<String, Object> params);
    // 获取所有通知（包括已删除）
    List<NoticeMainEntity> selectHistory();
    
    int updateByPrimaryKey(NoticeMainEntity record);
    
    int selectNoticeCount();
    
    List<NoticeMainEntity> searchNoticeByKeyword(Map<String,Object> map);
    
    List<NoticeMainEntity> selectNoticeByFilename(String filename);
    
    List<NoticeMainEntity> selectAllNoticeByUserid(int userid);
    
     int selectNoticeCountByUserid(int userid);
    
    
}