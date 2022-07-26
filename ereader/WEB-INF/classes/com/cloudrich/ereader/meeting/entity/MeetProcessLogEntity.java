package com.cloudrich.ereader.meeting.entity;

import java.util.Date;

public class MeetProcessLogEntity {
    private Integer id;

    private Integer meetid;

    private String submodulecode;

    private String curstate;

    private Integer tjuserid;

    private Date tjdatetime;

    private String comment;
    
    private String tjaction;
    
    private Integer shenheren;

    private Date shenhetime;
    
    
    private String tjuser;
    
    private String shenheuser;
    
    private int globalid;
    
    private int version;
    
    public int getVersion() {
		return version;
	}

	public void setVersion(int version) {
		this.version = version;
	}

	public int getGlobalid() {
		return globalid;
	}

	public void setGlobalid(int globalid) {
		this.globalid = globalid;
	}

	public String getTjuser() {
		return tjuser;
	}

	public void setTjuser(String tjuser) {
		this.tjuser = tjuser;
	}

	public String getShenheuser() {
		return shenheuser;
	}

	public void setShenheuser(String shenheuser) {
		this.shenheuser = shenheuser;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }


    public Integer getMeetid() {
        return meetid;
    }

    public void setMeetid(Integer meetid) {
        this.meetid = meetid;
    }

    public String getSubmodulecode() {
        return submodulecode;
    }

    public void setSubmodulecode(String submodulecode) {
        this.submodulecode = submodulecode == null ? null : submodulecode.trim();
    }

    public String getCurstate() {
        return curstate;
    }

    public void setCurstate(String curstate) {
        this.curstate = curstate == null ? null : curstate.trim();
    }

    public Integer getTjuserid() {
        return tjuserid;
    }

    public void setTjuserid(Integer tjuserid) {
        this.tjuserid = tjuserid;
    }

    public Date getTjdatetime() {
        return tjdatetime;
    }

    public void setTjdatetime(Date tjdatetime) {
        this.tjdatetime = tjdatetime;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment == null ? null : comment.trim();
    }
    
    public String getTjaction() {
        return tjaction;
    }

    public void setTjaction(String tjaction) {
        this.tjaction = tjaction == null ? null : tjaction.trim();
    }

	public Integer getShenheren() {
		return shenheren;
	}

	public void setShenheren(Integer shenheren) {
		this.shenheren = shenheren;
	}

	public Date getShenhetime() {
		return shenhetime;
	}

	public void setShenhetime(Date shenhetime) {
		this.shenhetime = shenhetime;
	}
    
}