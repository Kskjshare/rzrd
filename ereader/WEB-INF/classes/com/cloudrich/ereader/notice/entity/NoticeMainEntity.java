package com.cloudrich.ereader.notice.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class NoticeMainEntity implements Serializable{
	
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Integer noticeid;

    private String title;

    private Integer pubuserid;
    
    private Date pubtime;

    private String sendtype;

    private String filename;

    private String path;
    
    private Date sendtime;

    private Integer isdel;
    
    private List<Integer> scopeIds;
    
    private String sendway;
    
    private String phonenums;
    
    private String scopenames;
    
    private String pushdate;
 
    private String fileguid;
    
    
    public String getFileguid() {
		return fileguid;
	}

	public void setFileguid(String fileguid) {
		this.fileguid = fileguid;
	}
	public String getPushdate() {
		return pushdate;
	}

	public void setPushdate(String pushdate) {
		this.pushdate = pushdate;
	}

	public String getScopenames() {
		return scopenames;
	}

	public void setScopenames(String scopenames) {
		this.scopenames = scopenames;
	}

	public String getPhonenums() {
		return phonenums;
	}

	public void setPhonenums(String phonenums) {
		this.phonenums = phonenums;
	}

	public String getSendway() {
		return sendway;
	}

	public void setSendway(String sendway) {
		this.sendway = sendway;
	}

	public List<Integer> getScopeIds() {
		return scopeIds;
	}

	public void setScopeIds(List<Integer> scopeIds) {
		this.scopeIds = scopeIds;
	}

	public Integer getNoticeid() {
        return noticeid;
    }

    public void setNoticeid(Integer noticeid) {
        this.noticeid = noticeid;
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

    public String getSendtype() {
        return sendtype;
    }

    public void setSendtype(String sendtype) {
        this.sendtype = sendtype == null ? null : sendtype.trim();
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

    public Date getSendtime() {
        return sendtime;
    }

    public void setSendtime(Date sendtime) {
        this.sendtime = sendtime;
    }

    public Integer getIsdel() {
        return isdel;
    }

    public void setIsdel(Integer isdel) {
        this.isdel = isdel;
    }

	@Override
	public String toString() {
		return "NoticeMainEntity [noticeid=" + noticeid + ", title=" + title + ", pubuserid=" + pubuserid + ", pubtime="
				+ pubtime + ", sendtype=" + sendtype + ", filename=" + filename + ", path=" + path + ", sendtime="
				+ sendtime + ", isdel=" + isdel + ", scopeIds=" + scopeIds + ", sendway=" + sendway + ", phonenums="
				+ phonenums + ", scopenames=" + scopenames + ", pushdate=" + pushdate + ", fileguid=" + fileguid + "]";
	}
    
}