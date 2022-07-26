package com.cloudrich.ereader.meeting.entity;

import java.util.Date;
import java.util.List;

public class MeetFileMainEntity {
   
	private Integer id;
	
	private Integer fileid;
    
    private Integer meetid;

    private String title;

    private String filename;

    private String filepath;

    private Date uploadtime;

    private String filetype;

    private String fileown;
    
    private Integer sort;
    
    private Integer yichenid;
    
    private Integer isdel;
    
    private String mtype;
    
    private String filescopes;
    
    private String fileguid;
    
    
    public String getFileguid() {
		return fileguid;
	}

	public void setFileguid(String fileguid) {
		this.fileguid = fileguid;
	}

	private List<MeetYichenMainEntity> bindyichenlist;
    
    

    public List<MeetYichenMainEntity> getBindyichenlist() {
		return bindyichenlist;
	}

	public void setBindyichenlist(List<MeetYichenMainEntity> bindyichenlist) {
		this.bindyichenlist = bindyichenlist;
	}

	public String getFilescopes() {
		return filescopes;
	}

	public void setFilescopes(String filescopes) {
		this.filescopes = filescopes;
	}

	public Integer getid() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
    
    public Integer getFileid() {
        return fileid;
    }

    public void setFileid(Integer fileid) {
        this.fileid = fileid;
    }
    
    
    public Integer getMeetid() {
        return meetid;
    }

    public void setMeetid(Integer meetid) {
        this.meetid = meetid;
    }
    

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename == null ? null : filename.trim();
    }

    public String getFilepath() {
        return filepath;
    }

    public void setFilepath(String filepath) {
        this.filepath = filepath == null ? null : filepath.trim();
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
        this.filetype = filetype == null ? null : filetype.trim();
    }

    public String getFileown() {
        return fileown;
    }

    public void setFileown(String fileown) {
        this.fileown = fileown == null ? null : fileown.trim();
    }
    
    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }
	public Integer getYichenid() {
        return yichenid;
    }

    public void setYichenid(Integer yichenid) {
        this.yichenid = yichenid;
    }
    
    public Integer getIsdel() {
        return isdel;
    }

    public void setIsdel(Integer isdel) {
        this.isdel = isdel;
    }

	public String getMtype() {
		return mtype;
	}

	public void setMtype(String mtype) {
		this.mtype = mtype;
	}

	@Override
	public String toString() {
		return "MeetFileMainEntity [bindyichenlist=" + bindyichenlist
				+ ", fileid=" + fileid + ", filename=" + filename
				+ ", fileown=" + fileown + ", filepath=" + filepath
				+ ", filescopes=" + filescopes + ", filetype=" + filetype
				+ ", id=" + id + ", isdel=" + isdel + ", meetid=" + meetid
				+ ", mtype=" + mtype + ", sort=" + sort + ", title=" + title
				+ ", uploadtime=" + uploadtime + ", yichenid=" + yichenid + "]";
	}
}