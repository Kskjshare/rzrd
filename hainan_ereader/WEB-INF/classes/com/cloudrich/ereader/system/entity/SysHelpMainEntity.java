package com.cloudrich.ereader.system.entity;

import java.util.Date;

public class SysHelpMainEntity {
    private Integer id;

    private String filename;

    private String filepath;

    private String title;
 
    private String fileguid;
    
    
    public String getFileguid() {
		return fileguid;
	}

	public void setFileguid(String fileguid) {
		this.fileguid = fileguid;
	} 
    public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	private String filetype;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getFilepath() {
		return filepath;
	}

	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}

	public String getFiletype() {
		return filetype;
	}

	public void setFiletype(String filetype) {
		this.filetype = filetype;
	}



}