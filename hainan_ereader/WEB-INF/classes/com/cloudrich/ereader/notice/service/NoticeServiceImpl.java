package com.cloudrich.ereader.notice.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cloudrich.ereader.common.dao.PageHelper;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.common.dao.PageHelper.PageCall;
import com.cloudrich.ereader.notice.dao.NoticeMainDao;
import com.cloudrich.ereader.notice.dao.NoticePubDao;
import com.cloudrich.ereader.notice.dao.NoticeReplyDao;
import com.cloudrich.ereader.notice.dao.NoticeSendscopeDao;
import com.cloudrich.ereader.notice.entity.NoticeMainEntity;
import com.cloudrich.ereader.notice.entity.NoticePubEntity;
import com.cloudrich.ereader.notice.entity.NoticeReplyEntity;
import com.cloudrich.ereader.notice.entity.NoticeSendscopeEntity;
import com.cloudrich.ereader.remind.service.RemindService;
import com.cloudrich.ereader.system.entity.SysScopeMainEntity;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Resource
	NoticeMainDao noticeMainDao;
	@Resource
	NoticeSendscopeDao sendscopeDao;
	@Resource
	private NoticeReplyDao noticeReplyDao;	
	@Resource
	private RemindService remindService;
	@Resource
	private NoticePubDao noticePubDao;

	@Override
	public int delete(int id) {
		int i = noticeMainDao.deleteByPrimaryKey(id);
		noticePubDao.deleteByPrimaryKey(id);
		//处理通知提醒
		  try{
				remindService.NoticeRemindHandler("delete",null,id);
			}catch(Exception e){
				e.printStackTrace();
			}
		return i;
	}

	@Override
	public NoticeMainEntity selectEntityById(int id) {
		NoticeMainEntity mainEntity = noticeMainDao.selectByPrimaryKey(id);
		List<Integer> scopeIds = new ArrayList<Integer>();
		List<NoticeSendscopeEntity> entities = sendscopeDao
				.selectByNoticeId(id);
		if (entities != null && entities.size() > 0) {
			for (NoticeSendscopeEntity noticeSendscopeEntity : entities) {
				scopeIds.add(noticeSendscopeEntity.getScopeid());
			}
		}
		return mainEntity;
	}

	@Override
	public List<NoticeMainEntity> selectAll() {
		HashMap<String, Object> params = new HashMap<String, Object>();
		List<NoticeMainEntity> list = noticeMainDao.selectAll(params);
		return list;

	}

	public int insert(NoticeMainEntity entiry) {
		int i = noticeMainDao.insert(entiry);
		List<Integer> scopes = entiry.getScopeIds();
		if (scopes != null) {
			for (Integer scopeId : scopes) {
				NoticeSendscopeEntity sendscopeEntity = new NoticeSendscopeEntity();
				sendscopeEntity.setNoticeid(entiry.getNoticeid());
				sendscopeEntity.setScopeid(scopeId);
				sendscopeDao.insert(sendscopeEntity);
			}
		}
			
		return i;
	}

	public int update(NoticeMainEntity entiry) {
		int i = noticeMainDao.updateByPrimaryKey(entiry);
		sendscopeDao.deleteByPrimaryKey(entiry.getNoticeid());
		List<Integer> scopes = entiry.getScopeIds();
		if (scopes != null) {
			for (Integer scopeId : scopes) {
				NoticeSendscopeEntity sendscopeEntity = new NoticeSendscopeEntity();
				sendscopeEntity.setNoticeid(entiry.getNoticeid());
				sendscopeEntity.setScopeid(scopeId);
				sendscopeDao.insert(sendscopeEntity);
			}
		}
		return i;
	}

	@Override
	public Page selectByPage(int pageNo, int pageSize,
			final HashMap<String, Object> map) {
		return PageHelper.pagedQuery(new PageCall() {
			@Override
			public void executeQuery() {
				noticeMainDao.selectAll(map);
			}
		}, pageNo,pageSize);
	}

	@Override
	public void addNoticeReply(NoticeReplyEntity reply) {
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("userid", reply.getUserid());
		map.put("noticeid", reply.getNoticeid());
		List<NoticeReplyEntity> existlist=new ArrayList<NoticeReplyEntity>();
		
		try{
			existlist=noticeReplyDao.selectNoticeReplyByUseridAndNoticeid(map);
			System.out.println("-------"+existlist.size());
		}catch(Exception e){
			//existlist=null;
			e.printStackTrace();
		}
		if(existlist.size()>0){
			System.out.println("--update");
			System.out.println("userid:"+existlist.get(0).getUserid());
			System.out.println("noticeid:"+existlist.get(0).getNoticeid());
			System.out.println("replycode:"+existlist.get(0).getNoticereplycode());
			System.out.println("id:"+existlist.get(0).getId());
			
			reply.setId(existlist.get(0).getId());
			
			noticeReplyDao.updateByPrimaryKey(reply);
		}else{
			System.out.println("-----insert");
			System.out.println("userid:"+reply.getUserid());
			System.out.println("noticeid:"+reply.getNoticeid());
			System.out.println("replycode:"+reply.getNoticereplycode());
			System.out.println("id:"+reply.getId());
			noticeReplyDao.insert(reply);
		}
		
		
	}

	@Override
	public List<NoticeReplyEntity> selectReplys(int noticeId) {
		return noticeReplyDao.selectByNoticeId(noticeId);
	}
	
	@Override
	public List<NoticeReplyEntity> selectReplysByType(Map<String,Object> map) {
		return  noticeReplyDao.selectNoticeByType(map);
	}
	

	@Override
	public Page selectReplysPaged(int pageNo, int pageSize) {
		return PageHelper.pagedQuery(new PageCall() {
			@Override
			public void executeQuery() {
				noticeReplyDao.selectAll();
			}
		}, pageNo, pageSize);
	}
	
	
	@Override
	public int getNoticeCount(){
		return noticeMainDao.selectNoticeCount();
		
	}
	
	@Override
	public List<NoticePubEntity> searchNoticeByKeyword(String keyword,int userid){
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("title", keyword);
		map.put("userid", userid);
		return noticePubDao.searchNoticeByKeyword(map);
	}
	
	@Override
	public NoticeMainEntity  selectNoticeByFilename(String filename){
		List<NoticeMainEntity> list=noticeMainDao.selectNoticeByFilename(filename);
		if(list!=null&&list.size()!=0){
			return list.get(0);
		}
		return null;
		
	}
	
	
	//根据推送范围获取通知列表
	@Override
	public	List<NoticePubEntity> selectAllNoticeByUserid(int userid){
		
		List<NoticePubEntity> list = noticePubDao.selectAllNoticeByUserid(userid);
		return list;
		}
	
	//根据推送范围获取通知数量
	@Override
	public int getNoticeCount(int userid){
		int count=0;
		try{
			count=noticePubDao.selectNoticeCountByUserid(userid);
		}catch(Exception e){
			//e.printStackTrace();
			count=0;
		}
		return count;
	}
	
	
	//获取用户已读通知数量
		@Override
		public int getYdNoticeCount(int userid){
			int count=0;
			try{
				count=noticePubDao.selectYdNoticeCountByUserid(userid);
			}catch(Exception e){
				//e.printStackTrace();
				count=0;
			}
			return count;
		}
		
		//插入用户已读通知
		@Override
		public int insertYdNotice(int userid,int noticeid){
			int ydnoticeid=0;
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("userid", userid);
			map.put("noticeid", noticeid);
			try{
				ydnoticeid=noticePubDao.selectYdNotice(map);
			}catch(Exception e){
				//e.printStackTrace();
				ydnoticeid=0;
			}
			if(ydnoticeid==0){
				noticePubDao.insertYdNotice(map);
			}
			
			return 1;
		}

	@Override
	public int insertPush(NoticeMainEntity notice,String actiontype) {
		noticePubDao.deleteByPrimaryKey(notice.getNoticeid());
		notice=noticeMainDao.selectByPrimaryKey(notice.getNoticeid());
		NoticePubEntity pubenetity=new NoticePubEntity();
			pubenetity.setFilename(notice.getFilename());
			pubenetity.setIsdel(0);
			pubenetity.setNoticeid(notice.getNoticeid());
			pubenetity.setPath(notice.getPath());
			pubenetity.setPhonenums(notice.getPhonenums());
			pubenetity.setPubtime(new Date());
			pubenetity.setPubuserid(notice.getPubuserid());
			pubenetity.setScopeIds(notice.getScopeIds());
			pubenetity.setScopenames(notice.getScopenames());
			pubenetity.setSendtime(notice.getSendtime());
			pubenetity.setSendtype(notice.getSendtype());
			pubenetity.setSendway(notice.getSendway());
			pubenetity.setTitle(notice.getTitle());
			pubenetity.setFileguid(notice.getFileguid());
		int i=noticePubDao.insert(pubenetity);
		
   		//处理通知提醒
		  try{
				remindService.NoticeRemindHandler(actiontype,notice,0);
			}catch(Exception e){
				e.printStackTrace();
			}
		return i;
	}

	@Override
	public NoticePubEntity selectPubByNoticeid(int id) {

		return noticePubDao.selectByPrimaryKey(id);
	}

	@Override
	public List<NoticeMainEntity> selectHistory() {
		// TODO Auto-generated method stub
		return noticeMainDao.selectHistory();
	}

	
}
