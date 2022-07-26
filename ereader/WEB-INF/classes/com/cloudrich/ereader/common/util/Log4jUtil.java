package com.cloudrich.ereader.common.util;

/**
 * 日志工具类
 * @author LH
 *
 * 2012-2-24下午03:34:28
 */
public class Log4jUtil {

	public static final int DEBUG = 0;   // 调试
	public static final int INFO = 1;    // 信息
	public static final int WARN = 2;    // 警告
	public static final int ERROR = 3;   // 错误
	public static final int FATAL = 4;   // 致命错误

	/**
	 * 记录日志
	 * 
	 * @param e
	 * @param logger
	 * @param level
	 */
	public static void exeLog(Exception e, org.apache.commons.logging.Log logger, int level) {
		exeInfomation("==============================start log===================================", logger, level);
		exeError(e, logger, level);
		exeStackTrace(e, logger, level);
		exeInfomation("==============================end log===================================", logger, level);
	}

	/**
	 * 记录日志
	 * 
	 * @param e
	 * @param cla
	 * @param level
	 */
	public static void exeLog(Exception e, Class<?> cla, int level) {
		org.apache.commons.logging.Log logger = org.apache.commons.logging.LogFactory.getLog(cla);
		exeLog(e, logger, level);
	}

	/**
	 * 记录日志
	 * 
	 * @param infomation
	 * @param logger
	 * @param level
	 */
	public static void exeLog(String infomation, org.apache.commons.logging.Log logger, int level) {
		exeInfomation(infomation, logger, level);
	}

	/**
	 * 记录日志
	 * 
	 * @param infomation
	 * @param cla
	 * @param level
	 */
	public static void exeLog(String infomation, Class<?> cla, int level) {
		org.apache.commons.logging.Log logger = org.apache.commons.logging.LogFactory.getLog(cla);
		exeLog(infomation, logger, level);
	}

	/**
	 * 记录信息
	 * 
	 * @param infomation
	 * @param logger
	 * @param level
	 */
	private static void exeInfomation(String infomation, org.apache.commons.logging.Log logger, int level) {
		switch (level) {
		case Log4jUtil.DEBUG: {
			if (logger.isDebugEnabled()) {
				logger.debug(infomation);
			}
		}
			break;
		case Log4jUtil.INFO: {
			if (logger.isInfoEnabled()) {
				logger.info(infomation);
			}
		}
			break;
		case Log4jUtil.WARN: {
			if (logger.isWarnEnabled()) {
				logger.warn(infomation);
			}
		}
			break;
		case Log4jUtil.ERROR: {
			if (logger.isErrorEnabled()) {
				logger.error(infomation);
			}
		}
			break;
		case Log4jUtil.FATAL: {
			if (logger.isFatalEnabled()) {
				logger.fatal(infomation);
			}
		}
			break;
		}
	}

	/**
	 * 记录各类各方法调用时的错误路径
	 * 
	 * @param e
	 * @param logger
	 * @param level
	 */
	private static void exeStackTrace(Exception e, org.apache.commons.logging.Log logger, int level) {
		String res = "";
		StackTraceElement[] sts = e.getStackTrace();
		for (int i = 0; i < sts.length; i ++) {
			StackTraceElement st = sts[i];
			res = st.getClassName() + "." + st.getMethodName() + "(" + st.getFileName() + "：" + st.getLineNumber() + ")";
			switch (level) {
			case Log4jUtil.DEBUG: {
				if (logger.isDebugEnabled()) {
					logger.debug(res);
				}
			}
				break;
			case Log4jUtil.INFO: {
				if (logger.isInfoEnabled()) {
					logger.info(res);
				}
			}
				break;
			case Log4jUtil.WARN: {
				if (logger.isWarnEnabled()) {
					logger.warn(res);
				}
			}
				break;
			case Log4jUtil.ERROR: {
				if (logger.isErrorEnabled()) {
					logger.error(res);
				}
			}
				break;
			case Log4jUtil.FATAL: {
				if (logger.isFatalEnabled()) {
					logger.fatal(res);
				}
			}
				break;
			}
		}
	}

	/**
	 * 记录发生错误原因
	 * 
	 * @param e
	 * @param logger
	 * @param level
	 */
	private static void exeError(Exception e, org.apache.commons.logging.Log logger, int level) {
		switch (level) {
		case Log4jUtil.DEBUG: {
			if (logger.isDebugEnabled()) {
				logger.debug(e);
			}
		}
			break;
		case Log4jUtil.INFO: {
			if (logger.isInfoEnabled()) {
				logger.info(e);
			}
		}
			break;
		case Log4jUtil.WARN: {
			if (logger.isWarnEnabled()) {
				logger.warn(e);
			}
		}
			break;
		case Log4jUtil.ERROR: {
			if (logger.isErrorEnabled()) {
				logger.error(e);
			}
		}
			break;
		case Log4jUtil.FATAL: {
			if (logger.isFatalEnabled()) {
				logger.fatal(e);
			}
		}
			break;
		}
	}
}
