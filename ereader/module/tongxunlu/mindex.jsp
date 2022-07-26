<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/public/common.jspf"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript">
	function jump(locate) {
		window.location.href = locate;
	}
</script>
</head>
<body>
	<div>
		<div class="cwh_head">通讯录</div>
		<!--此处内容更替-->
		<div class="icon_head">
			<button class="button1" name="" type="button"
				onclick="jump('<%=basePath%>tongxunlun/select.action')">通讯录维护</button>
		</div>
		<div class="tongzhi"
			style="background:url(<%=path%>/themes/default/images/zucheng_bj1.png) no-repeat; background-size:100% 100%;">
			<div style="width:31%; height:464px;  float:left;">
				<ul style="width:200px;margin:40px;">
				<s:iterator value="dicList">
					<li
						style="width:180px; height:68px;background:url(<%=path%>/themes/default/images/jiankong_bj.png) no-repeat; background-size:100% 100%;border:none;padding-top:5px;"><a
						href="<%=basePath%>tongxunlun/selectComp.action?compCode=${code}">${name}</a>
					</li>
				</s:iterator>
				</ul>
			</div>
			<div class="jiankong_right flt">
				<div style="width:100%;margin:40px auto;">
					<table cellpadding="0" cellspacing="2" border="0"
						style="margin-left:3%" width="90%">
						<tr>
							<th width="33%" height="40" align="center" class="th1">姓名</th>
							<th width="33%" height="40" align="center" class="th1">办公电话(内部)</th>
							<th width="33%" height="40" align="center" class="th1">住宅电话(内部)/手机</th>
						</tr>
						<s:iterator value="entityList">
							<tr>
								<td width="33%" height="35" align="center" class="td1"
									style="border-left:1px solid #ccc;"><s:property
										value="name" />
								</td>
								<td width="33%" height="35" align="center" class="td1"><s:property
										value="phoneOffice" />
								</td>
								<td width="30%" height="35" align="center" class="td1"><s:property
										value="phoneHome" />&nbsp;/ <s:property value="mobile" /></td>
							</tr>
						</s:iterator>
					</table>
				</div>
			</div>
		</div>
		<!--此处内容更替结束-->
	</div>
</body>
</html>
