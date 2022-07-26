package com.cloudrich.ereader.groupmember.dao;


import com.cloudrich.ereader.groupmember.entity.GroupmemberMainEntity;
import com.cloudrich.ereader.groupmember.entity.GroupmemberSortEntity;

import java.util.ArrayList;
import java.util.List;

public interface GroupmemberMainDao {
    int deleteByPrimaryKey(Integer memberid);

    int insert(GroupmemberMainEntity record);

    GroupmemberMainEntity selectByPrimaryKey(Integer memberid);

    List<GroupmemberMainEntity> selectAll(GroupmemberMainEntity entity);

    int updateByPrimaryKey(GroupmemberMainEntity record);
   
    List<GroupmemberMainEntity> selectGroup(Integer groupcode);
    
    int updateSort(ArrayList<GroupmemberSortEntity> list);
}