<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/public/common.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>人大会议助理_常委会会议</title>
<script type="text/javascript" src="<%=basePath%>third/sort/jquery.dragsort-0.5.2.min.js"></script>
<script type="text/javascript">
	var flag=0;
	getPubtime();
	function jump(locate){
		window.location.href=locate;
 	}
	function changeli(){
		if (flag%2==0) {
			$('#list1').attr('class','list1');
			$('#list2').attr('class','list2');
			$('#changeli').text("确定");
		}else{
			$('#list1').attr('class','list11');
			$('#list2').attr('class','list22');
			$('#changeli').text("排序");
		}
		flag=flag+1;
	}
    	function showS(){
    		$.messager.alert('提示',"已保存！","info");
    	}
    	function saveAndP(){
    		var url="<%=basePath%>groupmember/insertPub.action?";
    		$.ajax({
  			      url: url,
		          success: function (data) {    	
						$.messager.alert('提示',data.msg,"info");
						getPubtime();
				}
			});
		}
    	function getPubtime(){
    		var url="<%=basePath%>groupmember/selectPubtime.action?";
    		$.ajax({
  			      url: url,
		          success: function (data) {    	
						$("#pushtime").html(data.msg);
				}
			});
		}	
</script>
<style type="text/css">
.left_table {
	width: 30%;
	float: left;
	margin-left: 3%;
	text-align: center;
	margin-top: 30px;
}

.left_table p {
	width: 100%;
	height: 40px;
	line-height: 40px;
	color: #D44C00;
	font-size: 16px;
	font-weight: bold;
}

.left_table td {
	width: 33%;
	height: 35px;
	line-height: 35px;
	color: #333;
	font-size: 14px;
	border: 1px solid #ccc;
	font-weight: bold;
	text-align: center;
}

.right_table {
	width: 59%;
	float: right;
	margin-right: 4%;
	text-align: center;
	margin-top: 30px;
}

.right_table p {
	width: 100%;
	height: 40px;
	line-height: 40px;
	color: #D44C00;
	font-size: 16px;
	font-weight: bold;
}

.right_table td {
	width: 16.6%;
	height: 35px;
	line-height: 35px;
	color: #333;
	font-size: 14px;
	font-weight: bold;
	border: 1px solid #ccc;
	text-align: center;
}

</style>
<style>
ul {
	margin: 0px;
	padding: 0px;
	margin-left: 20px;
	height: 450px;
}

#list1 {
	width: 100%;
	list-style-type: none;
	margin: 0px;
	padding-left: 8%;
}

#list1 li {
	text-align:center;
	border: none;
	float: left;
	margin-right: 4%;
	width: 25%;
	height: 40px;
	background: none;
	text-indent:0px;
}

#list1 div {
	width: 100%;
	height: 100%;
	background: #DFDFDF;
}

#list2 {
	width: 95%;
	list-style-type: none;
	margin: 0px;
	padding-left: 6%;
}

#list2 li {
	text-align:center;
	border: none;
	float: left;
	margin-right: 2%;
	width: 13%;
	height: 40px;
	background: none;
	text-indent:0px;
	font-size:14px;
}

#list2 div {
	width: 100%;
	height: 100%;
	background-color: #DFDFDF;
}

.placeHolder div {
	background-color: #F5F5F5 !important;
	border: dashed 1px gray !important;
}
</style>
</head>

<body>
	<div class="cwh_head">组成人员</div>
	<!--此处内容更替-->
	<div class="icon_head">
		<div style="position: absolute;font-size: 14px;color:#333;">支持拖动排序</div>
	</div>
	   <a class='easyui-linkbutton' data-options="iconCls:'icon-modify'" style="line-height: 25px;width:115px;color:#a10000;right:20px;top:65px;position: absolute;" onclick="jump('<%=basePath%>groupmember/select.action?membertype=0&groupcode=0')">组成人员维护</a>			
	
	<div class="tongzhi" style="height:543px;background:url(<%=path%>/themes/default/images/zucheng_bj.jpg) no-repeat; background-size:100% 100%;">
		<div class="left_table">
			<p>主任会议成员</p>
			<input id="list1SortOrder" name="list1SortOrder" type="hidden" />
			<ul id="list1" style="height:400px;overflow:auto;width: 95%">
				<s:iterator value="zhurenList">
					<li><div id="${memberid}">${truename}</div></li>
				</s:iterator>
			</ul>
			<script type="text/javascript">
				$("#list1")
						.dragsort(
								{
									dragSelector : "div",
									dragBetween : true,
									dragEnd : saveOrder,
									placeHolderTemplate : "<li class='placeHolder'><div></div></li>"
								});

				function saveOrder() {
					var data = $("#list1 li").map(function() {
						return $(this).children().attr("id");
						}).get();
					$("input[name=list1SortOrder]").val(data.join(","));
					var sort1 = $('#list1SortOrder').val();
					$.post('<%=basePath%>groupmember/updateSort1.action', {sort1:sort1});
				};
			</script>
		</div>
		<div class="right_table">
			<p>常委会委员</p>
			<input id="list2SortOrder" name="list2SortOrder" type="hidden" />
			<ul id="list2" style="height:400px;overflow:auto;width: 95%">
				<s:iterator value="changweiList">
					<li><div id="${memberid}">${truename}</div>
					</li>
				</s:iterator>
			</ul>
			<script type="text/javascript">
				$("#list2")
						.dragsort(
								{
									dragSelector : "div",
									dragBetween : true,
									dragEnd : saveOrder,
									placeHolderTemplate : "<li class='placeHolder'><div></div></li>"
								});
				function saveOrder() {
					var data = $("#list2 li").map(function() {
						return $(this).children().attr("id");
					}).get();
					$("input[name=list2SortOrder]").val(data.join(","));
					var sort2 = $('#list2SortOrder').val();
					$.post('<%=basePath%>groupmember/updateSort2.action', {sort2:sort2});
				};
			</script>
		</div>		
	</div>
	<!--此处内容更替结束-->
		<div style="float: left;margin-left: 40px;bottom:30px;position: absolute;">
			<span style="font-size: 14px;margin-left: 10px;margin-top:10px;float: left;">最后一次发布时间：<span id="pushtime">&nbsp;</span></span>
			<div style="float: left;margin-left: 300px;">
	        <a class='easyui-linkbutton'  data-options="iconCls:'icon-save'" style="line-height: 25px;width: 115px;color:#a10000;margin-right:115px;margin-top:10px;" onclick="showS();">保存</a>
	        <a class='easyui-linkbutton'  data-options="iconCls:'icon-push'" style="line-height: 25px;width: 115px;color:#a10000;margin-right:115px;margin-top:10px;" onclick="saveAndP();">保存并发布</a>
		</div>	
</body>
</html>
