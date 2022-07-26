package com.cloudrich.ereader.util;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

public class GetApplicationContext {  
  
  
    private static class ApplicationContextHolder {  
        // 单例变量  
        private static ApplicationContext AC = new FileSystemXmlApplicationContext(  
                "classpath:spring.xml");  
    }  
  
  
    // 私有化的构造方法，保证外部的类不能通过构造器来实例化。  
    private GetApplicationContext() {  
  
  
    }  
  
  
    // 获取单例对象实例  
    public static ApplicationContext getInstance() {  
        if (ApplicationContextHolder.AC == null) {  
            ApplicationContextHolder.AC = new FileSystemXmlApplicationContext(  
                    "classpath:spring.xml");  
        }  
        return ApplicationContextHolder.AC;  
    }  
    
    public static void main(String[] args){
    	
		GetApplicationContext.getInstance().getBeanDefinitionNames();
		//逐个打印出spring自动装配的bean。根据我的测试，类名第一个字母小写即bean的名字  
		for(int i=0;i<33;i++){  
		    System.out.println(GetApplicationContext.getInstance().getBeanDefinitionNames()[i]);  
		}
	}
}  

