package com.cloudrich.ereader.meeting.entity;

public class SelectEntity {

	private String keyV;
	private String valueV;
	public SelectEntity(String keyV, String valueV) {
		super();
		this.keyV = keyV;
		this.valueV = valueV;
	}
	public String getKeyV() {
		return keyV;
	}
	public void setKeyV(String keyV) {
		this.keyV = keyV;
	}
	public String getValueV() {
		return valueV;
	}
	public void setValueV(String valueV) {
		this.valueV = valueV;
	}
	@Override
	public String toString() {
		return "SelectEntity [keyV=" + keyV + ", valueV=" + valueV + "]";
	}
}
