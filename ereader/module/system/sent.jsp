<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/public/common.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>人大会议助理_常委会会议</title>
<script type="text/javascript">
	function toPage(page) {
		document.getElementById("page").value = page;
		document.getElementById("findForm").submit();
	}
	function toUserPage(page) {
		document.getElementById("pages").value = page;
		document.getElementById("findForm").submit();
	}
	window.onload = function() {
		if ($(".icon_head").html().trim() == '用户管理') {
			$("#bg1").find("img").attr("src", "<%=path%>/themes/default/images/xtglbg_03.png");
		}
		if ($(".icon_head").html().trim() == '角色管理') {
			$("#bg2").find("img").attr("src", "<%=path%>/themes/default/images/xtglbg_08.png");
		}
		if ($(".icon_head").html().trim() == '推送范围管理') {
			$("#bg3").find("img").attr("src", "<%=path%>/themes/default/images/xtglbg_11.png");
		}
		if ($(".icon_head").html().trim() == '会议维护') {
			$("#bg4").find("img").attr("src", "<%=path%>/themes/default/images/xtglbg_10.png");
		}
		if ($(".icon_head").html().trim() == '数据字典') {
			$("#bg5").find("img").attr("src", "<%=path%>/themes/default/images/shuju_10.png");
		}
		if ($(".icon_head").html().trim() == '版本管理') {
			$("#bg6").find("img").attr("src", "<%=path%>/themes/default/images/xtglbg_12.png");
		}
		if ($(".icon_head").html().trim() == '帮助维护') {
			$("#bg7").find("img").attr("src", "<%=path%>/themes/default/images/xtglbg_13.png");
		}
	}
	function showsysscope(id) {
		$("#hideid").html(id);
		var url = "<%=basePath %>sysscope/selectById.action?scopeid=" + id;
		$.ajax({
			url : url,
			type : "POST",
			async : false,
			cache : false,
			success : function(data) {
				$("#scopename").val(data['entity'].scopename);
				$("#des").val(data['entity'].des);
				$("#leftselect").find("option").remove();
				$("#rightselect").find("option").remove();
				$.each(data['userlist'], function(n, value) {
					$("#leftselect").append("<option value='" + value.id + "'>" + value.truename + "</option");
				});
				$.each(data['suserlist'], function(m, val) {
					$("#rightselect").append("<option value='" + val.userid + "'>" + val.username + "</option");
				})
			},
			error : function() {}
		});
		$("#savediv").css("display", "none");
		$("#updatediv").css("display", "block");
		if (id == '1') {
			$("#scopename").attr("disabled", true);
			$("#des").attr("disabled", true);
			$("#updatesysscope").attr("disabled", "disabled");
			$("#rightimg").unbind('click');
			$("#leftimg").unbind('click');
		} else {
			$("#scopename").attr("disabled", false);
			$("#des").attr("disabled", false);
			$("#updatesysscope").attr("disabled", false);
			$("#rightimg").unbind('click').bind('click', function() {
				if ($("#leftselect option:selected").length > 0) {
					$("#leftselect option:selected").each(function() {
						$("#rightselect").append("<option value='" + $(this).val() + "'>" + $(this).text() + "</option");
						$(this).remove();
					}) ;
				}
			});
			$("#leftimg").unbind('click').bind('click', function() {
				if ($("#rightselect option:selected").length > 0) {
					$("#rightselect option:selected").each(function() {
						$("#leftselect").append("<option value='" + $(this).val() + "'>" + $(this).text() + "</option");
						$(this).remove();
					}) ;
				}

			});
		}
		$(".panel-with-icon").html("编辑用户组");
		$("#add").window("open");
	}
	function deletesysscope(id) {
		$.messager.confirm("删除提示", "<span>确定要删除？</span>", function(data) {
			if (data) {
				var url = "<%=basePath %>sysscope/delete.action?scopeid=" + id;
				$.ajax({
					url : url,
					type : "POST",
					async : false,
					cache : false,
					success : function(data) {
						$.messager.alert("删除提示", data.msg, "info", function() {
							document.getElementById("findForm").submit();
						})
					},
					error : function() {
						$.messager.alert("操作提示", "操作失败", "error");
					}
				});
			}
		});
	}
	function showscopeuser(scopeid) {
		$("#titletr").siblings().empty();
		var url = "<%=basePath %>sysscope/selectUserList.action?pageNoUser=1&pageSizeUser=8&scopeid=" + scopeid;
		$.ajax({
			url : url,
			type : "POST",
			async : false,
			cache : false,
			success : function(data) {
				$.each(data, function(n, value) {
					$("#usertable tbody").append("<tr><td>" + value.userid + "</td><td >" + value.username + "</td><td >" + value.danwei + "</td></tr>")
				});
			},
			error : function() {}
		});
		$("#scopeuser").window("open");

	}
	$(function() {
		$("#rightimg").click(function() {
			if ($("#leftselect option:selected").length > 0) {
				$("#leftselect option:selected").each(function() {
					$("#rightselect").append("<option value='" + $(this).val() + "'>" + $(this).text() + "</option");
					$(this).remove();
				}) ;
			}
		})
		$("#leftimg").click(function() {
			if ($("#rightselect option:selected").length > 0) {
				$("#rightselect option:selected").each(function() {
					$("#leftselect").append("<option value='" + $(this).val() + "'>" + $(this).text() + "</option");
					$(this).remove();
				}) ;
			}
		})
		$("#savesysscope").click(function() {
			if (!$("#scopeForm").form('enableValidation').form('validate')) {
				return false;
			}
			;
			var str = "";
			if ($("#rightselect option").length > 0) {
				str = $("#rightselect option").map(function() {
					return $(this).val();
				}).get().join("&usersid=");
			}
			var url = "<%=basePath %>sysscope/saveScope.action?usersid=" + str;
			$.ajax({
				url : url,
				type : "POST",
				data : $("#scopeForm").serialize(),
				async : false,
				success : function(data) {
					$("#add").window("close");
					$.messager.alert("新建提示", data.msg, "info", function() {
						document.getElementById("findForm").submit();
					});
				},
				error : function() {
					$.messager.alert("操作提示", "操作失败", "error");
				}
			});
			$("#savediv").css("display", "block");
			$("#updatediv").css("display", "none");
		})
		$("#cancelsave").click(function() {
			$("#add").window("close");
		});
		$("#cancelupdate").click(function() {
			$("#add").window("close");
		});
		$("#closeuser").click(function() {
			$('#scopeuser').window("close");
		});
		$("#show").click(function() {
			$(".panel-with-icon").html("增加用户组");
			$("input[name=reset]").trigger("click");
			if ($("#rightselect option").length > 0) {
				$("#rightselect option").each(function() {
					$("#leftselect").append("<option value='" + $(this).val() + "'>" + $(this).text() + "</option");
					$(this).remove();
				}) ;
			}
			$("#updatediv").css("display", "none");
			$("#savediv").css("display", "block");
			$("#scopename").attr("disabled", false);
			$("#des").attr("disabled", false);
			$("#updatesysscope").attr("disabled", false);
			$("#rightimg").unbind('click').bind('click', function() {
				if ($("#leftselect option:selected").length > 0) {
					$("#leftselect option:selected").each(function() {
						$("#rightselect").append("<option value='" + $(this).val() + "'>" + $(this).text() + "</option");
						$(this).remove();
					}) ;
				}
			});
			$("#leftimg").unbind('click').bind('click', function() {
				if ($("#rightselect option:selected").length > 0) {
					$("#rightselect option:selected").each(function() {
						$("#leftselect").append("<option value='" + $(this).val() + "'>" + $(this).text() + "</option");
						$(this).remove();
					}) ;
				}
			});
			$("#add").window("open");
		});
		$("#updatesysscope").click(function() {
			if (!$("#scopeForm").form('enableValidation').form('validate')) {
				return false;
			}
			;
			var id = $('#hideid').html();
			var str = "";
			if ($("#rightselect option").length > 0) {
				str = $("#rightselect option").map(function() {
					return $(this).val();
				}).get().join("&usersid=");
			}
			var url = "<%=basePath %>sysscope/updateScope.action?scopeid=" + id + "&usersid=" + str;
			$.ajax({
				url : url,
				type : "POST",
				data : $("#scopeForm").serialize(),
				async : false,
				success : function(data) {
					$("#add").window("close");
					$.messager.alert("修改提示", data.msg, "info", function() {
						document.getElementById("findForm").submit();
					});
				},
				error : function() {
					$.messager.alert("操作提示", "操作失败", "error");
				}
			});
			$("#savediv").css("display", "block");
			$("#updatediv").css("display", "none");
		});
		$('#scopename').validatebox({
			required : true,
			missingMessage : '请输入用户组名',
		});
		$("#search_btn").click(function() {
			
			var txt = $("#seach").val();
			if ($.trim(txt) != "") {
				//console.info("不空");
				$("#leftselect option").hide();
				//console.info("隐藏");
				//console.info($("option").text());
				$("#leftselect option").filter(":contains('"+txt+"')").show();
			} else {
				//console.info("空");
				$("#leftselect option").show();
			}
		});
		$("#all_btn").click(function(){
			$("select option").show();
		})
	});
</script>
<style type="text/css">
.erjimain {
	margin: 0;
	float: left;
	width: 88%;
	height: 570px;
}
</style>
</head>

<body>
	<!--此处内容更替-->
	<div class="cwh_head">系统管理</div>

	<div class="syserjileftbar">
		<dl>
			<dt id="bg1">
				<a
					href="<%=basePath%>/sysuser/selectList.action?pageNo=1&pageSize=8"><img
					src="<%=path%>/themes/default/images/xtglbgold_03.png" /></a>
			</dt>
			<dt id="bg2">
				<a
					href="<%=basePath%>/sysrole/selectList.action?pageNo=1&pageSize=8"><img
					src="<%=path%>/themes/default/images/xtglbgold_08.png" /></a>
			</dt>
			<dt id="bg3">
				<a
					href="<%=basePath%>/sysscope/selectList.action?pageNo=1&pageSize=8"><img
					src="<%=path%>/themes/default/images/xtglbgold_11.png" /></a>
			</dt>
			<dt id="bg5">
				<a
					href="<%=basePath%>/sysdictdata/selectList.action?pageNo=1&pageSize=8"><img
					src="<%=path%>/themes/default/images/shuju1_10.png" /></a>
			</dt>
			<dt id="bg4">
				<a
					href="<%=basePath%>/sysmeetmaintain/selectAllTypeCurMeeting.action"><img
					src="<%=path%>/themes/default/images/xtglbgold_10.png" /></a>
			</dt>
			<dt id="bg6">
				<a
					href="<%=basePath%>/sysversion/selectVersionList.action?pageNo=1&pageSize=8"><img
					src="<%=path%>/themes/default/images/xtglbgold_12.png" /></a>
			</dt>
			<dt id="bg7">
				<a
					href="<%=basePath%>/syshelp/selectAllHelpList.action?pageNo=1&pageSize=8"><img
					src="<%=path%>/themes/default/images/xtglbgold_13.png" /></a>
			</dt>
		</dl>
	</div>
	<div class="erjimain">
		<div class="icon_head">推送范围管理</div>
		<div class="tongzhi_main" style="margin-top:10px;">
			<div class="tongzhi_head">
				<span id="hideid" style="display:none;"></span>
				<form action="<%=basePath%>sysscope/selectList.action?pageSize=8"
					id="findForm" method="post">
					<s:hidden name="pageNo" id="page"></s:hidden>
					<p style="font-size: 16px;margin-top: 5px;margin-left: 0px;">针对PAD端用户进行文件推送范围管理：</p>
					<!-- <button  class="button3" name="" id="show" type="button" style="position:absolute; right:0px;">增加用户组</button> -->
					<a class='easyui-linkbutton' id="show"
						data-options="iconCls:'icon-add'"
						style="width:100px;color:#a10000; position: absolute;right: 0px;margin-top: 12px;">增加用户组</a>
				</form>
			</div>
			<div class="sysscope_right">
				<div style="width:95%;margin:10px auto;">
					<table cellpadding="0" cellspacing="0" border="0" width="100%">
						<tr>
							<th class="th_sysscope">编号</th>
							<th class="th_sysscope">组名</th>
							<th class="th_sysscope">用户列表</th>
							<th class="th_sysscope">操作</th>
						</tr>
						<s:iterator value="page.result" id="stat">
							<tr>
								<td colspan="5" height="5"></td>
							</tr>
							<td class="td_sysscope"><s:property value="scopeid" /></td>
							<td class="td_sysscope"><s:property value="scopename" /></td>
							<td class="td_sysscope"><img
								src="<%=basePath%><%=themespath%>/images/jiankongicon.png"
								onclick="showscopeuser('<s:property value="scopeid"/>')"
								style="cursor:pointer;vertical-align: middle;" /></td>
							<td class="td_sysscope" style="border-right:none;">&nbsp; <s:if
									test="#stat.scopeid!=1">
									<img src="<%=basePath%><%=themespath%>/images/caozuo_03.png"
										onclick="showsysscope('<s:property value="scopeid"/>')"
										style="cursor:pointer;vertical-align: middle;" />
									<img src="<%=basePath%><%=themespath%>/images/caozuo_05.png"
										onclick="deletesysscope('<s:property value="scopeid"/>')"
										style="cursor:pointer;vertical-align: middle;" />
								</s:if>
							</td>
							</tr>
						</s:iterator>
					</table>
					<!-- 分页 -->
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
								<%--小于12页 --%>
								<s:if test="pageNo<8">
									<s:if test="totalPage<12">
										<s:iterator begin="1" end="totalPage" var="p">
											<s:if test="#p==pageNo">
												<a href="javascript:toPage(<s:property value="#p"/>);"
													class="current_page"><s:property value="#p" /></a>
											</s:if>
											<s:else>
												<a href="javascript:toPage(<s:property value="#p"/>);"><s:property
														value="#p" /></a>
											</s:else>
										</s:iterator>
									</s:if>
									<s:else>
										<s:iterator begin="1" end="12" var="p">
											<s:if test="#p==pageNo">
												<a href="javascript:toPage(<s:property value="#p"/>);"
													class="current_page"><s:property value="#p" /></a>
											</s:if>
											<s:else>
												<a href="javascript:toPage(<s:property value="#p"/>);"><s:property
														value="#p" /></a>
											</s:else>
										</s:iterator>
									</s:else>
								</s:if>
								<%--大于7页 小于12--%>
								<s:if test="pageNo>7">
									<s:if test="totalPage<13">
										<s:iterator begin="1" end="totalPage" var="p">
											<s:if test="#p==pageNo">
												<a href="javascript:toPage(<s:property value="#p"/>);"
													class="current_page"><s:property value="#p" /></a>
											</s:if>
											<s:else>
												<a href="javascript:toPage(<s:property value="#p"/>);"><s:property
														value="#p" /></a>
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
							<a>共<s:property value="totalPage" /> 页
							</a>
						</div>
					</s:if>
				</div>
			</div>
			<!--此处内容更替结束-->

			<!-- 弹窗1 -->
			<div id="add" class="easyui-window" closed="true"
				data-options="iconCls:'icon-save'" title="增加用户组"
				style="width:630px;height:500px;left:230px;top:100px;overflow: hidden;">
				<div class="sysscopeuser" style="margin-left: 70px">
					<form id="scopeForm">
						<table>
							<tr>
								<td width="25%">用户组名：</td>
								<td><input class="userinput" type="text" name="scopename"
									value="" id="scopename"></td>
								<td></td>
							</tr>
							<tr>
								<td colspan="3" height="10"></td>
							</tr>
							<tr>
								<td width="25%">用户组描述：</td>
								<td><input class="userinput" type="text" name="des"
									value="" id="des"></td>
								<td></td>
							</tr>
							<tr>
								<td width="25%">选择Pad端用户：</td>
								<td><input class="userinput" id="seach" type="text"
									name="searchstr" /></td>
								<td><a class='easyui-linkbutton'
									data-options="iconCls:'icon-search'"
									style="line-height: 25px;width: 60px;color:#a10000;left:260px;top:0px;"
									id="search_btn">搜索</a><a class='easyui-linkbutton'
									data-options="iconCls:'icon-reload'"
									style="line-height: 25px;width: 80px;color:#a10000;left:260px;top:0px;"
									id="all_btn">所有用户</a></td>
							</tr>
							<tr>
								<td width="25%"></td>
								<td style="font-size: 12px;">Pad端用户</td>
								<td style="font-size: 12px;">已选用户</td>
							</tr>
							<tr>
								<td width="25%"></td>
								<td><select multiple="multiple" id="leftselect"
									style="width:140px; float: left;" size="8">
										<s:iterator value="list">
											<option value="<s:property value='id'/>"><s:property
													value='truename'></s:property></option>
										</s:iterator>
								</select>
									<div
										style="width:40px;height:60px;position:relative;float:left;margin-left: 25px;">
										<img src="<%=basePath%><%=themespath%>images/transright.png"
											id="rightimg" style="cursor: pointer;margin-top: 30px;" /> <img
											src="<%=basePath%><%=themespath%>images/transleft.png"
											id="leftimg" style="cursor: pointer;margin-top: 15px;" />
									</div>
									<td><select multiple="multiple"
										style="width:140px;float:left;" id="rightselect" size="8"
										name="usersid">
									</select></td>
							</tr>
							<tr id="savediv">
								<td width="25%"></td>
								<td cosplan="2" style=" position:relative;">
									<!-- 	                     <button style="margin-top:40px; position:absolute; left:80px;top:0px;"  type="button" class="button3" id="savesysscope">保存</button>
	                      <button style="margin-top:40px; position:absolute; left:260px;top:0px;" type="button" class="button3" id="cancelsave">取消</button> -->
									<a class='easyui-linkbutton' data-options="iconCls:'icon-save'"
									style="line-height: 25px;width: 100px;color:#a10000;margin-top:40px;position:absolute; top:0px;left:100px;"
									id="savesysscope">保存</a> <a class='easyui-linkbutton'
									data-options="iconCls:'icon-cancel'"
									style="line-height: 25px;width: 100px;color:#a10000;margin-top:40px; position:absolute; left:260px;top:0px;"
									id="cancelsave">取消</a> <input type="reset" name="reset"
									style="display: none;" />
								</td>

							</tr>
							<tr id="updatediv">
								<td width="25%"></td>
								<td cosplan="2" style=" position:relative;">
									<!-- 	                     <button style="margin-top:40px; position:absolute; left:80px;top:0px;"  type="button" class="button3" id="updatesysscope">保存</button>
	                     <button style="margin-top:40px; position:absolute; left:260px;top:0px;" type="button" class="button3" id="cancelupdate">取消</button> -->
									<a class='easyui-linkbutton' data-options="iconCls:'icon-save'"
									style="line-height: 25px;width: 100px;color:#a10000;margin-top:40px;position:absolute; top:0px;left:100px;"
									id="updatesysscope">保存</a> <a class='easyui-linkbutton'
									data-options="iconCls:'icon-cancel'"
									style="line-height: 25px;width: 100px;color:#a10000;margin-top:40px; position:absolute; left:260px;top:0px;"
									id="cancelupdate">取消</a>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
			<!-- 弹窗 -->
			<!-- 弹窗 2-->
			<div id="scopeuser" class="easyui-window" closed="true"
				data-options="iconCls:'icon-save'" title="用户列表"
				style="width:630px;height:300px;padding:10px;">
				<div class="sysuserscanf">
					<form id="userForm"
						action="<%=basePath%>sysscope/selectUserList.action">
						<table id="usertable" cellpadding="0" cellspacing="0" width="90%">
							<tr class="jiankong_title" id="titletr">
								<th>编号：
									</td>
									<th>姓名：
										</td>
										<th>单位：
											</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
			<!-- 弹窗 -->
</body>
</html>
