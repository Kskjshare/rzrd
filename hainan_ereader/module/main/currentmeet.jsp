<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/public/common.jspf" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
  </head>
<body></body>
<%
	String mtype = request.getParameter("type");
	//String meetingid=request.getSession().getAttribute("currentmeetid");
	//
%>
<%
              String meetpath=null;
              String title="";
             // out.println(mtype);
             // out.println(mtype!=null&&mtype.trim().equals("1"));
             	int ty=Integer.parseInt(mtype);
             	String meetpathexist=null;
              if(mtype!=null&&mtype.trim().equals("1")){
          			meetpath="module/main/meet/zhurenh/index.jsp?type=1&meetid=0";
          			meetpathexist="module/main/meet/zhurenh/index.jsp?type=1";
          			title=" 主页>主任会议";
              }else if(mtype!=null&&mtype.trim().equals("2")){
           			meetpath="module/main/meet/changwh/index.jsp?type=2&meetid=0";
           			meetpathexist="module/main/meet/changwh/index.jsp?type=2";
           			title=" 主页>常委会会议";
              }else if(mtype!=null&&mtype.trim().equals("3")){
           			meetpath="module/main/meet/zhurenh/index.jsp?type=3&meetid=0";
           			meetpathexist="module/main/meet/zhurenh/index.jsp?type=3";
           			title=" 主页>法制委员会会议";
              }else if(mtype!=null&&mtype.trim().equals("4")){
           			meetpath="module/main/meet/zhurenh/index.jsp?type=4&meetid=0";
           			meetpathexist="module/main/meet/zhurenh/index.jsp?type=4";
           			title=" 主页>财政经济委员会会议";
              }else if(mtype!=null&&mtype.trim().equals("5")){
              		meetpath="module/main/meet/zhurenh/index.jsp?type=5&meetid=0";
           			meetpathexist="module/main/meet/zhurenh/index.jsp?type=5";
           			title=" 主页>其他会议";
              }
            %>
		<script type="text/javascript">
			$(function(){
				$('#selectHisMeeting').click(function(){
					var type=parseInt("<%=mtype%>");
					//alert("type;"+type);
					selectHisMeeting(type);
    			});
			});
			function selectHisMeeting(type){
				window.location.href="<%=basePath %>selectHisMeeting.action?type="+type+"&pageNo=1&pageSize=8";
			}	
		</script>
        <!--此处内容更替-->
        <div class="cwh_head">
              <%=title %> 
        </div>
    	<div class="cwh_topblank"></div>
    	<div class="cwh_head1">当前会议</div>
        <div class="cwh_top">
           <div class="cwh_neirong">
         		<s:if test="meeting==null">
         			<a href="<%=meetpath%>">
	            		<img src="<%=basePath%><%=themespath%>images/cwh_tianjia.png" /></a>
         		</s:if>
                <s:else>
                	<a href="<%=basePath %>getMeetingInfo.action?meetid=<s:property value="meeting.meetid"/>&type=<%=ty%>" style="font-size: 38px;color:#A10000"><s:property value="meeting.mname"/></a>
                	<div class="cwh_font">
                		<s:date name="meeting.sdate" format="yyyy年MM月dd日  HH:mm"/>-
                		<s:date name="meeting.edate" format="yyyy年MM月dd日  HH:mm"/>
                	</div>
                	
                	<%
                	if(mtype!=null&&(mtype.trim().equals("2"))){
                	 %>
                	<div class="cwh_icon">
                	    <a href="<%=basePath %>meet_getBriefingList.action?meetid=<s:property value="meeting.meetid"/>&type=<s:property value="meeting.mtype"/>">
                			<img src="<%=basePath%><%=themespath%>images/cwh_icon.png" />
                		</a>
                	</div>
                	
                	<%}else if(mtype!=null&&mtype.trim().equals("1")){ %>
                	
                	<div class="cwh_icon">
                	    <a href="<%=basePath %>meet_getJiyaoList.action?meetid=<s:property value="meeting.meetid"/>&type=<s:property value="meeting.mtype"/>">
                			<img src="<%=basePath%><%=themespath%>images/icon_jiyao.png" />
                		</a>
                	</div>
                	<%} %>
                </s:else>
	           
	         
           </div>
           
        </div>


        <div class="icon_head1">
            <input class="button3" name="" value="历史会议" id="selectHisMeeting" type="button" style="position:absolute; right:20px;"/>
        </div>
        
<!--此处内容更替结束-->
</body>
</html>