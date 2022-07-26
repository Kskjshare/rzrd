package com.cloudrich.ereader.briefing.service;


import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import com.cloudrich.ereader.briefing.dao.MeetBriefingSendscopeDao;
import com.cloudrich.ereader.briefing.entity.MeetBriefingSendscopeEntity;
import com.cloudrich.ereader.system.entity.SysUserMainEnity;

@Service("BriefingSendscopeServiceImpl")
public class BriefingSendscopeServiceImpl  implements BriefingSendscopeService{
	
	private static final long serialVersionUID = 1L;

	@Resource MeetBriefingSendscopeDao briefingSendDao;
	
	@Override
	public int delete(int briefid){
		int i=briefingSendDao.deleteByPrimaryKey(briefid);
		return i;
		
	}

	@Override
	public MeetBriefingSendscopeEntity selectBriefingById(int briefid) {
		return briefingSendDao.selectByPrimaryKey(briefid);
	}

     
	@Override
	 public int insert(MeetBriefingSendscopeEntity briefing){
		 int i=briefingSendDao.insert(briefing);
		 return i;
		 
	 }
	 
	@Override
	 public int update(MeetBriefingSendscopeEntity briefing){
		 int i=briefingSendDao.updateByPrimaryKey(briefing);
		 return i;
	 }

	@Override
	public List<MeetBriefingSendscopeEntity> selectByBriefid(int id) {
		List<MeetBriefingSendscopeEntity> list=new ArrayList<MeetBriefingSendscopeEntity>();
		list=briefingSendDao.selectByBriefid(id);
		return list;
	}

	@Override
	public int deleteByBriefid(int briefid) {
		int i=briefingSendDao.deleteByBrifeid(briefid);
		return 0;
	}
	
	@Override
	public List<SysUserMainEnity> selectScopeUserByBriefId(int briefid){
		return briefingSendDao.selectScopeUserByBriefId(briefid);
	}

}
