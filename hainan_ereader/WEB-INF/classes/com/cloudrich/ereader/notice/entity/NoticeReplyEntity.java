package com.cloudrich.ereader.notice.entity;

public class NoticeReplyEntity {
    private Integer id;

    private Integer noticeid;

    private Integer userid;

    private String noticereplycode;

    private String username;
    
    private String tel;
    
    public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username==null?"":username.trim();
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel==null?"":tel.trim();
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getNoticeid() {
        return noticeid;
    }

    public void setNoticeid(Integer noticeid) {
        this.noticeid = noticeid;
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public String getNoticereplycode() {
        return noticereplycode;
    }

    public void setNoticereplycode(String noticereplycode) {
        this.noticereplycode = noticereplycode == null ? null : noticereplycode.trim();
    }
}