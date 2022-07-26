package com.cloudrich.ereader.meeting.service;

public interface FileMd5ToolService {
	
	boolean updatePubFileMd5(String uploadpath);
	
   public boolean updateBriefFileMd5(String uploadpath);
   
   public boolean updateGroupFileMd5(String uploadpath);
   
   public boolean updateNoticeFileMd5(String uploadpath);
   
   public boolean updateChuqueFileMd5(String uploadpath);
   
   public boolean updateZiliaokuFileMd5(String uploadpath);
   
   public boolean updateHelpFileMd5(String uploadpath);

}
