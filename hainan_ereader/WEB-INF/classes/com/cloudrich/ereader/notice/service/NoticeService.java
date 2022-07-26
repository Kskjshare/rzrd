package com.cloudrich.ereader.notice.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.notice.entity.NoticeMainEntity;
import com.cloudrich.ereader.notice.entity.NoticePubEntity;
import com.cloudrich.ereader.notice.entity.NoticeReplyEntity;
import com.cloudrich.ereader.system.entity.SysScopeMainEntity;

public interface NoticeService {
	NoticeMainEntity selectEntityById(int briefid);

	List<NoticeMainEntity> selectAll();

	Page selectByPage(int pageNo, int pageSize, HashMap<String, Object> params);

	int insert(NoticeMainEntity briefing);

	int update(NoticeMainEntity briefing);

	int delete(int id);

	public void addNoticeReply(NoticeReplyEntity reply);

	public List<NoticeReplyEntity> selectReplys(int noticeId);
	
	public List<NoticeReplyEntity> selectReplysByType(Map<String,Object> map);
	/**
	 * 查询列表
	 * 
	 * @param pageNo 当前页号
	 * @param pageSize 页面大小
	 * @return
	 */
	public Page selectReplysPaged(int pageNo,int pageSize);
	
	
	//返回通知数量
	public int getNoticeCount();
	
	public List<NoticePubEntity> searchNoticeByKeyword(String keyword,int userid);
	
	public NoticeMainEntity  selectNoticeByFilename(String filename);
	
	
	//根据推送范围获取通知列表
	List<NoticePubEntity> selectAllNoticeByUserid(int userid);
	
	//根据推送范围获取通知数量
	int getNoticeCount(int userid);
	
	//获取用户已读通知数量
	int getYdNoticeCount(int userid);
	
	//插入
	int insertYdNotice(int userid,int noticeid);
	
	//发布通知
	int insertPush(NoticeMainEntity briefing,String actiontype);
	
	//根据通知id获取
	NoticePubEntity selectPubByNoticeid(int id);
	//获取历史通知
	List<NoticeMainEntity> selectHistory();
		
}
