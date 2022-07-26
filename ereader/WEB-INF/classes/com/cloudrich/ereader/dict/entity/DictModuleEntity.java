package com.cloudrich.ereader.dict.entity;

public class DictModuleEntity {
    private Integer id;

    private Integer moduleno;

    private String mname;

    private String murl;

    private String des;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getModuleno() {
        return moduleno;
    }

    public void setModuleno(Integer moduleno) {
        this.moduleno = moduleno;
    }

    public String getMname() {
        return mname;
    }

    public void setMname(String mname) {
        this.mname = mname == null ? null : mname.trim();
    }

    public String getMurl() {
        return murl;
    }

    public void setMurl(String murl) {
        this.murl = murl == null ? null : murl.trim();
    }

    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des == null ? null : des.trim();
    }
}