<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/public/common.jspf"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript"
	src="<%=basePath%>third/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	function jump(locate) {
		window.location.href = locate;
	}
	function toPage(page) {
		document.getElementById("page").value = page;
		document.getElementById("findForm").submit();
	}
	function downLoad(noticeid) {
		window.location.href = "notify/downFile.action?noticeId=" + noticeid;

	}
	function noticereply(noticeid) {
		$(".panel-with-icon").html("监控");
		$("#titletr").siblings().empty();
		$('#hideid').html(noticeid);
		var url = "<%=basePath%>notify/selectNotifyReply.action?noticeId=" + noticeid;
		$.ajax({
			url : url,
			type : "POST",
			dataType : "json",
			async : false,
			cache : false,
			contentType : false,
			processData : false,
			success : function(data) {
				$("#totalSize").html(data['totalSize'] + "人");
				$("#attendSize").html("(" + data['attendSize'] + ")");
				$("#absenceSize").html("(" + data['absenceSize'] + ")");
				$("#unconfirmSize").html("(" + data['unconfirmSize'] + ")");
				$("#title").html('参会人员：');
				$.each(data['attendList'], function(n, val) {
					$("#titletr").after("<tr><td>" + val.userid + "</td><td>" + val.username + "</td>" + "<td>" + val.tel + "</td></tr>");
				});
			},
			error : function() {
				$.messager.alert("操作提示", "操作失败！", "error");
			}
		});

		$("#tongzhijiankong").window("open");
	}
	function shownoticereply(replyType) {
		$("#titletr").siblings().empty();
		var noticeid = $("#hideid").html();
		var url = "<%=basePath%>notify/selectNotifyReply.action?noticeId=" + noticeid;
		$.ajax({
			url : url,
			type : "POST",
			dataType : "json",
			async : false,
			cache : false,
			contentType : false,
			processData : false,
			success : function(data) {
				if (replyType == '1') {
					$("#title").html('请假人员：');
					$.each(data['absenceList'], function(n, val) {
						$("#titletr").after("<tr><td>" + val.userid + "</td><td>" + val.username + "</td>" + "<td>" + val.tel + "</td></tr>");
					});

				}
				if (replyType == '2') {
					$("#title").html('参会人员：');
					$.each(data['attendList'], function(n, val) {
						$("#titletr").after("<tr><td>" + val.userid + "</td><td>" + val.username + "</td>" + "<td>" + val.tel + "</td></tr>");
					});
				}
				if (replyType == '3') {
					$("#title").html('待定人员：');
					$.each(data['unconfirmList'], function(n, val) {
						$("#titletr").after("<tr><td>" + val.userid + "</td><td>" + val.username + "</td>" + "<td>" + val.tel + "</td></tr>");
					});
				}
			},
			error : function() {
				$.messager.alert("操作提示", "操作失败！", "error");
			}
		});

	}
	function deletenotify(id) {
		$.messager.confirm("删除提示", "<span>确定要删除？</span>", function(data) {
			if (data) {
				var url = "notify/delete.action?pageNo=1&pageSize=8&noticeId=" + id;
				$.ajax({
					url : url,
					type : "POST",
					async : false,
					cache : false,
					contentType : false,
					processData : false,
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
	function shownotify(id) {
		$(".panel-with-icon").html("编辑通知");
		var url = "<%=basePath%>notify/selectById.action?noticeId=" + id;
		$("#hideid").html(id);
		$("a#updatepush").show();
		$.ajax({
			url : url,
			type : "POST",
			async : false,
			cache : false,
			contentType : false,
			processData : false,
			dataType : "json",
			success : function(datas) {
				var arr = new Array()
				$.each(datas['scopelist'], function(n, value) {
					arr[n] = value.scopeid;
				});
				$('#scopeselect').combotree('setValues', arr);
				$('#scopeselect').combotree('disable');
				var data = datas['noticeMainEntity'];
				$("#filetext").val(data.filename);
				$("#notifyname").val(data.title);
				var sendtype = data.sendway;
				if (sendtype.substr(0, 1) == '0') {
					$("#mobilesend").attr("checked", false);
				} else {
					$("#mobilesend").attr("checked", true);
				}
				var date = data.sendtime;
				var time = date.replace(/T/, " ");
				var sendType = data.sendtype;
				if (sendType == "2") {
					$("#lateInfo").prop("checked", true);
					$("#datenotify").val(time);
					$('#datenotify').validatebox({
						required : true,
						missingMessage : '请选择日期',
					});
				}
				if (sendType == "1") {
					$("#nowInfo").prop("checked", true);
					$("#datenotify").val("");
					$("#datenotify").validatebox('remove');
				}
				if (sendType == "3") {
					
					$("#datenotify").val("");
					$("#datenotify").validatebox('remove');
				}
			},
			error : function() {
				$.messager.alert("操作提示", "操作失败！", "error");
			}
		});
		$("#savediv").css("display", "none");
		$("#updatediv").css("display", "block");
		$("#add").window("open");
	}
	function downLoad(noticeid) {
		window.location.href = "notify/downFile.action?noticeId=" + noticeid;

	}
	$(function() {
		$("#searchlist").click(function() {
			document.getElementById("page").value = 1;
			document.getElementById("findForm").submit();
		});
		$("#nowInfo").focus(function() {
			$("#datenotify").val("");
			//$("#datenotify").attr("disabled",true);
			$("#datenotify").validatebox('remove');
		});
		/*     	    $("#lateInfo").focus(function(){
		    	        $("#datenotify").attr("disabled",false);
		    	    }); */
		$("#publishnotify").click(function() {
			$(".panel-with-icon").html("发布通知");
			$("button[name=reset]").trigger('click');
			$('#scopeselect').combotree('enable');
			$("#updatediv").css("display", "none");
			$("#savediv").css("display", "block");
			$("#padsend").attr("checked", false);
			$("#mobilesend").attr("checked", false);
			$('#scopeselect').combotree('setValue', '1');
			$("#datenotify").validatebox('remove');
			$("#add").window("open");
		});
		$("#cancelnotify").click(function() {
			$("#add").window("close");
		});
		$("#cancelupdate").click(function() {
			$("#add").window("close");
		});
		$("#closenotify").click(function() {
			$("#tongzhijiankong").hide();
		});
		$("#closepush").click(function() {
			$("#add").window("close");
		});
		$("#buttonupload").click(function() {
			$("#upload").click();
		});
		$("#upload").change(function() {
			var a = $("#upload").val();
			if (a.indexOf("\\") > 0) {
				a = a.substring(a.lastIndexOf("\\") + 1)
			}
			$("#filetext").val(a);
			$("#notifyname").val(a.substring(0, a.lastIndexOf('.')));
		});
		$("#savenotify").click(function() {
			if (!$("#uploadForm").form('enableValidation').form('validate')) {
				return false;
			}
			;
			var filetext = $("#filetext").val();
			if (filetext.indexOf('.pdf') == -1) {
				//$.messager.alert('提示', '请选择上传的pdf文件', "info", function() {});
				//return;
			}
			$("#pushflag").val("0");
			var formData = new FormData($("#uploadForm")[0]);
			var url = "<%=basePath%>notify/push.action";
			$.ajax({
				url : url,
				type : "POST",
				data : formData,
				dataType : "json",
				async : false,
				cache : false,
				contentType : false,
				processData : false,
				success : function(data) {
					$("#add").window("close");
					$.messager.alert("发布提示", data.msg, "info", function() {
						document.getElementById("findForm").submit();
					});
				},
				error : function() {
					$.messager.alert("操作提示", "操作失败！", "error");
				}
			});
			$("#savediv").css("display", "block");
			$("#updatediv").css("display", "none");
		});
		$("#updatenotify").click(function() {
			if (!$("#uploadForm").form('enableValidation').form('validate')) {
				return false;
			}
			;
			$("#pushflag").val("0");
			$('#scopeselect').combotree('enable');
			$("#noticeid").val($('#hideid').html());
			var formData = new FormData($("#uploadForm")[0]);
			var url = "<%=basePath%>notify/update.action";
			$.ajax({
				url : url,
				type : "POST",
				data : formData,
				dataType : "json",
				async : false,
				cache : false,
				contentType : false,
				processData : false,
				success : function(data) {
					$("#add").window("close");
					$.messager.alert("修改提示", data.msg, "info", function() {
						//document.getElementById("uploadForm").submit();
						document.getElementById("findForm").submit();
					});
				},
				error : function() {
					$.messager.alert("操作提示", "操作失败！", "error");
				}
			});
			$("#filetext").val("");
			$("#notifyname").val("");
			$("#nowInfo").prop("checked", true);
			$("#datenotify").val("");
		});
		$("#pushnotify").click(function() {
			if (!$("#uploadForm").form('enableValidation').form('validate')) {
				return false;
			}
			;
			var filetext = $("#filetext").val();
			if (filetext.indexOf('.pdf') == -1) {
				//$.messager.alert('提示', '请选择上传的pdf文件', "info", function() {});
				//return;
			}
			$("#pushflag").val("1");
			var formData = new FormData($("#uploadForm")[0]);
			var url = "<%=basePath%>notify/push.action";
			$.ajax({
				url : url,
				type : "POST",
				data : formData,
				dataType : "json",
				async : false,
				cache : false,
				contentType : false,
				processData : false,
				success : function(data) {
					$("#add").window("close");
					$.messager.alert("发布提示", data.msg, "info", function() {
						document.getElementById("findForm").submit();
					});
				},
				error : function() {
					$.messager.alert("操作提示", "操作失败！", "error");
				}
			});
			$("#savediv").css("display", "block");
			$("#updatediv").css("display", "none");
		});
		$("#updatepush").click(function() {
			if (!$("#uploadForm").form('enableValidation').form('validate')) {
				return false;
			}
			;
			$("#pushflag").val("1");
			$('#scopeselect').combotree('enable');
			$("#noticeid").val($('#hideid').html());
			var formData = new FormData($("#uploadForm")[0]);
			var url = "<%=basePath%>notify/update.action";
			$.ajax({
				url : url,
				type : "POST",
				data : formData,
				dataType : "json",
				async : false,
				cache : false,
				contentType : false,
				processData : false,
				success : function(data) {
					$("#add").window("close");
					$.messager.alert("修改提示", data.msg, "info", function() {
						//document.getElementById("uploadForm").submit();
						document.getElementById("findForm").submit();
					});
				},
				error : function() {
					$.messager.alert("操作提示", "操作失败！", "error");
				}
			});
			$("#filetext").val("");
			$("#notifyname").val("");
			$("#nowInfo").prop("checked", true);
			$("#datenotify").val("");
		});
		$.extend($.fn.validatebox.defaults.rules, {
			mymobile : {
				validator : function(value, param) {
					return /^(((13[0-9])|(15[^4,\\D])|(18[0,2,5-9]))\d{8}\,)*(((13[0-9])|(15[^4,\\D])|(18[0,2,5-9]))\d{8})$/.test(value);
				}
			}
		})
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
			invalidMessage : '请输入正确格式'
		});
		$("#lateInfo").bind("focus", function() {
			$('#datenotify').validatebox({
				required : true,
				//validType: 'mymobile',
				missingMessage : '请选择日期',
			});
		});

	});
	function fileOpen(fileid) {
		$.ajax({
			type : "post",
			async : false,
			cache : false,
			url : "<%=basePath%>meet_getExistFileByName.action?filePath=" + fileid,
			data : {},
			success : function(data) {
				//alert(fileUrl+"ee1936bc-7ad9-4aac-b88b-3cd01d27e9e3.doc");
				//window.location=fileUrl+"ee1936bc-7ad9-4aac-b88b-3cd01d27e9e3.doc";
				var json = eval("(" + data + ")");
				if (json.state) {
					window.open("<%=basePath%>" + fileid);
				} else {
					$.messager.alert('提示', "此附件已不存在");
				}
			}
		});
	}
	function historywindow() {
		$("#historywindow").window("open");
	}
	function closehistory() {
		var fileown = $("#fileowns").val();
		window.location.href = "<%=basePath%>notify/selectsearch.action?pageSize=8";
	}
	function showHisnotify(id) {
		$(".panel-with-icon").html("历史通知");
		var url = "<%=basePath%>notify/selectById.action?noticeId=" + id;
		$("#hideid").html(id);
		$.ajax({
			url : url,
			type : "POST",
			async : false,
			cache : false,
			contentType : false,
			processData : false,
			dataType : "json",
			success : function(datas) {
				var arr = new Array()
				$.each(datas['scopelist'], function(n, value) {
					arr[n] = value.scopeid;
				});
				$('#scopeselect').combotree('setValues', arr);
				$('#scopeselect').combotree('disable');
				var data = datas['noticeMainEntity'];
				$("#filetext").val(data.filename);
				$("#notifyname").val(data.title);
				var sendtype = data.sendway;
				if (sendtype.substr(0, 1) == '0') {
					$("#mobilesend").attr("checked", false);
				} else {
					$("#mobilesend").attr("checked", true);
				}
				var date = data.sendtime;
				var time = date.replace(/T/, " ");
				var sendType = data.sendtype;
				if (sendType == "2") {
					$("#lateInfo").prop("checked", true);
					$("#datenotify").val(time);
					$('#datenotify').validatebox({
						required : true,
						missingMessage : '请选择日期',
					});
				}
				if (sendType == "1") {
					$("#nowInfo").prop("checked", true);
					$("#datenotify").val("");
					$("#datenotify").validatebox('remove');
				}
			},
			error : function() {
				$.messager.alert("操作提示", "操作失败！", "error");
			}
		});
		$("#savediv").css("display", "none");
		$("#updatediv").css("display", "block");
		$("#add").window("open");
		$("a#updatepush").hide();
	}
	$(function() {
		$("#historynotify").click(function() {
			$.ajax({
				url : "<%=basePath%>notify/selectHistory.action",
				type : "get",
				dataType : "json",
				success : function(data) {
					console.info(data);
					console.info("请求成功！");
					var titletd;
					var isdel;
					var filename;
					var filepath;
					var sendtimetd;
					var pubtimetd;
					var jktd;
					var cztd;
					$.each(data, function(idx, obj) {
						console.info(idx);
						if (idx == "hnotice") {
							$.each(obj, function(i, hnotice) {
							console.info(hnotice.filepath);
								titletd = "<td class='tdsecond_tongzhi' style='border-bottom:3px solid #fff;text-align:left;'><a href=\"javascript:fileOpen('"+hnotice.filepath+"');\" style='cursor: hand;' title='"+hnotice.title+"'> &nbsp;&nbsp;"+hnotice.title+"</a></td>";
								//console.info(i);
								sendtimetd = "<td class='tdsecond_tongzhi' style='border-bottom:3px solid #fff'>" + hnotice.sendtime + "</td>";
								pubtimetd = "<td class='tdsecond_tongzhi' style='border-bottom:3px solid #fff'>" + hnotice.pubtime + "</td>";
								jktd = "<td class='td_tongzhi' style='border-bottom:3px solid #fff'><img src='<%=basePath%><%=themespath%>/images/jiankongicon.png' name='imgnotify' style='vertical-align: middle;cursor:pointer;' onclick='noticereply(" + hnotice.noticeid + ")'></img></td>";
								cztd = "<td class='td_tongzhi' style='border-right:none;border-bottom:3px solid #fff'><img src='<%=basePath%><%=themespath%>/images/caozuo_03.png' onclick='showHisnotify(" + hnotice.noticeid + ")' style='cursor:pointer;vertical-align: middle;'/></td>";
								//$("#history_data tr").append(titletd);
								isdel = "<td class='tdsecond_tongzhi' style='border-bottom:3px solid #fff'>" + ((hnotice.isdel==1)?'已删除':'未删除') + "</td>" ;
								var tr = "<tr>" + titletd + sendtimetd + pubtimetd +isdel+ jktd + cztd + "</tr>";
								$("#history_data").append(tr);
							})
						}
					})
				}
			})
		})
	});
</script>
</head>

<body>
	<div>
		<div class="cwh_head">主页>常委会会议</div>
		<!--此处内容更替-->
		<%--         <div class="icon_head">
            <button class="button1" name="" type="button" onclick="jump('<%=basePath %>notify/select.action?pageNo=1')">返回通知</button>
       
                 
 		</div> --%>
		<div class="tongzhi">
			<div
				style="text-align: left;height: 35px;width: 90%;margin: 2px 4% 10px 4%;">
				<!--  <button  class="button3" name="" type="button" id="publishnotify" style="margin-left: 15px;">发布通知</button> -->
				<a class='easyui-linkbutton' id="publishnotify"
					data-options="iconCls:'icon-add'"
					style="margin-top:10px;z-index: 9px;margin-left: 15px;width:80px;color:#a10000;">发布通知</a>
				<a class='easyui-linkbutton' id="historynotify"
					data-options="iconCls:'icon-modify'"
					style="margin-top:10px;z-index: 9px;margin-left: 15px;width:80px;color:#a10000;"
					onclick="historywindow();">历史通知</a>
			</div>

			<span id="hideid" style="display:none;"></span>
			<div class="tongzhi_head" style="margin:5px 5% 0px 4%">
				<form action="<%=basePath%>notify/selectsearch.action?pageSize=8"
					id="findForm" method="post">
					<s:hidden name="pageNo" id="page"></s:hidden>
					<p>
						通知标题：<input class="input" type="text" name="title"
							value='<s:property value='title'/>' id="searchtitle" />
					</p>
					<p style="margin-left:10px;">
						推送时间：<input class="input" type="text" name="startTime"
							value='<s:property value='startTime'/>'
							onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
							id="starttime" />到<input class="input" type="text"
							name="endTime" value='<s:property value='endTime'/>'
							onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
							id="endtime" />
					</p>
					<!-- <button  class="button3" name="" type="button"  id="searchlist" style="float: left;">查询</button> -->
					<a class='easyui-linkbutton' id="searchlist"
						data-options="iconCls:'icon-search'"
						style="line-height: 25px;width: 80px;color:#a10000;float:left;margin-top: 7px;">查询</a>
				</form>
			</div>
			<div class="tongzhi_right">
				<div style="width:90%;margin:10px auto;">
					<table cellpadding="0" cellspacing="0" border="0" width="100%"
						style="table-layout:fixed;">
						<tr>
							<th class="thfirst_tongzhi">通知标题</th>
							<th class="thsecond_tongzhi">保存时间</th>
							<th class="thsecond_tongzhi">最后发布时间</th>
							<th class="thsecond_tongzhi">推送范围</th>
							<th class="th_tongzhi" style="width:7%">监控</th>
							<th class="th_tongzhi" style="width:9%">操作</th>
						</tr>
						<s:iterator value="page.result" id="rodo">
							<tr>
								<td colspan="5" height="5"></td>
							</tr>
							<tr>
								<td class="tdfirst_tongzhi"><a
									href="javascript:fileOpen('<s:property value="path" />');"
									style="cursor: hand;" title="<s:property value="title" />">&nbsp;&nbsp;<s:property
											value="title" /></a></td>
								<td class="tdsecond_tongzhi"><s:date name="pubtime"
										format="yyy-MM-dd HH:mm" /></td>
								<td class="tdsecond_tongzhi"><s:if
										test="#rodo.pushdate==''">&nbsp;</s:if> <s:property
										value="pushdate" /></td>
								<td class="tdsecond_tongzhi"><span
									title="<s:property value="scopenames"/>"><s:property
											value="scopenames" /></span></td>
								<td class="td_tongzhi"><img
									src="<%=basePath%><%=themespath%>/images/jiankongicon.png"
									name="imgnotify" style="vertical-align: middle;cursor:pointer;"
									onclick="noticereply('<s:property value="noticeid"/>')" /></td>
								<td class="td_tongzhi" style="border-right:none;"><img
									src="<%=basePath%><%=themespath%>/images/caozuo_03.png"
									onclick="shownotify('<s:property value="noticeid"/>')"
									style="cursor:pointer;vertical-align: middle;" /> <img
									src="<%=basePath%><%=themespath%>/images/caozuo_05.png"
									onclick="deletenotify('<s:property value="noticeid"/>')"
									style="cursor:hand;cursor:pointer;vertical-align: middle;" /></td>
							</tr>
						</s:iterator>
					</table>
				</div>
				<s:if test="totalPage>1">
					<div id="page" style="margin-top: 5px;">
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
				</form>

			</div>
			<div id="add" class="easyui-window" closed="true"
				data-options="iconCls:'icon-save'" title="发布通知"
				style="width:630px;height:500px;left:230px;top:100px;padding:10px;">
				<div class="noticepopinner">
					<form id="uploadForm" action="<%=basePath%>notify/update.action?"
						enctype="multipart/form-data">
						<table cellpadding="0" cellspacing="0">
							<tr>
								<s:hidden name="noticeId" id="noticeid"></s:hidden>
								<s:hidden name="pushflag" id="pushflag"></s:hidden>
								<td width="100px;">通知文件：</td>
								<td><input type="text" name="notifyFileFileName" value=""
									id="filetext" readonly="readonly" class="easyui-validatebox"
									missingMessage="请选择上传文件" data-options="required:true"></td>
								<!--  <td><button type="button" class="button3" id="buttonupload">上传</button> -->
								<td><a class='easyui-linkbutton' id="buttonupload"
									style="line-height: 25px;width: 80px;color:#a10000;margin-left:10px;"
									data-options="iconCls:'icon-upload'">上传</a>
									<div style="display: none">
										<input type="file" name="notifyFile" value="" id="upload">
									</div></td>
							</tr>
							<tr style="display: none;">
								<td width="100px;">通知名称：</td>
								<td colspan="2"><input type="text" name="name" value=""
									id="notifyname"></td>
							</tr>
							<tr>
								<td width="100px;">推送范围：</td>
								<td colspan="2"><select
									style="line-height:25px; height:25px; width:300px;"
									bgcolor="#ccc" name="scopeids" class="easyui-combotree"
									data-options="url:'<%=basePath%>notify/listScope.action',required:true"
									multiple id="scopeselect" missingMessage='请选择推送范围'>
								</select></td>
							</tr>
							<tr>
								<td width="100px;">提醒时间：</td>
								<td colspan="2"><input type="radio" name="sendType"
									value="1" checked="checked" id="nowInfo">立即提醒</td>
							</tr>
							
							<tr>
								<td width="100px;"></td>
								<td colspan="2"><input type="radio" name="sendType"
									value="3" id="nowInfoBTX">不提醒</td>
							</tr>
							
							<tr>
								<td width="100px;"></td>
								<td colspan="2"><input type="radio" name="sendType"
									value="2" id="lateInfo">定时提醒</td>
							</tr>
							<tr>
								<td width="100px;"></td>
								<td colspan="2"><input type="text" name="sendTimeStr"
									class="Wdate"
									style="width:200px;height:25px;margin-left:5px;border:2px solid #ccc;"
									id="datenotify"
									onClick="WdatePicker({lang:'zh-cn',dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
								</td>
							</tr>
							<tr id="savediv">
								<!-- 	                	<td><button style="margin-top:35px; " type="button" class="button3" id="savenotify">保存</button>
	                	<td><button style="margin-top:35px; margin-left:30px;" type="button" class="button3" id="pushnotify">保存并发布</button></td>
	                	<td><button style="margin-top:35px; margin-left:30px;" type="button" class="button3" id="cancelnotify">取消</button></td> -->

								<td><a class='easyui-linkbutton'
									data-options="iconCls:'icon-save'"
									style="line-height: 25px;width: 115px;color:#a10000;margin-top:35px;"
									id="savenotify">保存</a></td>
								<td><a class='easyui-linkbutton'
									data-options="iconCls:'icon-push'"
									style="line-height: 25px;width: 115px;color:#a10000;margin-top:35px; margin-left:30px;"
									id="pushnotify">保存并发布</a></td>
								<td><a class='easyui-linkbutton'
									data-options="iconCls:'icon-cancel'"
									style="line-height: 25px;width: 115px;color:#a10000;margin-top:35px; margin-left:30px;"
									id="cancelnotify">取消</a></td>
							</tr>
							<tr id="updatediv">
								<!-- 	                	<td ><button style="margin-top:35px;" type="button" class="button3" id="updatenotify" >保存</button>
	                	<td ><button style="margin-top:35px; margin-left:30px;" type="button" class="button3" id="updatepush" >保存并发布</button></td>
	                	<td><button style="margin-top:35px; margin-left:30px;" type="button" class="button3" id="cancelupdate">取消</button>
	                	 -->
								<td><a class='easyui-linkbutton'
									data-options="iconCls:'icon-save'"
									style="line-height: 25px;width: 115px;color:#a10000;margin-top:35px;"
									id="updatenotify">保存</a></td>
								<td><a class='easyui-linkbutton'
									data-options="iconCls:'icon-push'"
									style="line-height: 25px;width: 115px;color:#a10000;margin-top:35px; margin-left:30px;"
									id="updatepush">保存并发布</a></td>
								<td><a class='easyui-linkbutton'
									data-options="iconCls:'icon-cancel'"
									style="line-height: 25px;width: 115px;color:#a10000;margin-top:35px; margin-left:30px;"
									id="cancelupdate">取消</a></td>
								<button type="reset" name="reset" style="display: none;"></button>
							</tr>
						</table>
					</form>
				</div>
			</div>
			<div id="tongzhijiankong" class="easyui-window" closed="true"
				data-options="iconCls:'icon-save'" title="监控"
				style="width:900px; height:500px; left:100px;top:100px;">
				<div class="jiankong_left2 flt">
					<p>
						总人数<br /> <span id="totalSize"></span>
					</p>
					<ul>
						<li>参会人员<span id="attendSize" onclick="shownoticereply('2')"></span></li>
						<li>请假人员<span id="absenceSize" onclick="shownoticereply('1')"></span></li>
						<li>待定人员<span id="unconfirmSize"
							onclick="shownoticereply('3')"></span></li>
					</ul>
				</div>
				<div class="jiankong_right2 frt">
					<p id="title">参会人员:</p>
					<div
						style="width:100%;margin:10px auto;overflow-x:hidden;overflow-y:scroll;height: 350px;">
						<table cellpadding="0" cellspacing="0" border="1" width="100%"
							id="replytitle">
							<tr class="jiankong_title2" id="titletr">
								<th>编号
								</td>
								<th>姓名
								</td>
								<th>手机号码
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
		<!--此处内容更替结束-->
		<!--此处内容更替开始-->
		<div id="historywindow" class="easyui-window" closed="true"
			data-options="iconCls:'icon-save'" title="历史通知"
			style="width:1050px;height:550px;">
			<table cellpadding="0" cellspacing="0" border="0" width="100%"
				style="table-layout:fixed; padding: 10px;">
				<thead>
					<tr>
						<th class="thfirst_tongzhi">通知标题</th>
						<th class="thsecond_tongzhi">保存时间</th>
						<th class="thsecond_tongzhi">最后发布时间</th>
						<!-- <th class="thsecond_tongzhi">推送范围</th> -->
						<th class="th_tongzhi" style="width:8%">已删除</th>
						<th class="th_tongzhi" style="width:7%">监控</th>
						<th class="th_tongzhi" style="width:9%">操作</th>
						
					</tr>
				</thead>
				<tbody id="history_data">
				</tbody>
			</table>
			<div id="tongzhijiankong" class="easyui-window" closed="true"
				data-options="iconCls:'icon-save'" title="监控"
				style="width:900px; height:500px; left:100px;top:100px;">
				<div class="jiankong_left2 flt">
					<p>
						总人数<br /> <span id="totalSize"></span>
					</p>
					<ul>
						<li>参会人员<span id="attendSize" onclick="shownoticereply('2')"></span></li>
						<li>请假人员<span id="absenceSize" onclick="shownoticereply('1')"></span></li>
						<li>待定人员<span id="unconfirmSize"
							onclick="shownoticereply('3')"></span></li>
					</ul>
				</div>
				<div class="jiankong_right2 frt">
					<p id="title">参会人员:</p>
					<div
						style="width:100%;margin:10px auto;overflow-x:hidden;overflow-y:scroll;height: 350px;">
						<table cellpadding="0" cellspacing="0" border="1" width="100%"
							id="replytitle">
							<tr class="jiankong_title2" id="titletr">
								<th>编号
								</td>
								<th>姓名
								</td>
								<th>手机号码
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<!-- <div>
				<a class='easyui-linkbutton' data-options="iconCls:'icon-ok'"
					style="line-height: 25px;width: 80px;color:#a10000;margin-left:800px;margin-top: 5px;"
					onclick="closehistory();">确定</a>
			</div> -->
		</div>
</body>
</html>
