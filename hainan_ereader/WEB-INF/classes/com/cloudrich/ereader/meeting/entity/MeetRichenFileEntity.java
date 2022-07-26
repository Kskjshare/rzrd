package com.cloudrich.ereader.meeting.entity;

import java.util.Date;

public class MeetRichenFileEntity {
    private Integer id;

    private Integer sort;

    private Integer richenid;

    private Integer fileid;
    
    private Integer isdel;
    
    private String title;

    private String filename;

    private String filepath;

    private Date uploadtime;

    private String filetype;

    private String fileown;
    
    private int meetid;
 
    private String fileguid;
    
    public String getFileguid() {
		return fileguid;
	}
	public void setFileguid(String fileguid) {
		this.fileguid = fileguid;
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

	public Date getUploadtime() {
		return uploadtime;
	}

	public void setUploadtime(Date uploadtime) {
		this.uploadtime = uploadtime;
	}

	public String getFiletype() {
		return filetype;
	}

	public void setFiletype(String filetype) {
		this.filetype = filetype;
	}

	public String getFileown() {
		return fileown;
	}

	public void setFileown(String fileown) {
		this.fileown = fileown;
	}

	public int getMeetid() {
		return meetid;
	}

	public void setMeetid(int meetid) {
		this.meetid = meetid;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public Integer getRichenid() {
        return richenid;
    }

    public void setRichenid(Integer richenid) {
        this.richenid = richenid;
    }

    public Integer getFileid() {
        return fileid;
    }

    public void setFileid(Integer fileid) {
        this.fileid = fileid;
    }
    
    public Integer getIsdel() {
        return isdel;
    }

    public void setIsdel(Integer isdel) {
        this.isdel = isdel;
    }
}