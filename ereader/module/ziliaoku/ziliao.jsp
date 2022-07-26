<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/public/common.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>人大会议助理_常委会会议</title>
<script type="text/javascript" src="<%=basePath%>/third/officeformat/xdoc.js"></script>
<script type="text/javascript">
	function jump(locate) {
		window.location.href = locate;
	}
	function toPage(page) {
		document.getElementById("page").value = page;
		document.getElementById("findForm").submit();
	}
	function addcontent(){
		$(".panel-with-icon").html("添加资料");
		$("#popwindow").attr("title","添加资料");
		$("#popform").attr("action","<%=basePath%>ziliaoku/upload.action");
		$("#popwindow").window("open");
	}
	function cancel(){
		$('#popwindow').window('close');
	}
	function deleteone(id){
		$.messager.defaults = { ok: "确定", cancel: "取消" };  
	    $.messager.confirm("删除提示", "确认要删除？", function (data) {  
	        if (data) {  
	        	window.location.href="<%=basePath %>ziliaoku/delete.action?ziliaoid="+id;
	        }  
	    });
	}
	function updateinfo (id){
		var url="<%=basePath %>ziliaoku/selectById.action?ziliaoid="+id;
		$.ajax({
			  url: url,
              type: "POST",
	          async: false,  
	          cache: false,  
	          contentType: false,  
	          processData: false,
	          dataType:"json",
	          success: function (data) { 
				$("#filetext").val(data.filename);
				$("#fileName").val(data.filename);
				$("#iziliaoName").val(data.name);
				$(".panel-with-icon").html("修改资料");
				$("#popwindow").attr("title","修改资料");
	     		$("#popform").attr("action","<%=basePath %>ziliaoku/update.action?ziliaoid="+id);
	    		$("#popwindow").window("open");
	          },  
	          error: function () {  
	             alert("暂不能修改");  
	          }  
	    }); 
	}
	$(function() {
		$("#buttonupload").click(function(){
    		$("#upload").click();
    	});
    	$("#upload").change(function(){
    	    var url=$("#upload").val();
    	    $("#fileName").val(url);
    		var reg1=/[^\\\/]*[\\\/]+/g;
    		var fn=url.replace(reg1,"");
           $("#filetext").val(fn);
           var reg2=/\.\w+$/;
           var zn=fn.replace(reg2,"");
           $("#iziliaoName").val(zn);
    	});
	});
</script>
<script type="text/javascript">
$(function () {
    $('#filetext').validatebox({
    	required: true,
    	missingMessage:'请选择资料'
    });

     $("#savefir").click(function(){
        if(!$("#popform").form('validate')){
    		return false;
    	}
    	var filetext=$("#filetext").val();
						if(filetext.indexOf('.pdf')==-1){
							//$.messager.alert('提示','请选择上传的pdf文件',"info",function(){});
							//return;
						}
    	$("#popform").submit();
    })   
})

 function fileOpen(fileid){
	$.ajax({
	type:"post",
	async:false,
	cache:false,
	url:"<%=basePath%>meet_getExistFileByName.action?filePath="+fileid,
	data:{},
	success:function(data){
	//alert(fileUrl+"ee1936bc-7ad9-4aac-b88b-3cd01d27e9e3.doc");
	//href="javascript:fileOpen('<s:property value="path" />');"
	//window.location=fileUrl+"ee1936bc-7ad9-4aac-b88b-3cd01d27e9e3.doc";
	var json=eval("("+data+")");
    if(json.state){
			window.open("<%=basePath%>"+fileid);
				    	}else{
				    		$.messager.alert('提示',"此附件已不存在");
				    	}
	}
	});
	}
</script>
<style type="text/css">
a:hover{color:#999}
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
	<div class="cwh_head">资料库</div>
	<!--此处内容更替-->
	<div class="icon_head">
<%-- 		<button class="button1" onclick="jump('<%=basePath %>ziliaoku/selectFirstType.action');" type="button">返回资料库</button>
 --%>	</div>
	<a class='easyui-linkbutton'  data-options="iconCls:'icon-goback'" style="line-height: 25px;width:115px;color:#a10000;right:20px;top:65px;position: absolute;" onclick="jump('<%=basePath%>ziliaoku/selectFirstType.action')">返回资料库</a>							
	<div class="tongzhi">
		<div class="tongzhi_head">
			 <a style="font-size:18px;float:left;line-height:24px;height:24px;margin-left:10px;margin-top:8px;" href="<%=basePath %>ziliaoku/selectFirstType.action">资料库</a>
	        <span style="font-size:18px;float:left;line-height:24px;height:24px;margin-left:3px;margin-top:8px;">>></span>
	        <a style="font-size:18px;float:left;line-height:24px;height:24px;margin-top:8px;margin-left:3px;" href="<%=basePath %>ziliaoku/selectSecondType.action?typeid=${ftypeEntity.typeid}">${ftypeEntity.name}</a>
	        <span style="font-size:18px;float:left;line-height:24px;height:24px;margin-left:3px;margin-top:8px;">>></span>
	        <a style="font-size:18px;float:left;line-height:24px;margin-top:8px;height:24px;margin-left:3px;" href="<%=basePath %>ziliaoku/selectSecondType.action?typeid=${stypeEntity.typeid}">${stypeEntity.name}</a>
			<form action="<%=basePath%>ziliaoku/select.action"
				id="findForm" method="post">
				<s:hidden name="pageNo" id="page"></s:hidden>
				<p>
					资料名称：
					<s:textfield class="input" name="searchName"></s:textfield>
				</p>
	<!-- 			<button class="button3 flt" type="submit">查询</button> -->
				<a class='easyui-linkbutton'  data-options="iconCls:'icon-search'" style="line-height: 25px;width:80px;color:#a10000;float: left;margin-top: 7px; margin-left:10px;" onclick="document.getElementById('findForm').submit()">查询</a>							
				<a class='easyui-linkbutton'  data-options="iconCls:'icon-add'" style="line-height: 25px;width:80px;color:#a10000;float: right;margin-top: 7px; margin-right:20px;" onclick="addcontent();">添加资料</a>											
			</form>
		</div>
		<div class="tongzhi_main">
			<div class="tongyong_table">
				<div style="width:90%;margin:10px auto;">
					<table cellpadding="0" cellspacing="0" border="0" width="100%">
						<tr>
							<th colspan="2"  style="width:45%;" class="th_tongyong">资料名称</th>
							<th class="th_tongyong">资料分类</th>
							<th class="th_tongyong">日期</th>
							<th colspan="2" class="th_tongyong">操作</th>
						</tr>
						<s:iterator value="page.result" id="rodo">
							<tr>
								<td colspan="6" height="5"></td>
							</tr>
							<tr id="${ziliaoid}">
								<td colspan="2" style="width:45%;text-align:left;text-indent:26px;" class="td_tongyong">
								<a href="javascript:fileOpen('<s:property value="path" />');" title="<s:property value="name" />">
				            	<s:if test="%{#rodo.name.length()>28}"> 
								    <s:property value="%{#rodo.name.substring(0,28)}" />...
								</s:if>
								<s:else> 
									<s:property value="name" />
								</s:else>									
								</a>
								</td>
								<td class="td_tongyong">
								${ftypeEntity.name}>>${stypeEntity.name}
								</td>
								<td class="td_tongyong">
									<s:date name="createtime" format="yyyy-MM-dd hh:mm"/>
								</td>
								<td style="border-right:none;" colspan="2" class="td_tongyong">
									<a href="javascript:void(0)" onclick="updateinfo ('${ziliaoid}');">
										<img src="<%=path%>/themes/default/images/caozuo_03.png" style="vertical-align:middle;"/> </a>
									<a href="javascript:void(0)" onclick="deleteone ('${ziliaoid}');"> 
										<img src="<%=path%>/themes/default/images/caozuo_05.png" style="vertical-align:middle;"/> </a>
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
									<a href="javascript:toPage(<s:property value="#p"/>);"> <s:property
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
	</div>
	<!--此处内容更替结束-->

	<!-- 弹窗div -->
	<div id="popwindow" class="easyui-window" closed="true" data-options="iconCls:'icon-save'" title="添加资料" style="width:540px;height:250px;padding:10px;">
		<div class="popinner" style="margin-left:50px;margin-top:15px;">
			<form action="<%=basePath%>ziliaoku/upload.action" id="popform" enctype="multipart/form-data" method="post">
				<table>
					<!--  <tr>
						<td>资料分类：法规>政策</td>
					</tr> -->
					<tr>
						<td style="width:390px;">资料文件：<input  class="input" name="fileName" type="text" style="width:167px;" readonly id="filetext">
						<a class='easyui-linkbutton'  data-options="iconCls:'icon-upload'" style="line-height: 25px;width:80px;color:#a10000;" id="buttonupload">上传</a>														
						<input hidden type="text" name="filePath" id="fileName"/>
	                    	<div style="display: none"><input type="file" name="file" id="upload"></div>
						</td>
					</tr>
					<tr>
						<td style="width:350px;"></td>
					</tr>
					<tr>
						<td style="width:350px;">

							<a class='easyui-linkbutton'  data-options="iconCls:'icon-ok'" style="line-height: 25px;width:80px;color:#a10000;margin-right:50px;float:left;margin-left: 80px;" id="savefir">确定</a>								
							<a class='easyui-linkbutton'  data-options="iconCls:'icon-cancel'" style="line-height: 25px;width:80px;color:#a10000;" onclick="cancel();">取消</a>								
						</td>
					</tr>
				</table>
				<input type="text" id="iziliaoName" class="input" hidden name="ziliaoName"/>
			</form>
		</div>
	</div>
	<!-- 弹窗结束 -->

</body>
</html>
