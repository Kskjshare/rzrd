package com.cloudrich.ereader.meeting.entity;

public class MeetYichenMainEntity {
    private Integer yichenid;

    private Integer meetid;

    private Integer pyichenid;

    private String title;

    private Integer isdel;

    private Integer sort;

    public Integer getYichenid() {
        return yichenid;
    }

    public void setYichenid(Integer yichenid) {
        this.yichenid = yichenid;
    }

    public Integer getMeetid() {
        return meetid;
    }

    public void setMeetid(Integer meetid) {
        this.meetid = meetid;
    }

    public Integer getPyichenid() {
        return pyichenid;
    }

    public void setPyichenid(Integer pyichenid) {
        this.pyichenid = pyichenid;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public Integer getIsdel() {
        return isdel;
    }

    public void setIsdel(Integer isdel) {
        this.isdel = isdel;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

	@Override
	public String toString() {
		return "MeetYichenMainEntity [isdel=" + isdel + ", meetid=" + meetid
				+ ", pyichenid=" + pyichenid + ", sort=" + sort + ", title="
				+ title + ", yichenid=" + yichenid + "]";
	}
}