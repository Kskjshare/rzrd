package com.cloudrich.ereader.meetpub.entity;

public class MeetPubFileScopeEntity {
    private Integer id;

    private Integer fileid;

    private Integer scopeid;
    
    private Integer isdel;
    
    private Integer version;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getFileid() {
        return fileid;
    }

    public void setFileid(Integer fileid) {
        this.fileid = fileid;
    }

    public Integer getScopeid() {
        return scopeid;
    }

    public void setScopeid(Integer scopeid) {
        this.scopeid = scopeid;
    }
    
    public Integer getIsdel() {
        return isdel;
    }

    public void setIsdel(Integer isdel) {
        this.isdel = isdel;
    }
    
    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }
}