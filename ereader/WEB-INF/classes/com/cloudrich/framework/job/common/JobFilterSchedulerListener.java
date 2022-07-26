
package com.cloudrich.framework.job.common;

import org.quartz.JobKey;
import org.quartz.listeners.SchedulerListenerSupport;


public class JobFilterSchedulerListener extends SchedulerListenerSupport {

	private ScheduleJobFilter scheduleJobFilter;

	/**
	 * 
	 */
	public JobFilterSchedulerListener(ScheduleJobFilter scheduleJobFilter) {
		this.scheduleJobFilter = scheduleJobFilter;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * org.quartz.listeners.SchedulerListenerSupport#jobDeleted(org.quartz.JobKey
	 * )
	 */
	@Override
	public void jobDeleted(JobKey jobKey) {
		super.jobDeleted(jobKey);
		this.scheduleJobFilter.unregisterJob(jobKey.getName());
	}
}
