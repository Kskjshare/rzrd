package com.cloudrich.ereader.tongxunlun.entity;

import java.util.Date;

public class TongxunluPubEntity {
	private Integer id;
	
	private Integer txlid;

    private Integer sort;

    private String name;
    
    private String dept;

    private Integer compCode;

    private String phoneOffice;

    private String phoneHome;

    private String mobile;

    private String mail;

    private String comment;

    private String jobtitle;

    private Integer isdel;
    
    private Date pubtime;
    
    public Integer getTxlid() {
		return txlid;
	}

	public void setTxlid(Integer txlid) {
		this.txlid = txlid;
	}

	public Date getPubtime() {
		return pubtime;
	}

	public void setPubtime(Date pubtime) {
		this.pubtime = pubtime;
	}

	public String getDept() {
		return dept;
	}

	public void setDept(String dept) {
		this.dept = dept;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name == null ? null : name.trim();
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

    public Integer getCompCode() {
		return compCode;
	}

	public void setCompCode(Integer compCode) {
		this.compCode = compCode;
	}

	public String getPhoneOffice() {
		return phoneOffice;
	}

	public void setPhoneOffice(String phoneOffice) {
		System.out.println("phoneOffice:"+phoneOffice);
		this.phoneOffice = phoneOffice == null ? null : phoneOffice.trim();
	}

	public String getPhoneHome() {
		return phoneHome;
	}

	public void setPhoneHome(String phoneHome) {
		this.phoneHome = phoneHome == null ? null : phoneHome.trim();
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile == null ? null : mobile.trim();
	}

	public String getMail() {
		return mail;
	}

	public void setMail(String mail) {
		this.mail = mail == null ? null : mail.trim();
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment == null ? null : comment.trim();
	}

	public String getJobtitle() {
		return jobtitle;
	}

	public void setJobtitle(String jobtitle) {
		this.jobtitle = jobtitle == null ? null : jobtitle.trim();
	}

	public Integer getIsdel() {
        return isdel;
    }

    public void setIsdel(Integer isdel) {
        this.isdel = isdel;
    }

	@Override
	public String toString() {
		return "TongxunluMainEntity [id=" + id + ", sort=" + sort + ", name="
				+ name + ", dept=" + dept + ", compCode=" + compCode
				+ ", phoneOffice=" + phoneOffice + ", phoneHome=" + phoneHome
				+ ", mobile=" + mobile + ", mail=" + mail + ", comment="
				+ comment + ", jobtitle=" + jobtitle + ", isdel=" + isdel
				+ "]";
	}
}