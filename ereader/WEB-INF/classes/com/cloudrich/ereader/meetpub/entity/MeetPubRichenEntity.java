package com.cloudrich.ereader.meetpub.entity;

import java.util.Date;

public class MeetPubRichenEntity {
    private Integer id;

    private Integer richenid;

    private String name;

    private Integer prichenid;

    private Integer meetid;

    private Integer isdel;

    private Integer sort;
    
    private Integer version;

	private Date pubtime;
    
    public Date getPubtime() {
		return pubtime;
	}

	public void setPubtime(Date pubtime) {
		this.pubtime = pubtime;
	}
	
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getRichenid() {
        return richenid;
    }

    public void setRichenid(Integer richenid) {
        this.richenid = richenid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public Integer getPrichenid() {
        return prichenid;
    }

    public void setPrichenid(Integer prichenid) {
        this.prichenid = prichenid;
    }



    public Integer getMeetid() {
        return meetid;
    }

    public void setMeetid(Integer meetid) {
        this.meetid = meetid;
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
}