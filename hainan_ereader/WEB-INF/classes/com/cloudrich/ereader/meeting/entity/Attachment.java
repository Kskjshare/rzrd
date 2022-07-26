package com.cloudrich.ereader.meeting.entity;


/**
 * Attachment entity. @author MyEclipse Persistence Tools
 */

public class Attachment implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	
	private static final long serialVersionUID = 998271974498813782L;
	private String ID;
	private String filename;
	private String filenameindisk;
	private String description;
	private String contenttype;
	private long filelength;
	private int needwatermark;
	private String memberID;
	
	// Constructors

	/** default constructor */
	public Attachment() {
	}

	/** full constructor */
	public Attachment(String filename, String filenameindisk,
			String description, String contenttype, int filelength,
			int needwatermark, String memberID) {
		this.filename = filename;
		this.filenameindisk = filenameindisk;
		this.description = description;
		this.contenttype = contenttype;
		this.filelength = filelength;
		this.needwatermark = needwatermark;
		this.memberID = memberID;
	}

	// Property accessors

	public String getID() {
		return this.ID;
	}

	public void setID(String ID) {
		this.ID = ID;
	}

	public String getFilename() {
		return this.filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getFilenameindisk() {
		return this.filenameindisk;
	}

	public void setFilenameindisk(String filenameindisk) {
		this.filenameindisk = filenameindisk;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getContenttype() {
		return this.contenttype;
	}

	public void setContenttype(String contenttype) {
		this.contenttype = contenttype;
	}

	

	/**
	 * @return the filelength
	 */
	public long getFilelength() {
		return filelength;
	}

	/**
	 * @param filelength the filelength to set
	 */
	public void setFilelength(long filelength) {
		this.filelength = filelength;
	}

	public int getNeedwatermark() {
		return this.needwatermark;
	}

	public void setNeedwatermark(int needwatermark) {
		this.needwatermark = needwatermark;
	}

	public String getMemberID() {
		return this.memberID;
	}

	public void setMemberID(String memberID) {
		this.memberID = memberID;
	}

	@Override
	public String toString() {
		return "Attachment [ID=" + ID + ", contenttype=" + contenttype
				+ ", description=" + description + ", filelength=" + filelength
				+ ", filename=" + filename + ", filenameindisk="
				+ filenameindisk + ", memberID=" + memberID
				+ ", needwatermark=" + needwatermark + "]";
	}

}