package com.cloudrich.ereader.meeting.entity;

import java.util.Date;

public class MeetGroupMainEntity {
    private Integer groupid;

    private String groupno;
    
    private String filename;
    
    private String title;
    
    private String filepath;
    
    private Date uploadtime;
    
    private Integer meetid;
    
    private Date pushtime;

    private String fileguid;
    
    public String getFileguid() {
		return fileguid;
	}
	public void setFileguid(String fileguid) {
		this.fileguid = fileguid;
	}
	public Date getPushtime() {
		return pushtime;
	}
	public void setPushtime(Date pushtime) {
		this.pushtime = pushtime;
	}
	public Integer getGroupid() {
        return groupid;
    }
    public void setGroupid(Integer groupid) {
        this.groupid = groupid;
    }
    public Integer getMeetid() {
        return meetid;
    }
    public void setMeetid(Integer meetid) {
        this.meetid = meetid;
    }
    public String getGroupno() {
        return groupno;
    }
    public void setGroupno(String groupno) {
        this.groupno = groupno == null ? null : groupno.trim();
    }

	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getFilepath() {
		return filepath;
	}
	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}
	public Date getUploadtime() {
		return uploadtime;
	}
	public void setUploadtime(Date uploadtime) {
		this.uploadtime = uploadtime;
	}
	@Override
	public String toString() {
		return "MeetGroupMainEntity [groupid=" + groupid + ", groupno=" + groupno + ", meetid="
				+ meetid + "]";
	}
}