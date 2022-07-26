<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/public/common.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>人大会议助理_常委会会议</title>

<script type="text/javascript">
	function jump(locate){
		window.location.href=locate;
	}
</script>
<style>
li{
color:#fff;
}
a:hover{
color:blue;
}
</style>
</head>

<body>
	<div class="cwh_head">资料库</div>
	<!--此处内容更替-->
	<div class="icon_head">
<%-- 		<button class="button1" onclick="jump('<%=basePath %>ziliaoku/selectType.action');" type="button">分类维护</button> --%>
	</div>
	   <a class='easyui-linkbutton' data-options="iconCls:'icon-modify'" style="line-height: 25px;width:115px;color:#a10000;right:20px;top:65px;position: absolute;" onclick="jump('<%=basePath %>ziliaoku/selectType.action');">分类维护</a>						
	<div class="ziliaoku" style="overflow: auto;margin:0 5 auto;width:99%;">
	<a style="font-size:18px;float:left;margin-left:50px;margin-top:8px;" href="<%=basePath %>ziliaoku/selectFirstType.action">资料库</a>
		<div style="height:20px;"></div>
			<s:iterator value="firstList" status="st1">
				<s:if test="#st1.modulus(4)==1">
					<ul style="padding-top:10px;">
				</s:if>
				<a href="javascript:void(0)"
					onclick="jump('<%=basePath %>ziliaoku/selectSecondType.action?typeid=${typeid}');">
					<li><s:property value="name" /></li>
				</a>
				
				<s:if test="#st1.modulus(4)==0">
					</ul>
				</s:if>
			</s:iterator>
	</div>
	<!--此处内容更替结束-->

</body>
</html>
