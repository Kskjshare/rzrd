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
public class MeetFileRemindJob implements Job {
	/**
	 * 日志
	 */
	private  final Log logger = LogFactory.getLog(BriefRemindJob.class);
	@Override
	public void execute(JobExecutionContext jobExec) throws JobExecutionException {
		JobDataMap dataMap = jobExec.getJobDetail().getJobDataMap();
		JobEntity entity = (JobEntity) dataMap.get("plan");
		
		MeetFileRemindTask meetfileTask= new MeetFileRemindTask();
		
		try {
			meetfileTask.start(entity);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
	}

}
