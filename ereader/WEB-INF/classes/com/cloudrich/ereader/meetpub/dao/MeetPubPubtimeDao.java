package com.cloudrich.ereader.meetpub.dao;


import java.util.Map;

import com.cloudrich.ereader.meetpub.entity.MeetPubPubtimeEntity;

public interface MeetPubPubtimeDao {
	
	int insert (MeetPubPubtimeEntity entity);
	
	int deleteByModuleidAndMtype (Map<String,Object> map);
	
	int updateByModuleidAndMtype (MeetPubPubtimeEntity entity);
	
	MeetPubPubtimeEntity selectByModuleidAndMtype (Map<String,Object> map);
}