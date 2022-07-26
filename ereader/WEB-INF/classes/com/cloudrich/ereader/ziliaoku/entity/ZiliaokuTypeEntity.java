package com.cloudrich.ereader.ziliaoku.entity;

public class ZiliaokuTypeEntity {
    private Integer typeid;

    private String name;

    private Integer sort;

    private Integer ptypeid;

    private Integer isdel;
    
    public Integer getTypeid() {
        return typeid;
    }

    public void setTypeid(Integer typeid) {
        this.typeid = typeid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public Integer getPtypeid() {
        return ptypeid;
    }

    public void setPtypeid(Integer ptypeid) {
        this.ptypeid = ptypeid;
    }

    public Integer getIsdel() {
        return isdel;
    }

    public void setIsdel(Integer isdel) {
        this.isdel = isdel;
    }

	@Override
	public String toString() {
		return "ZiliaokuTypeEntity [typeid=" + typeid + ", name=" + name
				+ ", sort=" + sort + ", ptypeid=" + ptypeid + ", isdel="
				+ isdel + "]";
	}
    
}