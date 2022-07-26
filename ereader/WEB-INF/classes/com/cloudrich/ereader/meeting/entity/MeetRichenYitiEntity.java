package com.cloudrich.ereader.meeting.entity;

public class MeetRichenYitiEntity {
    private Integer yitiid;

    private String title;

    private Integer sort;

    private String bindyichenid;
    
    private Integer richenid;
    
    private Integer isdel;
    
    private String bindbimu;
    
    public String getBindbimu() {
		return bindbimu;
	}

	public void setBindbimu(String bindbimu) {
		this.bindbimu = bindbimu;
	}

	@Override
	public String toString() {
		return "MeetRichenYitiEntity [bindyichenid=" + bindyichenid
				+ ", isdel=" + isdel + ", richenid=" + richenid + ", sort="
				+ sort + ", title=" + title + ", yitiid=" + yitiid + "]";
	}

	public Integer getRichenid() {
        return richenid;
    }

    public void setRichenid(Integer richenid) {
        this.richenid = richenid;
    }
    
    
    public Integer getYitiid() {
        return yitiid;
    }

    public void setYitiid(Integer yitiid) {
        this.yitiid = yitiid;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public String getBindyichenid() {
        return bindyichenid;
    }

    public void setBindyichenid(String bindyichenid) {
        this.bindyichenid = bindyichenid;
    }
    
    public Integer getIsDel() {
        return isdel;
    }

    public void setIsDel(Integer isdel) {
        this.isdel = isdel;
    }
}