package com.cloudrich.ereader.notice.dao;

import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.notice.entity.NoticeReplyEntity;

public interface NoticeReplyDao {
    int deleteByPrimaryKey(Integer id);

    int insert(NoticeReplyEntity record);

    NoticeReplyEntity selectByPrimaryKey(Integer id);

    List<NoticeReplyEntity> selectAll();

    List<NoticeReplyEntity> selectByNoticeId(Integer noticeId);
    
    int updateByPrimaryKey(NoticeReplyEntity record);
    
    List<NoticeReplyEntity> selectNoticeByType(Map<String,Object> map);
    
    List<NoticeReplyEntity> selectNoticeReplyByUseridAndNoticeid(Map<String,Object> map);
}