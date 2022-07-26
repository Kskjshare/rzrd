package com.cloudrich.ereader.remind.job;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.DisallowConcurrentExecution;
import org.quartz.Job;
import org.quartz.JobDataMap;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cloudrich.framework.job.JobEntity;


@DisallowConcurrentExecution
public class SmsMgrRemindJob implements Job {
	/**
	 * 日志
	 */
	private  final Log logger = LogFactory.getLog(SmsMgrRemindJob.class);
	@Override
	public void execute(JobExecutionContext jobExec) throws JobExecutionException {
		System.out.println("6.SmsMgrRemindJob");
		JobDataMap dataMap = jobExec.getJobDetail().getJobDataMap();
		JobEntity entity = (JobEntity) dataMap.get("plan");
		
		SmsMgrRemindTask smsMgrTask= new SmsMgrRemindTask();
		
		try {
			smsMgrTask.start(entity);
		} catch (Exception e) {
			logger.error(e.getMessage());
			e.printStackTrace();
		}
		
	}

}
