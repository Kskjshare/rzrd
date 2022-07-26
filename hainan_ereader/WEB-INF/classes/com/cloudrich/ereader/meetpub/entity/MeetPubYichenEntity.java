package com.cloudrich.ereader.meetpub.entity;

import java.util.Date;

public class MeetPubYichenEntity {
    private Integer id;

    private Integer yichenid;

    private Integer meetid;

    private Integer pyichenid;

    private String title;

    private Integer isdel;

    private Integer sort;
    
    private Integer version;
    
    private Date pubtime;

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getYichenid() {
        return yichenid;
    }

    public void setYichenid(Integer yichenid) {
        this.yichenid = yichenid;
    }

    public Integer getMeetid() {
        return meetid;
    }

    public void setMeetid(Integer meetid) {
        this.meetid = meetid;
    }

    public Integer getPyichenid() {
        return pyichenid;
    }

    public void setPyichenid(Integer pyichenid) {
        this.pyichenid = pyichenid;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public Integer getIsdel() {
        return isdel;
    }

    public void setIsdel(Integer isdel) {
        this.isdel = isdel;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }
    
    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }
    
    public Date getPubtime() {
		return pubtime;
	}

	public void setPubtime(Date pubtime) {
		this.pubtime = pubtime;
	}
}