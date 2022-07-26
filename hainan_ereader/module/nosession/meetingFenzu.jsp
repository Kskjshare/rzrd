<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%
String meetingid = request.getParameter("meetingid");
String fenzuid = request.getParameter("fenzuid");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <%@include file="/public/common.jspf" %>
<script type="text/javascript">
		var meetingid = "<%=meetingid%>";
		var fenzuid = "<%=fenzuid%>";
           $(document).ready(function (){
				var canhuicontext="";
			    $.ajax({
					url:"<%=basePath%>service/service_getFenzu.action?meetingid="+meetingid+"&fenzuid="+fenzuid,
					success:function (data){
						if(data.state){
							document.getElementById('content').innerHTML=data.groupcontent;
						}
					}
				});
				
<!--				$.ajax({-->
<!--				url:'<%=basePath%>sys/canhui/canhuiAction!zhuyishixiang.action',-->
<!--				type:'post',-->
<!--				success:function  (data){-->
<!--					document.getElementById('content2').innerHTML=data[0].canhuicontext;-->
<!--				}-->
<!--				});-->
		
			});	
		
			
			
			
		</script>
  </head>
  
  <body>
   
   <div id="content" style="align:center;">
   		
   </div>
<!--   <div id="content2" style="align:center;margin-top:50px;">-->
<!--   -->
<!--   </div>-->
  </body>
</html>
