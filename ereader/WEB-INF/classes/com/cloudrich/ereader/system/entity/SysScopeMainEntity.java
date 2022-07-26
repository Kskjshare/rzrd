package com.cloudrich.ereader.system.entity;

public class SysScopeMainEntity {
    private Integer scopeid;

    private String scopename;

    private String des;

    public Integer getScopeid() {
        return scopeid;
    }

    public void setScopeid(Integer scopeid) {
        this.scopeid = scopeid;
    }

    public String getScopename() {
        return scopename;
    }

    public void setScopename(String scopename) {
        this.scopename = scopename == null ? null : scopename.trim();
    }

    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des == null ? null : des.trim();
    }
}