package com.cloudrich.ereader.meeting.entity;

import java.util.Date;

public class MeetMainEntity {
    private Integer meetid;

    private String mname;

    private String mtype;
    private String jnum;
    private String cnum;

  

	private Date sdate;

    private Date edate;

    private Date createtime;

    private Integer userid;
   

    private Integer isdel;
    private String sdateStr,edateStr;
    
    private Date bmhdate;
    
  
	public Date getBmhdate() {
		return bmhdate;
	}

	public void setBmhdate(Date bmhdate) {
		this.bmhdate = bmhdate;
	}

	public String getSdateStr() {
		return sdateStr;
	}

	public void setSdateStr(String sdateStr) {
		this.sdateStr = sdateStr;
	}

	public String getEdateStr() {
		return edateStr;
	}

	public void setEdateStr(String edateStr) {
		this.edateStr = edateStr;
	}

	public Integer getMeetid() {
        return meetid;
    }

    public void setMeetid(Integer meetid) {
        this.meetid = meetid;
    }

    public String getMname() {
        return mname;
    }

    public void setMname(String mname) {
        this.mname = mname == null ? null : mname.trim();
    }

    public String getMtype() {
        return mtype;
    }

    public void setMtype(String mtype) {
        this.mtype = mtype == null ? null : mtype.trim();
    }

    public Date getSdate() {
        return sdate;
    }

    public void setSdate(Date sdate) {
        this.sdate = sdate;
    }

    public Date getEdate() {
        return edate;
    }

    public void setEdate(Date edate) {
        this.edate = edate;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public Integer getIsdel() {
        return isdel;
    }

    public void setIsdel(Integer isdel) {
        this.isdel = isdel;
    }
    
    public String getJnum() {
  		return jnum;
  	}

  	public void setJnum(String jnum) {
  		this.jnum = jnum;
  	}

  	public String getCnum() {
  		return cnum;
  	}

  	public void setCnum(String cnum) {
  		this.cnum = cnum;
  	}

	@Override
	public String toString() {
		return "MeetMainEntity [ createtime=" + createtime
				+ ", edate=" + edate + ", edateStr=" + edateStr + ", isdel="
				+ isdel + " meetid=" + meetid
				+ ", mname=" + mname + ", mtype=" + mtype + ", sdate=" + sdate
				+ ", sdateStr=" + sdateStr + ", userid=" + userid + "]";
	}
}