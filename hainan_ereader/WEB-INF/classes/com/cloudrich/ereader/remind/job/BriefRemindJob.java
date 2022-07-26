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
public class BriefRemindJob implements Job {
	/**
	 * 日志
	 */
	private  final Log logger = LogFactory.getLog(BriefRemindJob.class);
	@Override
	public void execute(JobExecutionContext jobExec) throws JobExecutionException {
		System.out.println("6.BriefRemindJob");
		JobDataMap dataMap = jobExec.getJobDetail().getJobDataMap();
		JobEntity entity = (JobEntity) dataMap.get("plan");
		
		BriefRemindTask briefPadTask= new BriefRemindTask();
		//NoticeRemindSmsTask noticeSmsTask= new NoticeRemindSmsTask();
		try {
			briefPadTask.start(entity);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
	}

}
