package com.cloudrich.ereader.meeting.entity;

import java.util.Date;
import java.util.List;
import java.util.Map;

public class MeetProcessEntity {
    private Integer id;

    private Integer meetid;

    private String submodulecode;

    private String curstate;
    
    private String prestate;

    private Integer tjuserid;

    private Date tjdatetime;

    private String comment;
    
    private String curstatename;
    
    private List<Map<String,Object>> actionlist;
    
    private String submitaction;
    
    private int version;
    

    public int getVersion() {
		return version;
	}

	public void setVersion(int version) {
		this.version = version;
	}

	public String getPrestate() {
		return prestate;
	}

	public void setPrestate(String prestate) {
		this.prestate = prestate;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCurstatename() {
        return curstatename;
    }

    public void setCurstatename(String curstatename) {
        this.curstatename = curstatename == null ? null : curstatename.trim();
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
    
    public List<Map<String,Object>> getActionlist() {
        return actionlist;
    }

    public void setActionlist(List<Map<String,Object>> actionlist) {
        this.actionlist = actionlist;
    }
    
    public String getSubmitaction() {
        return submitaction;
    }

    public void setSubmitaction(String submitaction) {
        this.submitaction = submitaction == null ? null : submitaction.trim();
    }

	@Override
	public String toString() {
		return "MeetProcessEntity [actionlist=" + actionlist + ", comment="
				+ comment + ", curstate=" + curstate + ", curstatename="
				+ curstatename + ", id=" + id + ", meetid=" + meetid
				+ ", submitaction=" + submitaction + ", submodulecode="
				+ submodulecode + ", tjdatetime=" + tjdatetime + ", tjuserid="
				+ tjuserid + "]";
	}
}