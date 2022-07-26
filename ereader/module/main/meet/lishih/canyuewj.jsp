<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
 <%@ include file="/public/common.jspf" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">  
<style type="text/css">

</style>
    <script type="text/javascript">
    	function jump(locate){
    		window.location.href=locate;
    	}
    	
    	function toPage(page){
            	document.getElementById("page").value=page;
            	document.getElementById("findForm").submit();
            }
       function downLoad(path){
            var filepath=path.substring(path.indexOf('upload'));
            alert(filepath);
  
       }
    </script>
</head>

<body>
    <div >

        <div class="cwh_head">
            参阅文件
        </div>
<!--此处内容更替-->
        <div class="tongzhi">
        <form action="<%=basePath%>selectMeetFileList.action" id="findForm" method="post">
            <ul>
            <s:iterator value="fileMainList" id="rodo">
            	<li style="margin-top:0px;"><a href="<%=basePath %>upload/<s:property value="filepath"/>" style="cursor: hand;" target="_blank" title="<s:property value="title"/>">
            	<s:if test="%{#rodo.title.length()>55}"> 
				<s:property value="%{#rodo.title.substring(0,55)}" />...</s:if>
				<s:else> 
						<s:property value="title" />
				</s:else>
            	</a><a href="<%=basePath %>upload/<s:property value="filepath" />" target="_blank"  class="button2" ><img src="<%=basePath %><%=themespath%>/images/button2.png"/></a></li>
            </s:iterator>
            </ul>
   	</head>
	<body>
        </form>
        </div>
<!--此处内容更替结束-->
</div>
</body>
</html>
