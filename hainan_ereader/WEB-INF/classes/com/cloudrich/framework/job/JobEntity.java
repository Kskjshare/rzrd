package com.cloudrich.framework.job;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.cloudrich.framework.util.DateUtils;


public class JobEntity implements Serializable{
	private static final long serialVersionUID = 4393402002522091062L;
	/**主键ID*/
	private int id;
	/**计划名称*/
	private String name;
	/**计划开始时间*/
	
	private Map<String,Object> map;
	
	private String jobtype;
	
	private String jobtype2;

	private String cronexpression;
	
	private String sendtype;
	
	
	
	public String getJobtype2() {
		return jobtype2;
	}
	public void setJobtype2(String jobtype2) {
		this.jobtype2 = jobtype2;
	}
	public String getSendtype() {
		return sendtype;
	}
	public void setSendtype(String sendtype) {
		this.sendtype = sendtype;
	}
	public String getCronexpression() {
		return cronexpression;
	}
	public void setCronexpression(String cronexpression) {
		this.cronexpression = cronexpression;
	}
	
	
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
		this.name = name;
	}
	
	public Map<String, Object> getMap() {
		return map;
	}
	public void setMap(Map<String, Object> map) {
		this.map = map;
	}
	public String getJobtype() {
		return jobtype;
	}
	public void setJobtype(String jobtype) {
		this.jobtype = jobtype;
	}
	
}	
