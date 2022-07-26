package com.cloudrich.ereader.briefing.entity;

import java.io.Serializable;
import java.util.Date;

public class MeetBriefingMainEntity implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Integer briefid;

    private String briefname;

    private Integer meetid;

    private String filename;

    private String filepath;
    
    private String sendtype;

    private Date sendtime;
    
    private Date pubtime;
    
    private String scopename;
    
    private String fileguid;
    
    
    public String getFileguid() {
		return fileguid;
	}

	public void setFileguid(String fileguid) {
		this.fileguid = fileguid;
	}
    public String getScopename() {
		return scopename;
	}

	public void setScopename(String scopename) {
		this.scopename = scopename;
	}

	public Date getPubtime() {
		return pubtime;
	}

	public void setPubtime(Date pubtime) {
		this.pubtime = pubtime;
	}

	public Integer getBriefid() {
        return briefid;
    }

    public void setBriefid(Integer briefid) {
        this.briefid = briefid;
    }

    public String getBriefname() {
        return briefname;
    }

    public void setBriefname(String briefname) {
        this.briefname = briefname == null ? null : briefname.trim();
    }

    public Integer getMeetid() {
        return meetid;
    }

    public void setMeetid(Integer meetid) {
        this.meetid = meetid;
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

    public String getSendtype() {
        return sendtype;
    }

    public void setSendtype(String sendtype) {
        this.sendtype = sendtype == null ? null : sendtype.trim();
    }

    public Date getSendtime() {
        return sendtime;
    }

    public void setSendtime(Date sendtime) {
        this.sendtime = sendtime;
    }

	@Override
	public String toString() {
		return "MeetBriefingMainEntity [briefid=" + briefid + ", briefname="
				+ briefname + ", filename=" + filename + ", filepath="
				+ filepath + ", meetid=" + meetid + ", sendtime=" + sendtime
				+ ", sendtype=" + sendtype + "]";
	}
}