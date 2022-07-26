<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
 <%@ include file="/public/common.jspf" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    

  </head>
  
  <body class="easyui-layout" >
<div class="mainicon">
           <% 
       //增加权限控制
 			//Map<String,Object> permission=user.getPermissionmap();
            //String usertype=user.getUsertype().trim();
 			if(usertype!=null&&usertype.equals("1")){  
         %>
        <div class="top">
        </div>
        <div class="bottom">
           <ul>
            <li><a href="<%=basePath %>selectCurMeeting.action?type=2"><img src="<%=basePath %><%=themespath%>/images/mainicon_05.png"/></a></li>
              <li><a href="<%=basePath %>selectCurMeeting.action?type=1"><img src="<%=basePath %><%=themespath%>/images/mainicon_03.png"/></a></li>
             <li><a href="<%=basePath %>selectCurMeeting.action?type=5"><img src="<%=basePath %><%=themespath%>/images/mainicon_10.png"/></a></li>
           </ul>
        </div>
      </div>
      <% 
     	 }else{
     		if(permission!=null){
 				
     			boolean b1=permission.get("1")!=null&&permission.get("1").toString().equals("0");
     			boolean b2=permission.get("2")!=null&&permission.get("2").toString().equals("0");
     			boolean b3=permission.get("3")!=null&&permission.get("3").toString().equals("0");
     			boolean b4=permission.get("4")!=null&&permission.get("4").toString().equals("0");
     			boolean b5=permission.get("5")!=null&&permission.get("5").toString().equals("0");
      %>
        <div class="top">
           <ul>
             <% 
             if(b2){  
             %>
             <li><a href="<%=basePath %>selectCurMeeting.action?type=2"><img src="<%=basePath %><%=themespath%>/images/mainicon_05.png"/></a></li>
             <%}
             if(b1){ 
             %>
              <li><a href="<%=basePath %>selectCurMeeting.action?type=1"><img src="<%=basePath %><%=themespath%>/images/mainicon_03.png"/></a></li>
             <%} %>
           </ul>
        </div>
        <div class="bottom">
           <ul>
           <%if(b3){ %>
             <li><a href="<%=basePath %>selectCurMeeting.action?type=3"><img src="<%=basePath %><%=themespath%>/images/mainicon_13.png"/></a></li>
             <%}
             if(b4){
             %>
             <li><a href="<%=basePath %>selectCurMeeting.action?type=4"><img src="<%=basePath %><%=themespath%>/images/mainicon_15.png"/></a></li>
             <%}
             if(b5){
             %>
             <li><a href="<%=basePath %>selectCurMeeting.action?type=5"><img src="<%=basePath %><%=themespath%>/images/mainicon_10.png"/></a></li>
             <%} %>
           </ul>
        </div>
      </div>
      <%}
     	  }
      %>
   </div>
  </body>
</html>
