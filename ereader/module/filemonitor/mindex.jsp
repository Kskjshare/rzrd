<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/public/common.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>人大会议助理_常委会会议</title>
<script>
$(function(){
	var flag='${flag}';
   	if(flag=='1'){
   		$("#findForm").attr("action","<%=basePath %>filemonitor/allReceived.action");
   	}else if(flag=="2"){
   		$("#findForm").attr("action","<%=basePath %>filemonitor/allNotReceived.action");
   	}else if(flag=="3"){
   		$("#findForm").attr("action","<%=basePath %>filemonitor/notAllReceived.action");
   	}else{
   		$("#findForm").attr("action","<%=basePath%>filemonitor/select.action");
   	}
})
function toPage(page){
   	document.getElementById("page").value=page;
   	document.getElementById("findForm").submit();
}
function jump(locate){
	window.location.href=locate;
}
function searchlist(){
	document.getElementById("page").value="1";
	$("#findForm").attr("action","<%=basePath%>filemonitor/select.action");
	$("#findForm").append('<input type="hidden" name="fmList"/>');
	document.getElementById("findForm").submit();
}
</script>
<style>
#page a.current_page {
	background: #DEE5FA;
	border: #89bdd8 solid 1px;
	color: #2e6ab1;
	font-size: 15px;
}

#page a,#page a.current_page:hover {
	padding: 5px 7px;
	text-decoration: none;
	color: #2e6ab1;
	font-size: 15px;
}

#page {
	margin-top: 20px;
}

#mtype {
	width: 160px;
	height: 30px;
	line-height: 30px;
	margin: 5px 20px auto 10px;
	float: left;
}

#meetid {
	width: 220px;
	height: 30px;
	line-height: 30px;
	margin: 5px;
	float: left;
}

.nobr br {
	display: none;
}

.th_tongyong {
	width: 11%;
	height: 40px;
	line-height: 40px;
	font-size: 16px;
	color: #333;
	border-bottom: 1px solid #ccc;
	background: #ea8619;
}

.td_tongyong {
	width: 11%;
	height: 35px;
	line-height: 35px;
	font-size: 14px;
	color: #333;
	border-right: 1px solid #ccc;
	background: #faefb2;
	text-align: center;
}
#meetid{
	width:380px;
}
</style>
</head>

<body>
	<div class="cwh_head">文件监控</div>
	<!--此处内容更替-->
	<div class="icon_head">
		<form name="findForm" action="<%=basePath%>filemonitor/select.action"
			method="post" id="findForm">
			<s:hidden name="pageNo" id="page"></s:hidden>
			<p class="flt" style="height:40px; line-height:40px;">
				<div class="nobr">
					<s:doubleselect theme="simple" formName="findForm"
						list="map.keySet()" name="mtype" id="mtype" listKey="code"
						listValue="name" doubleName="meetid" doubleId="meetid"
						doubleList="map[top]" doubleListKey="meetid"
						doubleListValue="mname" />
				</div>
			</p>
			<!-- <button type="submit" class="button4 flt">查询</button> -->
		</form>
	</div>
 	   <a class='easyui-linkbutton' data-options="iconCls:'icon-search'" style="line-height: 25px;width:100px;color:#a10000;left:600px;top:65px;position: absolute;" onclick="searchlist()">查询</a>						
	<div class="tongzhi">
		<!--此处为文件监控补充内容-->
		<div class="tongzhijiankong" style="height:450px;">
			<div style="margin:20px;text-align:center;float:left;width:20%">
				<div>总人数：${total}人</div>
				<div>
					<ul>
						<li
							style="height:68px;background:url(<%=path%>/themes/default/images/jiankong_bj.png) no-repeat; background-size:100% 100%;border:none;padding-top:5px;"><a href="<%=basePath %>filemonitor/allReceived.action?pageNo=1">全部已接收:${allReceived}人</a></li>
						<li
							style="height:68px;background:url(<%=path%>/themes/default/images/jiankong_bj.png) no-repeat; background-size:100% 100%;border:none;padding-top:5px;"><a href="<%=basePath %>filemonitor/allNotReceived.action?pageNo=1">全部未接收:${allNotReceived}人</a></li>
						<li
							style="height:68px;background:url(<%=path%>/themes/default/images/jiankong_bj.png) no-repeat; background-size:100% 100%;border:none;padding-top:5px;"><a href="<%=basePath %>filemonitor/notAllReceived.action?pageNo=1">部分未接收:${notAllReceived}人</a></li>
					</ul>
				</div>
			</div>
			<div class="tongyong_table"
				style="margin:0px auto;width:70%;float:left">
<%-- 				<button class="button3"
					onclick="jump('<%=basePath %>/smsdefine/selectSmsdefineMain.action?pageNo=1&pageSize=8');"
					type="button" style="float:right;margin-bottom:10px;">提醒</button> --%>
<%--  	 			<a class='easyui-linkbutton' data-options="iconCls:'icon-application-go'" style="line-height: 25px;width:100px;color:#a10000;float:right;margin-top:10px;margin-bottom:10px;" 
 	 			onclick="jump('<%=basePath %>/smsdefine/selectSmsdefineMain.action?pageNo=1&pageSize=8');">提醒</a> --%>											
				<table cellpadding="0" cellspacing="0" style="width:100%;">
					<tr>
						<th width="25%" height="35" align="center" class="th_tongyong">姓名</th>
						<th width="25%" height="35" align="center" class="th_tongyong">应收</th>
						<th width="25%" height="35" align="center" class="th_tongyong">已收</th>
						<th width="25%" height="35" align="center" class="th_tongyong">未收</th>
					</tr>
					<s:iterator value="ulist">
						<tr>
							<td colspan="4" height="5"></td>
						</tr>
						<tr>
							<td width="25%" align="center" class="td_tongyong"
								style="height:30px;"><s:property value="name" />
							</td>
							<td width="25%" align="center" class="td_tongyong"
								style="height:30px;"><s:property value="shouldReceive" />
							</td>
							<td width="25%" align="center" class="td_tongyong"
								style="height:30px;"><s:property value="haveReceived" />
							</td>
							<td width="25%" align="center" class="td_tongyong"
								style="height:30px;"><s:property value="notReceived" />
							</td>
						</tr>
					</s:iterator>
				</table>
			</div>
		</div>
		<s:if test="totalPage>1">
			<div id="page">
				<s:if test="totalPage==0"></s:if>
				<s:else>
					<a href="javascript:toPage(1);">首页</a>
					<s:if test="pageNo==1">
						<a href="javascript:;">上一页</a>
					</s:if>
					<s:else>
						<a href="javascript:toPage(<s:property value="pageNo-1"/>);">上一页</a>
					</s:else>
					<s:if test="pageNo<8">
						<s:if test="totalPage<12">
							<s:iterator begin="1" end="totalPage" var="p">
								<s:if test="#p==pageNo">
									<a href="javascript:toPage(<s:property value="#p"/>);"
										class="current_page"><s:property value="#p" /> </a>
								</s:if>
								<s:else>
									<a href="javascript:toPage(<s:property value="#p"/>);"><s:property
											value="#p" /> </a>
								</s:else>
							</s:iterator>
						</s:if>
						<s:else>
							<s:iterator begin="1" end="12" var="p">
								<s:if test="#p==pageNo">
									<a href="javascript:toPage(<s:property value="#p"/>);"
										class="current_page"><s:property value="#p" /> </a>
								</s:if>
								<s:else>
									<a href="javascript:toPage(<s:property value="#p"/>);"><s:property
											value="#p" /> </a>
								</s:else>
							</s:iterator>
						</s:else>
					</s:if>

					<s:if test="pageNo>7">
						<s:if test="totalPage<13">
							<s:iterator begin="1" end="totalPage" var="p">
								<s:if test="#p==pageNo">
									<a href="javascript:toPage(<s:property value="#p"/>);"
										class="current_page"><s:property value="#p" /> </a>
								</s:if>
								<s:else>
									<a href="javascript:toPage(<s:property value="#p"/>);"><s:property
											value="#p" /> </a>
								</s:else>
							</s:iterator>
						</s:if>
						<s:if test="totalPage>12">
							<s:if test="pageNo+4<totalPage">
								<%
											for (int i = 6; i > -6; i--) {
																	//System.out.println("i:"+i);
																	request.setAttribute("ii", i);
										%>
								<s:if test="pageNo==pageNo+#attr.ii">
									<a href="javascript:toPage(${pageNo-ii});"
										class="current_page">${pageNo+ii }</a>
								</s:if>
								<s:else>
									<a href="javascript:toPage(${pageNo-ii});">${pageNo-ii}</a>
								</s:else>
								<%
											}
										%>
							</s:if>
							<s:else>
								<%
											for (int i = 11; i > -1; i--) {
																	//System.out.println("i:"+i);
																	request.setAttribute("ii", i);
										%>
								<s:if test="pageNo==pageNo+#attr.ii">
									<a href="javascript:toPage(${pageNo-ii});"
										class="current_page">${pageNo+ii }</a>
								</s:if>
								<s:else>
									<s:if test="pageNo-#attr.ii>0">
										<a href="javascript:toPage(${pageNo-ii});">${pageNo-ii}</a>
									</s:if>
								</s:else>
								<%
											}
										%>
							</s:else>
						</s:if>
					</s:if>
					<s:if test="pageNo==totalPage">
						<a href="javascript:;">下一页</a>
					</s:if>
					<s:else>
						<a href="javascript:toPage(<s:property value="pageNo+1"/>);">下一页</a>
					</s:else>
					<a href="javascript:toPage(<s:property value="totalPage"/>);">末页</a>
				</s:else>
				<a>共<s:property value="totalPage" /> 页</a>
			</div>
		</s:if>
		<!--此处为文件监控补充内容结束-->

	</div>
	<!--此处内容更替结束-->
</body>
</html>
