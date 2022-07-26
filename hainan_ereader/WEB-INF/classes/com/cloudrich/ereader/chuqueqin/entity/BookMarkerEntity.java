package com.cloudrich.ereader.chuqueqin.entity;

public class BookMarkerEntity {
	private int id;
	private int page;
	private String content;
	private String createtime;
	private int userid;
	private String filename;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCreatetime() {
		return createtime;
	}
	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	@Override
	public String toString() {
		return "BookMarker [content=" + content + ", createtime=" + createtime
				+ ", filename=" + filename + ", id=" + id + ", page=" + page
				+ ", userid=" + userid + "]";
	}
}
