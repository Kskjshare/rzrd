<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/public/common.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>人大会议助理_常委会会议</title>
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

<%
int meetid =Integer.parseInt (request.getParameter ("meetid")); System.out.println 
	("meetid: "+meetid ); %> .erjileftbar dl {
	margin-top: 15px;
}

.erjileftbar dt {
	margin-top: 5px;
}
</style>
<link href="<%=basePath %>third/swfupload/css/default.css"
	rel="stylesheet" type="text/css" />
<script language="javascript" src="<%=basePath %>third/json.js"></script>
<script type="text/javascript"
	src="<%=basePath %>third/swfupload/swfupload.js"></script>
<script type="text/javascript"
	src="<%=basePath %>third/swfupload/swfupload.queue.js"></script>
<script type="text/javascript"
	src="<%=basePath %>third/swfupload/fileprogresscommon.js"></script>
<script type="text/javascript"
	src="<%=basePath %>third/swfupload/handlers.js"></script>
<script type="text/javascript" src="<%=basePath%>third/myJs/editable.js"></script>
<script type="text/javascript">
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
/* 					var sel=document.getElementById('filetypeSel');
					sel.options.length=3;
					sel.options[0].text = "正式文件"; 
					sel.options[0].value = "1";
					sel.options[1].text = "延伸阅读"; 
					sel.options[1].value = "2";
					sel.options[2].text = "参阅文件"; 
					sel.options[2].value = "3";
					sel.options[0].selected="selected"; */
					$("#filetypeSel").attr("checked",true);
					$('#scopeselect').combotree('setValues', [1]);
			      //document.getElementById('fff').action = "<%=basePath%>meeting/subMeetingAction!meetingfileadd.action?submeetingid="+id+"&rand="+Math.random();
			}
			//document.getElementById('meetingname').innerHTML=meetingname;
			function sub1(){
				$('#logicWindow1').window('close');
				$('#search').click();
			}	
			function closeW3()
			{
				$('#logicWindow3').window('close');
			}
			function deleteFile(id,meetid){
			 if(iseditable){
			 	 $.messager.confirm("确认", "是否删除条目及子条目", function (r) {  
       		 if (r) {  
            	var filetype=document.getElementById("filetype").value;
                	//alert("filetype:"+filetype+","+meetid);
                	$.ajax({
                		url:"<%=basePath%>meet_deleteFile.action?fileid="+id+"&meetid="+meetid+"&filetype="+filetype+"&fileown=1",
                		dataType:"json",
                        type: "POST",
      		         	async: false,  
                	})
                	document.getElementById('findForm').submit();    
       		}  
    		}); 
			 }else{
			 	$.messager.alert("提示",'当前状态不允许操作',"info");
			 }
			
			}
			var preType=1;
			function savePreType(obj){
				preType=obj;
			}
			function updateFileType(fileid,obj){
			if(iseditable){
			//将排序中的文件类型同步修改
			$("#"+fileid).find("select").eq(0).val(obj.value)
			var val=obj.options[obj.options.selectedIndex].value;
			//置顶
			//alert(val);
			if(val=='9'||val=='10'){
				$(obj).parent().next().find("a[name='bindhandle']").hide();
			}else{
				$(obj).parent().next().find("a[name='bindhandle']").show();

			}
			//alert(fileid+","+obj+","+val);
			$.ajax({
					url:"<%=basePath%>meet_uploadFileType.action?fileid="+fileid+"&filetype="+val,
					success:function (data){
					var json = data;
						//alert(!json.state);
						if(!json.state)
						{
							alert(json.msg);
						}else {
						//	$("#dataGrid").treegrid("reload");
						}
					}
				});
				 }else{
				obj.value=preType; 
			 	$.messager.alert("提示",'当前状态不允许操作',"info");
			 }
			}
			
			function toPage(page){
            	document.getElementById("page").value=page;
            	document.getElementById("findForm").submit();
            }
            var iseditable=true;
            $(function(){
            	//alert("ok");
            	//alert($("#hideBindType").html())
            	$("#bindtype").val($("#hideBindType").html().trim())
		        $("input[name=filetypeSel]").on("click", function() {
		           $("input[name=filetypeSel]").val($(this).val())
		        });	
             getPubtime();
			 $('#relativeRiccheng').click(function(){
			 //alert("OK");
			 	var meetid=parseInt(document.getElementById('meetid').value);
			 	$.post("<%=basePath%>meet_relativeRiccheng.action",{"meetid":meetid},
			 	function(data){
			 		//alert("data:"+data+","+data.state);
			 	var json=eval("("+data+")");
			 		//alert(json.state);
			 	if(json.state){
			 		$.messager.alert("提示",'文件关联成功'+json.bindsuccess+'条,文件关联失败'+json.bindfailure+'条',"info",function(){
			 			$('#search').click();
			 		});
			 	}else{
			 		$.messager.alert("提示",'操作有误',"info",function(){});
			 	};
			 	})
			 });
			 
			 var meetid=parseInt(document.getElementById('meetid').value);
			// alert("meetid:"+meetid);
            $.post("<%=basePath%>meet_getCurMeetProcess.action",{"meetid":meetid,processType:"file"},
			 function(data){
			 	if(data.state){
			 		$('#curstate').val(data.curstate);
			 		$('#statename').val(data.statename);
			 		$('#showStateName').html("状态："+data.statename);
			 		//alert(data.curstate);
			 		//$('#comment').val(data.comment);
			 		if(data.curstate=="2"||data.curstate=="5"||data.curstate=="0"){
			 			iseditable=false;
			 			$('#buttonupload').attr('disabled',"true");
			 			$('#relativeRiccheng').attr('disabled',"true");
			 			$('#deleteAlls').attr('disabled',"true");
			 			$('#sorts').attr('disabled',"true");
			 			$('#iseditable').val("2");//不可编辑
			 		}else{
			 			iseditable=true;
			 			$('#buttonupload').removeAttr("disabled");
			 			$('#relativeRiccheng').removeAttr("disabled");
			 			$('#deleteAlls').removeAttr("disabled");
			 			$('#sorts').removeAttr("disabled");
			 			$('#iseditable').val("1");//可编辑
			 			//alert("iseditables2:"+iseditable);
							if(iseditable){
							$('#table').editablefile({
							action:"<%=basePath%>meet_updateFileSortZD.action",
							});
						}
			 		}
			 		if(data.curstate=="2"||data.curstate=="5"){
			 			$('#backornext').show();
			 			$('#showState').show();
			 		}else{
			 			$('#backornext').hide();
			 			$('#showState').hide();
			 		}
			 		var selectaction=document.getElementById('selectState');
			 		var array=data.list;
			 		//alert(array.length);
			 		for(var i=0;i<array.length;i++){
			 			var action=array[i].action;
			 			var actionname=array[i].actionname;
			 			selectaction.options.add(new Option(actionname,action));
			 		}
			 	};
			 });
            })
            function searchFile(){
            	document.getElementById("page").value=1;
            	document.getElementById('findForm').submit();
            }
            function subPro(){
            //alert("OK");
			$('#proForm').form('submit',{
				success:function(data){
					var json=eval('('+data+')');
					if(json.state){
					$.messager.alert("提示",'操作成功',"info",function(){});
					$('#curstate').val(json.curstate);
			 		$('#statename').val(json.statename);
			 		$('#showStateName').html("状态："+json.statename);
			 		//$('#comment').val(json.comment);
			 		//alert(json.curstate);
			 		if(json.curstate=="2"||json.curstate=="5"||json.curstate=="0"){
			 			iseditable=false;
			 			$('#buttonupload').attr('disabled',"true");
			 			$('#relativeRiccheng').attr('disabled',"true");
			 			$('#deleteAlls').attr('disabled',"true");
			 			$('#sorts').attr('disabled',"true");
			 		}else{
			 			iseditable=true;
			 			$('#buttonupload').removeAttr("disabled");
			 			$('#relativeRiccheng').removeAttr("disabled");
			 			$('#deleteAlls').removeAttr("disabled");
			 			$('#sorts').removeAttr("disabled");
			 			//alert("iseditables2:"+iseditable);
							if(iseditable){
							$('#table').editablefile({
							action:"<%=basePath%>meet_updateFileSortZD.action",
							});
							}
			 		}
			 		if(json.curstate=="2"||json.curstate=="5"){
			 			$('#backornext').show();
			 			$('#showState').show();
			 		}else{
			 			$('#backornext').hide();
			 			$('#showState').hide();
			 		}
			 		var selectaction=document.getElementById('selectState');
			 		var array=json.list;
			 		var selLength=selectaction.length;
			 		for(var i=0;i<selLength;i++){
			 			selectaction.removeChild(selectaction[0]);
			 		}
			 		//alert(array.length);
			 		for(var i=0;i<array.length;i++){
			 			var action=array[i].action;
			 			var actionname=array[i].actionname;
			 			selectaction.options.add(new Option(actionname,action));
			 		}
					}else{
						$.messager.alert('提示','操作失败',"info",function(){});
					}
				}
			});
		}	
		
		$(function(){
			$('#table').checkAll({
				action:"<%=basePath%>meet_deleteMeetFiles.action",
				idSubmit:"fileids"
			});
		})
		
		function setComValues(){
			//var selVal=$('#scopeselect').combotree('getValues');
			//document.getElementById('selVal').value=selVal;
			//alert(selVal);
		}
		
		function sortwindow(){
			$("#popwindow").window("open");
		}
		
		//置顶
		function ZD(obj,filetype){
			var tr=obj.parentNode.parentNode;
			alert(tr.rowIndex);
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
				console.info("trpreindex:"+trpreinde);
				var tBody = tr.parentNode;
				tBody.replaceChild(trpre, tr);
				var target =trpre.previousSibling;
				tBody.insertBefore(tr, target);
				$('tr#'+trpreid+' td[data=sort]').text(trsort);
				$('tr#'+trpreid+' td[data=index]').text(trindex);
				$('tr#'+trid+' td[data=sort]').text(trpresort);
				$('tr#'+trid+' td[data=index]').text(trpreindex);
				$.post('<%=basePath%>meet_updateSortZD.action', {id:trid,ftype:filetype,sort:trpresort},function(){
					$.post('<%=basePath%>meet_updateSortZD.action', {id:trpreid,ftype:filetype,sort:trsort});
				});
			}
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
			var tr=obj.parentNode.parentNode;
			var tBody = tr.parentNode;
			if (tr.rowIndex < tBody.rows.length-1) {
				var trid=tr.id;
				var trsort=$('tr#'+trid+' td[data=sort]').text();
				var trindex=$('tr#'+trid+' td[data=index]').text();
				var trnext=tr.nextSibling.nextSibling;
				var trnextid=trnext.id;
				var trnextsort=$('tr#'+trnextid+' td[data=sort]').text();
				var trnextindex=$('tr#'+trnextid+' td[data=index]').text();
				tBody.replaceChild(tr, trnext);
				var target = tr.previousSibling;
				tBody.insertBefore(trnext, target);
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
			window.location.href ="<%=basePath %>meet_getMeetFile2.action?meetid=<s:property value="meetid"/>&fileown=1&filetype=&pageNo=1&pageSize=8";
		}
		function flownext(){
			var selectaction=document.getElementById('selectState');
			//alert("length:"+selectaction.length);
					var selLength=selectaction.length;
			 		for(var i=0;i<selLength;i++){
			 			selectaction.removeChild(selectaction[0]);
			 		}
			 		selectaction.options.add(new Option("正式发布",2));
			 		selectaction.options.add(new Option("退回上一级",3));
		}
		function flowback(){
			var selectaction=document.getElementById('selectState');
			//alert("length:"+selectaction.length);
					var selLength=selectaction.length;
			 		for(var i=0;i<selLength;i++){
			 			selectaction.removeChild(selectaction[0]);
			 		}
			 		selectaction.options.add(new Option("退回上一级",3));
			 		selectaction.options.add(new Option("正式发布",2));
		}
		function sel(obj){
			$("#poptable td[class='trsel']").attr("class","td_tongyong");
			var $obj=$(obj);
			$obj.children("td").attr("class","trsel");
		}
		 function backMeet(){
    		window.location.href="<%=basePath %>selectCurMeeting.action?type=2";
    	}
    	function showS(){
    		$.messager.alert('提示',"已保存！","info");
    	}
    	function saveAndP(){
			$('#meetid').val(parseInt(<%=meetid%>));
			$('#statename').val('file');
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
						url:"<%=basePath%>meet_selectPubtimeFile.action?fileown=1&meetid="+<%=meetid%>,
						success:function (data){
							$("#pushtime").html(data.msg);
						} 			
	 			});			
		}	
		function bindYiChen(fileid,meetid,filetype){
			setCheck(fileid,meetid,filetype);
 			$.ajax({
				url:"<%=basePath%>meet_selectBindFile.action?fileid="+fileid,
				success:function (data){
					var json=data;
					$("#bindfilename").html(json.title);
				} 			
			});	
			$("#logicWindow3").window("open");
			document.getElementById('ff3').action ="<%=basePath%>meet_updateYichenBindFile.action?rand="+Math.random()+"&fileid="+fileid;			
		}
		
		var setting = {
				async: {
					enable: true,
					autoParam: ["id"]
				},
				check: {
					enable: true
				},
				data: {
					simpleData: {
						idKey: "id",
						pIdKey:"pid",
						enable: true
					}
				}
			};			
		function setCheck(fileid,meetid,filetype) {
			setting.async.url = "<%=basePath%>meet_getMeetTreeYichenOrRichenFileJson.action?meetid=<%=meetid%>&fileid="+fileid;
			if(filetype=='8'){
				ztreeObj = $.fn.zTree.init($("#treeDemo2"), setting, null);
				$("#yichengStep").hide();
				$("#richengStep").show();
	 			$("#bindflag").val("1");

			}else{
				ztreeObj = $.fn.zTree.init($("#treeDemo"), setting, null);		
				$("#yichengStep").show();
				$("#richengStep").hide();
				$("#bindflag").val("0");
			}
			ztreeObj.setting.check.chkboxType = { "Y" : "", "N" : "" };
		}	
		function sub3(){
			if($("#bindflag").val()=='1'){
				//提交日程关联闭幕会文件
				var treeObj2 = $.fn.zTree.getZTreeObj("treeDemo2");
				var nodes2 = treeObj2.getCheckedNodes(true);
				var ids2 = [] ;
				for(var j = 0 ; j < nodes2.length ; j ++)
				{
						if(j==0){
							//alert(nodes[i].id+","+nodes[i].name+","+nodes[i].wenjianname);
						}
						ids2.push(nodes2[j].id);
				}
				document.getElementById('yichenids').value=ids2.join(","); 	
			}else{
				var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
				var nodes = treeObj.getCheckedNodes(true);
				var ids = [] ;
				for(var i = 0 ; i < nodes.length ; i ++)
				{
						if(i==0){
							//alert(nodes[i].id+","+nodes[i].name+","+nodes[i].wenjianname);
						}
						ids.push(nodes[i].id);
				}
				document.getElementById('yichenids').value=ids.join(",");		
			}

			//alert(document.getElementById('richenids').value);
					$('#ff3').form("submit",{
						success:function(data){   
							$('#logicWindow3').window('close');	
							document.getElementById('findForm').submit();
  
						 } 
					});
						
		}		
</script>
<style>
.tongyong_table {
	width: 100%;
	height: 520px;
	font-family: "微软雅黑";
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

.th_tongyongleft {
	height: 30px;
	line-height: 30px;
	font-size: 16px;
	color: #333;
	border-bottom: 1px solid #ccc;
	background: #ea8619;
	text-align: left;
	padding-left: 10px;
}

.th_tongyonghead {
	height: 30px;
	line-height: 30px;
	font-size: 16px;
	color: #333;
	border-bottom: 1px solid #ccc;
	background: #ea8619;
	text-align: center;
}

.th_tongyong {
	height: 40px;
	line-height: 40px;
	font-size: 16px;
	color: #333;
	border-bottom: 1px solid #ccc;
	background: #ea8619;
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
		主页>常委会会议>文件管理
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
					src="<%=path%>/themes/default/images/icon02.png" /></a>
			</dt>
			<dt>
				<a id="groupInfo"
					href="<%=basePath%>meet_getFenzuList.action?meetid=<%=meetid%>"><img
					src="<%=path%>/themes/default/images/icon5.png" /></a>
			</dt>
			<dt>
				<a id="meetfile2"
					href="<%=basePath%>meet_getMeetFile.action?meetid=<%=meetid%>&fileown=2&filetype=&pageNo=1&pageSize=8"><img
					src="<%=path%>/themes/default/images/icon9.png" /></a>
			</dt>
		</dl>
	</div>
	<div class="erjimain">
		<div class="huiyi_head" style="display: none;">
			<form action="<%=basePath%>meet_submitMeetProcess.action"
				method="post" id="proForm">
				<input id="curstate" name="curstate" type="hidden" /> <input
					id="processType" name="processType" type="hidden" value="file" />
				<input id="statename" name="statename" type="hidden" />
				<s:hidden id="meetid" name="meetid" type="hidden">
				</s:hidden>
				<p id="showStateName"></p>
				<p id="showState" style="display: none;">
					<img style="width: 32px;height: 32px;"
						src="<%=path%>/themes/default/images/lb01.gif" />
				</p>
				<p id="backornext" style="display: none;">
					<input name="comment" type="radio" value="同意" checked="checked"
						onclick="flownext()" /> &nbsp;&nbsp;同意&nbsp; <input
						name="comment" type="radio" value="退回" onclick="flowback()" />
					&nbsp;&nbsp;退回&nbsp;
				</p>
				<p>
					下一步骤： <select style="width:150px; height:30px;line-height:30px;"
						name="action" id="selectState">
						<!--                  <s:iterator value="processList">-->
						<!--                  	  <option value="<s:property value="action"/>"> <s:property value="actionname"/></option>-->
						<!--                  </s:iterator>-->
					</select>
				</p>

				<!--              <p style="display: none;"> 审核意见:<input style="width:200px; height:30px;line-height:30px;border:1px solid #ccc; margin-left:5px;" id="comment" name="comment" type="text"/></p>-->
				<%
					boolean b = false;
					if (usertype != null && usertype.equals("1")) {
						b = true;
					} else {
						b = permission.get(2) != null && permission.get("2").toString().equals("2");
					}
				%>
				<%
					if (b) {
				%>
				<button class="button3" name="" type="button" onclick="subPro();"
					style="position:absolute; right:20px;">提交</button>
				<%
					}
				%>
				<input type="hidden" name="iseditable" id="iseditable" value="1" />
			</form>
		</div>
		<div class="huiyi_main">


			<form action="<%=basePath%>meet_benchRichenAddByFile.action"
				method="post" enctype="multipart/form-data">
				<s:hidden name="meetid"></s:hidden>
				<s:hidden name="fileown" id="fileown"></s:hidden>
				<!--           	 <table align="left">-->
				<!--           	 </table>-->
			</form>
			<%-- <div class="tongzhi_head">
			<form action="<%=basePath%>meet_selectFiledefineMainList.action"
				method="post" enctype="multipart/form-data">
				
			</form> --%>
			</div>
			<form action="<%=basePath%>meet_getMeetFile2.action" method="post"
				id="findForm">
				<div class="tongzhi_main">
					<div class="tongyong_table">
						<div style="width:99%;margin:1px auto;">
							<s:hidden name="pageNo" id="page"></s:hidden>
							<div id="hideBindType" style="display: none;">
								<s:property value='bindtype' />
							</div>
							<table cellpadding="0" cellspacing="0" border="0" width="100%">

								<tr>
									<td
										style="height:30px; line-height:30px; font-size:14px; color:#333;font-family:微软雅黑; margin-left:20px; width:14%;">
										1.选择会议文件：&nbsp;&nbsp;&nbsp;&nbsp;<!-- <button type="button" class="button3" id="buttonupload" onclick="addfile(0)">上传</button> -->
									</td>
									<td><a class='easyui-linkbutton' id="buttonupload"
										data-options="iconCls:'icon-upload'"
										style="line-height: 25px;width: 80px;color:#a10000;margin-left: 10px;"
										onclick="addfile(0)">上传</a>
										<div style="display: none">
											<input type="file" name="file" value="" id="upload">
										</div></td>
									<td></td>
								</tr>
								<tr>
									<td
										style="height:30px; line-height:30px; font-size:14px; color:#333;font-family:微软雅黑; margin-left:20px; ">
										2.关联议程和日程：</td>
									<td><a class='easyui-linkbutton'
										data-options="iconCls:'icon-link'"
										style="line-height: 25px;width: 80px;color:#a10000;margin-left: 10px;"
										id="relativeRiccheng">自动关联</a></td>
									<td></td>
								</tr>
								<tr>
									<td
										style="height:30px; line-height:30px; font-size:14px; color:#333;font-family:微软雅黑; margin-left:20px; ">
										3.会议文件维护：</td>
									<td><select name="filetype" id="filetype"
										style="margin-top:5px; margin-left:10px;width:115px;">
											<s:iterator value="fileSelect">
												<option value="<s:property value="fvalue"/>"><s:property
														value="fname" /></option>
											</s:iterator>
									</select> <!-- 									<button  class="button3" id="search" type="submit">查询</button>

 --> &nbsp;&nbsp;关联状态： <select name="bindtype" id="bindtype"
										style="margin-top:5px; margin-left:5px;width:115px;">
											<option value="">全部</option>
											<option value="1">未关联</option>
											<option value="2">已关联</option>
									</select> <a class='easyui-linkbutton' id="search"
										data-options="iconCls:'icon-search'"
										style="line-height: 25px;width: 80px;color:#a10000;"
										onclick="searchFile();">查询</a></td>
									<td align=right><a class='easyui-linkbutton' id="sorts"
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
									<th class="th_tongyonghead">&nbsp;</th>
									<th class="th_tongyonghead"><input type='checkbox'
										id='selAll' /></th>
									<th class="th_tongyongleft">文件名称</th>
									<th class="th_tongyonghead">上传日期</th>
									<th class="th_tongyonghead">关联状态</th>
									<th class="th_tongyonghead">推送范围</th>
									<th class="th_tongyonghead">排序</th>
									<th class="th_tongyonghead">文件类型</th>
									<th colspan="2" class="th_tongyonghead">操作</th>
								</tr>
								<tbody>
									<s:iterator value="page.result" id="rodo" status="L">
										<tr>
											<td colspan="4" height="2"></td>
										</tr>
										<tr>

											<td class="td_tongyong"
												style="width: 3%;height:30px;text-align: center;vertical-align:middle">
												<div style="display: none;">
													<s:property value="fileid" />
												</div> <s:property value="#L.index+1" />
											</td>
											<td class="td_tongyong"
												style="width: 2%;height:30px;text-align: center;vertical-align:middle">
												<input type='checkbox' value="<s:property value="fileid" />" />
											</td>
											<td class="td_tongyong"
												style="width: 45%;height:30px;text-align: left;padding-left: 10px;">
												 <a
												href="javascript:fileOpen('<s:property value="filepath" />');"
												style="cursor: hand;"
												title="<s:property value="filename" />"</a> <s:if
													test="%{#rodo.filename.length()>30}">
													<s:property value="%{#rodo.filename.substring(0,30)}" />...</s:if>
												<s:else>
													<s:property value="filename" />
												</s:else>
												<%-- <span style="cursor: hand;"
												title="<s:property value="filename" />"> <s:if
														test="%{#rodo.filename.length()>28}">
														<s:property value="%{#rodo.filename.substring(0,28)}" />...
								</s:if> <s:else>
														<s:property value="filename" />
													</s:else>
											</span> --%>

											</td>
											<td class="td_tongyong" style="width: 11%;height:30px;">
												<s:date name="uploadtime" format="MM月dd日  HH:mm" />
											</td>
											<td class="td_tongyong" style="width: 7%;height:30px;">
												<s:if
													test="bindyichenlist==null or bindyichenlist.isEmpty()">
												未关联 
											</s:if> <s:else>
												已关联
											</s:else>
											</td>
											<td class="td_tongyong" style="width: 13%;height:30px;">
												<span title="<s:property value="filescopes"/>"> <s:if
														test="%{#rodo.filescopes.length()>8}">
														<s:property value="%{#rodo.filescopes.substring(0,8)}" />...
										</s:if> <s:else>
														<s:property value="filescopes" />
													</s:else>
											</span>
											</td>
											<td class="td_tongyong" style="width: 4%;height:30px;">
												<s:property value="sort" />
											</td>
											<td class="td_tongyong" style="width: 9%;height:30px;">
												<s:if test="%{#rodo.filetype==1}">
													<select
														onchange="updateFileType(<s:property value="fileid" />,this)"
														onclick="savePreType(this.value)">
														<option value="1">正式文件</option>
														<option value="2">延伸阅读</option>
														<option value="3">参阅文件</option>
														<option value="8">闭幕会文件</option>
														<option value="9">议程文件</option>
														<option value="10">日程文件</option>
													</select>
												</s:if> <s:if test="%{#rodo.filetype==2}">
													<select
														onchange="updateFileType(<s:property value="fileid" />,this)"
														onclick="savePreType(this.value)">
														<option value="2">延伸阅读</option>
														<option value="1">正式文件</option>
														<option value="3">参阅文件</option>
														<option value="8">闭幕会文件</option>
														<option value="9">议程文件</option>
														<option value="10">日程文件</option>
													</select>
												</s:if> <s:if test="%{#rodo.filetype==3}">
													<select
														onchange="updateFileType(<s:property value="fileid" />,this)"
														onclick="savePreType(this.value)">
														<option value="3">参阅文件</option>
														<option value="2">延伸阅读</option>
														<option value="1">正式文件</option>
														<option value="8">闭幕会文件</option>
														<option value="9">议程文件</option>
														<option value="10">日程文件</option>
													</select>
												</s:if> <s:if test="%{#rodo.filetype==8}">
													<select
														onchange="updateFileType(<s:property value="fileid" />,this)"
														onclick="savePreType(this.value)">
														<option value="8">闭幕会文件</option>
														<option value="1">正式文件</option>
														<option value="2">延伸阅读</option>
														<option value="3">参阅文件</option>
														<option value="9">议程文件</option>
														<option value="10">日程文件</option>
													</select>
												</s:if> <s:if test="%{#rodo.filetype==9}">
													<select
														onchange="updateFileType(<s:property value="fileid" />,this)"
														onclick="savePreType(this.value)">
														<option value="9">议程文件</option>
														<option value="1">正式文件</option>
														<option value="2">延伸阅读</option>
														<option value="3">参阅文件</option>
														<option value="8">闭幕会文件</option>
														<option value="10">日程文件</option>
													</select>
												</s:if> <s:if test="%{#rodo.filetype==10}">
													<select
														onchange="updateFileType(<s:property value="fileid" />,this)"
														onclick="savePreType(this.value)">
														<option value="10">日程文件</option>
														<option value="1">正式文件</option>
														<option value="2">延伸阅读</option>
														<option value="3">参阅文件</option>
														<option value="8">闭幕会文件</option>
														<option value="9">议程文件</option>
													</select>
												</s:if>
											</td>
											<td style="border-right:none;width:10%;height:30px;"
												class="td_tongyong"><s:if
													test="%{#rodo.filetype==9 or #rodo.filetype==10}">
													<a name="bindhandle" style="display: none;"
														disabled="disabled" href="javascript:void(0)"
														onclick="bindYiChen(<s:property value="fileid"/>,<s:property value="meetid"/>,<s:property value="filetype"/>);">
														<img src="<%=path%>/themes/default/images/caozuo_03.png" />
													</a>
												</s:if> <s:if test="%{#rodo.filetype!=9 and #rodo.filetype!=10}">
													<a name="bindhandle" href="javascript:void(0)"
														onclick="bindYiChen(<s:property value="fileid"/>,<s:property value="meetid"/>,<s:property value="filetype"/>);">
														<img src="<%=path%>/themes/default/images/caozuo_03.png" />
													</a>
												</s:if> <a href="javascript:void(0)"
												onclick="deleteFile(<s:property value="fileid"/>,<s:property value="meetid"/>);">
													<img src="<%=path%>/themes/default/images/caozuo_05.png" />
											</a></td>
										</tr>
									</s:iterator>
								</tbody>
							</table>
						</div>
						<s:if test="totalPage>1">
							<div id="page" style="margin-top: 15px;">
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
		<div region="south" border="false"
			style="text-align: center; padding: 5px 0;">
			<span style="font-size: 14px;margin-left: 10px;float: left;">最后一次发布时间：<span
				id="pushtime"></span></span> <a class='easyui-linkbutton'
				data-options="iconCls:'icon-save'"
				style="line-height: 25px;width: 115px;color:#a10000;margin-right:80px;margin-top:10px;"
				onclick="showS();">保存</a> <a class='easyui-linkbutton'
				data-options="iconCls:'icon-push'"
				style="line-height: 25px;width: 115px;color:#a10000;margin-right:80px;margin-top:10px;"
				onclick="saveAndP();">保存并发布</a>
		</div>
	</div>
	</div>
	</div>

	<!--此处内容更替结束-->
	<div id="popwindow" class="easyui-window" closed="true"
		data-options="iconCls:'icon-save'" title="排序"
		style="width:1200px;height:510px;padding:10px;top:50px;">
		<div style="font-size:16px;margin-bottom:5px;">文件管理</div>
		<table id="poptable" cellpadding="0" cellspacing="0"
			width="100%">
			<tr>
				<th class="th_tongyonghead">&nbsp;</th>
				<th class="th_tongyongleft">文件名称</th>
				<th class="th_tongyonghead">上传日期</th>
				<th class="th_tongyonghead">关联状态</th>
				<th class="th_tongyonghead">推送范围</th>
				<th class="th_tongyonghead">排序</th>
				<th class="th_tongyonghead">文件类型</th>
				<th colspan="2" class="th_tongyonghead">操作</th>
			</tr>
			<tbody>
				<s:iterator value="sortlist" id="rodo" status="L">
					<tr id=<s:property value="fileid"/> onclick="sel(this);"
						style="border:4px solid red ;">
						<td data="index" class="td_tongyong"
							style="width: 3%;height:30px;text-align: center;vertical-align:middle"><s:property
								value="#L.index+1" /></td>
						<td class="td_tongyong"
							style="width: 47%;height:30px;text-align: left;padding-left: 10px;">
							<!--											<a href="javascript:void(0);" class="tdfirst_changwei" style="cursor: hand;" title="<s:property value="filename" />">&nbsp;&nbsp;-->
							<span style="cursor: hand;"
							title="<s:property value="filename" />"> <s:if
									test="%{#rodo.filename.length()>30}">
									<s:property value="%{#rodo.filename.substring(0,30)}" />...
			</s:if> <s:else>
									<s:property value="filename" />
								</s:else>
						</span>

						</td>
						<td class="td_tongyong" style="width: 11%;height:30px;"><s:date
								name="uploadtime" format="MM月dd日  HH:mm" /></td>
						<td class="td_tongyong" style="width: 7%;height:30px;"><s:if
													test="bindyichenlist==null or bindyichenlist.isEmpty()">
							未关联
						</s:if> <s:else>
							已关联
						</s:else></td>
						<td class="td_tongyong" style="width: 15%;height:30px;"><span
							title="<s:property value="filescopes"/>"> <s:if
									test="%{#rodo.filescopes.length()>8}">
									<s:property value="%{#rodo.filescopes.substring(0,8)}" />...
							</s:if> <s:else>
									<s:property value="filescopes" />
								</s:else>
						</span></td>
						<td data="sort" class="td_tongyong" style="width: 4%;height:30px;"><s:property
								value="sort" /></td>
						<td class="td_tongyong" style="width: 7%;height:30px;"><s:if
								test="%{#rodo.filetype==1}">
								<select
									onchange="updateFileType(<s:property value="fileid" />,this)">
									<option value="1">正式文件</option>
									<option value="2">延伸阅读</option>
									<option value="3">参阅文件</option>
									<option value="8">闭幕会文件</option>
									<option value="9">议程文件</option>
									<option value="10">日程文件</option>
								</select>
							</s:if> <s:if test="%{#rodo.filetype==2}">
								<select
									onchange="updateFileType(<s:property value="fileid" />,this)">
									<option value="2">延伸阅读</option>
									<option value="1">正式文件</option>
									<option value="3">参阅文件</option>
									<option value="8">闭幕会文件</option>
									<option value="9">议程文件</option>
									<option value="10">日程文件</option>
								</select>
							</s:if> <s:if test="%{#rodo.filetype==3}">
								<select
									onchange="updateFileType(<s:property value="fileid" />,this)">
									<option value="3">参阅文件</option>
									<option value="2">延伸阅读</option>
									<option value="1">正式文件</option>
									<option value="8">闭幕会文件</option>
									<option value="9">议程文件</option>
									<option value="10">日程文件</option>
								</select>
							</s:if> <s:if test="%{#rodo.filetype==8}">
								<select
									onchange="updateFileType(<s:property value="fileid" />,this)">
									<option value="8">闭幕会文件</option>
									<option value="3">参阅文件</option>
									<option value="2">延伸阅读</option>
									<option value="1">正式文件</option>
									<option value="9">议程文件</option>
									<option value="10">日程文件</option>
								</select>
							</s:if> <s:if test="%{#rodo.filetype==9}">
								<select
									onchange="updateFileType(<s:property value="fileid" />,this)">
									<option value="9">议程文件</option>
									<option value="3">参阅文件</option>
									<option value="2">延伸阅读</option>
									<option value="1">正式文件</option>
									<option value="8">闭幕会文件</option>
									<option value="10">日程文件</option>
								</select>
							</s:if> <s:if test="%{#rodo.filetype==10}">
								<select
									onchange="updateFileType(<s:property value="fileid" />,this)">
									<option value="10">日程文件</option>
									<option value="3">参阅文件</option>
									<option value="2">延伸阅读</option>
									<option value="1">正式文件</option>
									<option value="8">闭幕会文件</option>
									<option value="9">议程文件</option>
								</select>
							</s:if></td>
						<td style="border-right:none;width:12%;height:30px;"
							class="td_tongyong">
							
							<a href="javascript:void(0)"
							onclick="ZD(this,<s:property value="filetype"/>);"> 顶
						</a>&nbsp;&nbsp;&nbsp;
							
							
							<a href="javascript:void(0)"
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
		</table>
		<a class='easyui-linkbutton' data-options="iconCls:'icon-ok'"
			style="line-height: 25px;width: 80px;color:#a10000;margin-left:800px;margin-top: 5px;"
			onclick="closeSort();">确定</a>
	</div>

	<div id="logicWindow1" class="easyui-window" title="添加文件"
		iconCls="icon-save"
		style="width: 560px; height: 450px; padding: 5px;top:100px;"
		closed="true">
		<form id="fff" action="index.htm" method="post"
			enctype="multipart/form-data">
			<table>
				<tr valign="top">
					<td colspan="3">
						<div style="width: 500px">
							&nbsp;文件类型:&nbsp;
							<!-- 						<select name="filetypeSel" id="filetypeSel"  style="line-height:25px; height:25px; width:530px;" bgcolor="#ccc" >
									
									</select> -->
							<input type="radio" name="filetypeSel" value="1" id="filetypeSel">正式文件</input>
							<input type="radio" name="filetypeSel" value="2">延伸阅读</input> <input
								type="radio" name="filetypeSel" value="3">参阅文件</input> <input
								type="radio" name="filetypeSel" value="8">闭幕会文件</input> <input
								type="radio" name="filetypeSel" value="9">议程文件</input> <input
								type="radio" name="filetypeSel" value="10">日程文件</input> <br />
						</div>
					</td>
				</tr>
				<tr>
					<td style="font-size: 12px;height:30px;">所有推送范围</td>
					<td></td>
					<td style="font-size: 12px;height:30px;">已选推送范围</td>
				</tr>
				<tr>
					<td width="237px">
						<%-- <select style="line-height:25px; height:25px; width:530px;" bgcolor="#ccc" name="scopeids" class="easyui-combotree"
	                      data-options="url:'<%=basePath %>notify/listScope.action',required:true, onChange:function(node){setComValues();},
	                      onLoadSuccess:function(data){}" multiple id="scopeselect"
	                       missingMessage='请选择推送范围'>  </select> --%>
						<div id="treeDemo3" class="ztree"
							style="overflow: auto;width:225px; float:left;height: 200px;border: 1px solid #ccc;"></div>
						</td><td  width="30px">
						<div style="width:35px;height:60px;position:relative;float:left;margin-left: 5px;margin-top: 45px;">
							<img src="<%=basePath%><%=themespath%>images/transright.png"
								id="rightimg" style="cursor: pointer;" /> <img
								src="<%=basePath%><%=themespath%>images/transleft.png"
								id="leftimg" style="margin-top:20px;cursor: pointer;" />
						</div>
					</td>
					<td width="237px"><div style="overflow: auto;width:225px; float:left;height: 200px;border: 1px solid #ccc;">
					<select multiple="multiple" style="width:225px;float:left;height: 210px;" id="rightselect"
						size="10" name="setscopeids" onchange="setComValues();"></select></div>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<div>
							<div class="fieldset flash" id="fsUploadProgress1" style="width: 500px"></div>
							<input type="hidden" id="saveDataId1" />
							<div style="padding-left: 5px;">
								<span id="spanButtonPlaceholder1"></span> <input id="btnCancel1"
									type="button" value="取消" onclick="cancelQueue(upload1);"
									disabled="disabled"
									style="margin-left: 2px; height: 22px; font-size: 8pt;display:none;" />
								<br />
							</div>
						</div>

					</td>
				</tr>
			</table>
			<div>
				<s:hidden name="meetid"></s:hidden>
				<input type="hidden" id="fileown" value="1" /> <input type="hidden"
					id="idv" /> <input type="hidden" id="selVal" name="selVal" /> <input
					type="hidden" id="reid" name="reid" /> <input type="hidden"
					id="filenames" name="filenames" /> <input type="hidden"
					id="scopeids" name="scopeids" />

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
	<div id="logicWindow3" class="easyui-window" title="日程议题信息"
		iconCls="icon-save" style="width: 850px; height: 400px; padding: 5px;"
		closed="true">
		<div class="easyui-layout" fit="true">
			<div region="center" border="false"
				style="background: #fff; border: 1px solid #ccc;">
				<form id="ff3" method="post" action="">
					<input type="hidden" name="yichenids" id="yichenids"> <input
						type="hidden" name="bindflag" id="bindflag">
							<table>
								<tr>
									<td class="td_tongyong"
										style="background:white;border-right: none;">文件名称：</td>
									<td>
										<div
											style="width: 600px;line-height:35px;line-height:35px;font-size: 14px; font-family: '微软雅黑';"
											id="bindfilename"></div>
									</td>
								</tr>
								<tr id="yichengStep">
									<td class="td_tongyong" style="background:white;">关联议程：</td>

									<td style="border: 1px solid #ccc">
										<ul id="treeDemo" class="ztree"></ul>
									</td>
								</tr>
								<tr id="richengStep">
									<td class="td_tongyong" style="background:white;">关联日程：</td>

									<td style="border: 1px solid #ccc">
										<ul id="treeDemo2" class="ztree"></ul>
									</td>
								</tr>
							</table>
				</form>
			</div>
			<div region="south" border="false"
				style="text-align: center; padding: 5px 0;">
				<a class='easyui-linkbutton' data-options="iconCls:'icon-ok'"
					style="line-height: 25px;width: 80px;color:#a10000;margin-top: 5px;margin-right: 40px;"
					onclick="sub3();">确定</a> <a class='easyui-linkbutton'
					data-options="iconCls:'icon-cancel'"
					style="line-height: 25px;width: 80px;color:#a10000;margin-top: 5px;"
					onclick="closeW3();">取消</a>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">

	var setting3 = {
		check : {
			enable : true
		},
		
		data : {
			simpleData : {
				enable : true
			}
		} 
	};

	function setCheck3() {
		var zTree3 = $.fn.zTree.getZTreeObj("treeDemo3");
		zTree3.setting.check.chkboxType = {
			"Y" : "ps",
			"N" : "ps"
		};

	}
	$(document).ready(function() {
		/* $.fn.zTree.init($("#treeDemo3"), setting3  , eval('${jsonStr}' )); */
		var zNodes;
		$.ajax({
             type: "post",    
             url: '<%=basePath%>meet_selectFiledefineMainList.action',          
             dataType: "json",     
             //global: false,             
             async: false,                      
             success: function (jsonStr) {
             console.info("Ajax请求数据成功!")   
                 zNodes=eval(jsonStr); 
                 $.fn.zTree.init($("#treeDemo3"), setting3, zNodes);
             },    
            error: function (jsonStr) {
            //alert('${jsonStr}');
            //alert('${zNodes}');
            //console.info('${jsonStr}');
            alert("Ajax请求数据失败!");
            }
            });
            //zTreeObj = $.fn.zTree.init($("#treeDemo3"), setting3, zNodes);
		setCheck3() ;
		
	});
	$("#rightimg").click(function() {
			$("#rightselect option").remove();
			var treeObj = $.fn.zTree.getZTreeObj("treeDemo3");
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
			}
			var selVal = "";
			if ($("#rightselect option").length > 0) {
				selVal = $("#rightselect option").map(function() {
					return $(this).val();
				}).get().join(",");
			}
			document.getElementById('selVal').value = selVal;
			document.getElementById('scopeids').value = selVal;
		});
		$("#leftimg").click(function() {
			if ($("#rightselect option:selected").length > 0) {
				$("#rightselect option:selected").each(function() {
					var treeObj = $.fn.zTree.getZTreeObj("treeDemo3");
					var checknodes = treeObj.getCheckedNodes(true);
					for (var j = 0; j < checknodes.length; j++) {
						if (checknodes[j].id == $(this).val()) {
							checknodes[j].checked = false;
							treeObj.updateNode(checknodes[j]);
						}
					}
					$(this).remove();
				}) ;
				var selVal = "";
				if ($("#rightselect option").length > 0) {
					selVal = $("#rightselect option").map(function() {
						return $(this).val();
					}).get().join(",");
				}
				document.getElementById('selVal').value = selVal;
				document.getElementById('scopeids').value = selVal;
			}
		})
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
<script type="text/javascript">
	var upload1;
	window.onload = function() {
		upload1 = new SWFUpload({
			// Backend Settings   上传文件访问的后台地址
			upload_url : "<%=basePath%>meet_meetingfileadd.action",
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
</html>