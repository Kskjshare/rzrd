package com.cloudrich.ereader.util;


import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.ApplicationEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextClosedEvent;
import org.springframework.context.event.ContextStartedEvent;
import org.springframework.context.event.ContextStoppedEvent;

 
public class SpringBeanUtil implements ApplicationContextAware,
		ApplicationListener<ApplicationEvent> {
	
	
	/**
	 * 当前IOC
	 */
	private static ApplicationContext applicationContext;

	private static boolean hasStarted = false;
	
	private Logger logger = Logger.getLogger(SpringBeanUtil.class);

	/**
	 * 设置当前上下文环境，此方法由spring自动装配
	 */
	public void setApplicationContext(ApplicationContext applicationContext) {
		SpringBeanUtil.applicationContext = applicationContext;
	}

	public static boolean isSpringContextReady() {
		return applicationContext != null && hasStarted;
	}

	/**
	 * 从当前IOC获取bean
	 * 
	 * @param id
	 *            bean的id
	 * @return
	 */
	public static Object getObject(String id) {
		return applicationContext == null ? null : applicationContext
				.getBean(id);
	}

	public static <T> T getBean(Class<T> clazz) {
		return applicationContext == null ? null : applicationContext
				.getBean(clazz);
	}

	@Override
	public void onApplicationEvent(ApplicationEvent e) {
		if (e instanceof ContextStartedEvent) {
			hasStarted = true;
		} else if (e instanceof ContextStoppedEvent
				|| e instanceof ContextClosedEvent) {
			hasStarted = false;
		}
	}
	
	public static void ListBeans() {
		int count=applicationContext.getBeanDefinitionCount();
		for(int i=0;i<count;i++){
			System.out.println("bean is--------------------------"+applicationContext.getBeanDefinitionNames()[i]);
			
		}
		
	}
}
