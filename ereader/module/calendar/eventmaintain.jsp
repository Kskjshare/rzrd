<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
 <%@ include file="/public/common.jspf" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0"> 
<script type="text/javascript" src="<%=path%>/third/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" >
function jump(locate){
	window.location.href=locate;
}
function toPage(page){
   	document.getElementById("page").value=page;
   	document.getElementById("findForm").submit();
}
function addcontent(){
	$("#popwindow").attr("title","新增事件");
	$("#popform").attr("action","<%=basePath%>calendar/add.action");
	$("#popwindow").window("open");
}
function cancel(){
	$('#popwindow').window('close');
}
function deleteone(id){
	$.messager.defaults = { ok: "确定", cancel: "取消" };  
    $.messager.confirm("删除提示", "确认要删除？", function (data) {  
        if (data) {  
        	window.location.href="<%=basePath%>calendar/deleteById.action?eventid="+id;
        }  
    });
}
function updateinfo (id){
	var url="<%=basePath%>calendar/selectById.action?eventid="+id;
	$.ajax({
		  url: url,
          type: "POST",
          async: false,  
          cache: false,  
          contentType: false,  
          processData: false,
          dataType:"json",
          success: function (data) { 
			$("#ieventname").val(data.eventname);
			$("#ishowdate").val(data.showdate.substr(0,10));
        	$("#icomment").val(data.comment);  
     		$("#popwindow").attr("title","修改事件");
     		$("#popform").attr("action","<%=basePath%>calendar/update.action?eventid="+id);
			$("#popwindow").window("open");
		},
		error: function() {
			alert("暂不能修改");
		}
	});
}
</script>
<script type="text/javascript">
$(function () {
    $('#ieventname').validatebox({
    	required: true,
    	missingMessage:'请输入事件名称'
    });
    $('#ishowdate').validatebox({
    	required: true,
    	missingMessage:'请输入显示日期'
    });
    $('#popform').submit(function(){
    	if(!$("#popform").form('validate')){
    		return false;
    	}
    })
})
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

.tongyong_table {
	width: 100%;
	height: 400px;
	font-family: "微软雅黑";
}

.th_tongyong {
	height: 40px;
	line-height: 40px;
	font-size: 16px;
	color: #333;
	border-bottom: 1px solid #ccc;
	background: #ea8619;
}

.td_tongyong {
	height: 35px;
	line-height: 35px;
	font-size: 14px;
	color: #333;
	border-right: 1px solid #ccc;
	background: #faefb2;
	text-align: center;
}
</style>
</head>

<body>
    <div >
        <div class="cwh_head">
            年历表
        </div>
<!--此处内容更替-->
        <div class="icon_head">
            <button class="button1" type="button" onclick="jump('<%=basePath %>module/calendar/mindex.jsp')">返回年历</button>
        </div>
        <div class="tongzhi">
         <form action="<%=basePath%>calendar/select.action" id="findForm" method="post">
			<s:hidden name="pageNo" id="page"></s:hidden>
            <div class="tongzhi_head"  style="margin-top:15px;margin-buttom:10px;line-height:45px;">
                <button  class="button3" type="button" style="position:absolute; right:20px;" onclick="addcontent();">新增事件</button>  
            </div>
            <div class="tongzhi_main">
              <div class="tongyong_table">
					<div style="width:90%;margin:10px auto;">
						<table cellpadding="0" cellspacing="0" border="0" width="100%">
							<tr>
								<th class=th_tongyong width="30%">事件名称</th>
								<th class="th_tongyong" width="15%">备注</th>
								<th class="th_tongyong" width="15%">显示日期</th>
								<th class="th_tongyong" width="15%">创建日期</th>
								<th class="th_tongyong" width="25%">操作</th>
							</tr>
							<s:iterator value="page.result">
								<tr>
									<td colspan="5" height="5"></td>
								</tr>
								<tr id="${eventid}">
									<td class="td_tongyong"><s:property value="eventname" /></td>
									<td class="td_tongyong"><s:property value="comment" /></td>
									<td class="td_tongyong"><s:date name="showdate" format="yyyy-MM-dd"/></td>
									<td class="td_tongyong"><s:date name="createdate" format="yyyy-MM-dd hh:mm"/></td>
									<td style="border-right:none;" class="td_tongyong"><a
										href="javascript:void(0)" onclick="updateinfo (${eventid});"><img
											src="<%=path%>/themes/default/images/caozuo_03.png" style="vertical-align:middle;"/> </a> <a
										href="javascript:void(0)" onclick="deleteone (${eventid});"><img
											src="<%=path%>/themes/default/images/caozuo_05.png" style="vertical-align:middle;"/> </a></td>
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
            </div>
            </form>
            
        <!-- 弹窗 -->
		<div id="popwindow" class="easyui-window" closed="true" data-options="iconCls:'icon-save'" title="新增事件" style="width:630px;height:350px;padding:10px;">
			<div class="contactstable" style="height:180px;">
				<form id="popform" action="" method="post">
					<table>
						<tr>
							<td>事件名称：</td>
							<td><input class="input" type="text" id="ieventname"
								name="eventname" /></td>
						</tr>
						<tr>
							<td>显示日期：</td>
							<td>
							<input style="height:30px;width:95%;margin-left:5px;border:2px solid #ccc;" id="ishowdate" class="Wdate" onFocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy-MM-dd'})" type="text" name="showdate"/>
							</td>
						</tr>
						<tr>
							<td>备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
							<td><input class="input" type="text" id="icomment" name="comment" />
							</td>
						</tr>
						<tr>
							<td>
								<button style="margin-top:20px; margin-left:15px;" id="subm"
									type="submit" class="button3">保存</button>
							</td>
							<td>
								<button style="margin-top:20px; margin-left:50px;" type="button"
									class="button3" onclick="cancel();">取消</button>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		<!-- 弹窗 -->
		
        </div>
<!--此处内容更替结束-->
    </div>
</body>
</html>
