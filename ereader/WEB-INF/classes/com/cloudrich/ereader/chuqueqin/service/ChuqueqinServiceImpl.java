package com.cloudrich.ereader.chuqueqin.service;


import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cloudrich.ereader.chuqueqin.dao.ChuqueqinMainDao;
import com.cloudrich.ereader.chuqueqin.dao.ChuqueqinPubDao;
import com.cloudrich.ereader.chuqueqin.entity.BookMarkerEntity;
import com.cloudrich.ereader.chuqueqin.entity.ChuqueqinMainEntity;
import com.cloudrich.ereader.chuqueqin.entity.ChuqueqinPubEntity;
import com.cloudrich.ereader.common.dao.PageHelper;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.common.dao.PageHelper.PageCall;

@Service("ChuqueqinServiceImpl")
public class ChuqueqinServiceImpl  implements ChuqueqinService {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Resource ChuqueqinMainDao chuqueqinMainDao;
	@Resource ChuqueqinPubDao chuqueqinPubDao;
	
	@Override
	public int delete(int id){
		int i=chuqueqinMainDao.deleteByPrimaryKey(id);
		chuqueqinPubDao.deleteByAbsentid(id);
		return i;
		
	}

	@Override
	public ChuqueqinMainEntity selectEntityById(int id) {
		return chuqueqinMainDao.selectByPrimaryKey(id);
	}

	@Override
	public List<ChuqueqinMainEntity> selectAll(Map<String, Object> map) {
			List<ChuqueqinMainEntity> list = chuqueqinMainDao.selectAll(map);
			return list;
		
	}

	 public int insert(ChuqueqinMainEntity entiry){
		 int i=chuqueqinMainDao.insert(entiry);
		 return i;
		 
	 }
	   
	 public int update(ChuqueqinMainEntity entiry){
		 int i=chuqueqinMainDao.updateByPrimaryKey(entiry);
		 return i;
	 }
		@Override
		public Page selectByPage(int pageNo, int pageSize,final Map<String, Object> map) {
			return PageHelper.pagedQuery(new PageCall() {
				@Override
				public void executeQuery() {
					System.out.println("map:" + map);
					chuqueqinMainDao.selectAll(map);
				}
			}, pageNo, pageSize);
		}

		@Override
		public int insertAndPush(ChuqueqinMainEntity briefing) {
				chuqueqinPubDao.deleteByAbsentid(briefing.getAbsentid());
				ChuqueqinPubEntity pubentity=new ChuqueqinPubEntity();
					pubentity.setAbsentid(briefing.getAbsentid());
					pubentity.setFilename(briefing.getFilename());
					pubentity.setIsdel(0);
					pubentity.setPath(briefing.getPath());
					pubentity.setPubtime(new Date());
					pubentity.setTitle(briefing.getTitle());
					pubentity.setPubuserid(briefing.getPubuserid());
					pubentity.setFileguid(briefing.getFileguid());
				int i=chuqueqinPubDao.insert(pubentity);	
				return i;
		}
		
		@Override
		public ChuqueqinPubEntity selectLatestPubtime(int absentid) {	
			return chuqueqinPubDao.selectLatestPubtime(absentid);	
		}

		@Override
		public List<ChuqueqinMainEntity> selectAllPub(Map<String, Object> map) {
			return chuqueqinPubDao.selectAll(map);
		}

		@Override
		public int insertBM(BookMarkerEntity entity) {
			 int i=chuqueqinMainDao.insertBM(entity);
			 return i;
		}

		@Override
		public Page selectBm(int pageNo, int pageSize, final Map<String, Object> map) {
			return PageHelper.pagedQuery(new PageCall() {
				@Override
				public void executeQuery() {
					System.out.println("map:" + map);
					chuqueqinMainDao.selectBm(map);
				}
			}, pageNo, pageSize);
		}

		@Override
		public List<ChuqueqinMainEntity> selectBookMeeting() {
			return chuqueqinMainDao.selectBookMeeting();
		}
}
