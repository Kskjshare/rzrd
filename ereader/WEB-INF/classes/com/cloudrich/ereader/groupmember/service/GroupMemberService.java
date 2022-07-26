package com.cloudrich.ereader.groupmember.service;

import java.util.ArrayList;
import java.util.List;

import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.groupmember.entity.GroupmemberMainEntity;
import com.cloudrich.ereader.groupmember.entity.GroupmemberPubEntity;
import com.cloudrich.ereader.groupmember.entity.GroupmemberSortEntity;

public interface GroupMemberService {
    
	GroupmemberMainEntity selectEntityById(int briefid);
    int insert(GroupmemberMainEntity entity);
    int update(GroupmemberMainEntity entity); 
    int delete(int id);
    List<GroupmemberMainEntity> selectGroup(int groupcode);
    Page selectByPage(int pageNo,int pageSize,GroupmemberMainEntity entity);
    //获取所有
    List<GroupmemberMainEntity> selectAllMember();
    /**
     * 根据id更新sort
     */
    int updateSort(ArrayList<GroupmemberSortEntity> sortList);
    
    void insertAndPush();
    
    GroupmemberPubEntity selectPubtime();
    
    List<GroupmemberMainEntity> selectAllMemberPub();
}
