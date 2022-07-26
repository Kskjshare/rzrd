package com.cloudrich.ereader.meeting.entity;

public class ProcessSelectEntity {

	private String action,actionname;

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public String getActionname() {
		return actionname;
	}

	public void setActionname(String actionname) {
		this.actionname = actionname;
	}

	@Override
	public String toString() {
		return "ProcessSelectEntity [action=" + action + ", actionname="
				+ actionname + "]";
	}
}
