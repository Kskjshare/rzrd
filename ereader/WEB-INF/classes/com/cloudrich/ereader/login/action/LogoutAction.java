package com.cloudrich.ereader.login.action;

import org.springframework.stereotype.Controller;

import com.cloudrich.ereader.common.action.BaseAction;
import com.cloudrich.ereader.common.constant.LoginConstant;

@Controller("LogoutAction")
public class LogoutAction extends BaseAction {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1569526743581556803L;
	public static String page;// 登陆者的cmid,用以区分退出到哪套界面

	public String getPage() {
		return page;
	}

	public void setPage(String page) {
		LogoutAction.page = page;
	}

	public String logout() {
		if (this.getSessionUser() == null) {
			return SUCCESS;
		} else {
			this.getSession().removeAttribute(LoginConstant.USER);
			this.getSession().invalidate();
			return SUCCESS;
		}
	}
}
