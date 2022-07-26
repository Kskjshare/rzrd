package com.cloudrich.ereader.filemonitor.entity;

public class FileMonitorUserEntity {
	private int id;//userid
	private String name;//名字
	private int shouldReceive;//应收文件数量
	private int haveReceived;//已收文件数量
	private int notReceived;//未收到的文件数量
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name == null ? null : name.trim();
	}
	public int getShouldReceive() {
		return shouldReceive;
	}
	public void setShouldReceive(int shouldReceive) {
		this.shouldReceive = shouldReceive;
	}
	public int getHaveReceived() {
		return haveReceived;
	}
	public void setHaveReceived(int haveReceived) {
		this.haveReceived = haveReceived;
	}
	public int getNotReceived() {
		return notReceived;
	}
	public void setNotReceived(int notReceived) {
		this.notReceived = notReceived;
	}
	@Override
	public String toString() {
		return "FileMonitorUserEntity [id=" + id + ", name=" + name
				+ ", shouldReceive=" + shouldReceive + ", haveReceived="
				+ haveReceived + ", notReceived=" + notReceived + "]";
	}
	
	
}
