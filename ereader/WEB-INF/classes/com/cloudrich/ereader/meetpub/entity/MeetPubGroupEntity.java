package com.cloudrich.ereader.meetpub.entity;

import java.util.Date;

public class MeetPubGroupEntity {
	private Integer id;

	private Integer groupid;

    private String groupno;

    private String title;
    
    private String filename;
    
    private String filepath;
    
    private Integer meetid;
    
    private Date pushtime;

    private String fileguid;
    
    private int isdel;
    
    
    public int getIsdel() {
		return isdel;
	}
	public void setIsdel(int isdel) {
		this.isdel = isdel;
	}
	public String getFileguid() {
		return fileguid;
	}
	public void setFileguid(String fileguid) {
		this.fileguid = fileguid;
	}
    public Integer getGroupid() {
        return groupid;
    }
    public Date getPushtime() {
		return pushtime;
	}
	public void setPushtime(Date pushtime) {
		this.pushtime = pushtime;
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
	
    public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getFilepath() {
		return filepath;
	}
	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	@Override
	public String toString() {
		return "MeetGroupMainEntity [groupid=" + groupid + ", groupno=" + groupno + ", meetid="
				+ meetid + "]";
	}
}