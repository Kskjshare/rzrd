package com.cloudrich.ereader.meetpub.entity;

import java.util.Date;

public class MeetPubPubtimeEntity {
    private Integer id;

    private Integer moduleid;

    private Integer meetid;

    private Date pubtime;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getModuleid() {
		return moduleid;
	}

	public void setModuleid(Integer moduleid) {
		this.moduleid = moduleid;
	}

	public Integer getMeetid() {
		return meetid;
	}

	public void setMeetid(Integer meetid) {
		this.meetid = meetid;
	}

	public Date getPubtime() {
		return pubtime;
	}

	public void setPubtime(Date pubtime) {
		this.pubtime = pubtime;
	}

    
}