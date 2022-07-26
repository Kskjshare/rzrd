<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
 <%@ include file="/public/common.jspf" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">  
<style type="text/css">
<%
String mtype=request.getParameter("type");
%>
</style>
    <script type="text/javascript">
    	function jump(){
    		window.history.go(-1);
    	}
    	
    	function toPage(page){
            	document.getElementById("page").value=page;
            	document.getElementById("findForm").submit();
            }
        $(function(){
        	var type=parseInt("<%=mtype%>");
        	$('#type').val(type);
        })
    </script>
</head>

<body>
    <div >

        <div class="cwh_head">
           	 历史会议
        </div>
<!--此处内容更替-->
        <div class="icon_head">
           <!--  <button class="button1" name="" type="button" onclick="goback()">返回&nbsp;&nbsp;&nbsp;</button> -->
        </div>
        <a class='easyui-linkbutton'  onclick="javascript:goback()" data-options="iconCls:'icon-Undo'" style="right:20px;position:absolute;margin-top:10px;z-index: 9px;top:5px;" >返回</a>                        
        <div class="tongzhi">
        <form action="selectHisMeeting.action" id="findForm" method="post">
        
        <s:hidden name="type" id="type" ></s:hidden>
        <s:hidden name="pageNo" id="page" ></s:hidden>
            <ul>
            <s:iterator value="page.result"> 
            		<li style="margin-top:0px;"><s:property value="mname"/><a href="<%=basePath %>showHistoryMeet.action?meetid=<s:property value="meetid"/>&type=<%=mtype%>" class="button2" target="_blank"><img src="<%=basePath%><%=themespath%>images/button2.png"/></a></li>
<!--            	<li style="margin-top:0px;"><s:property value="mname"/><a href="<%=basePath %>getMeetingInfo.action?meetid<s:property value="meetid"/>" class="button2"><img src="<%=basePath%><%=themespath%>images/button2.png"/></a></li>-->
            </s:iterator>
            </ul>
    <style>
    #page a.current_page{
    background: #DEE5FA;
    border: #89bdd8 solid 1px;
    color: #2e6ab1;
    font-size: 15px;
	}
	#page a, #page a.current_page:hover
	{
    padding: 5px 7px;
    text-decoration:none;
     color: #2e6ab1;
     font-size: 15px;
	}
	#page{
	margin-top:20px;
	}
	
    </style>
   	</head>
	<body>
	<s:if test="totalPage>1">
	<div id="page">
                	<s:if test="totalPage==0"></s:if>
             <s:else>
                  <a href="javascript:toPage(1);">首页</a>
                  <s:if test="pageNo==1"><a href="javascript:;">上一页</a></s:if>
                  <s:else><a href="javascript:toPage(<s:property value="pageNo-1"/>);">上一页</a></s:else>
                 
                  <s:if test="pageNo<8">
                    	<s:if test="totalPage<12">
                   			 <s:iterator begin="1" end="totalPage" var="p">
                    			<s:if test="#p==pageNo">
                    				<a href="javascript:toPage(<s:property value="#p"/>);" class="current_page"><s:property value="#p"/></a>
                    			</s:if>
                    			<s:else>
                    				<a href="javascript:toPage(<s:property value="#p"/>);"><s:property value="#p"/></a>
                    			</s:else>
                    		</s:iterator>
                   	   	</s:if>
                    	<s:else>
                    		<s:iterator begin="1" end="12" var="p">
                    			<s:if test="#p==pageNo">
                    				<a href="javascript:toPage(<s:property value="#p"/>);" class="current_page"><s:property value="#p"/></a>
                    			</s:if>
                    			<s:else>
                    				<a href="javascript:toPage(<s:property value="#p"/>);"><s:property value="#p"/></a>
                   				 </s:else>
                  			</s:iterator>
                    	</s:else>
                  </s:if>
                  
                   <s:if test="pageNo>7">
                   		<s:if test="totalPage<13">
                   			<s:iterator begin="1" end="totalPage" var="p">
                    			<s:if test="#p==pageNo">
                    				<a href="javascript:toPage(<s:property value="#p"/>);" class="current_page"><s:property value="#p"/></a>
                    			</s:if>
                    			<s:else>
                    				<a href="javascript:toPage(<s:property value="#p"/>);"><s:property value="#p"/></a>
                   				 </s:else>
                  			</s:iterator>
                   		</s:if>
                   		<s:if test="totalPage>12">
                   			<s:if test="pageNo+4<totalPage">
                   			<%for(int i=6;i>-6;i--){ 
                     		//System.out.println("i:"+i);
                   			  request.setAttribute("ii",i);
                   			  %>
                      		 <s:if test="pageNo==pageNo+#attr.ii">
                     			<a href="javascript:toPage(${pageNo-ii});" class="current_page">${pageNo+ii }</a>
                  			 </s:if>
                  			 <s:else>
                   			 	<a href="javascript:toPage(${pageNo-ii});">${pageNo-ii}</a>
                   			 </s:else>
                    		 <%} %>
                    		 </s:if>
                   			 <s:else>
                   			 	<%for(int i=11;i>-1;i--){ 
                     		//System.out.println("i:"+i);
                   			  request.setAttribute("ii",i);
                   			  %>
                      		 <s:if test="pageNo==pageNo+#attr.ii">
                     			<a href="javascript:toPage(${pageNo-ii});" class="current_page">${pageNo+ii }</a>
                  			 </s:if>
                  			 <s:else>
                  			 	<s:if test="pageNo-#attr.ii>0">
                   			 	<a href="javascript:toPage(${pageNo-ii});">${pageNo-ii}</a>
                   			 	</s:if>
                   			 </s:else>
                    		 <%} %>
                   			 </s:else>
                   		</s:if>
                   </s:if>
                    <s:if test="pageNo==totalPage"><a href="javascript:;">下一页</a></s:if>
                    <s:else><a href="javascript:toPage(<s:property value="pageNo+1"/>);">下一页</a></s:else>
                    <a href="javascript:toPage(<s:property value="totalPage"/>);">末页</a>
          			</s:else>
                    <a>共<s:property value="totalPage"/> 页</a>
                </div>  
                </s:if>
        </form>
        </div>
<!--此处内容更替结束-->
</div>
</body>
</html>
