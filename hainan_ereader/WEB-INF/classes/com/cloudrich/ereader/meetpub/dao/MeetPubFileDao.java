package com.cloudrich.ereader.meetpub.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.meeting.entity.MeetFileMainEntity;
import com.cloudrich.ereader.meetpub.entity.MeetPubFileEntity;

public interface MeetPubFileDao {
    int deleteByPrimaryKey(Integer id);

    int insert(MeetPubFileEntity record);

    MeetPubFileEntity selectByPrimaryKey(Integer id);

    List<MeetPubFileEntity> selectAll();

    int updateByPrimaryKey(MeetPubFileEntity record);
    
    //获取最后的版本号
    int selectMeetMaxVersion(int meetid);
    
    List<MeetFileMainEntity> searchPubFileByKeyword(Map<String,Object> map);
    
    List<MeetFileMainEntity> selectAllFileByMeetidAndFileOwn(Map<String,Object> map);
    
    List<MeetFileMainEntity> selectAllFileByMeetidAndFileOwnAndVersion(Map<String,Object> map);
    
    int selectPubFileCountByMeetidAndVersionAndUserid(Map<String,Object> map);
    
    int selectCYFileCountByMeetidAndVersionAndUserid(Map<String,Object> map);
    
    List<MeetFileMainEntity> selectAllFileByMeetidAndFileOwnAndVersionAndUserid(Map<String,Object> map);
    
    int deletePubFileByMeetid(Map<String,Object> map);
    
    MeetPubFileEntity selectFilePubtimeByMeetid(Map<String,Object> map);
    //PAD端获取文件路径
	List<MeetFileMainEntity> selectAllFileByMeetid(HashMap<String, Object> map);
	//PAD端获取日程文件
	List<MeetFileMainEntity> selectRcFileByMeetid(HashMap<String, Object> map);
    
    
}