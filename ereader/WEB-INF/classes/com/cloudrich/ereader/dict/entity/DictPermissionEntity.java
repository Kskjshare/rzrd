package com.cloudrich.ereader.dict.entity;

public class DictPermissionEntity {
    private Integer id;

    private String persimoncode;

    private Integer moduleno;
    
    private String modulename;

    private String operation;

    private String opename;
    
    private String url;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPersimoncode() {
        return persimoncode;
    }

    public void setPersimoncode(String persimoncode) {
        this.persimoncode = persimoncode == null ? null : persimoncode.trim();
    }

    public Integer getModuleno() {
        return moduleno;
    }

    public void setModuleno(Integer moduleno) {
        this.moduleno = moduleno;
    }

    public String getOperation() {
        return operation;
    }

    public void setOperation(String operation) {
        this.operation = operation == null ? null : operation.trim();
    }

    public String getOpename() {
        return opename;
    }

    public void setOpename(String opename) {
        this.opename = opename == null ? null : opename.trim();
    }
    
    public String getModulename() {
        return modulename;
    }

    public void setModulename(String modulename) {
        this.modulename = modulename == null ? null : modulename.trim();
    }
    
    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }
}