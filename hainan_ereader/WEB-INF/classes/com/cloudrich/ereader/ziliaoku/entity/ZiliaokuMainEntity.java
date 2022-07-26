package com.cloudrich.ereader.ziliaoku.entity;

import java.util.Date;

public class ZiliaokuMainEntity {
    private Integer ziliaoid;

    private String name;

    private String filename;

    private String path;

    private Integer isdel;

    private Integer userid;

    private Date createtime;

    private Integer typeid;

    private String sname;
    
    private String fname;
    
    private String fileguid;
    
    
    public String getFileguid() {
		return fileguid;
	}

	public void setFileguid(String fileguid) {
		this.fileguid = fileguid;
	}      
    public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public String getSname() {
		return sname;
	}

	public void setSname(String sname) {
		this.sname = sname == null ? null : sname.trim();;
	}

	public Integer getZiliaoid() {
        return ziliaoid;
    }

    public void setZiliaoid(Integer ziliaoid) {
        this.ziliaoid = ziliaoid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
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

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public Integer getTypeid() {
        return typeid;
    }

    public void setTypeid(Integer typeid) {
        this.typeid = typeid;
    }

	@Override
	public String toString() {
		return "ZiliaokuMainEntity [ziliaoid=" + ziliaoid + ", name=" + name
				+ ", filename=" + filename + ", path=" + path + ", isdel="
				+ isdel + ", userid=" + userid + ", createtime=" + createtime
				+ ", typeid=" + typeid + ", sname=" + sname + ", fname="
				+ fname + "]";
	}
}