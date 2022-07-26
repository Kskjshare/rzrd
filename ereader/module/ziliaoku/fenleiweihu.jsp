<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/public/common.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>人大会议助理_常委会会议</title>
<script type="text/javascript">
function jump(locate) {
	window.location.href = locate;
}
function addcontent(){
    $('#ifirstName').validatebox({
    	required: true,
    	missingMessage:'请输入一级分类名称'
    });
    $(".panel-with-icon").html("添加分类");
	$("#popwindow").attr("title","添加分类");
	$("#popform").attr("action","<%=basePath%>ziliaoku/addType.action");
	$("#firstType").show();
	$("#secondType").hide();
	$("#popwindow").window("open");
}
function cancel(){
	$('#popwindow').window('close');
}
function deleteone(id,st){
	$.messager.defaults = { ok: "确定", cancel: "取消" };  
    $.messager.confirm("删除提示", "确认要删除？", function (data) {  
        if (data) {  
        	window.location.href="<%=basePath%>ziliaoku/deleteType.action?flag="+st+"&typeid="+id; 
        }  
    }); 
}
function addSecondType(ptypeid){
	$(".panel-with-icon").html("添加分类");
	$("#popwindow").attr("title","添加分类");
	$("#popform").attr("action","<%=basePath%>ziliaoku/addSecondType.action?ptypeid="+ptypeid);
	$("#firstType").hide();
	$("#secondType").show();
	$("#popwindow").window("open");
	$('#ifirstName').validatebox({
    	required: false,
    	missingMessage:'请输入一级分类名称'
    });
}
function updateinfo (id,flag){
	var url="<%=basePath %>ziliaoku/selectTypeById.action?typeid="+id;
	$.ajax({
		  url: url,
          type: "POST",
          async: false,  
          cache: false,  
          contentType: false,  
          processData: false,
          dataType:"json",
          success: function (data) {
			if (flag==1) {
				$("#firstType").show();
				$("#secondType").hide();
				$("#ifirstName").val(data.name);
			    $('#isecondName').validatebox({
			    	required: false,
			    	missingMessage:'请输入二级分类名称'
			    });				
			}else{
				$('#ifirstName').validatebox({
    				required: false,
    				missingMessage:'请输入一级分类名称'
    			});
				$("#firstType").hide();
				$("#secondType").show();
				$("#isecondName").val(data.name);
			}
			$(".panel-with-icon").html("修改分类");
			$("#popwindow").attr("title","修改分类");
     		$("#popform").attr("action","<%=basePath %>ziliaoku/updateType.action?flag="+flag+"&typeid="+id);
    		$("#popwindow").window("open");
          },  
          error: function () {  
             alert("暂不能修改");  
          }  
    }); 
}
</script>
<script type="text/javascript">
$(function () {
	 $('#ifirstName').change(function(){
		 $('#isecondName').attr('value',' ')
	 });
	 $('#isecondName').change(function(){
		 $('#ifirstName').attr('value',' ')
	 });
    $('#ifirstName').validatebox({
    	required: true,
    	missingMessage:'请输入一级分类名称'
    });
    $('#isecondName').validatebox({
    	required: true,
    	missingMessage:'请输入二级分类名称'
    });
    $("#savefir").click(function(){
        if(!$("#popform").form('validate')){
    		return false;
    	}
    	$("#popform").submit();
    })
})
</script>
<style type="text/css">
.tongyong_table {
	width: 100%;
	height: 400px;
	font-family: "微软雅黑";
}
.th_tongyong {
	width: 11%;
	height: 40px;
	line-height: 40px;
	font-size: 16px;
	color: #333;
}
.td_tongyong {
	height: 35px;
	line-height: 35px;
	font-size: 14px;
	color: #333;
	background: #faefb2;
	text-align: center;
}
.td_tongyongfirst {
	height: 35px;
	line-height: 35px;
	font-size: 14px;
	color: #333;
	text-align: center;
}
</style>
</head>

<body>
	<div class="cwh_head">资料库</div>
	<!--此处内容更替-->
	<div class="icon_head">
<%-- 		<button class="button1"
			onclick="jump('<%=basePath%>ziliaoku/selectFirstType.action')"
			type="button">返回资料库</button> --%>
	</div>
	<a class='easyui-linkbutton'  data-options="iconCls:'icon-goback'" style="line-height: 25px;width:115px;color:#a10000;right:20px;top:65px;position: absolute;" onclick="jump('<%=basePath%>ziliaoku/selectFirstType.action')">返回资料库</a>						
	
	<div class="tongzhi">
		<div class="tongzhi_head" style="height:30px;">
<!-- 			<button class="button3 frt" onclick="addcontent();" type="button"
				style="margin-right:90px;float:right;">添加分类</button> -->
		<a class='easyui-linkbutton'  data-options="iconCls:'icon-add'" style="line-height: 25px;width:115px;color:#a10000;margin-right:90px;float:right;" onclick="addcontent();">添加分类</a>								
		</div>
		<div class="tongzhi_main">
		<div class="tongyong_table">
		<div style="width:80%;height:40px;margin:0px auto;margin-top:10px;color:#333;font-size:16px;background: #ea8619;">
		<div style="float:left;margin-top:10px;margin-left:120px;">资料分类</div>
		<div style="margin-top:10px;float:right;margin-right:90px;">操作</div></div>
			<div style="width:80%;margin:0px auto;height:420px;overflow-y:auto;">
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				
				<s:iterator value="typeList" id="out" var="fl">
					<s:if test="#fl.ptypeid==0">
						<tr>
							<td colspan="3" height="5"></td>
						</tr>
						<tr style="margin-top:5px;">
							<td class="td_tongyongfirst" colspan="2" style="width:85%;text-align:left;text-indent:26px;background:url(<%=path%>/themes/default/images/ziliaofenlei_tr.png);background-size:101% 100%;"><s:property value="#fl.name" /></td>
							<td class="td_tongyongfirst" style="width:15%;text-align: center;background:url(<%=path%>/themes/default/images/ziliaofenlei_tr2.png);background-size:101% 100%;">
								<a href="javascript:void(0)" onclick="addSecondType(${fl.typeid});">
								<img src="<%=path%>/themes/default/images/caozuo_01.png" style="vertical-align:middle;padding-bottom:7px"/></a>
								<a href="javascript:void(0)" onclick="updateinfo (${fl.typeid},1);">
								<img src="<%=path%>/themes/default/images/caozuo_03.png" style="vertical-align:middle;padding-bottom:7px"/></a>
								<a href="javascript:void(0)" onclick="deleteone(${fl.typeid},1);">
								<img src="<%=path%>/themes/default/images/caozuo_05.png" style="vertical-align:middle;padding-bottom:7px"/></a>
							</td>
						</tr>
						<s:iterator value="typeList" id="inner" var="sl">
							<s:if test="#fl.typeid==#sl.ptypeid">
								<tr>
									<td colspan="3" height="5"></td>
								</tr>
								<tr>
									<td style="width:2%;"></td>
									<td class="td_tongyong" style="width:83%;text-align:left;text-indent:26px;"><s:property
											value="#sl.name" /></td>
									<td  class="td_tongyong" style="width:15%;text-align: center;"><a href="javascript:void(0)"
								onclick="updateinfo (${sl.typeid},2);"> <img
									src="<%=path%>/themes/default/images/caozuo_03.png" style="vertical-align:middle;"/> </a> <a
								href="javascript:void(0)" onclick="deleteone(${sl.typeid},2);">
									<img src="<%=path%>/themes/default/images/caozuo_05.png" style="vertical-align:middle;"/> </a></td>
								</tr>
							</s:if>
						</s:iterator>
					</s:if>
				</s:iterator>
			</table>
			</div>
			</div>
		</div>
	</div>
	<!--此处内容更替结束-->

	<!-- 弹窗div -->
	<div id="popwindow" class="easyui-window" closed="true" data-options="iconCls:'icon-save'" title="增加分类" style="width:470px;height:250px;padding:10px;">
		<div class="popinner" style="margin-left:80px;margin-top:15px;">
			<form action="<%=basePath%>ziliaoku/addType.action" id="popform" method="post">
				<table>
					<tr id="firstType">
						<td style="width:270px;">一级分类： <input class="input" type="text" id="ifirstName" name="firstName" />
						</td>
					</tr>
					<tr id="secondType">
						<td style="width:270px;">二级分类： <input class="input" type="text" id="isecondName" name="secondName" />
						</td> 
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td style="width:270px;">
								<a class='easyui-linkbutton'  data-options="iconCls:'icon-ok'" style="line-height: 25px;width:80px;color:#a10000;margin-right:50px;float:left;" id="savefir">确定</a>								
								<a class='easyui-linkbutton'  data-options="iconCls:'icon-cancel'" style="line-height: 25px;width:80px;color:#a10000;" onclick="cancel();">取消</a>	
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<!-- 弹窗结束 -->

</body>
</html>
