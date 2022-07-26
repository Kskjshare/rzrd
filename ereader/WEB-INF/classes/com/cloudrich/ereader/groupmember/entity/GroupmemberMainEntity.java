package com.cloudrich.ereader.groupmember.entity;

public class GroupmemberMainEntity {
    private Integer memberid;

    private Integer groupcode;

    private Integer membertype;

    private String truename;

    private String tel;

    private String post;

    private Integer sort;

    private String address;

    private String phone;

    private String mishuname;

    private String mishuphone;

    private String note;

    private Integer isdel;

    public Integer getMemberid() {
        return memberid;
    }

    public void setMemberid(Integer memberid) {
        this.memberid = memberid;
    }

    public Integer getGroupcode() {
        return groupcode;
    }

    public void setGroupcode(Integer groupcode) {
        this.groupcode = groupcode;
    }

    public Integer getMembertype() {
        return membertype;
    }

    public void setMembertype(Integer membertype) {
        this.membertype = membertype;
    }

    public String getTruename() {
        return truename;
    }

    public void setTruename(String truename) {
        this.truename = truename == null ? null : truename.trim();
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel == null ? null : tel.trim();
    }

    public String getPost() {
        return post;
    }

    public void setPost(String post) {
        this.post = post == null ? null : post.trim();
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public String getMishuname() {
        return mishuname;
    }

    public void setMishuname(String mishuname) {
        this.mishuname = mishuname == null ? null : mishuname.trim();
    }

    public String getMishuphone() {
        return mishuphone;
    }

    public void setMishuphone(String mishuphone) {
        this.mishuphone = mishuphone == null ? null : mishuphone.trim();
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note == null ? null : note.trim();
    }

    public Integer getIsdel() {
        return isdel;
    }

    public void setIsdel(Integer isdel) {
        this.isdel = isdel;
    }
}