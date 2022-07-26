package com.cloudrich.ereader.meeting.entity;

import java.io.Serializable;
import java.util.Calendar;
import java.util.Date;

public class MeetFileRemindEntity implements Serializable {

	
	private int meetid;
	private String mtype;
	private String moduleid;
	private int filecount;
	private String fileown;
	private Date uploaddate;
	private int version;
	
	private int fileid;
	private String filetitle;
	
	
	public int getFileid() {
		return fileid;
	}
	public void setFileid(int fileid) {
		this.fileid = fileid;
	}
	public String getFiletitle() {
		return filetitle;
	}
	public void setFiletitle(String filetitle) {
		this.filetitle = filetitle;
	}
	public int getVersion() {
		return version;
	}
	public void setVersion(int version) {
		this.version = version;
	}
	public String getFileown() {
		return fileown;
	}
	public void setFileown(String fileown) {
		this.fileown = fileown;
	}
	public Date getUploaddate() {
		return uploaddate;
	}
	public void setUploaddate(Date uploaddate) {
		this.uploaddate = uploaddate;
	}
	public int getMeetid() {
		return meetid;
	}
	public void setMeetid(int meetid) {
		this.meetid = meetid;
	}
	public String getMtype() {
		return mtype;
	}
	public void setMtype(String mtype) {
		this.mtype = mtype;
	}
	public String getModuleid() {
		return moduleid;
	}
	public void setModuleid(String moduleid) {
		this.moduleid = moduleid;
	}
	public int getFilecount() {
		return filecount;
	}
	public void setFilecount(int filecount) {
		this.filecount = filecount;
	}
	
}
