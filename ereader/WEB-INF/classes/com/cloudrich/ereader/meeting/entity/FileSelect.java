package com.cloudrich.ereader.meeting.entity;

public class FileSelect {
	
	private String fvalue;
	private String fname;
	public FileSelect(String fvalue, String fname) {
		super();
		this.fvalue = fvalue;
		this.fname = fname;
	}
	public String getFvalue() {
		return fvalue;
	}
	public void setFvalue(String fvalue) {
		this.fvalue = fvalue;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
}
