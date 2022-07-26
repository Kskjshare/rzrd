package com.cloudrich.framework.job;

import java.util.HashMap;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.Job;
import org.quartz.SchedulerException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cloudrich.framework.job.common.IJob;
import com.cloudrich.framework.job.common.ScheduleManager;


@Service
public class JobEngine {
	/**
	 * 日志
	 */
	private  final Log logger = LogFactory.getLog(JobEngine.class);
	/**
	 * job计划Manager
	 */
	private ScheduleManager scheduleManager;
	/**
	 * job key
	 */
	private static final String JOB_KEY = "remind-Job-";
	
	public JobEngine(){}
	/**
	 * 启动job任务
	 * @param
	 */
	public void startJob(JobEntity entity,Job remindjob) throws ClassNotFoundException, SchedulerException{
		System.out.println("4.启动Job任务");
		IJob job = creatJob(entity,remindjob);
		//调度Job
		String jobKey=JOB_KEY+entity.getJobtype().trim()+"-"+entity.getJobtype2().trim()+"-"+entity.getId();
		if(this.scheduleManager.isExists(jobKey)){
			System.out.println("---crontab is---:"+this.scheduleManager.isExists(jobKey));
			this.scheduleManager.updateJob(jobKey, job);
		}else{
			this.scheduleManager.scheduleJob(job);
		}
		System.out.println("Job启动结束");
		
	}
	
	public void updateJob(JobEntity entity,Job remindjob) throws ClassNotFoundException, SchedulerException{
		String jobKey=JOB_KEY+entity.getJobtype().trim()+"-"+entity.getJobtype2().trim()+"-"+entity.getId();
		System.out.println("update jobkey is:"+jobKey);
		IJob job = creatJob(entity,remindjob);
		this.scheduleManager.updateJob(jobKey, job);
	}	
	
	private IJob creatJob(JobEntity entity,Job remindjob){
		
		String cronExpression=entity.getCronexpression();
		//jobkey=JOB_KEY+备份计划ID
		String jobKey=JOB_KEY+entity.getJobtype().trim()+"-"+entity.getJobtype2().trim()+"-"+entity.getId();
		System.out.println("create jobkey is:"+jobKey);
		HashMap<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("plan", entity);
		//运行周期（测试用），根据  0 0/10 * * * ?
		//cronExpression="0 */1 * * * ?";
		IJob iremindJob=new IJob(jobKey,remindjob,cronExpression,dataMap);
		return iremindJob;
	}
	
	

	
	/**
	 * 单个删除job
	 * @throws ClassNotFoundException
	 * @throws SchedulerException
	 */
	public void stopJob(int entityId,String jobtype,String jobtype2) throws ClassNotFoundException, SchedulerException{
		
		String jobKey=JOB_KEY+jobtype.trim()+"-"+jobtype2.trim()+"-"+entityId;
			System.out.println("delete jobkey is:"+jobKey);
			this.scheduleManager.deleteJob(jobKey);
		
	}
	
	public ScheduleManager getScheduleManager() {
		return scheduleManager;
	}
	
	@Autowired
	public void setScheduleManager(ScheduleManager scheduleManager) {
		this.scheduleManager = scheduleManager;
	}
}
