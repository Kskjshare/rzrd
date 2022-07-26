package com.cloudrich.ereader.system.entity;

import java.util.Date;

public class SysVersionMainEnity {
    private Integer id;

    private String upcontent;

    private String versionnum;

    private Date createtime;

    private String path;

    private String filename;

    private String filetype;

    private String apptype;

    private String isdel;

    private String fileguid;
    
    
    public String getFileguid() {
		return fileguid;
	}

	public void setFileguid(String fileguid) {
		this.fileguid = fileguid;
	} 
    public String getUpcontent() {
		return upcontent;
	}

	public void setUpcontent(String upcontent) {
		this.upcontent = upcontent;
	}

	public String getVersionnum() {
		return versionnum;
	}

	public void setVersionnum(String versionnum) {
		this.versionnum = versionnum;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getFiletype() {
		return filetype;
	}

	public void setFiletype(String filetype) {
		this.filetype = filetype;
	}

	public String getApptype() {
		return apptype;
	}

	public void setApptype(String apptype) {
		this.apptype = apptype;
	}

	public void setIsdel(String isdel) {
		this.isdel = isdel;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

	public String getIsdel() {
		return isdel;
	}

	@Override
	public String toString() {
		return "SysVersionMainEnity [id=" + id + ", upcontent=" + upcontent + ", versionnum=" + versionnum
				+ ", createtime=" + createtime + ", path=" + path + ", filename=" + filename + ", filetype=" + filetype
				+ ", apptype=" + apptype + ", isdel=" + isdel + ", fileguid=" + fileguid + "]";
	}

}