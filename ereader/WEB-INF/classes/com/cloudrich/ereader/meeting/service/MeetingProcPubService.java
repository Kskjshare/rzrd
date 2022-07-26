package com.cloudrich.ereader.meeting.service;

import java.util.List;


public interface MeetingProcPubService {
	
	//常委会发布议程
	public void pubMeetYichen(int meetid);
	
	//常委会发布日程
	public void pubMeetRichen(int meetid);
	
	//常委会发布文件
	public void pubMeetFiles(int meetid,String fileown);
	
	
	//更改流程当前状态，从已发布到已发布有变更
	public void chgMeetProcState(String submodule,int meetid);
	
	//获取当前常委会发布的版本号
	public int getPubYichenMaxVersion(int meetid);
	
	public int selectPubFileCountByMeetid(int meetid,int version);
	
	//常委会分组发布
	public void pubMeetGroup(int meetid,String groupno);

}
