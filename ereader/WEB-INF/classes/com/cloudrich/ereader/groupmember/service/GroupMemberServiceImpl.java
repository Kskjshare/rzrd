package com.cloudrich.ereader.groupmember.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cloudrich.ereader.common.dao.PageHelper;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.common.dao.PageHelper.PageCall;
import com.cloudrich.ereader.groupmember.dao.GroupmemberMainDao;
import com.cloudrich.ereader.groupmember.dao.GroupmemberPubDao;
import com.cloudrich.ereader.groupmember.entity.GroupmemberMainEntity;
import com.cloudrich.ereader.groupmember.entity.GroupmemberPubEntity;
import com.cloudrich.ereader.groupmember.entity.GroupmemberSortEntity;

@Service("GroupMemberServiceImpl")
public class GroupMemberServiceImpl  implements GroupMemberService{

	@Resource GroupmemberMainDao groupmemberMainDao;
	@Resource GroupmemberPubDao groupmemberPubDao;
	
	@Override
	public int delete(int id){
		int i=groupmemberMainDao.deleteByPrimaryKey(id);
		return i;
		
	}

	@Override
	public GroupmemberMainEntity selectEntityById(int id) {
		return groupmemberMainDao.selectByPrimaryKey(id);
	}

	 public int insert(GroupmemberMainEntity entiry){
		 int i=groupmemberMainDao.insert(entiry);
		 return i;
		 
	 }
	   
	 public int update(GroupmemberMainEntity entiry){
		 int i=groupmemberMainDao.updateByPrimaryKey(entiry);
		 return i;
	 }

	@Override
	public List<GroupmemberMainEntity> selectGroup(int groupcode) {
		return groupmemberMainDao.selectGroup(groupcode);
	}

	@Override
	public Page selectByPage(int pageNo, int pageSize,final GroupmemberMainEntity entity) {
		return PageHelper.pagedQuery(new PageCall() {
			@Override
			public void executeQuery() {
				groupmemberMainDao.selectAll(entity);
			}
		}, pageNo, pageSize);
	}

	@Override
	public List<GroupmemberMainEntity> selectAllMember(){
		GroupmemberMainEntity entity=new GroupmemberMainEntity();
		entity.setGroupcode(0);
		entity.setMembertype(0);
		entity.setTruename(null);
		return groupmemberMainDao.selectAll(entity);
	}
	@Override
	public List<GroupmemberMainEntity> selectAllMemberPub(){
		GroupmemberPubEntity entity=new GroupmemberPubEntity();
		entity.setGroupcode(0);
		entity.setMembertype(0);
		entity.setTruename(null);
		return groupmemberPubDao.selectAll(entity);
	}

	@Override
	public int updateSort(ArrayList<GroupmemberSortEntity> sortList) {
		return groupmemberMainDao.updateSort(sortList);
	}

	@Override
	public void insertAndPush() {
		GroupmemberMainEntity entity=new GroupmemberMainEntity();
		entity.setGroupcode(0);
		entity.setMembertype(0);
		entity.setTruename(null);
		List<GroupmemberMainEntity> list=groupmemberMainDao.selectAll(entity);
		if(list==null||list.size()==0){
			groupmemberPubDao.deleteAll();
		}else{
			groupmemberPubDao.deleteAll();
			for (int i = 0; i < list.size(); i++) {
				GroupmemberMainEntity grpentity=list.get(i);
				groupmemberPubDao.deleteByPrimaryKey(grpentity.getMemberid());
				GroupmemberPubEntity pubentity=new GroupmemberPubEntity();
				pubentity.setAddress(grpentity.getAddress());
				pubentity.setGroupcode(grpentity.getGroupcode());
				pubentity.setIsdel(grpentity.getIsdel());
				pubentity.setMemberid(grpentity.getMemberid());
				pubentity.setMembertype(grpentity.getMembertype());
				pubentity.setMishuname(grpentity.getMishuname());
				pubentity.setMishuphone(grpentity.getMishuphone());
				pubentity.setNote(grpentity.getNote());
				pubentity.setPhone(grpentity.getPhone());
				pubentity.setPost(grpentity.getPost());
				pubentity.setSort(grpentity.getSort());
				pubentity.setTel(grpentity.getTel());
				pubentity.setTruename(grpentity.getTruename());
							
				groupmemberPubDao.insert(pubentity);	
			}
			
		}
		
	}

	@Override
	public GroupmemberPubEntity selectPubtime() {
		
		return groupmemberPubDao.selectLatestPubtime();
	}
}
