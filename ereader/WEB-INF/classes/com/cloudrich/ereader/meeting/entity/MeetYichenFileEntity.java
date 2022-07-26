package com.cloudrich.ereader.meeting.entity;

public class MeetYichenFileEntity {
    private Integer id;

    private Integer sort;

    private Integer yichenid;

    private Integer fileid;
    
    private Integer isdel;
    

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public Integer getYichenid() {
        return yichenid;
    }

    public void setYichenid(Integer yichenid) {
        this.yichenid = yichenid;
    }

    public Integer getFileid() {
        return fileid;
    }

    public void setFileid(Integer fileid) {
        this.fileid = fileid;
    }
    
    public Integer getIsdel() {
        return isdel;
    }

    public void setIsdel(Integer isdel) {
        this.isdel = isdel;
    }
}