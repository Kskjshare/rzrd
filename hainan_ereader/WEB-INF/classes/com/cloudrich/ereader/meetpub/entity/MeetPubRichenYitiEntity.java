package com.cloudrich.ereader.meetpub.entity;

public class MeetPubRichenYitiEntity {
    private Integer id;

    private Integer yitiid;

    private String title;

    private Integer sort;

    private String bindyichenid;

    private Integer richenid;
    
    private Integer version;
    
    private Integer isdel;
    
    private String bindbimu;

    public String getBindbimu() {
		return bindbimu;
	}

	public void setBindbimu(String bindbimu) {
		this.bindbimu = bindbimu;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public Integer getRichenid() {
        return richenid;
    }

    public void setRichenid(Integer richenid) {
        this.richenid = richenid;
    }
    
    public Integer getVersion() {
        return version;
    }
    

    public void setVersion(Integer version) {
        this.version = version;
    }
    
    public Integer getIsdel() {
        return isdel;
    }

    public void setIsdel(Integer isdel) {
        this.isdel = isdel;
    }
}