<%@ page language="java"  pageEncoding="utf-8"%>
<%@ include file="/public/common.jspf" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>人大会议助理_常委会会议</title>
<script type="text/javascript">
function toPage(page){
       document.getElementById("page").value=page;
       document.getElementById("findForm").submit();
} 
function showsmsdetail(id){
    $("#title").siblings().empty();
	var url="<%=basePath%>smsdefine/selectSmsdefineLogDetail.action?logid="+id;
        $.ajax({
	        url: url,
	        type: "POST",
		    async: false,  
		    success: function (data) { 
				 $.each(data,function(n,val){
					 var mes="";
					 if(val.issucess=='0'){
					    mes="成功";
					 }
					 if(val.issucess=='1'){
					 	mes="失败";
					 }
					 var id=val.id;
					 if(id==null||typeof(id)=="undefined" || id==0){
					    id="";
					 }
					 var name=val.name;
					 if(name==null||typeof(name)=="undefined" || name==0){
					    name="";
					 }
					 var phonenum=val.phonenum;
					 if(phonenum==null||typeof(phonenum)=="undefined" || phonenum==0){
					    phonenum="";
					 }
					 var sendtime=val.sendtime;
					 if(sendtime==null||typeof(sendtime)=="undefined" || sendtime==0){
					    sendtime="";
					 }						 					 					 					 
		    		$("#title").after("<tr><td  width=10%>"+id+"</td><td  width=20%>"+name+"</td><td  width=20%>"+phonenum+"</td><td  width=30%>"+sendtime.replace(/T/,' ')+"</td><td  width=20%>"+mes+"</td></tr>");
		    	});
		    },  
	        error: function () {   
	               $.messager.alert("操作提示","操作失败","error"); 
	        }  
       }); 
      $("#popwindow").window("open");
}
$(function () {
	$('#smsremind').click(function(){
			window.location.href="<%=basePath %>/smsdefine/selectSmsdefineMain.action?pageNo=1&pageSize=8";
	 });
});
</script>
</head>

<body>
        <div class="cwh_head">
             短信管理
        </div>
<!--此处内容更替-->
        <div class="icon_head">
             <form action="<%=basePath %>/smsdefine/selectSmsdefineLog.action?pageSize=8" id="findForm" method="post">
	                  <s:hidden name="pageNo" id="page"></s:hidden>
              <!--    <button class="button1" id="smsremind" name="" type="button">提醒维护</button> -->
              </form>
        </div>
 	   <a class='easyui-linkbutton' data-options="iconCls:'icon-modify'" style="line-height: 25px;width:115px;color:#a10000;right:20px;top:65px;position: absolute;" id="smsremind">提醒维护</a>						       
        <div class="tongzhi">
            <div style="height:20px;"></div>
            <div class="tongzhi_main">
              <div class="smsdefine_right">
	           <div style="width:90%;margin:10px auto;">
	                 <table cellpadding="0" cellspacing="0" border="0" width="100%" style="table-layout:fixed;">
	                  <tr>
	                	<th class="thfirst_smsdefine">手机提醒内容</th>
	                	<th class="th_smsdefine">发送人员</th>
	                	<th class="th_smsdefine">发送时间</th>
	                 </tr>
	                <s:iterator value="page.result" id="stat">
	              	  <tr><td colspan="9" height="5"></td></tr>
	                   <td class="tdfirst_smsdefine" style="text-align: left;">&nbsp;&nbsp;<span title="<s:property value="smscontent"/>"><s:property value="smscontent"/></span></td>
	                	<td class="td_smsdefine"><a onclick="showsmsdetail('<s:property value="logid"/>')" style="cursor:pointer;">详情</a></td>
	                	<td class="td_smsdefine"><s:date name="senddate" format="yyy-MM-dd HH:mm"/></td>
	              	 </tr>
	                 </s:iterator>
	              </table>
	              
	             <!-- 分页 --> 
	             <s:if test="totalPage>1">
               <div id="page">
                	<s:if test="totalPage==0"></s:if>
             <s:else>
                  <a href="javascript:toPage(1);">首页</a>
                  <s:if test="pageNo==1"><a href="javascript:;">上一页</a></s:if>
                  <s:else><a href="javascript:toPage(<s:property value="pageNo-1"/>);">上一页</a></s:else>
                  <%--小于12页 --%>
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
                   <%--大于7页 小于12--%>
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
            <!-- 分页 -->
            		<!-- 弹窗 -->
		<div id="popwindow" class="easyui-window" closed="true" data-options="iconCls:'icon-save'" title="详情" style="width:630px;height:300px;padding:10px;">
			<div class="smsdefinetable">
					<table cellpadding="0" cellspacing="0" width="10%">
						<tr id="title" >
							<th  width=10%>编号</td>
							<th  width=20%>系统用户姓名</td>
							<th  width=20%>手机号码</td>
							<th  width=30%>发送时间</td>
							<th  width=20%>是否成功</td>
						</tr>
					</table>
			</div>
		</div>
		<!-- 弹窗 -->
		
        </div>
      </div>
   </div>
   </div>
<!--此处内容更替结束-->

</body>
</html>
