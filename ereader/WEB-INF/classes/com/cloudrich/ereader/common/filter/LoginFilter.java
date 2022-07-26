package com.cloudrich.ereader.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.cloudrich.ereader.common.constant.LoginConstant;
import com.cloudrich.ereader.login.entity.LoginUser;
import com.cloudrich.ereader.meeting.entity.MeetMainEntity;
import com.cloudrich.ereader.meeting.service.MeetingViewService;

public class LoginFilter implements Filter {

	private String[] includesFilter;
	private String[] excludesFilter;
	
	private MeetingViewService meetingViewService;
	 //存储编码格式信息
	 private String encode = null;
	
	public MeetingViewService getMeetingViewService() {
		return meetingViewService;
	}

	public void setMeetingViewService(MeetingViewService meetingViewService) {
		this.meetingViewService = meetingViewService;
	}

	public void init(FilterConfig filterConfig) throws ServletException {
		System.out.println("**过滤器初始化...");
		 this.encode = filterConfig.getInitParameter("encode");
        ServletContext context = filterConfig.getServletContext();  
        ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(context);  
        meetingViewService = (MeetingViewService) ctx.getBean(MeetingViewService.class); 
		
		String includes = filterConfig.getInitParameter("includes");
		if (includes != null) {
			includesFilter = includes.split(",");
		}
		String excludes = filterConfig.getInitParameter("excludes");
//		System.out.println("excludes:"+excludes);
		if (excludes != null) {
			excludesFilter = excludes.split(",");
		}
	}

	private boolean isInclude(String uri) {
		if (includesFilter != null && excludesFilter.length > 0) {
			for (String includePattern : includesFilter) {
				if (uri.matches(includePattern)) {
					return true;
				}
			}
			return false;
		}
		return true;
	}
	
	private boolean isExclude(String uri) {
		if (excludesFilter != null) {
			for (String includePattern : excludesFilter) {
//				System.out.println("excludesFilter:"+excludesFilter);
				if (uri.matches(includePattern)) {
					return true;
				}
			}
		}
		return false;
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		// Session属于HTTP范畴，所以ServletRequest对象需要先转换成HttpServletRequest对象
		HttpServletRequest req = (HttpServletRequest) request;
		HttpSession session = req.getSession();
		HttpServletResponse res = (HttpServletResponse) response;
		// // 如果请求的路径与forwardUrl相同，或请求的路径是排除的URL时，则直接放行
				
		StringBuffer fileURL = req.getRequestURL();
		// 如果session不为空，则可以浏览其他页面
	      //System.out.println("------"+session.getAttribute(LoginConstant.USER));
	     
	      LoginUser user = (LoginUser) session.getAttribute(LoginConstant.USER);
	      
	      if(this.encode != null && !this.encode.equals("")){
	    	   request.setCharacterEncoding(this.encode);
	    	   response.setCharacterEncoding(this.encode);
	    	  }else{
	    	   request.setCharacterEncoding("UTF-8");
	    	   response.setCharacterEncoding("UTF-8");
	    	  }
	      
	    if (user != null) {
	    	String uri = req.getRequestURI();
	    	//过滤的会议url,包括action及jsp页面
	    	String[] filterStr={"meet_","/module/main","getMeetingInfo","saveOrUpdateMeeting","getYichengInfo","selectCurMeeting","ListByVersion"};
	    	for (int i = 0; i < filterStr.length; i++) {
				if(uri.indexOf(filterStr[i])>-1){
					String meetid=req.getParameter("meetid");
					if(!"".equals(meetid)&&meetid!=null){
						MeetMainEntity entity=	meetingViewService.selectMeetBasicByMeetId(Integer.parseInt(meetid));
						if(entity!=null&&entity.getIsdel()==1){
							String path = req.getContextPath();
							String basePath = req.getScheme() + "://" + req.getServerName()
									+ ":" + req.getServerPort() + path + "/";	
							if(entity.getIsdel()==1){
								String meetPage="/index.jsp";
							  //res.sendRedirect(basePath+"/module/main/main.jsp");
							 // req.getRequestDispatcher("/module/main/main.jsp").forward(req, res);
								res.getWriter().println("<script type = 'text/javascript' > ");
								res.getWriter().println(
										"top.location.href = '"  +path+ meetPage + "'");
								res.getWriter().println("</script>");
								  return;
							}
							//System.out.println("isdel===="+entity.getIsdel());
						}
					}	
					break;
				}
			}	
			chain.doFilter(req, res);
		} else {
			String uri = req.getRequestURI();
//			System.out.println("uri0:"+uri);
			if (isInclude(uri)) {
//				System.out.println("uri:"+uri);
				if (isExclude(uri)) {
//					System.out.println("uri2:"+uri);
					chain.doFilter(req, res);
					return;
				}
				String loginPage = "login.jsp";
				String path = req.getContextPath();
				String basePath = req.getScheme() + "://" + req.getServerName()
						+ ":" + req.getServerPort() + path + "/";
				res.getWriter().println("<script type = 'text/javascript' > ");
				res.getWriter().println(
						"top.location.href = '" + basePath + loginPage + "'");
				res.getWriter().println("</script>");
			} else {
				chain.doFilter(req, res);
			}
		}
	}

	public void destroy() {
		System.out.println("**过滤器销毁...");
	}

	public static void main(String[] args) {
	}
}
