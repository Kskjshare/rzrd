package com.cloudrich.ereader.briefing.action;

import java.io.File;
import java.util.Date;

import javax.annotation.Resource;

import com.cloudrich.ereader.briefing.entity.MeetBriefingMainEntity;
import com.cloudrich.ereader.briefing.service.BriefingService;
import com.cloudrich.ereader.common.action.BaseAction;
import com.cloudrich.ereader.notice.constant.NotifyConstant;
import com.cloudrich.ereader.notice.entity.NoticeMainEntity;
import com.opensymphony.xwork2.ActionSupport;

public class BriefingAction extends BaseAction{
	private static final long serialVersionUID = 1L;
	@Resource BriefingService briefingService;
	private MeetBriefingMainEntity briefingEntity;
	private String briefingname;
	private String id;
	private String fileUploadFileName;
	private File fileUpload;
	private String path;
	private String filename;
	private String periods;
	private String content;
	
	private File file;
	private String fileFileName,cmid;
	private String filepath;
	
	private int meetingid;
	
	
}
