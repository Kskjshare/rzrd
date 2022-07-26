package com.cloudrich.ereader.meeting.service;

import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.meeting.entity.MeetFileMainEntity;
import com.cloudrich.ereader.meeting.entity.MeetGroupMainEntity;
import com.cloudrich.ereader.meeting.entity.MeetMainEntity;
import com.cloudrich.ereader.meeting.entity.MeetProcessEntity;
import com.cloudrich.ereader.meeting.entity.MeetRichenMainEntity;
import com.cloudrich.ereader.meeting.entity.MeetRichenYitiEntity;
import com.cloudrich.ereader.meeting.entity.MeetYichenMainEntity;
import com.cloudrich.ereader.meetpub.entity.MeetPubGroupEntity;


public interface MeetingService {
   
	    //增加一个会议基本信息
		public void addMeetBasic(MeetMainEntity briefing) throws Exception;
	    
	    //更新一个会议基本信息
		public void updateMeetBasic(MeetMainEntity briefing) throws Exception; 
		
		//删除一个会议
		public void deleteMeet(int id) throws Exception;
		
		//一键生成议程
		public void AutoGeneMeetYichen(String filename,int meetid);
		
		//增加会议议程
		public MeetYichenMainEntity addMeetYichen(MeetYichenMainEntity yichen);
		
		//更新会议议程
		public void updateMeetYichen(MeetYichenMainEntity yichen);
		
		//删除会议
		public void delMeetYichen(int yichenid);
		
		//绑定议程文件
		public void bindYichenFile(int yichenid,String[] fileids);
		
		
		//一键生成日程
		public void AutoGeneMeetRichen(String filename,int meetid);
		
		//增加日程
		public void addRichen(MeetRichenMainEntity richen);
		
		//日程绑定闭幕会文件
		public void bindRichenFile(int richenid,String[] fileids);
		
		//更新日程
		public void updateRichen(MeetRichenMainEntity richen);
		
		//删除日程
		public void deleteRichen(int richenid);
		
		//增加日程议题
		public void addRichenYiti(MeetRichenYitiEntity richyiti);
		
		//更新日程议题
		public void updateRichenYiti(MeetRichenYitiEntity richyiti);
		
		//删除日程议题
		public void deleteRichenYiti(int yitiid);
		//增加会议文件List
		public List<MeetFileMainEntity> addMeetFiles(List<MeetFileMainEntity> list);
		//增加会议文件单个文件
		public MeetFileMainEntity addMeetFile(MeetFileMainEntity meetfile);
		public MeetFileMainEntity addMeetFileHzzrhy(MeetFileMainEntity meetfile);	
		
		//删除会议文件
		public void deleteMeetFile(int fileid);
		
		//自动关联会议文件和议程
		public Map<String,Object> autoRelaMeetFileAndYichen(int meetid);
		
		//根据文件id更新文件类型
		public MeetFileMainEntity updateFileTypeByFileId(MeetFileMainEntity meetfile);
		
		//更新会议分组
		public int upddateMeetGrp(MeetGroupMainEntity grp);
		
		//获取所有的会议分组信息
		public List<MeetGroupMainEntity> getMeetGrp(int meetid);
		
		//获取会议发布的分组信息
		public List<MeetPubGroupEntity> getPubMeetGrp(Map<String,Object> map);
		
		
		//获取当前流程状态
		public MeetProcessEntity getCurMeetProcess(int meetid,String submodulecode);
		
		
		//提交保存发布
		public boolean submitMeetPub(int meetid, String submodule,String noTX);
		
	
		

		public Page selectByPage(int pageNo, int pageSize);
		
		//获取所有类型的当前会议
		public List<MeetMainEntity>  selectAllTypeCurMeeting();
		
		
		//更新排序
		public boolean  updateSort(int id,String filetype,int sort);
		
		//置顶排序
		public boolean  updateSortZD(int id,String filetype,int sort);
		
		//批量删除
		public void deleteMeetFiles(String fileids);
		
		public String deleteBashYitiAndRichen(String ids,String filetypes);
		
		public int selectFileCountByMeetidAndFileOwn(Map<String,Object> map);
		
		public boolean submitFenzuPub(int meetid, String groupno);
		
		public MeetPubGroupEntity selectGroupPubTime(Map<String,Object> map);
		
		public MeetFileMainEntity selecMeetFileByFileid(int fileid);

		public void relativeYichenFile(String[] split, int fileid);
		
		public void relativeRichenFile(int fileid,String[] richenid);
		
		//保存数据
		public void AutoSaveFile(MeetFileMainEntity obj, int meetid);
}
