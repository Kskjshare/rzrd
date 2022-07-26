/**
 * 
 */
package com.cloudrich.ereader.common.interceptor;

import com.cloudrich.ereader.common.constant.LoginConstant;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;

/**
 * @author Administrator
 *
 */
public class LoginInterceptor extends MethodFilterInterceptor  {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7235894273930897432L;

	/**
	 * 
	 */
	public LoginInterceptor() {
	}
	
	@Override
	protected String doIntercept(ActionInvocation invocation) throws Exception {
		Object loginUserName = ActionContext.getContext().getSession().get(LoginConstant.USER);  
        if(null == loginUserName){
            return LoginConstant.VIEW_LOGIN;  // 这里返回用户登录页面视图  
        }
        return invocation.invoke();
	}
}
