<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/public/common.jspf" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>人大会议助理_常委会会议</title>
<style type="text/css">
.erjimain{
margin:0;
float:left;
height:580px;
border:none;
}
.erjileftbar{
margin:0;
float:left;
}

.erjileftbar dt{ margin-top:15px;}
</style>
<link href="<%=basePath %>third/swfupload/css/default.css" rel="stylesheet" type="text/css" />
<script language= "javascript" src="<%=basePath %>third/json.js"></script>
<script type="text/javascript" src="<%=basePath %>third/swfupload/swfupload.js"></script>
<script type="text/javascript" src="<%=basePath %>third/swfupload/swfupload.queue.js"></script>
<script type="text/javascript" src="<%=basePath %>third/swfupload/fileprogress.js"></script>
<script type="text/javascript" src="<%=basePath %>third/swfupload/handlers.js"></script>
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
					
			     // document.getElementById('fff').action = "<%=basePath%>meeting/subMeetingAction!meetingfileadd.action?submeetingid="+id+"&rand="+Math.random();
			}
			//document.getElementById('meetingname').innerHTML=meetingname;
			function sub1(){
				$('#logicWindow1').window('close');
				$('#search').click();
			}
			
			function deleteFile(id,meetid){
				var r = window.confirm("确定要删除此文件吗？");
                if(r){
                	var filetype=document.getElementById("filetype").value;
                	//alert("filetype:"+filetype+","+meetid);
                	window.location.href = "<%=basePath%>meet_deleteFileAction.action?fileid="+id+"&meetid="+meetid+"&filetype="+filetype+"&fileown=1";
                }
			}
			
			function updateFileType(fileid,filetype){
			//alert(fileid+","+filetype+","+filetype.value);
			$.ajax({
					url:"<%=basePath%>meet_uploadFileType.action?fileid="+fileid+"&filetype=2",
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
            	var meet=parseInt(document.getElementById('meetid').value);
            	 $.post("<%=basePath%>meet_getCurMeetProcess.action",{"meetid":meet,processType:"yichen"},
			 function(data){
			 	if(data.state){
			 		$('#curstate').val(data.curstate);
			 		$('#statename').val(data.statename);
			 		$('#showStateName').html("状态："+data.statename);
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
            
            function subPro(){
			$('#proForm').form('submit',{
				success:function(data){
					var json=eval('('+data+')');
					if(json.state){
					$.messager.alert('提示','操作成功');
					$('#curstate').val(json.curstate);
			 		$('#statename').val(json.statename);
			 		$('#showStateName').html("状态："+json.statename);
			 		$('#comment').val('');
			 		var selectaction=document.getElementById('selectState');
			 		var array=json.list;
			 		for(var i=0;i<selectaction.length;i++){
			 			selectaction.removeChild(selectaction[i]);
			 		}
			 		//alert(array.length);
			 		for(var i=0;i<array.length;i++){
			 			var action=array[i].action;
			 			var actionname=array[i].actionname;
			 			selectaction.options.add(new Option(actionname,action));
			 		}
					}else{
						$.messager.alert('提示','操作失败');
					}
				}
			});
		}	
		
		 $(function(){
			$('#table').editable2({
				action:"<%=basePath%>meet_updateFileSort.action"
			});
		})
		
		function setComValues(){
			var selVal=$('#scopeselect').combotree('getValues');
			document.getElementById('selVal').value=selVal;
			//alert(selVal);
		}
		
		function backMeet(){
    		window.location.href="<%=basePath %>selectCurMeeting.action?type=2";
    	}
	
</script>
<style>
.tongyong_table {
	width: 100%;
	height: 400px;
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
<!--此处内容更替-->
        <div class="cwh_head">
            主页>常委会会议>闭幕会 <button  class="button1" style="margin-top: 10px;"  id="backMeet" onclick="javascript:backMeet()" type="button" style="">返回</button>
        </div>
        <div class="erjileftbar">
            <dl>
              <dt><a href="<%=basePath %>module/main/meet/changwh/index.jsp?meetid=<s:property value="meetid"/>"><img src="<%=path%>/themes/default/images/icon1.png"/></a></dt>
               <dd>基本信息</dd>
               <dt><a href="<%=basePath %>module/main/meet/changwh/yichengmanage.jsp?meetid=<s:property value="meetid"/>"><img src="<%=path%>/themes/default/images/icon3.png"/></a></dt>
               <dd>议程管理</dd>
               <dt><a href="<%=basePath %>module/main/meet/changwh/richengmanage.jsp?meetid=<s:property value="meetid"/>"><img src="<%=path%>/themes/default/images/icon4.png"/></a></dt>
               <dd>日程管理</dd>
               <dt><a href="<%=basePath %>meet_getMeetFile.action?meetid=<s:property value="meetid"/>&fileown=1&filetype=&pageNo=1&pageSize=8"><img src="<%=path%>/themes/default/images/icon2.png"/></a></dt>
               <dd>文件管理</dd>              
               <dt><a href="<%=basePath %>module/main/meet/changwh/fenzu.jsp?meetid=<s:property value="meetid"/>"><img src="<%=path%>/themes/default/images/icon5.png"/></a></dt>
               <dd>分组</dd>
               <dt><a href="<%=basePath %>meet_getMeetFile.action?meetid=<s:property value="meetid"/>&fileown=2&filetype=&pageNo=1&pageSize=8"><img src="<%=path%>/themes/default/images/icon4.png"/></a></dt>
               <dd>会中主任会议</dd>
               <dt><a href="<%=basePath %>meet_getMeetFile.action?meetid=<s:property value="meetid"/>&fileown=3&filetype=&pageNo=1&pageSize=8"><img src="<%=path%>/themes/default/images/icon4.png"/></a></dt>
               <dd>闭幕会</dd>
               <dt><a href="<%=basePath %>meet_selectProcessLogByMeetid.action?meetid=<s:property value="meetid"/>&pageNo=1&pageSize=8"><img src="<%=path%>/themes/default/images/icon6.png"/></a></dt>
               <dd>审核记录</dd>
            </dl>
        </div>
         <div class="erjimain">   
           <div class="huiyi_main" style="text-align: left;">
<!--             <form action="<%=basePath %>meet_benchRichenAddByFile.action" method="post" enctype="multipart/form-data">-->
            <s:hidden name="meetid" id="meetid"></s:hidden>
            <s:hidden name="fileown" id="fileown"></s:hidden>
<!--           	 <table>-->
<!--           	 		<tr>-->
<!--	                    <td>2.关联议程和日程</td>-->
<!--	                    <td><button  class="button3" name="" id="addriccheng" type="submit" style="">自动关联</button></td>-->
<!--	                    <td>-->
<!--	                    </td>-->
<!--	                </tr>-->
<!--           	 </table>-->
<!--           	 </form>-->
           	  <form action="<%=basePath %>meet_getMeetFile.action" method="post" id="findForm">
           	 <div class="tongzhi_main">
				<div class="tongyong_table">
						<div style="width:99%;margin:10px auto;">
							<s:hidden name="pageNo" id="page"></s:hidden>
							<table>
							<tr>
	                    <td style="height:40px; line-height:40px; font-size:14px; color:#333;font-family:"微软雅黑"; margin-left:20px; ">1.选择文件：</td>
	                    <td style="height:40px; line-height:40px; font-size:14px; color:#333;font-family:"微软雅黑"; margin-left:20px; "><button type="button" class="button3" id="buttonupload" onclick="addfile(0)">上传</button>
	                    	<div style="display: none"><input type="file" name="file" value="" id="upload"></div>
	                    </td>
	                    <td></td>
	                </tr>
								<tr>
							<td style="height:40px; line-height:40px; font-size:14px; color:#333;font-family:"微软雅黑"; margin-left:20px; ">2.会议文件维护</td>
	                    <td style="height:40px; line-height:40px; font-size:14px; color:#333;font-family:"微软雅黑"; margin-left:20px; ">
	                    <select name="filetype" id="filetype" style="margin-top:10px; margin-left:10px;">
	                    	<option value="">全部</option>
                           <option value="1">正式文件</option>      
                           <option value="2">延伸阅读</option>      
                        </select ></td>
	                    <td>
<!--	                    <button type="button" class="button3" id="buttonupload" onclick="addfile(0)">上传</button>-->
	                    <button  class="button3" id="search" type="submit">查询</button></td>
	                    
	                </tr>
							</table>
							<table id="table" cellpadding="0" cellspacing="0" border="0" width="100%">
								<tr>
									<th class="th_tongyongth">ID</th>
									<th class="th_tongyongth">文件名称</th>
									<th class="th_tongyongth">上传日期</th>
									<th class="th_tongyongth">排序</th>
									<th class="th_tongyongth">文件类型</th>
									<th class="th_tongyongth">操作</th>
								</tr>
								<tbody>
								<s:iterator value="page.result" id="rodo" status="L">
									<tr>
										<td style="height: 3px;"></td>
									</tr>
									<tr >
									<td class="td_tongyong" >
											<div style="display: none;">
												<s:property value="fileid"/>
											</div>
											<s:property value="#L.index+1"/>
										</td>
										<td class="td_tongyong" style="width: 60%;height:30px;text-align: left;padding-left: 10px;">
											<span style="cursor: hand;" title="<s:property value="filename" />">
											<s:if test="%{#rodo.filename.length()>40}"> 
								 <s:property value="%{#rodo.filename.substring(0,40)}" />...
								</s:if>
								<s:else> 
									<s:property value="filename" />
								</s:else>
											</span>
										</td>
										
										<td class="td_tongyong">
											<s:date name="uploadtime" format="yy年MM月dd HH:mm"/>
										</td>
										<td class="td_tongyong"  style="width: 5%;">
											<s:property value="sort" />
										</td>
										<td class="td_tongyong"  style="width: 10%;">
											<s:if test="%{#rodo.filetype==1}">
												<select onchange="updateFileType(<s:property value="fileid" />,this)">
												<option value="1">正式文件</option>
												<option value="2">延伸阅读</option>
												</select>
											</s:if>
											<s:else>
												<select onchange="updateFileType(<s:property value="fileid" />,this)">
												<option value="2">延伸阅读</option>
												<option value="1">正式文件</option>
												</select>
											</s:else>
										</td>
										<td style="border-right:none;width: 7%" class="td_tongyong">
										<a href="javascript:void(0)" onclick="deleteFile(<s:property value="fileid"/>,<s:property value="meetid"/>);">
											<img src="<%=path%>/themes/default/images/caozuo_05.png" />
										</a>
										</td>
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
												class="current_page"><s:property value="#p" />
											</a>
										</s:if>
										<s:else>
											<a href="javascript:toPage(<s:property value="#p"/>);"><s:property
													value="#p" />
											</a>
										</s:else>
									</s:iterator>
								</s:if>
								<s:else>
									<s:iterator begin="1" end="12" var="p">
										<s:if test="#p==pageNo">
											<a href="javascript:toPage(<s:property value="#p"/>);"
												class="current_page"><s:property value="#p" />
											</a>
										</s:if>
										<s:else>
											<a href="javascript:toPage(<s:property value="#p"/>);"><s:property
													value="#p" />
											</a>
										</s:else>
									</s:iterator>
								</s:else>
							</s:if>

							<s:if test="pageNo>7">
								<s:if test="totalPage<13">
									<s:iterator begin="1" end="totalPage" var="p">
										<s:if test="#p==pageNo">
											<a href="javascript:toPage(<s:property value="#p"/>);"
												class="current_page"><s:property value="#p" />
											</a>
										</s:if>
										<s:else>
											<a href="javascript:toPage(<s:property value="#p"/>);"><s:property
													value="#p" />
											</a>
										</s:else>
									</s:iterator>
								</s:if>
								<s:if test="totalPage>12">
									<s:if test="pageNo+4<totalPage">
										<%for(int i=6;i>-6;i--){ 
                     		//System.out.println("i:"+i);
                   			  request.setAttribute("ii",i);
                   			  %>
										<s:if test="pageNo==pageNo+#attr.ii">
											<a href="javascript:toPage(${pageNo-ii});"
												class="current_page">${pageNo+ii }</a>
										</s:if>
										<s:else>
											<a href="javascript:toPage(${pageNo-ii});">${pageNo-ii}</a>
										</s:else>
										<%} %>
									</s:if>
									<s:else>
										<%for(int i=11;i>-1;i--){ 
                     		//System.out.println("i:"+i);
                   			  request.setAttribute("ii",i);
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
										<%} %>
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
           	 </form>
                                
               
           </div>
        </div>
					</div>
			</div>
			
<!--此处内容更替结束-->
    <div id="logicWindow1" class="easyui-window" title="添加文件"
			iconCls="icon-save"
			style="width: 630px; height: 300px; padding: 5px;" closed = "true" >
	<form id="fff" action="index.htm" method="post" enctype="multipart/form-data">
		<table>
			<tr valign="top">
				<td>
					<div>
					&nbsp;推送范围:
	                   &nbsp;<select style="line-height:25px; height:25px; width:530px;" bgcolor="#ccc" name="scopeids" class="easyui-combotree"
	                      data-options="url:'<%=basePath %>notify/listScope.action',required:true, onChange:function(node){setComValues();}" multiple id="scopeselect"
	                       missingMessage='请选择推送范围'>  </select>
						<div class="fieldset flash" id="fsUploadProgress1">
						</div>
						<input type="hidden" id="saveDataId1"/>
						<div style="padding-left: 5px;">
							<span id="spanButtonPlaceholder1"></span>
							 <input id="btnCancel1" type="button" value="取消" onclick="cancelQueue(upload1);" disabled="disabled" style="margin-left: 2px; height: 22px; font-size: 8pt;display:none;" /> 
						</div>
					</div>
					
				</td>
			</tr>
		</table>
		<div>		<s:hidden name="meetid" id="meetid"></s:hidden>
					<input type="hidden" id="fileown" value="3"/>
					<input type="hidden" id="idv"/>
					<input type="hidden" id="reid" name="reid"/>
					<input type="hidden" id="filenames" name="filenames"/>
					<input type="hidden" id="selVal" name="selVal"/>
					</div>
					
	</form>
	 <div style="display: none;">
	 	<input type="text" id="fmtype" name="fmtype" value="2"/>
	 </div>
	<div region="south" border="false"
					style="text-align: right; padding: 5px 0;">
					<a class="easyui-linkbutton" id="btnsub1" iconCls="icon-ok"
						onclick = "sub1()">确定</a>
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
				upload_url: "<%=basePath %>meet_meetingfileadd.action",
				//post_params: {"submeetingid" : document.getElementById("idv").value},
				
				// File Upload Settings
				file_size_limit : "3600 MB",	// 100MB  文件上传大小，（这里不管用）
				file_types : "*.*",  //限制上传文件类型   ”*.jpg;*.jpeg;*.gif;*.png;*.bmp;”
				file_types_description : "All Files",  //文件类型描述
				file_upload_limit : 100,//允许同时上传文件的个数
				file_queue_limit : 0,  //允许队列存在的文件数量，默认值为0，即不限制
				
				// Event Handler Settings (all my handlers are in the Handler.js file)
				swfupload_preload_handler : preLoad,  //如果falsh版本不够深
				swfupload_load_failed_handler : loadFailed,
				file_dialog_start_handler : fileDialogStart,//文件选择对话框显示之前触发。只能同时存在一个文件对话框。
				file_queued_handler : fileQueued,//当文件选择对话框关闭消失时，如果选择的文件成功加入上传队列，那么针对每个成功加入的文件都会触发一次该事件（N个文件成功加入队列，就触发N次此事件）。
				file_queue_error_handler : fileQueueError, //当选择文件对话框关闭消失时，如果选择的文件加入到上传队列中失败，那么针对每个出错的文件都会触发一次该事件
				file_dialog_complete_handler : fileDialogComplete,  //设置swf监听fileDialogComplete 事件  选择好上传的文件就自动开始上传
				upload_start_handler : uploadStart, //在文件往服务端上传之前触发此事件，可以在这里完成上传前的最后验证以及其他你需要的操作
				upload_progress_handler : uploadProgress, //该函数用于侦听文件选择对话框关闭的事件，
				upload_error_handler : uploadError,//上传出错
				upload_success_handler : uploadSuccess,//上传成功
				upload_complete_handler : uploadComplete,//上传完成，无论上传过程中出错还是上传成功，都会触发该事件，并且在那两个事件后被触发
				// Button Settings
				button_image_url : "<%=basePath %>third/swfupload/images/icon_uploads.jpg",
				button_placeholder_id : "spanButtonPlaceholder1",//上传按钮占位符的id
				button_width: 61,  //按钮宽度
				button_height: 22,//按钮高度
				//button_image_url: "http://labs.goodje.com/swfu/swfu_bgimg.jpg",//按钮背景图片路径
//				button_text_style: ‘.btn-txt{color: #666666;font-size:20px;font-family:"微软雅黑"}‘,
//				button_text_top_padding: 6,
//				button_text_left_padding: 65,

				
				// Flash Settings
				//swfupload压缩包解压后swfupload.swf的url
				flash_url : "<%=basePath %>third/swfupload/swfupload.swf",
				flash9_url : "<%=basePath %>third/swfupload/swfupload_fp9.swf",
			
                //一些自定义的信息，默认值为一个空对象{}
				custom_settings : { 
					progressTarget : "fsUploadProgress1",
					cancelButtonId : "btnCancel1"
				},debug:false   //debug模式，可以在页面看到详细信息debug:false,   //debug模式，可以在页面看到详细信息
			});
	     }
	     
</script>
</html>
