package com.cloudrich.ereader.dict.entity;

public class DictProcessDefEntity {
    private Integer id;

    private String proccode;

    private String curstate;

    private String action;

    private String nextstate;

    private String description;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getProccode() {
        return proccode;
    }

    public void setProccode(String proccode) {
        this.proccode = proccode == null ? null : proccode.trim();
    }

    public String getCurstate() {
        return curstate;
    }

    public void setCurstate(String curstate) {
        this.curstate = curstate == null ? null : curstate.trim();
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action == null ? null : action.trim();
    }

    public String getNextstate() {
        return nextstate;
    }

    public void setNextstate(String nextstate) {
        this.nextstate = nextstate == null ? null : nextstate.trim();
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description == null ? null : description.trim();
    }
}