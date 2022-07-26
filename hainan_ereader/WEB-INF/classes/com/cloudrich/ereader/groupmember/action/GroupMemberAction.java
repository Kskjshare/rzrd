package com.cloudrich.ereader.groupmember.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;


import com.cloudrich.ereader.common.action.BaseAction;
import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.dict.entity.DictDataEntity;
import com.cloudrich.ereader.dict.service.DictDataService;
import com.cloudrich.ereader.groupmember.entity.GroupmemberMainEntity;
import com.cloudrich.ereader.groupmember.entity.GroupmemberPubEntity;
import com.cloudrich.ereader.groupmember.entity.GroupmemberSortEntity;
import com.cloudrich.ereader.groupmember.service.GroupMemberService;

@Controller("GroupMemberAction")
public class GroupMemberAction extends BaseAction{
	private static final long serialVersionUID = 1L;
	@Resource GroupMemberService groupMemberService;
	@Resource DictDataService dictDataService;
	private GroupmemberMainEntity entity; 
	private Page page;
	private int pageNo=1;
	private int pageSize=8;
	private long totalPage;
	private int memberid;
	private int membertype=0;
	private String truename="";
	private int groupcode=0;//成员类型（0.所有成员，1.主任会议成员，2.常委会委员）
	private String post;
	private String address;
	private String phone;
	private String mishuname;
	private String mishuphone;
	private String note;
	private List<GroupmemberMainEntity> zhurenList;
	private List<GroupmemberMainEntity> changweiList;
	private String sort1;
	private String sort2;
	private List<DictDataEntity> membertypeList;
	private List<DictDataEntity> groupcodeList;
	private GroupmemberSortEntity sortEntity;
	private ArrayList<GroupmemberSortEntity> sortList;

	public String selectGroup(){
		zhurenList=groupMemberService.selectGroup(1);//1为主任会议成员
		changweiList=groupMemberService.selectGroup(2);//2为常委会委员
		return SUCCESS;
	}

	public String select(){
		System.out.println("pageNo:"+pageNo+",totalPage:"+totalPage+",pageSize:"+pageSize+",truename:"+truename+",membertype:"+membertype+",groupcode:"+groupcode);
		entity=new GroupmemberMainEntity();
		entity.setTruename(truename);
		entity.setGroupcode(groupcode);
		entity.setMembertype(membertype);
		page=groupMemberService.selectByPage(pageNo, pageSize, entity);
		totalPage=page.getPages();
		membertypeList=dictDataService.getDictDataByType("membertype");
		groupcodeList=dictDataService.getDictDataByType("groupcode");
		jsonSuccess("listGroupMember");
		return SUCCESS;
	}

	public String delete(){
		System.out.println("memberid:"+memberid);
		groupMemberService.delete(memberid);
		return SUCCESS;
	}

	public String selectById(){
		System.out.println("memberid:"+memberid);
		entity=groupMemberService.selectEntityById(memberid);
		return SUCCESS;
	}

	public String update(){
		System.out.println("修改memberid:"+memberid);
		groupMemberService.update(entity);
		jsonSuccess("update");
		return SUCCESS;
	}

	public String add(){
		System.out.println("添加memberid:"+entity.getMemberid());
		groupMemberService.insert(entity);
		jsonSuccess("add");
		return SUCCESS;
	}

	public void updateSort1(){
		System.out.println("sort1:"+sort1);
		String sortArray1[]=sort1.split(",");
		sortList=new ArrayList<GroupmemberSortEntity>();
		sortList.removeAll(sortList);
		for (int i = 0; i < sortArray1.length; i++) {
			if (Integer.valueOf(sortArray1[i])!=zhurenList.get(i).getMemberid()) {
				sortEntity=new GroupmemberSortEntity();
				sortEntity.setId(Integer.valueOf(sortArray1[i]));
				sortEntity.setSort(zhurenList.get(i).getSort());
				sortList.add(sortEntity);
			}
		}
		System.out.println(sortList.toString());
		groupMemberService.updateSort(sortList);
	}
	public void updateSort2(){
		System.out.println("sort2:"+sort2);
		String sortArray2[]=sort2.split(",");
		sortList=new ArrayList<GroupmemberSortEntity>();
		sortList.removeAll(sortList);
		for (int i = 0; i < sortArray2.length; i++) {
			if (Integer.valueOf(sortArray2[i])!=changweiList.get(i).getMemberid()) {
				sortEntity=new GroupmemberSortEntity();
				sortEntity.setId(Integer.valueOf(sortArray2[i]));
				sortEntity.setSort(changweiList.get(i).getSort());
				sortList.add(sortEntity);
			}
		}
		System.out.println(sortList.toString());
		groupMemberService.updateSort(sortList);
	}

	public String insertPub(){
		try {
			groupMemberService.insertAndPush();
			jsonSuccess("发布成功");
		} catch (Exception e) {
			e.printStackTrace();
			jsonSuccess("发布失败");
		}
		return SUCCESS;
	}
	
	public String selectPubtime(){
		GroupmemberPubEntity entity=groupMemberService.selectPubtime();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
		if(entity!=null){
			jsonSuccess(sdf.format(entity.getPubtime()));
		}else{
			jsonSuccess("");
		}
		return SUCCESS;
	}
	public List<DictDataEntity> getMembertypeList() {
		return membertypeList;
	}

	public void setMembertypeList(List<DictDataEntity> membertypeList) {
		this.membertypeList = membertypeList;
	}

	public List<DictDataEntity> getGroupcodeList() {
		return groupcodeList;
	}

	public void setGroupcodeList(List<DictDataEntity> groupcodeList) {
		this.groupcodeList = groupcodeList;
	}

	public String getSort1() {
		return sort1;
	}

	public void setSort1(String sort1) {
		this.sort1 = sort1;
	}

	public String getSort2() {
		return sort2;
	}

	public void setSort2(String sort2) {
		this.sort2 = sort2;
	}

	public String getPost() {
		return post;
	}

	public void setPost(String post) {
		this.post = post;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getMishuname() {
		return mishuname;
	}

	public void setMishuname(String mishuname) {
		this.mishuname = mishuname;
	}

	public String getMishuphone() {
		return mishuphone;
	}

	public void setMishuphone(String mishuphone) {
		this.mishuphone = mishuphone;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public GroupmemberMainEntity getEntity() {
		return entity;
	}

	public void setEntity(GroupmemberMainEntity entity) {
		this.entity = entity;
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public long getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(long totalPage) {
		this.totalPage = totalPage;
	}

	public int getMemberid() {
		return memberid;
	}

	public void setMemberid(int memberid) {
		this.memberid = memberid;
	}

	public int getMembertype() {
		return membertype;
	}

	public void setMembertype(int membertype) {
		this.membertype = membertype;
	}

	public String getTruename() {
		return truename;
	}

	public void setTruename(String truename) {
		this.truename = truename;
	}

	public int getGroupcode() {
		return groupcode;
	}

	public void setGroupcode(int groupcode) {
		this.groupcode = groupcode;
	}

	public List<GroupmemberMainEntity> getZhurenList() {
		return zhurenList;
	}

	public void setZhurenList(List<GroupmemberMainEntity> zhurenList) {
		this.zhurenList = zhurenList;
	}

	public List<GroupmemberMainEntity> getChangweiList() {
		return changweiList;
	}

	public void setChangweiList(List<GroupmemberMainEntity> changweiList) {
		this.changweiList = changweiList;
	}




}
