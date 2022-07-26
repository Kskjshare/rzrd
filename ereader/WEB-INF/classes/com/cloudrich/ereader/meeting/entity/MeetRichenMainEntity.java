package com.cloudrich.ereader.meeting.entity;

public class MeetRichenMainEntity {
    private Integer richenid;

    private String name;

    private Integer prichenid;

    private Integer sort;
    
    private Integer meetid;
    
    private Integer isdel;
    

    public Integer getMeetid() {
        return meetid;
    }

    public void setMeetid(Integer meetid) {
        this.meetid = meetid;
    }
    
    
    public Integer getIsdel() {
        return isdel;
    }

    public void setIsdel(Integer isdel) {
        this.isdel = isdel ;
    }
    
    public Integer getRichenid() {
        return richenid;
    }

    public void setRichenid(Integer richenid) {
        this.richenid = richenid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public Integer getPrichenid() {
        return prichenid;
    }

    public void setPrichenid(Integer prichenid) {
        this.prichenid = prichenid;
    }

    
    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

	@Override
	public String toString() {
		return "MeetRichenMainEntity [isdel=" + isdel + ", meetid=" + meetid
				+ ", name=" + name + ", prichenid=" + prichenid + ", richenid="
				+ richenid + ", sort=" + sort + "]";
	}
    
}