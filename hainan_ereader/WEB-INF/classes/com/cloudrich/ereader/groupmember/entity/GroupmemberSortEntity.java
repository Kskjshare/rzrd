package com.cloudrich.ereader.groupmember.entity;

public class GroupmemberSortEntity {
	private int id;
	private int sort;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	@Override
	public String toString() {
		return "GroupmemberSortEntity [id=" + id + ", sort=" + sort + "]";
	}
	
}
