package com.cloudrich.ereader.tongxunlun.entity;

public class TongxunluPermissionEntity {
    private Integer id;

    private Integer scopeid;
    
    private String scopename;

    public String getScopename() {
		return scopename;
	}

	public void setScopename(String scopename) {
		this.scopename = scopename;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getScopeid() {
        return scopeid;
    }

    public void setScopeid(Integer scopeid) {
        this.scopeid = scopeid;
    }
}