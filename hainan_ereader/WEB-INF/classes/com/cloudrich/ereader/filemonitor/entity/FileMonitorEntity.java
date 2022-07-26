package com.cloudrich.ereader.filemonitor.entity;

import java.util.Date;

public class FileMonitorEntity {
    private Integer id;

    private Integer meetid;

    private Integer userid;

    private Integer moduleid;

    private Integer filecount;

    private Date accepttime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getMeetid() {
        return meetid;
    }

    public void setMeetid(Integer meetid) {
        this.meetid = meetid;
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public Integer getModuleid() {
        return moduleid;
    }

    public void setModuleid(Integer moduleid) {
        this.moduleid = moduleid;
    }

    public Integer getFilecount() {
        return filecount;
    }

    public void setFilecount(Integer filecount) {
        this.filecount = filecount;
    }

    public Date getAccepttime() {
        return accepttime;
    }

    public void setAccepttime(Date accepttime) {
        this.accepttime = accepttime;
    }
}