<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/public/common.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>人大会议助理_常委会会议</title>
<script type="text/javascript"
	src="<%=basePath %>third/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	$(function() {
		$("#cancelsave").click(function() {
			$("#add").window("close");
		});
		$("#cancelupdate").click(function() {
			$("#add").window("close");
		});
		$('#backindex').click(function() {
			window.location.href = "<%=basePath %>/smsdefine/selectSmsdefineLog.action?pageNo=1&pageSize=8";
		});
		$("#rightimg").click(function() {
			$("#rightselect option").remove();
			var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
			var nodes = treeObj.getCheckedNodes(true);
			var ids = [];
			for (var i = 0; i < nodes.length; i++) {
				if (nodes[i].pId != null) {
					if ($("#rightselect option").length > 0) {
						var flag2 = true;
						$("#rightselect option").each(function() {
							if (nodes[i].id == $(this).val()) {
								flag2 = false;
							}
						}) ;
						if (flag2) {
							$("#rightselect").append("<option id='checkscope" + nodes[i].id + "' value='" + nodes[i].id + "'>" + nodes[i].name + "</option");
						}
					} else {
						$("#rightselect").append("<option id='checkscope" + nodes[i].id + "' value='" + nodes[i].id + "'>" + nodes[i].name + "</option");
					}

				}
			/* ids.push(nodes[i].id); */
			}
		/* 		alert(ids)
				document.getElementById('fileids').value=ids.join(",");
		    	if($("#leftselect option:selected").length>0) { 
		           $("#leftselect option:selected").each(function(){ 
		                   $("#rightselect").append("<option value='"+$(this).val()+"'>"+$(this).text()+"</option"); 
		                       $(this).remove();
		           }) ;
		        }  */
		})
		$("#leftimg").click(function() {
			if ($("#rightselect option:selected").length > 0) {
				$("#rightselect option:selected").each(function() {
					var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
					var checknodes = treeObj.getCheckedNodes(true);
					for (var j = 0; j < checknodes.length; j++) {
						if (checknodes[j].id == $(this).val()) {
							checknodes[j].checked = false;
							treeObj.updateNode(checknodes[j]);
						}
					}
					/*         	        var node=treeObj.getNodesByParamFuzzy("name", $(this).text(), null);
					    				for (var i = 0; i < node.length; i++) {
											if(node[i].checked){
												node[i].checked=false;
												treeObj.updateNode(node[i]);
											}
										} */
					/*                    $("#leftselect").append("<option value='"+$(this).val()+"'>"+$(this).text()+"</option");  */
					$(this).remove();
				}) ;
			}
		})
		$("#show").click(function() {
			var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
			var nodes = treeObj.getCheckedNodes(true);
			for (var i = 0; i < nodes.length; i++) {
				treeObj.checkNode(nodes[i], false, false);
			}
			$(".panel-with-icon").html("新增手机提醒");
			$("input[name=reset]").trigger("click");
			$("#mobilesend").attr("checked", true);
			$("#mobilesend").attr("disabled", true);
			$("#nowsend").attr("checked", true);
			if ($("#rightselect option").length > 0) {
				$("#rightselect option").each(function() {
					$("#leftselect").append("<option value='" + $(this).val() + "'>" + $(this).text() + "</option");
					$(this).remove();
				}) ;
			}
			$("#updatediv").css("display", "none");
			$("#savediv").css("display", "block");
			$("#add").window("open");
		});
		$("#savesmsdefine").click(function() {
			if (!$("#smsdefineForm").form('enableValidation').form('validate')) {
				return false;
			}
			;
			var str = "";
			if ($("#rightselect option").length > 0) {
				str = $("#rightselect option").map(function() {
					return $(this).val();
				}).get().join("&tongxluserids=");
			}
			var url = "<%=basePath %>smsdefine/insertSmsdefine.action?tongxluserids=" + str;
			$.ajax({
				url : url,
				type : "POST",
				data : $("#smsdefineForm").serialize(),
				async : false,
				cache : false,
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

		});

		$("#updatesmsdefine").click(function() {
			if (!$("#smsdefineForm").form('enableValidation').form('validate')) {
				return false;
			}
			;
			var id = $('#hideid').html();
			var str = "";
			if ($("#rightselect option").length > 0) {
				str = $("#rightselect option").map(function() {
					return $(this).val();
				}).get().join("&tongxluserids=");
			}
			var url = "<%=basePath %>smsdefine/updateSmsdefine.action?tongxluserids=" + str + "&smsid=" + id;
			$.ajax({
				url : url,
				type : "POST",
				data : $("#smsdefineForm").serialize(),
				async : false,
				cache : false,
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
		$.extend($.fn.validatebox.defaults.rules, {
			selectValueRequired : {
				validator : function(value, param) {
					//console.info($(param[0]).find("option:contains('"+value+"')").val());
					alert($(param[0]).options.length)
					return $(param[0]).options.length != 0;
				},
				message : '请选择人员'
			},
			mymobile : {
				validator : function(value, param) {
					return /^((1[3|4|5|8|9]\d{9}\,)*(1[3|4|5|8|9]\d{9}))$/.test(value);
				}
			}
		});
		$.extend($.fn.validatebox.methods, {
			remove : function(jq, newposition) {
				return jq.each(function() {
					$(this).removeClass("validatebox-text validatebox-invalid").unbind('focus').unbind('blur');
				});
			},
			reduce : function(jq, newposition) {
				return jq.each(function() {
					var opt = $(this).data().validatebox.options;
					$(this).addClass("validatebox-text").validatebox(opt);
				});
			}
		});

		$('#phonenums').validatebox({
			validType : 'mymobile',
			missingMessage : '请输入手机号码',
			invalidMessage : '多个手机号码请使用,分隔'
		});
		$("#nowsend").focus(function() {
			$("#sendTimeStr").val("");
			$("#sendTimeStr").attr("disabled", true);
			$("#sendTimeStr").validatebox('remove');
		});
		$("#latesend").focus(function() {
			$("#sendTimeStr").attr("disabled", false);
		});
		$("#latesend").bind("focus", function() {
			$('#sendTimeStr').validatebox({
				required : true,
				//validType: 'mymobile',
				missingMessage : '请选择日期',
			});
		});
	});
	function toPage(page) {
		document.getElementById("page").value = page;
		document.getElementById("findForm").submit();
	}
	function deletesmsdefine(id) {
		$.messager.confirm("删除提示", "<span>确定要删除？</span>", function(data) {
			if (data) {
				var url = "<%=basePath %>smsdefine/delete.action?pageSize=8&smsid=" + id;
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
	function showsmsdefine(id) {
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
		var nodes = treeObj.getCheckedNodes(true);
		for (var i = 0; i < nodes.length; i++) {
			treeObj.checkNode(nodes[i], false, false);
		}
		$(".panel-with-icon").html("编辑手机提醒");
		var url = "<%=basePath%>smsdefine/selectBySmsid.action?smsid=" + id;
		$("#hideid").html(id);
		$.ajax({
			url : url,
			type : "POST",
			async : false,
			cache : false,
			success : function(data) {
				$("#leftselect").find("option").remove();
				$("#rightselect").find("option").remove();
				$("#mobilesend").attr("checked", true);
				$("#mobilesend").attr("disabled", true);
				$.each(data['userlist'], function(n, value) {
					$("#leftselect").append("<option value='" + value.id + "'>" + value.truename + "</option");
				});
				$.each(data['smsdefineUserList'], function(m, val) {
					$("#rightselect").append("<option value='" + val.id + "'>" + val.truename + "</option");
				}) ;
				$("#content").val(data['smsdefineEntity'].content);
				var sendtype = data['smsdefineEntity'].sendtype;
				if (data['smsdefineEntity'].sendway == '1') {
					$("#nowsend").attr("checked", true);
					$("#sendTimeStr").val("");
					$("#sendTimeStr").attr("disabled", true);
					$("#sendTimeStr").validatebox('remove');
				} else {
					$("#latesend").attr("checked", true);
					$("#sendTimeStr").val(data['smsdefineEntity'].sendtime.replace("T", " "));
					$("#sendTimeStr").attr("disabled", false);
					$('#sendTimeStr').validatebox({
						required : true,
						//validType: 'mymobile',
						missingMessage : '请选择日期',
					});
				}
				$("#phonenums").val(data['smsdefineEntity'].phonenums);
			},
			error : function() {
				$.messager.alert("操作提示", "操作失败！", "error");
			}
		});
		$("#savediv").css("display", "none");
		$("#updatediv").css("display", "block");
		$("#add").window("open");
	}
	function showsmsdefineusers(userids) {
		$("#titletr").siblings().empty();
		var url = "<%=basePath %>smsdefine/selectUserList.action?userids=" + userids;
		$.ajax({
			url : url,
			type : "POST",
			async : false,
			cache : false,
			success : function(data) {
				$("#usertable").window("open");
				$.each(data, function(n, value) {
					$("#usertables tbody").append("<tr><td>" + value.id + "</td><td >" + value.truename + "</td><td >" + value.danwei + "</td></tr>")
				});
			},
			error : function() {
				$.messager.alert("操作提示", "操作失败！", "error");
			}
		});

	}
</script>
</head>
<body>
	<div class="cwh_head">提醒管理</div>
	<!--此处内容更替-->
	<div class="icon_head">
		<!--             <button class="button1" name="" id="backindex" type="button">返回短信管理</button>
 -->
	</div>
	<a class='easyui-linkbutton' data-options="iconCls:'icon-goback'"
		style="line-height: 25px;width:115px;color:#a10000;right:20px;top:65px;position: absolute;"
		id="backindex">返回短信管理</a>
	<div class="tongzhi">
		<div class="tongzhi_head">
			<span id="hideid" style="display:none;"></span>
			<form
				action="<%=basePath%>/smsdefine/selectSmsdefineMain.action?pageSize=8"
				id="findForm" method="post">
				<s:hidden name="pageNo" id="page" />
				<!--  <button  class="button3 flt" id="show" name="" type="button" style="position:absolute; right:20px;">新增手机提醒</button> -->
				<a class='easyui-linkbutton' id="show"
					data-options="iconCls:'icon-add'"
					style="line-height: 25px;width:100px;color:#a10000;float:right;margin-top:10px;margin-bottom:10px;">新增手机提醒</a>
			</form>
		</div>
		<div class="tongzhi_main">
			<div class="smsdefine_right2">
				<div style="width:93%;margin:10px auto;">
					<table cellpadding="0" cellspacing="0" border="0" width="100%"
						style="table-layout:fixed;">
						<tr>
							<th class="th_smsdefine2" width="8%">编号</th>
							<th class="th_smsdefine2" width="55%">手机提醒内容</th>
							<th class="th_smsdefine2" width="8%">设置人</th>
							<th class="th_smsdefine2" width="7%">用户</th>
							<th class="th_smsdefine2" width="7%">提醒时间</th>
							<th class="th_smsdefine2" width="5%">操作</th>
						</tr>
						<s:iterator value="page.result" id="stat">
							<tr>
								<td colspan="5" height="5"></td>
							</tr>
							<td class="td_smsdefine2" width="8%"><s:property
									value="smsid" /></td>
							<td class="td_smsdefine2" width="55%"
								style="word-break:keep-all; white-space:nowrap;overflow:hidden;text-overflow:ellipsis;text-align: left;">&nbsp;&nbsp;<span
								title="<s:property value="content"/>"><s:property
										value="content" /><span></td>
							<td class="td_smsdefine2" width="8%"><s:property
									value="createusername" /></td>
							<td class="td_smsdefine2" width="7%"><a
								onclick="showsmsdefineusers('<s:property value="tongxluserids"/>')"
								style="cursor:pointer;">详情</a></td>
							<td class="td_smsdefine2" width="7%"><s:if
									test="#stat.sendway==1">立即提醒</s:if> <s:if
									test="#stat.sendway==2">定时提醒</s:if></td>
							<td width="5%" class="td_smsdefine2" style="border-right:none;"><img
								src="<%=basePath%><%=themespath%>/images/caozuo_03.png"
								onclick="showsmsdefine('<s:property value="smsid"/>')"
								style="cursor:pointer;vertical-align: middle;" /> <img
								src="<%=basePath%><%=themespath%>/images/caozuo_05.png"
								onclick="deletesmsdefine('<s:property value="smsid"/>')"
								style="cursor:pointer;vertical-align: middle;" /></td>
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
					<!-- 分页 -->
				</div>
			</div>

			<!-- 弹窗 -->
			<div id="add" class="easyui-window" closed="true"
				data-options="iconCls:'icon-save'" title="新增手机提醒"
				style="width:730px;height:600px;overflow:hidden">
				<div class="smsdefineaddtable">
					<form id="smsdefineForm">
						<table style="margin-left: 50px;margin-top: 20px;">
							<tr>
								<td width="15%">提醒内容：</td>
								<td colspan="2"><textarea cols="38" rows="3"
										style="resize: none;border: 1px solid #aaa;font-size: 14px;"
										name="content" id="content" class="easyui-validatebox"
										data-options="required:true"></textarea></td>
							</tr>
							<tr>
								<td colspan="3" height="8"></td>
							</tr>
							<tr>
								<td width="15%">发送人员：</td>
								<td>所有人员</td>
								<td style="padding-left: 35px;">已选人员</td>
							</tr>

							<tr>
								<td width="15%"></td>
								<td>
									<div id="treeDemo" class="ztree"
										style="overflow: auto;width:300px; height: 200px;border: 1px solid #ccc;"></div>
									<%--                    <select multiple="multiple" id="leftselect" style="width:125px; float: left;" size="8" >
                  	<s:iterator value="txlist">
                  		<option value="<s:property value='id'/>"><s:property value='truename'></s:property></option>
                      </s:iterator> 
		           </select>  --%>
									<td>
										<div
											style="width:35px;height:60px;position:relative;float:left;margin-left: 22px;margin-top: 45px;">
											<img src="<%=basePath%><%=themespath%>images/transright.png"
												id="rightimg" style="cursor: pointer;" /> <img
												src="<%=basePath%><%=themespath%>images/transleft.png"
												id="leftimg" style="margin-top:20px;cursor: pointer;" />
										</div> <select multiple="multiple"
										style="width:150px;float:left;height: 210px;" id="rightselect"
										size="10" name="tongxluserids">
									</select>
								</td>
							</tr>
							<tr>
								<td colspan="3" height="8"></td>
							</tr>
							<tr>
								<td width="15%">提醒方式：</td>
								<td colspan="2"><input type="radio" name="mobilesend"
									id="mobilesend" value="1" disabled="disabled" />手机短信提醒</td>
							</tr>
							<tr>
								<td colspan="3" height="8"></td>
							</tr>
							<tr>
								<td width="15%"></td>
								<td colspan="2"><input type="text" name="phonenums"
									class="input_bg" placeholder="手工输入号码" id="phonenums" border="0"
									style="color: #333; font-size: 14px; font-family: '微软雅黑';border: 2px solid #ccc;line-height: 25px;height: 25px;width: 58%" /></td>
							</tr>
							<tr>
								<td colspan="3" height="8"></td>
							</tr>
							<tr>
								<td width="15%">提醒时间：</td>
								<td colspan="2"><input type="radio" name="sendway"
									value='1' checked="checked" id="nowsend" />立即提醒</td>
							</tr>
							<tr>
								<td colspan="3" height="8"></td>
							</tr>
							<tr>
								<td width="15%"></td>
								<td colspan="2"><input type="radio" name="sendway"
									value='2' id="latesend" />定时提醒 <input type="text"
									name="sendTimeStr" id="sendTimeStr" class="Wdate"
									style="width:160px;margin-left: 60px;height:25px;border:2px solid #ccc;"
									onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
									disabled="disabled" /></td>
							</tr>
							<tr id="savediv">
								<td width="20%"></td>
								<td colspan="2" style=" position:relative;">
									<!-- 	               <button style="margin-top:30px; position:absolute; top:0px;left:85px;"  type="button" class="button3" id="savesmsdefine">保存</button>
	               <button style="margin-top:30px; position:absolute; left:270px;top:0px;" type="button" class="button3" id="cancelsave">取消</button> -->
									<a class='easyui-linkbutton' data-options="iconCls:'icon-save'"
									style="line-height: 25px;width: 100px;color:#a10000;margin-top:30px;position:absolute; top:0px;left:85px;"
									id="savesmsdefine">保存</a> <a class='easyui-linkbutton'
									data-options="iconCls:'icon-cancel'"
									style="line-height: 25px;width: 100px;color:#a10000;margin-top:30px; position:absolute; left:260px;top:0px;"
									id="cancelsave">取消</a> <input type="reset" name="reset"
									style="display: none;" />
								</td>
							</tr>
							<tr id="updatediv">
								<td width="15%"></td>
								<td colspan="2" style=" position:relative;">
									<!--  <button style="margin-top:30px; position:absolute; top:0px;left:85px;"  type="button" class="button3" id="updatesmsdefine">保存</button>
	               <button style="margin-top:30px; position:absolute; left:270px;top:0px;" type="button" class="button3" id="cancelupdate">取消</button> -->
									<a class='easyui-linkbutton' data-options="iconCls:'icon-save'"
									style="line-height: 25px;width: 100px;color:#a10000;margin-top:30px;position:absolute; top:0px;left:85px;"
									id="updatesmsdefine">保存</a> <a class='easyui-linkbutton'
									data-options="iconCls:'icon-cancel'"
									style="line-height: 25px;width: 100px;color:#a10000;margin-top:30px; position:absolute; left:260px;top:0px;"
									id="cancelupdate">取消</a> <input type="reset" name="reset"
									style="display: none;" />
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
			<!-- 弹窗 -->
			<!-- 弹窗 2-->
			<div id="usertable" class="easyui-window" closed="true"
				data-options="iconCls:'icon-save'" title="查看用户"
				style="width:630px;height:300px;padding:10px;">
				<div class="sysuserscanf">
					<form id="userForm"
						action="<%=basePath%>sysrole/selectUserList.action">
						<table id="usertables" cellpadding="0" cellspacing="0" width="90%">
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
		</div>
	</div>
	<!--此处内容更替结束-->

	<script type="text/javascript">
	
		var setting = {
			check : {
				enable : true
			},
			data : {
				simpleData : {
					enable : true
				}
			}
		};
	
		function setCheck() {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			zTree.setting.check.chkboxType = {
				"Y" : "ps",
				"N" : "ps"
			};
	
		}
		$(document).ready(function() {
			$.fn.zTree.init($("#treeDemo"), setting, eval('${jsonStr}'));
			setCheck() ;
		});
	</script>
</body>
</html>
