package com.cloudrich.ereader.chuqueqin.entity;

import java.util.Date;

public class ChuqueqinPubEntity {
	private Integer id;
	
    private Integer absentid;

    private String title;

    private Integer pubuserid;

    private Date pubtime;

    private String filename;

    private String path;

    private Integer isdel;
    
    private String fileguid;
    
    
    public String getFileguid() {
		return fileguid;
	}

	public void setFileguid(String fileguid) {
		this.fileguid = fileguid;
	}   
    public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
    public Integer getAbsentid() {
        return absentid;
    }

    public void setAbsentid(Integer absentid) {
        this.absentid = absentid;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public Integer getPubuserid() {
        return pubuserid;
    }

    public void setPubuserid(Integer pubuserid) {
        this.pubuserid = pubuserid;
    }

    public Date getPubtime() {
        return pubtime;
    }

    public void setPubtime(Date pubtime) {
        this.pubtime = pubtime;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename == null ? null : filename.trim();
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path == null ? null : path.trim();
    }

    public Integer getIsdel() {
        return isdel;
    }

    public void setIsdel(Integer isdel) {
        this.isdel = isdel;
    }
}