package com.cloudrich.ereader.smsmanager.entity;

import java.util.Date;

public class SmsdefineLogDetailEntity {
    private Integer id;

    private Integer logid;
    
    private Integer tongxluserid;

    private String phonenum;

    private String smstype;

    private Date sendtime;
    
    private String issucess;
    
    private String name;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getLogid() {
		return logid;
	}

	public void setLogid(Integer logid) {
		this.logid = logid;
	}

	public Integer getTongxluserid() {
		return tongxluserid;
	}

	public void setTongxluserid(Integer tongxluserid) {
		this.tongxluserid = tongxluserid;
	}

	public String getPhonenum() {
		return phonenum;
	}

	public void setPhonenum(String phonenum) {
		this.phonenum = phonenum;
	}

	public String getSmstype() {
		return smstype;
	}

	public void setSmstype(String smstype) {
		this.smstype = smstype;
	}

	public Date getSendtime() {
		return sendtime;
	}

	public void setSendtime(Date sendtime) {
		this.sendtime = sendtime;
	}

	public String getIssucess() {
		return issucess;
	}

	public void setIssucess(String issucess) {
		this.issucess = issucess;
	}

	@Override
	public String toString() {
		return "SmsdefineLogDetailEntity [id=" + id + ", logid=" + logid + ", tongxluserid=" + tongxluserid
				+ ", phonenum=" + phonenum + ", smstype=" + smstype + ", sendtime=" + sendtime + ", issucess="
				+ issucess + ", name=" + name + "]";
	}
	
  
}