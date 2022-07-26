package com.cloudrich.ereader.system.action;


import java.util.HashMap;
import java.util.List;
import java.util.Map;


import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.cloudrich.ereader.common.action.BaseAction;

import com.cloudrich.ereader.dict.service.DictDataService;
import com.cloudrich.ereader.meeting.entity.MeetMainEntity;
import com.cloudrich.ereader.meeting.service.MeetingService;
import com.opensymphony.xwork2.ActionSupport;

@Controller("MeetMaintainAction")
@Scope("prototype")
public class MeetMaintainAction extends BaseAction{
	
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Resource MeetingService meetService;
	@Resource DictDataService dictDataService;
	private int meetid;
    private List<MeetMainEntity> list;


	public List<MeetMainEntity> getList() {
		return list;
	}

	public void setList(List<MeetMainEntity> list) {
		this.list = list;
	}

	public int getMeetid() {
		return meetid;
	}

	public void setMeetid(int meetid) {
		this.meetid = meetid;
	}

	public String selectAllTypeCurMeeting(){
		list=meetService.selectAllTypeCurMeeting();
		for(int i=0;i<list.size();i++){
			System.out.println(list.get(i).getMname());
			String mtype=list.get(i).getMtype();
			String mtypeDict=dictDataService.getNameByTypeAndcode("mtype", mtype);
			System.out.println(dictDataService.getNameByTypeAndcode("mtype", mtype));
			list.get(i).setMtype(mtypeDict);
		}
		return ActionSupport.SUCCESS;
	}

	public String deleteMeet() {
	    try {
			meetService.deleteMeet(meetid);
			jsonSuccess("注销成功");
		} catch (Exception e) {
			e.printStackTrace();
			jsonError("注销失败");
		}
	    return ActionSupport.SUCCESS;
	}
}
