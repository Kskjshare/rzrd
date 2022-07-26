package com.cloudrich.framework.util.file;

public class LawEntity {
	private int id;  //资料id
   	private String lawTopic;//资料标题
	private String releaseTime;  //发布时间
	private String releaseUser;   //发布人
	private String contentno;   //发文字号
	private String prikey;   //关键字
	private String lawContent;//公告内容
	private String path;
	private int cmid;
	private String topbg;
	private int sort; 
//	private String lawType;
//	private Integer fromuser;
//	private int readid;
	
//	public int getReadid() {
//		return readid;
//	}
//	public void setReadid(int readid) {
//		this.readid = readid;
//	}
//	public Integer getFromuser() {
//		return fromuser;
//	}
//	public void setFromuser(Integer fromuser) {
//		this.fromuser = fromuser;
//	}
//	public String getLawType() {
//		return lawType;
//	}
//	public void setLawType(String lawType) {
//		this.lawType = lawType;
//	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public String getTopbg() {
		return topbg;
	}
	public void setTopbg(String topbg) {
		this.topbg = topbg;
	}
	private String comes;//来源
	
	public String getComes() {
		return comes;
	}
	public void setComes(String comes) {
		this.comes = comes;
	}
	private String type;
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public int getCmid() {
		return cmid;
	}
	public void setCmid(int cmid) {
		this.cmid = cmid;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public String getReleaseTime() {
		return releaseTime;
	}
	public void setReleaseTime(String releaseTime) {
		this.releaseTime = releaseTime;
	}
	public String getReleaseUser() {
		return releaseUser;
	}
	public void setReleaseUser(String releaseUser) {
		this.releaseUser = releaseUser;
	}
	public String getLawTopic() {
		return lawTopic;
	}
	public void setLawTopic(String lawTopic) {
		this.lawTopic = lawTopic;
	}
	public String getLawContent() {
		return lawContent;
	}
	public void setLawContent(String lawContent) {
		this.lawContent = lawContent;
	}
	@Override
	public String toString() {
		return "LawEntity [cmid=" + cmid + ", id=" + id + ", lawContent="
				+ lawContent + ", lawTopic=" + lawTopic + ", path=" + path
				+ ", releaseTime=" + releaseTime + ", releaseUser="
				+ releaseUser + ", type=" + type + "]";
	}
	public String getContentno() {
		return contentno;
	}
	public void setContentno(String contentno) {
		this.contentno = contentno;
	}
	public String getPrikey() {
		return prikey;
	}
	public void setPrikey(String prikey) {
		this.prikey = prikey;
	}
	
	
}
