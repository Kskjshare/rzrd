<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/public/common.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>人大会议助理_常委会会议</title>
<%
	String meetid = request.getParameter("meetid");
	String fileown = request.getParameter("fileown");
%>
<style type="text/css">
.erjimain {
	margin: 0;
	float: left;
	height: 580px;
	border: none;
}

.erjileftbar {
	margin: 0;
	float: left;
}

.erjileftbar dl {
	margin-top: 15px;
}

.erjileftbar dt {
	margin-top: 5px;
}
</style>
<link href="<%=basePath%>third/swfupload/css/default.css"
	rel="stylesheet" type="text/css" />
<script language="javascript" src="<%=basePath%>third/json.js"></script>
<script type="text/javascript"
	src="<%=basePath%>third/swfupload/swfupload.js"></script>
<script type="text/javascript"
	src="<%=basePath%>third/swfupload/swfupload.queue.js"></script>
<script type="text/javascript"
	src="<%=basePath%>third/swfupload/fileprogresscommon.js"></script>
<script type="text/javascript"
	src="<%=basePath%>third/swfupload/handlers.js"></script>
<script type="text/javascript" src="<%=basePath%>third/myJs/editable.js"></script>
<script type="text/javascript">
		var filetown=1;
		function addfile(id){
           		 $('#logicWindow1').window('open');
			     $('#fff').form('clear');
 		            document.getElementById('fsUploadProgress1').innerHTML="";
 		          // document.getElementById('pushdiv').style.display="none";
					$('#fff').form({
						onSubmit:function (){
							var t =  $(this).form('validate');
							if(t)
							{
								$('#btnsub1').linkbutton({disabled:true});
							}
							return t;
						},
						success:function(data){
							var json = eval("("+data+")");
							if(!json.state)
							{
								alert(json.msg);
							}
							$('#btnsub1').linkbutton({disabled:false});
						}
					});
					var sel=document.getElementById('filetypeSel');
					sel.options.length=3;
					sel.options[0].text = "正式文件"; 
					sel.options[0].value = "1";
					sel.options[1].text = "延伸阅读"; 
					sel.options[1].value = "2";
					sel.options[0].selected="selected"
					$('#scopeselect').combotree('setValues', [1]);
			     // document.getElementById('fff').action = "<%=basePath%>meeting/subMeetingAction!meetingfileadd.action?submeetingid="+id+"&rand="+Math.random();
			}
			//document.getElementById('meetingname').innerHTML=meetingname;
			function sub1(){
				$('#logicWindow1').window('close');
				$('#search').click();
			}
			
			function deleteFile(id,meetid){
				$.messager.confirm("确认", "确定要删除此文件吗？", function (r) {
                if(r){
                	var filetype=document.getElementById("filetype").value;
                	filetown=document.getElementById("fileowns").value;
                	//alert("filetype:"+filetype+","+meetid);
                	window.location.href = "<%=basePath%>meet_deleteFileAction.action?fileid="+id+"&meetid="+meetid+"&filetype="+filetype+"&fileown="+filetown;
                 }
			   })
			}
			function updateFileType(fileid,obj){
			var val=obj.options[obj.options.selectedIndex].value;
			//alert(fileid+","+obj+","+val);
			$("#"+fileid).find("select").eq(0).val(obj.value)
			$.ajax({
					url:"<%=basePath%>meet_uploadFileType.action?fileid="+fileid+"&filetype="+val,
					success:function (data){
					var json = eval("("+data+")");
						alert(!json.state);
						if(!json.state)
						{
							alert(json.msg);
						}else {
						//	$("#dataGrid").treegrid("reload");
						}
					}
				});
			}
			
			function toPage(page){
            	document.getElementById("page").value=page;
            	document.getElementById("findForm").submit();
            }
            
            $(function(){
			$('#table').editablefile2({
				action:"<%=basePath%>meet_updateFileSort.action"
			});
			$('#table').checkAll({
				action:"<%=basePath%>meet_deleteMeetFiles.action",
				idSubmit:"fileids"
			});
			 getPubtime();
		})
		
		function setComValues(){
			var selVal=$('#scopeselect').combotree('getValues');
			document.getElementById('selVal').value=selVal;
			//alert(selVal);
		}
        
           function sortwindow(){
   			$("#popwindow").window("open");
   		}
   		function up(obj,filetype){
       			var tr=obj.parentNode.parentNode;
       			if (tr.rowIndex > 1) {
       				var trid=tr.id;
				console.info("trid:"+trid);
				var trsort=$('tr#'+trid+' td[data=sort]').text();
				console.info("trsort:"+trsort);
				var trindex=$('tr#'+trid+' td[data=index]').text();
				console.info("trindex"+trindex);
				console.info(tr);
				var trpre=tr.previousSibling.previousSibling;
				console.info(trpre);
				var trpreid=trpre.id;
				console.info("trpreid:"+trpreid);
				var trpresort=$('tr#'+trpreid+' td[data=sort]').text();
				console.info("trpresort:"+trpresort);
				var trpreindex=$('tr#'+trpreid+' td[data=index]').text();
				console.info("trpreindex:"+trpreindex);
				var tBody = tr.parentNode;
				tBody.replaceChild(trpre, tr);
				var target =trpre.previousSibling;
				tBody.insertBefore(tr, target);
				console.info("=============================")
				$('tr#'+trpreid+' td[data=sort]').text(trsort);
				$('tr#'+trpreid+' td[data=index]').text(trindex);
				$('tr#'+trid+' td[data=sort]').text(trpresort);
				$('tr#'+trid+' td[data=index]').text(trpreindex);
				$.post('<%=basePath%>meet_updateSort.action', {id:trid,ftype:filetype,sort:trpresort},function(){
					$.post('<%=basePath%>meet_updateSort.action', {id:trpreid,ftype:filetype,sort:trsort});
				});
       			}
       		}
       		function down(obj,filetype){
       			console.info(obj);
       			var tr=obj.parentNode.parentNode;
       			var tBody = tr.parentNode;
       			console.info(tBody);
       			if (tr.rowIndex < tBody.rows.length-1) {
       			console.info(tBody.rows.length);
       				var trid=tr.id;
       				console.info(trid);
       				var trsort=$('tr#'+trid+' td[data=sort]').text();
       				var trindex=$('tr#'+trid+' td[data=index]').text();
       				var trnext=tr.nextSibling.nextSibling;
       				console.info(tr);
       				var trnextid=trnext.id;
       				console.info("trnextid:"+trnextid);
       				var trnextsort=$('tr#'+trnextid+' td[data=sort]').text();
       				var trnextindex=$('tr#'+trnextid+' td[data=index]').text();
       				
       				tBody.replaceChild(tr, trnext);
       				var target = tr.previousSibling;
       				tBody.insertBefore(trnext, target);
       				console.info("===============================");
       				$('tr#'+trnextid+' td[data=sort]').text(trsort);
       				$('tr#'+trnextid+' td[data=index]').text(trindex);
       				$('tr#'+trid+' td[data=sort]').text(trnextsort);
       				$('tr#'+trid+' td[data=index]').text(trnextindex);
       				$.post('<%=basePath%>meet_updateSort.action', {id:trid,ftype:filetype,sort:trnextsort},function(){
       					$.post('<%=basePath%>meet_updateSort.action', {id:trnextid,ftype:filetype,sort:trsort});
       				});
       			}
       		}
   		function closeSort(){
   			var fileown=$("#fileowns").val();
   			window.location.href ="<%=basePath%>meet_getMeetFilecwh2.action?meetid=<s:property value="meetid"/>&filetype=&pageNo=1&pageSize=8&fileown="+fileown;
   		}
   		function sel(obj){
   			$("#poptable td[class='trsel']").attr("class","td_tongyong");
   			var $obj=$(obj);
   			$obj.children("td").attr("class","trsel");
   		}
            function backMeet(){
    		window.location.href="<%=basePath%>selectCurMeeting.action?type=2";
    	}
    	function showS(){
    		$.messager.alert('提示',"已保存！","info");
    	}
    	function saveAndP(){
			$('#meetid').val(parseInt(<%=meetid%>));
			if(parseInt(<%=fileown%>)==2){
				$('#statename').val('huizhong');
			}else{
				$('#statename').val('bimu');
			}
			$('#proForm').form('submit',{
				success:function(data){
					var json=eval('('+data+')');
					if(json.state){
						$.messager.alert('提示',"发布成功！","info");
						getPubtime();
					}else{
						$.messager.alert('提示',"发布失败！","error");
					}
				}
			});
		}
		function getPubtime(){
	 			$.ajax({
						url:"<%=basePath%>meet_selectPubtimeFile.action?fileown="+<s:property value='fileown'/>+"&meetid="+<%=meetid%>,
						success:function (data){
							$("#pushtime").html(data.msg);
						} 			
	 			});			
		}	
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
					window.open("<%=basePath%>"+"upload/" + fileid);
				} else {
					$.messager.alert('提示', "此附件已不存在");
				}
			}
		});
	}		      	
</script>
<style>
.tongyong_table {
	width: 100%;
	height: 510px;
	font-family: "微软雅黑";
}

.th_tongyongleft {
	height: 40px;
	line-height: 40px;
	font-size: 16px;
	color: #333;
	border-bottom: 1px solid #ccc;
	background: #ea8619;
	text-align: left;
}

.th_tongyongth {
	height: 40px;
	line-height: 40px;
	font-size: 16px;
	color: #333;
	border-bottom: 1px solid #ccc;
	background: #ea8619;
	text-align: center;
}

.trsel {
	height: 35px;
	line-height: 35px;
	font-size: 14px;
	color: #333;
	border-right: 1px solid #ccc;
	background: #DBCB71;
	text-align: center;
}

.th_tongyong {
	height: 40px;
	line-height: 40px;
	font-size: 16px;
	color: #333;
	border-bottom: 1px solid #ccc;
	background: #ea8619;
	text-align: center;
}

.td_tongyong {
	height: 35px;
	line-height: 35px;
	font-size: 14px;
	color: #333;
	border-right: 1px solid #ccc;
	background: #faefb2;
	border-bottom: 1px solid #ccc;
	text-align: center;
}
</style>

</head>

<body>
	<!--此处内容更替-->
	<div class="cwh_head">
		<s:if test="fileown==3">
        	      主页>常委会会议>闭幕会   
        </s:if>
		<s:if test="fileown==2">
        	        主页>常委会会议>会中主任会议   
        </s:if>
		<!-- <button  class="button1" style="margin-top: 10px;"  id="backMeet" onclick="javascript:backMeet()" type="button" style="">返回</button> -->
	</div>
	<a class='easyui-linkbutton' onclick="javascript:backMeet()"
		data-options="iconCls:'icon-Undo'"
		style="right:20px;position:absolute;margin-top:10px;z-index: 9px;top:5px;">返回</a>
	<div class="erjileftbar">
		<dl>
			<dt>
				<a id="indexInfo"
					href="<%=basePath%>module/main/meet/changwh/index.jsp?meetid=<%=meetid%>"><img
					src="<%=path%>/themes/default/images/icon1.png" /></a>
			</dt>
			<dt>
				<a id="yichengmanage"
					href="<%=basePath%>module/main/meet/changwh/yichengmanage.jsp?meetid=<%=meetid%>"><img
					src="<%=path%>/themes/default/images/icon3.png" /></a>
			</dt>
			<dt>
				<a id="richengmanage"
					href="<%=basePath%>module/main/meet/changwh/richengmanage.jsp?meetid=<%=meetid%>"><img
					src="<%=path%>/themes/default/images/icon4.png" /></a>
			</dt>
			<dt>
				<a id="meetfile1"
					href="<%=basePath%>meet_getMeetFile2.action?meetid=<%=meetid%>&fileown=1&filetype=&pageNo=1&pageSize=8&bindtype=0"><img
					src="<%=path%>/themes/default/images/icon2.png" /></a>
			</dt>
			<dt>
				<a id="groupInfo"
					href="<%=basePath%>meet_getFenzuList.action?meetid=<%=meetid%>"><img
					src="<%=path%>/themes/default/images/icon5.png" /></a>
			</dt>
			<dt>
				<a id="meetfile2"
					href="<%=basePath%>meet_getMeetFile.action?meetid=<%=meetid%>&fileown=2&filetype=&pageNo=1&pageSize=8"><img
					src="<%=path%>/themes/default/images/icon09.png" /></a>
			</dt>
		</dl>
	</div>
	<div class="erjimain">
		<!--          <div class="huiyi_head">-->
		<div class="huiyi_main" style="text-align: left;">
			<!--             <form action="<%=basePath%>meet_benchRichenAddByFile.action" method="post" enctype="multipart/form-data">-->

			<!--           	 <table>-->

			<!--           	 		<tr>-->
			<!--	                    <td>2.关联议程和日程</td>-->
			<!--	                    <td><button  class="button3" name="" id="addriccheng" type="submit" style="">自动关联</button></td>-->
			<!--	                    <td>-->
			<!--	                    </td>-->
			<!--	                </tr>-->
			<!--           	 </table>-->
			<!--           	 </form>-->
			<form action="<%=basePath%>meet_getMeetFile.action" method="post"
				id="findForm">
				<div class="tongzhi_main">
					<div class="tongyong_table">
						<div style="width:99%;margin:10px auto;">
							<s:hidden name="pageNo" id="page"></s:hidden>
							<s:hidden name="meetid" id="meetid"></s:hidden>
							<s:hidden name="fileown" id="fileowns"></s:hidden>
							<table width="100%">
								<tr>
									<td
										style="height:40px; line-height:40px; font-size:14px; color:#333;font-family:微软雅黑; margin-left:20px;"
										width="12%">1.选择文件：</td>
									<td
										style="height:40px; line-height:40px; font-size:14px; color:#333;font-family:微软雅黑; margin-left:20px; ">
										<!-- <button type="button" class="button3" id="buttonupload" onclick="addfile(0)">上传</button> -->
										<a class='easyui-linkbutton' id="buttonupload"
										data-options="iconCls:'icon-upload'"
										style="line-height: 25px;width: 80px;color:#a10000;margin-top: 8px;margin-left:10px;"
										onclick="addfile(0)">上传</a>
										<div style="display: none">
											<input type="file" name="file" value="" id="upload">
										</div>
									</td>
									<td></td>
								</tr>
								<tr>
									<td
										style="height:40px; line-height:40px; font-size:14px; color:#333;font-family:微软雅黑; margin-left:20px; ">
										<!--							 <div style="display: none;">--> 2.会议文件维护 <!--							 </div>-->
									</td>
									<td
										style="height:40px; line-height:40px; font-size:14px; color:#333;font-family:微软雅黑; margin-left:20px; ">
										<select name="filetype" id="filetype"
										style="margin-top:10px; margin-left:10px;width:115px;">
											<s:iterator value="fileSelect">
												<option value="<s:property value="fvalue"/>"><s:property
														value="fname" /></option>
											</s:iterator>
									</select> <a class='easyui-linkbutton' id="search"
										data-options="iconCls:'icon-search'"
										style="line-height: 25px;width: 80px;color:#a10000;"
										onclick="javascript:document.getElementById('findForm').submit();">查询</a>
									</td>
									<td>
										<!--  <input  class="button1" type="button" style="margin-right:150px;" onclick="sortwindow();" value="排序" />
	                    <input  class="button1" type="button" id="deleteAlls" value="批量删除" />   -->
										<a class='easyui-linkbutton' id="sorts"
										data-options="iconCls:'icon-sort'"
										style="line-height: 25px;width: 80px;color:#a10000;margin-top: 5px;position: absolute;right: 100px;"
										onclick="sortwindow();">排序</a> <a class='easyui-linkbutton'
										id="deleteAlls" data-options="iconCls:'icon-remove'"
										style="line-height: 25px;width: 80px;color:#a10000;margin-top: 5px;position: absolute;right: 10px;">批量删除</a>
									</td>
								</tr>
							</table>
							<table id="table" cellpadding="0" cellspacing="0" border="0"
								width="100%">
								<tr>
									<th class="th_tongyongth">&nbsp;</th>
									<th class="th_tongyongth">&nbsp;<input type='checkbox'
										id='selAll' />&nbsp; <!--									<label for="selAll"><input type='checkbox' id='selAll'/>全选</label>-->
									</th>
									<th class="th_tongyongleft">文件名称</th>
									<th class="th_tongyongth">上传日期</th>
									<th class="th_tongyongth">推送范围</th>
									<th class="th_tongyongth">排序</th>
									<th class="th_tongyongth">文件类型</th>
									<th class="th_tongyongth">操作</th>
								</tr>
								<tbody>
									<s:iterator value="page.result" id="rodo" status="L">
										<tr>
											<td style="height: 3px;"></td>
										</tr>
										<tr>
											<td class="td_tongyong"
												style="width: 2%;height:30px;text-align: center;vertical-align:middle">
												<div style="display: none;">
													<s:property value="fileid" />
												</div> <s:property value="#L.index+1" />
											</td>
											<td class="td_tongyong"
												style="width: 3%;height:30px;text-align: center;vertical-align:middle">
												&nbsp;<input type='checkbox'
												value="<s:property value="fileid" />" />&nbsp;
											</td>
											<td class="td_tongyong"
												style="width: 51%;height:30px;text-align: left;padding-left: 10px;">
												<%-- <span style="cursor: hand;"
												title="<s:property value="filename" />"> <s:if
														test="%{#rodo.filename.length()>32}">
														<s:property value="%{#rodo.filename.substring(0,32)}" />...
								</s:if> <s:else>
														<s:property value="filename" />
													</s:else>
											</span> --%> <a
												href="javascript:fileOpen('<s:property value="filepath" />');"
												style="cursor: hand;"
												title="<s:property value="filename" />"</a> <s:if
													test="%{#rodo.filename.length()>30}">
													<s:property value="%{#rodo.filename.substring(0,30)}" />...</s:if>
												<s:else>
													<s:property value="filename" />
												</s:else>

											</td>
											<td class="td_tongyong" style="width: 11%;height:30px;">
												<s:date name="uploadtime" format="MM月dd日 HH:mm" />
											</td>
											<td class="td_tongyong" style="width: 16%;height:30px;">
												<span title="<s:property value="filescopes"/>"> <s:if
														test="%{#rodo.filescopes.length()>10}">
														<s:property value="%{#rodo.filescopes.substring(0,10)}" />...
										</s:if> <s:else>
														<s:property value="filescopes" />
													</s:else>
											</span>
											</td>
											<td class="td_tongyong" style="width: 5%;height:30px;">
												<s:property value="sort" />
											</td>
											<!--										<td class="td_tongyong" style="width: 15%;height:30px;">-->
											<!--											<s:property value="sort"/>-->
											<!--										</td>-->
											<td class="td_tongyong" style="width: 7%;height:30px;">
												<s:if test="%{#rodo.filetype==1}">
													<select
														onchange="updateFileType(<s:property value="fileid" />,this)">
														<option value="1">正式文件</option>
														<option value="2">延伸阅读</option>
													</select>
												</s:if> <s:else>
													<select
														onchange="updateFileType(<s:property value="fileid" />,this)">
														<option value="2">延伸阅读</option>
														<option value="1">正式文件</option>
													</select>
												</s:else>
											</td>
											<td style="border-right:none;" class="td_tongyong"
												style="width:5%;height:30px;"><a
												href="javascript:void(0)"
												onclick="deleteFile(<s:property value="fileid"/>,<s:property value="meetid"/>);">
													<img src="<%=path%>/themes/default/images/caozuo_05.png" />
											</a></td>
										</tr>
									</s:iterator>
								</tbody>
							</table>
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
								<a>共<s:property value="totalPage" /> 页
								</a>
							</div>
						</s:if>
			</form>


		</div>
		<form action="<%=basePath%>meet_submitMeetProcess.action"
			method="post" id="proForm">
			<input id="statename" name="statename" type="hidden" />
			<s:hidden id="meetid" name="meetid" type="hidden">
			</s:hidden>
		</form>
		<div region="south" border="false"
			style="text-align: center; padding: 5px 0;">
			<span
				style="font-size: 14px;margin-left: 10px;margin-top:10px;float: left;">最后一次发布时间：<span
				id="pushtime"></span></span> <a class='easyui-linkbutton'
				data-options="iconCls:'icon-save'"
				style="line-height: 25px;width: 115px;color:#a10000;margin-right:80px;margin-top:10px;"
				onclick="showS();">保存</a> <a class='easyui-linkbutton'
				data-options="iconCls:'icon-push'"
				style="line-height: 25px;width: 115px;color:#a10000;margin-right:80px;margin-top:10px;"
				onclick="saveAndP();">保存并发布</a>
		</div>
		<!--        </div>-->
	</div>
	</div>

	<!--此处内容更替结束-->
	<div id="popwindow" class="easyui-window" closed="true"
		data-options="iconCls:'icon-save'" title="排序"
		style="width:1050px;height:510px;padding:10px;">
		<div style="font-size:16px;margin-bottom:5px;">
			<s:if test="fileown==3">
        	     闭幕会   
        </s:if>
			<s:if test="fileown==2">
        	       会中主任会议   
        </s:if>
		</div>
		<table id="poptable" cellpadding="0" cellspacing="0" border="0"
			width="100%">
			<tr>
				<th class="th_tongyongth">&nbsp;</th>
				<th class="th_tongyongleft">文件名称</th>
				<th class="th_tongyongth">上传日期</th>
				<th class="th_tongyongth">推送范围</th>
				<th class="th_tongyongth">排序</th>
				<th class="th_tongyongth">文件类型</th>
				<th class="th_tongyongth">操作</th>
			</tr>
			<tbody>
				<s:iterator value="sortlist" id="rodo" status="L">
					
					<tr id=<s:property value="fileid"/> onclick="sel(this);">
						<td data="index" class="td_tongyong"
							style="width: 3%;height:30px;text-align: center;vertical-align:middle"><s:property
								value="#L.index+1" /></td>
						<td class="td_tongyong"
							style="width: 50%;height:30px;text-align: left;padding-left: 10px;">
							<%-- <span style="cursor: hand;"
							title="<s:property value="filename" />"> <s:if
									test="%{#rodo.filename.length()>30}">
									<s:property value="%{#rodo.filename.substring(0,30)}" />...
		</s:if> <s:else>
									<s:property value="filename" />
								</s:else>
						</span> --%> <a
							href="javascript:fileOpen('<s:property value="filepath" />');"
							style="cursor: hand;" title="<s:property value="filename" />"</a>
							<s:if test="%{#rodo.filename.length()>30}">
								<s:property value="%{#rodo.filename.substring(0,30)}" />...</s:if> <s:else>
								<s:property value="filename" />
							</s:else>
						</td>
						<td class="td_tongyong" style="width: 12%;height:30px;"><s:date
								name="uploadtime" format="MM月dd日 HH:mm" /></td>
						<td class="td_tongyong" style="width: 16%;height:30px;"><span
							title="<s:property value="filescopes"/>"> <s:if
									test="%{#rodo.filescopes.length()>10}">
									<s:property value="%{#rodo.filescopes.substring(0,10)}" />...
					</s:if> <s:else>
									<s:property value="filescopes" />
								</s:else>
						</span></td>
						<td data="sort" class="td_tongyong" style="width: 5%;height:30px;"><s:property
								value="sort" /></td>
						<td class="td_tongyong" style="width: 7%;height:30px;"><s:if
								test="%{#rodo.filetype==1}">
								<select
									onchange="updateFileType(<s:property value="fileid" />,this)">
									<option value="1">正式文件</option>
									<option value="2">延伸阅读</option>
								</select>
							</s:if> <s:else>
								<select
									onchange="updateFileType(<s:property value="fileid" />,this)">
									<option value="2">延伸阅读</option>
									<option value="1">正式文件</option>
								</select>
							</s:else></td>
						<td style="border-right:none;" class="td_tongyong"
							style="width:7%;height:30px;"><a href="javascript:void(0)"
							onclick="up(this,<s:property value="filetype"/>);"> <img
								width=15px height=25px style="vertical-align:middle;"
								src="<%=path%>/themes/default/images/up.png" />
						</a>&nbsp;&nbsp;&nbsp; <a href="javascript:void(0)"
							onclick="down(this,<s:property value="filetype"/>);"> <img
								width=15px height=25px style="vertical-align:middle;"
								src="<%=path%>/themes/default/images/down.png" />
						</a></td>
					</tr>
				</s:iterator>
			</tbody>
		</table>
		<a class='easyui-linkbutton' data-options="iconCls:'icon-ok'"
			style="line-height: 25px;width: 80px;color:#a10000;margin-left:800px;margin-top: 5px;"
			onclick="closeSort();">确定</a>
	</div>

	<div id="logicWindow1" class="easyui-window" title="添加文件"
		iconCls="icon-save" style="width: 700px; height: 300px; padding: 5px;"
		closed="true">
		<form id="fff" action="" method="post" enctype="multipart/form-data">
			<table>
				<tr valign="top">
					<td>
						<div>
							&nbsp;文件类型:&nbsp; <select name="filetypeSel" id="filetypeSel"
								style="line-height:25px; height:25px; width:530px;"
								bgcolor="#ccc">

							</select> <br /> &nbsp;推送范围: &nbsp;<select
								style="line-height:25px; height:25px; width:530px;"
								bgcolor="#ccc" name="scopeids" class="easyui-combotree"
								data-options="url:'<%=basePath%>notify/listScope.action',required:true, onChange:function(node){setComValues();}"
								multiple id="scopeselect" missingMessage='请选择推送范围'>
							</select>
							<!--	                       <input type="hidden" name="filetypeSel" id="filetypeSel" value="1"/>-->
							<div class="fieldset flash" id="fsUploadProgress1"></div>
							<input type="hidden" id="saveDataId1" />
							<div style="padding-left: 5px;">
								<span id="spanButtonPlaceholder1"></span> <input id="btnCancel1"
									type="button" value="取消" onclick="cancelQueue(upload1);"
									disabled="disabled"
									style="margin-left: 2px; height: 22px; font-size: 8pt;display:none;" />
							</div>
						</div>

					</td>
				</tr>
			</table>
			<div>
				<s:hidden name="meetid" id="meetid"></s:hidden>
				<input type="hidden" id="fileown" value="2" /> <input type="hidden"
					id="idv" /> <input type="hidden" id="reid" name="reid" /> <input
					type="hidden" id="selVal" name="selVal" /> <input type="hidden"
					id="filenames" name="filenames" />
			</div>

		</form>
		<div style="display: none;">
			<input type="text" id="fmtype" name="fmtype" value="2" />
		</div>
		<div region="south" border="false"
			style="text-align: right; padding: 5px 0;">
			<a class="easyui-linkbutton" id="btnsub1" iconCls="icon-ok"
				onclick="sub1()">确定</a>
			<!--<a class="easyui-linkbutton" iconCls="icon-cancel"
						onclick = "closeW1()">取消</a>-->
		</div>
	</div>
</body>
<script type="text/javascript">
	var upload1;
	window.onload = function() {
		upload1 = new SWFUpload({
			// Backend Settings   上传文件访问的后台地址
			upload_url : "<%=basePath%>meet_hzbenchAddByFile.action",
			//post_params: {"submeetingid" : document.getElementById("idv").value},

			// File Upload Settings
			file_size_limit : "3600 MB", // 100MB  文件上传大小，（这里不管用）
			file_types : "*.*", //限制上传文件类型   ”*.jpg;*.jpeg;*.gif;*.png;*.bmp;”
			file_types_description : "All Files", //文件类型描述
			file_upload_limit : 100, //允许同时上传文件的个数
			file_queue_limit : 0, //允许队列存在的文件数量，默认值为0，即不限制

			// Event Handler Settings (all my handlers are in the Handler.js file)
			swfupload_preload_handler : preLoad, //如果falsh版本不够深
			swfupload_load_failed_handler : loadFailed,
			file_dialog_start_handler : fileDialogStart, //文件选择对话框显示之前触发。只能同时存在一个文件对话框。
			file_queued_handler : fileQueued, //当文件选择对话框关闭消失时，如果选择的文件成功加入上传队列，那么针对每个成功加入的文件都会触发一次该事件（N个文件成功加入队列，就触发N次此事件）。
			file_queue_error_handler : fileQueueError, //当选择文件对话框关闭消失时，如果选择的文件加入到上传队列中失败，那么针对每个出错的文件都会触发一次该事件
			file_dialog_complete_handler : fileDialogComplete, //设置swf监听fileDialogComplete 事件  选择好上传的文件就自动开始上传
			upload_start_handler : uploadStart, //在文件往服务端上传之前触发此事件，可以在这里完成上传前的最后验证以及其他你需要的操作
			upload_progress_handler : uploadProgress, //该函数用于侦听文件选择对话框关闭的事件，
			upload_error_handler : uploadError, //上传出错
			upload_success_handler : uploadSuccess, //上传成功
			upload_complete_handler : uploadComplete, //上传完成，无论上传过程中出错还是上传成功，都会触发该事件，并且在那两个事件后被触发
			// Button Settings
			button_image_url : "<%=basePath%>third/swfupload/images/icon_uploads.jpg",
			button_placeholder_id : "spanButtonPlaceholder1", //上传按钮占位符的id
			button_width : 61, //按钮宽度
			button_height : 22, //按钮高度
			//button_image_url: "http://labs.goodje.com/swfu/swfu_bgimg.jpg",//按钮背景图片路径
			//				button_text_style: ‘.btn-txt{color: #666666;font-size:20px;font-family:"微软雅黑"}‘,
			//				button_text_top_padding: 6,
			//				button_text_left_padding: 65,


			// Flash Settings
			//swfupload压缩包解压后swfupload.swf的url
			flash_url : "<%=basePath%>third/swfupload/swfupload.swf",
			flash9_url : "<%=basePath%>third/swfupload/swfupload_fp9.swf",

			//一些自定义的信息，默认值为一个空对象{}
			custom_settings : {
				progressTarget : "fsUploadProgress1",
				cancelButtonId : "btnCancel1"
			},
			debug : false //debug模式，可以在页面看到详细信息debug:false,   //debug模式，可以在页面看到详细信息
		});

	}
</script>
<!-- 自动上传完成删除 -->
<script type="text/javascript">
	function uploadSuccess(file, serverData) {
		try {
			var progress = new FileProgress(file, this.customSettings.progressTarget);
			progress.setComplete();
			//转为json对象
			var obj = jQuery.parseJSON(serverData);
			//显示已经上传图片列表(这是一个已经上传文件列表的div)
			$('#qrcode-page-5-picture-list').css('display', '');
			//文件列表内容
			var html = '<div id="file-' + file.id + '" class="upload-queue-item" style="height:50px;">'
				+ '<div class="preview">'
				+ '<a href="#link" target="file_preview">'
				+ '<img width="48" height="48" src="' + obj.image_src + '">'
				+ '</a>'
				+ '</div>'
				+ '<div class="fileinfo">'
				+ '<div class="cancel uploadedFileCancel"> </div>'
				+ '<span class="fileName">' + obj.image_filename + '</span>'
				//注意这里的cancelUploadFile(file.id),这是个自定义函数
				+ '<span onClick="javascript:cancelUploadedFile(\'' + file.id + '\');return false;" style="display:inline-block;float:right;cursor:pointer;">X</span>'
				+ '</div>'
				+ '</div>';
			$('#qrcode-page-5-picture-list').append(html);
			//

			progress.setStatus("上传完成.");
			progress.toggleCancel(false);

		} catch (ex) {
			this.debug(ex);
		}
	}
</script>
<!-- 手动删除文件 -->
<!-- <script type="text/javascript">
	function cancelUploadedFile(fileid) {
		if (!fileid) {
			return false;
		}
		//这里的uupload1是SWFUpload对象  
		//获取对象的状态  
		var stats = upload1.getStats();
		//删除队列中的特定文件  
		upload1.cancelUpload(fileid, false);
		//把队列状态中的成功上传文件数减一,这是关键,不减一,swfupload以为并未取消成功  
		upload1.setStats({
			successful_uploads : (stats.successful_uploads - 1)
		});
		////删除文件列表内容  
		$('#file-' + fileid).remove();
	}
</script> -->

</html>
