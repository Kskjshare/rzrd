package com.cloudrich.ereader.smsmanager.entity;

import java.io.Serializable;
import java.util.Date;

public class SmsdefineMainEntity implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Integer smsid;

    private String content;

    private Integer createuserid;

    private Date createtime;

    private Integer isvalid;

    private Integer isdel;

    private String phonenums;

    private String tongxluserids;
    
    private String createusername;

    private String sendtype;
    
    private String sendway;
    
    private Date sendtime;
    
	public String getSendtype() {
		return sendtype;
	}

	public void setSendtype(String sendtype) {
		this.sendtype = sendtype;
	}

	public String getSendway() {
		return sendway;
	}

	public void setSendway(String sendway) {
		this.sendway = sendway;
	}

	public Date getSendtime() {
		return sendtime;
	}

	public void setSendtime(Date sendtime) {
		this.sendtime = sendtime;
	}

	public Integer getSmsid() {
		return smsid;
	}

	public void setSmsid(Integer smsid) {
		this.smsid = smsid;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getCreateuserid() {
		return createuserid;
	}

	public void setCreateuserid(Integer createuserid) {
		this.createuserid = createuserid;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Integer getIsvalid() {
		return isvalid;
	}

	public void setIsvalid(Integer isvalid) {
		this.isvalid = isvalid;
	}

	public Integer getIsdel() {
		return isdel;
	}

	public void setIsdel(Integer isdel) {
		this.isdel = isdel;
	}

	public String getPhonenums() {
		return phonenums;
	}

	public void setPhonenums(String phonenums) {
		this.phonenums = phonenums;
	}

	public String getTongxluserids() {
		return tongxluserids;
	}

	public void setTongxluserids(String tongxluserids) {
		this.tongxluserids = tongxluserids;
	}

	public String getCreateusername() {
		return createusername;
	}

	public void setCreateusername(String createusername) {
		this.createusername = createusername;
	}

	@Override
	public String toString() {
		return "SmsdefineMainEntity [smsid=" + smsid + ", content=" + content + ", createuserid=" + createuserid
				+ ", createtime=" + createtime + ", isvalid=" + isvalid + ", isdel=" + isdel + ", phonenums="
				+ phonenums + ", tongxluserids=" + tongxluserids + ", createusername=" + createusername + ", sendtype="
				+ sendtype + ", sendway=" + sendway + ", sendtime=" + sendtime + "]";
	}
	
   

}