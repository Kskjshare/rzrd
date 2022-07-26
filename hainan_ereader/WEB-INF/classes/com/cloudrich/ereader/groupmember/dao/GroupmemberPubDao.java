package com.cloudrich.ereader.groupmember.dao;


import com.cloudrich.ereader.groupmember.entity.GroupmemberMainEntity;
import com.cloudrich.ereader.groupmember.entity.GroupmemberPubEntity;
import com.cloudrich.ereader.groupmember.entity.GroupmemberSortEntity;

import java.util.ArrayList;
import java.util.List;

public interface GroupmemberPubDao {
    int deleteByPrimaryKey(Integer memberid);

    int insert(GroupmemberPubEntity record);

    GroupmemberPubEntity selectByPrimaryKey(Integer memberid);

    List<GroupmemberMainEntity> selectAll(GroupmemberPubEntity entity);

    int updateByPrimaryKey(GroupmemberPubEntity record);
   
    List<GroupmemberPubEntity> selectGroup(Integer groupcode);
        
    GroupmemberPubEntity selectLatestPubtime();
    
    int deleteAll();
    
   
}