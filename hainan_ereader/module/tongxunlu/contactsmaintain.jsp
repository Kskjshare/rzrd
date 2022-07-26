<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/public/common.jspf"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript">
	    function jump(locate){
    		window.location.href=locate;
    	}
    	function toPage(page){
           	document.getElementById("page").value=page;
           	document.getElementById("findForm").submit();
        }
    	function addcontent(){
    		$(".panel-with-icon").html("增加人员");
    		$("#popwindow").attr("title","增加人员");
    		$("#popform").attr("action","<%=basePath%>tongxunlun/add.action");
			$("#iname").val('');
        	$("#isort").val('');  
        	$("#idept").val('');  
        	$("#ijobtitle").val('');  
        	$("#iphoneOffice").val('');  
        	$("#iphoneHome").val('');  
        	$("#imobile").val('');  
        	$("#imail").val('');  
	        $("input[name='entity.comment']").get(1).checked = true;
    		$("#popwindow").window("open");
    	}
    	function cancel(){
    		$('#popwindow').window('close');
    	}
    	function cancelUpload(){
    		$('#add').window('close');
    	}    	
    	function deleteone(id){
    		$.messager.defaults = { ok: "确定", cancel: "取消" };  
    	    $.messager.confirm("删除提示", "确认要删除？", function (data) {  
    	        if (data) {  
    	        	window.location.href="<%=basePath%>/tongxunlun/deleteById.action?id="+id;
    	        }  
    	    });
    	}
    	function importcontent(){
    		$(".panel-with-icon").html("导入通讯录");
    		$("button[name=reset]").trigger("click");
    		$('#add').window('open');
    	}      	
    	function uploadTXL(){
	    	$("#hideupload").click();
    	}
        function changeFileName(){
    	   var a=$("#hideupload").val();
    	   if(a.indexOf("\\")>0){
    		a=a.substring(a.lastIndexOf("\\")+1)
    	   }
           $("#fileName").val(a);
    	};    	
    	function saveUpload(){
    		if(!$("#uploadForm").form('enableValidation').form('validate')){
	   	 		return false;
	   	 	}; 
	    	var formData = new FormData($("#uploadForm")[0]);  
	   		var url="<%=basePath%>tongxunlun/autoImportUser.action";
	   		$.ajax({
	 			  url: url,
	              type: "POST",
		          async: false,  
		          cache: false,  
		          contentType: false,  
		          processData: false,
		          data:formData,
		          dataType:"json",
		          success: function (data) {
		          		  $('#add').window('close');
			              $.messager.alert("提示",data.msg,"info",function(){
			                   document.getElementById("findForm").submit();
			              });
		          },  
		          error: function () {  
		           		 $.messager.alert("操作提示", "操作失败！","error");
		          }  
		    });     		
    	}
    	function updateinfo (id){
    		var url="<%=basePath%>tongxunlun/selectById.action?id="+id;
    		$.ajax({
  			      url: url,
                  type: "POST",
		          async: false,  
		          cache: false,  
		          contentType: false,  
		          processData: false,
		          dataType:"json",
		          success: function (data) {
					$("#iname").val(data.name);
					$("#icompCode option[value="+data.compCode+"]").attr("selected",true);
		        	$("#isort").val(data.sort);  
		        	$("#idept").val(data.dept);  
		        	$("#ijobtitle").val(data.jobtitle);  
		        	$("#iphoneOffice").val(data.phoneOffice);  
		        	$("#iphoneHome").val(data.phoneHome);  
		        	$("#imobile").val(data.mobile);  
		        	$("#imail").val(data.mail);  
		        	var comments=data.comment;
		        	if(comments==0&&comments!=''){
		        		$("input[name='entity.comment']").get(0).checked = true;
		        	}else{
			        	$("input[name='entity.comment']").get(1).checked = true;
		        	}
		        	$(".panel-with-icon").html("编辑人员");
		     		$("#popwindow").attr("title","编辑人员");
		     		$("#popform").attr("action","<%=basePath%>/tongxunlun/update.action?entity.id="+id);
		    		$("#popwindow").window("open");
		          },  
		          error: function () {  
		             alert("暂不能修改");  
		          }  
		    }); 
    	}
    	function showS(){
    		$.messager.alert('提示',"已保存！","info");
    	}
    	function saveAndP(){
    		var url="<%=basePath%>tongxunlun/addPush.action?";
    		$.ajax({
  			      url: url,
                  type: "POST",
		          async: false,  
		          cache: false,  
		          contentType: false,  
		          processData: false,
		          dataType:"json",
		          success: function (data) {    	
						$.messager.alert('提示',data.msg,"info",function(){
							document.getElementById("findForm").submit();
						});
				}
			});
		}
function savepermission(){
      var str="";
	  if($("#rightselect option").length>0) { 
	       str = $("#rightselect option").map(function(){
	       return $(this).val();
	       }).get().join("&scopeid=");
	   } 
	   var url="<%=basePath %>tongxunlun/savePermission.action?&scopeid="+str;
	   		$.ajax({
	   			  url: url,
	              type: "POST",
		          success: function () { 
		        	  $("#showpermission").window('close');
		          }
	  	});
	
}    	
</script>
<script type="text/javascript">
$(function () {
	$("tr[name='bold0']").css("font-weight","bold");
    $('#iname').validatebox({
    	required: true,
    	missingMessage:'请输入姓名'
    });
    $('#imail').validatebox({
    	validType:'email',
    	invalidMessage:'邮箱格式不正确' 
    });
    $('#fileName').validatebox({
    	required: true,
    	missingMessage:'请选择上传文件' 
    });    
    $('#isort').validatebox({
    	validType:'integer',
    });
   
	$("#selAll").click(function(){
		    var checknodes=$(this).parent().parent().parent().find(':checkbox');
			var checkstatus=$(this).attr('checked');
			if(checkstatus=='checked'){
				checknodes.attr('checked', $(this).attr('checked'));
			}else{
				checknodes.removeAttr("checked");
			}
	})
})
	function deleteAll(){
		$.messager.confirm("确认", "确定执行批量操作吗", function (r) {
		if (!r)
			return;
		var tt = $("#table").find(
				'input[value][type=checkbox]:checked').not($("#selAll")[0]);
		var sel = tt.length;
		if (!sel) {
			$.messager.alert('提示','请选择操作数据',"info");
			return;
		}
		var ids = tt.map(function() {
			return $(this).val();
		}).get().join(',');
		window.location.href="<%=basePath%>tongxunlun/deleteAll.action?txlids="+ids;
		});	
	}
    function popSubmit(){
    	if(!$("#popform").form('validate')){
	    	return false;
	    }
	    $('#popform').submit();
 	};
 $.extend($.fn.validatebox.defaults.rules, {
	//移动手机号码验证
	    mobile: {//value值为文本框中的值
	        validator: function (value) {
	            var reg = /^1[3|4|5|8|9]\d{9}$/;
	            return reg.test(value);
	        },
	        message: '手机号码格式不正确'
	    },
	    integer: {//value值为文本框中的值
	        validator: function (value) {
	            var reg = /^[0-9]*$/;
	            return reg.test(value);
	        },
	        message: '只能输入整数'
	    }
 });
 function showPermission(){
 	$("#leftselect").find("option").remove();
	$("#rightselect").find("option").remove();
	 var url="<%=basePath %>tongxunlun/selectTxlPermission.action";  
     $.ajax({
	        url: url,
	        type: "POST",
	        dataType:"json",
		    success: function (data) { 
		    	$.each(data['list'],function(n,value){
		    		$("#leftselect").append("<option value='"+value.scopeid+"'>"+value.scopename+"</option"); 
		    	});
		    	$.each(data['permitlist'],function(m,val){
		    		$("#rightselect").append("<option value='"+val.scopeid+"'>"+val.scopename+"</option"); 
		    	})
		    }

    }); 
	  $("#rightimg").unbind('click').bind('click',function(){
	      	if($("#leftselect option:selected").length>0) { 
             $("#leftselect option:selected").each(function(){ 
             		  $("#rightselect").append("<option value='"+$(this).val()+"'>"+$(this).text()+"</option"); 
                        $(this).remove();
             }) ;
          } 
	  });
	  $("#leftimg").unbind('click').bind('click',function(){
	    	if($("#rightselect option:selected").length>0) { 
	           $("#rightselect option:selected").each(function(){ 
	                   $("#leftselect").append("<option value='"+$(this).val()+"'>"+$(this).text()+"</option"); 
	                       $(this).remove();
	           }) ;
	        } 		  
	  
	  });        
     $("#showpermission").window('open');
 }
</script>
<style>
#page a.current_page {
	background: #DEE5FA;
	border: #89bdd8 solid 1px;
	color: #2e6ab1;
	font-size: 15px;
}

#page a,#page a.current_page:hover {
	padding: 5px 7px;
	text-decoration: none;
	color: #2e6ab1;
	font-size: 15px;
}

#page {
	margin-top: 5px !important;
}

.tongyong_table {
	width: 100%;
	height: 400px;
	font-family: "微软雅黑";
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
.popinner input{
width:167px;
}
</style>
</head>

<body>
	<div class="cwh_head">通讯录</div>
	<!--此处内容更替-->
<!-- 	<div class="icon_head">
	</div> -->
	<div class="tongzhi" style="height: 500px;">
		<form action="<%=basePath%>tongxunlun/select.action" id="findForm" method="post">
			<s:hidden name="pageNo" id="page"></s:hidden>
			<div class="tongzhi_head"
				style="margin-left:55px;margin-top:15px;margin-buttom:10px;line-height:45px;">
				<p class="flt">
					姓名：
					<s:textfield class="input" style="line-height:30px;" name="name"></s:textfield>
 	                <a class='easyui-linkbutton' id="query_by_name" data-options="iconCls:'icon-search'" style="line-height: 25px;width: 80px;color:#a10000;position:absolute; left:240px;top:8px;" onclick="document.getElementById('findForm').submit()">查询</a>	   
 	                <a class='easyui-linkbutton' id="query_by_name" data-options="iconCls:'icon-modify'" style="line-height: 25px;width: 100px;color:#a10000;position:absolute; right:322px;top:8px;" onclick="showPermission();">设置权限</a>	                                   											 	                                                					
 	                <a class='easyui-linkbutton' id="query_by_name" data-options="iconCls:'icon-textadd'" style="line-height: 25px;width: 100px;color:#a10000;position:absolute; right:215px;top:8px;" onclick="importcontent();">导入通讯录</a>	                                   											
					</form>	
 	                <a class='easyui-linkbutton' id="query_by_name" data-options="iconCls:'icon-add'" style="line-height: 25px;width: 100px;color:#a10000;position:absolute; right:107px;top:8px;" onclick="addcontent();">增加人员</a>	       
 	                <a class='easyui-linkbutton' id="deleteAlls" data-options="iconCls:'icon-remove'" style="line-height: 25px;width: 100px;color:#a10000;position:absolute; right:0px;top:8px;"  onclick="deleteAll()">批量删除</a></td>	                            																	
			</div>
			<div class="tongzhi_main" style="height: 410px;">
				<div class="tongyong_table">
					<div style="width:90%;margin:10px auto;">
						<table cellpadding="0" cellspacing="0" border="0" width="100%" id="table" >
							<tr>
							    <th class="th_tongyong" width="3%"><input type='checkbox' id='selAll' style="vertical-align:middle;line-height: 40px;height: 40px;"/></th>
								<th class="th_tongyong" width="15%">姓名</th>
								<th class="th_tongyong" width="14%">分组</th>
								<th class="th_tongyong" width="12%">单位</th>
								<th class="th_tongyong" width="11%">职务</th>
								<th class="th_tongyong" width="10%">办公电话</th>
								<th class="th_tongyong" width="10%">住宅电话</th>
								<th class="th_tongyong" width="10%">手机</th>
								
								<th class="th_tongyong" width="4%">排序</th>
								<th colspan="2" class="th_tongyong" width="7%">操作</th>
							</tr>
							<s:iterator value="page.result" id="rodo">
								<tr>
									<td colspan="10" height="5"></td>
								</tr>
								<tr id="${id}" name="bold${rodo.comment}">
									<td class="td_tongyong" width="3%"><input type='checkbox' value="<s:property value="id" />" style="vertical-align:middle;line-height: 35px;height: 35px;"/></td>
									<td class="td_tongyong" width="15%"><s:property value="name" /></td>
									<td class="td_tongyong" width="14%" style="word-break: keep-all;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">
									<s:if test="#rodo.compCode==1">省人大常委会</s:if>
									<s:if test="#rodo.compCode==2">省人大常委会机关</s:if>
									<s:if test="#rodo.compCode==3">省人大离退休老同志</s:if> 
									<s:if test="#rodo.compCode==4">省人大各专门委员会组成人员...</s:if> 
									<s:if test="#rodo.compCode==5">各市县人大</s:if> 								
									</td>
									<td class="td_tongyong" width="12%"><s:if test="#rodo.dept==''">&nbsp;</s:if><s:property value="dept" /></td>
									<td class="td_tongyong" width="11%"><s:if test="#rodo.jobtitle==''">&nbsp;</s:if><s:property value="jobtitle" /></td>
									<td class="td_tongyong" width="10%"><s:if test="#rodo.phoneOffice==''">&nbsp;</s:if><s:property value="phoneOffice" />
									</td>
									<td class="td_tongyong" width="10%"><s:if test="#rodo.phoneHome==''">&nbsp;</s:if><s:property value="phoneHome" />
									</td>
									<td class="td_tongyong" width="10%"><s:if test="#rodo.mobile==''">&nbsp;</s:if><s:property value="mobile" /></td>
									
									<td class="td_tongyong" width="4%"><s:if test="#rodo.sort==null">&nbsp;</s:if><s:property value="sort" /></td>
									<td style="border-right:none;" class="td_tongyong" width="7%"><a
										href="javascript:void(0)" onclick="updateinfo (${id});"><img
											src="<%=path%>/themes/default/images/caozuo_03.png" style="vertical-align:middle;"/> </a> <a
										href="javascript:void(0)" onclick="deleteone (${id});"><img
											src="<%=path%>/themes/default/images/caozuo_05.png" style="vertical-align:middle;"/> </a></td>
								</tr>
							</s:iterator>
						</table>
					</div>	
	
					</div>					
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
						<a>共<s:property value="totalPage" /> 页</a>
					</div>
				</s:if>
			</div>
		</form>
		<div style="float: left;margin-left: 40px;position: absolute;">
			<span style="font-size: 14px;margin-left: 10px;margin-top:10px;float: left;">最后一次发布时间：<s:date name="Pubtime" format="yyy-MM-dd HH:mm"/></span>
			<div style="float: left;margin-left: 160px;">
	        <a class='easyui-linkbutton'  data-options="iconCls:'icon-save'" style="line-height: 25px;width: 115px;color:#a10000;margin-right:115px;margin-top:10px;" onclick="showS();">保存</a>
	        <a class='easyui-linkbutton'  data-options="iconCls:'icon-push'" style="line-height: 25px;width: 115px;color:#a10000;margin-right:115px;margin-top:10px;" onclick="saveAndP();">保存并发布</a>
		</div>
		<!-- 弹窗 -->
		<div id="popwindow" class="easyui-window" closed="true" data-options="iconCls:'icon-save'" title="增加人员" style="width:600px;height:560px;padding:10px;">
			<div class="popinner">
				<form id="popform" action="" method="post">
					<table align="left">
						<tr>
							<td>姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：</td>
							<td><input class="input" type="text" id="iname"
								name="entity.name" /></td>
						</tr>
						<tr >
							<td style="padding-top: 10px;">是否加粗：</td>
							<td style="margin:0 auto;padding-top: 10px;"><input   type="radio"	name="entity.comment" value="0" style="width: 30px;"> <span>是</span><input  type="radio" name="entity.comment" value="1" checked style="width: 30px;" ><span> 否</span>
								</td>
						</tr>
						<tr>
							<td>分&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;组：</td>
							<td><select id="icompCode" name="entity.compCode" class="input" 
								style="height:30px;margin-left:5px;width:167px;">
									<option style="width:162px;" value="1">&nbsp;&nbsp;省人大常委会</option>
									<option style="width:162px;" value="2">&nbsp;&nbsp;省人大常委会机关</option>
									<option style="width:162px;" value="3">&nbsp;&nbsp;省人大离退休老同志</option>
									<option style="width:162px;" value="4">&nbsp;&nbsp;省人大各专门委员会组成人员和省人大常委会各工作委员会委员</option>
									<option style="width:162px;" value="5">&nbsp;&nbsp;各市县人大</option>
							</select>
							</td>
						</tr>
						<tr>
							<td>排&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;序：</td>
							<td><input class="input" type="text" id="isort" name="entity.sort" />
							</td>
						</tr>
						<tr>
							<td>单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;位：</td>
							<td><input class="input" type="text" id="idept"
								name="entity.dept" />
							</td>
						</tr>
						<tr>
							<td>职&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;务：</td>
							<td><input class="input" id="ijobtitle" type="text"
								name="entity.jobtitle"></td>
						</tr>
						<tr>
							<td>办公电话：</td>
							<td><input class="input" id="iphoneOffice" type="text"
								name="entity.phoneOffice"></td>
						</tr>
						<tr>
							<td>住宅电话：</td>
							<td><input class="input" id="iphoneHome" type="text"
								name="entity.phoneHome"></td>
						</tr>
						<tr>
							<td>手&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;机：</td>
							<td><input class="input" id="imobile" type="text"
								name="entity.mobile"></td>
						</tr>
						<tr>
							<td>邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;箱：</td>
							<td><input class="input" id="imail" type="text"
								name="entity.mail"></td>
						</tr>
						
						<tr>
	                		<td><a class='easyui-linkbutton' id="subm" data-options="iconCls:'icon-save'" style="line-height: 25px;width: 80px;color:#a10000;margin-top:5px;margin-left: 20px;" onclick="popSubmit()" >保存</a>					
							</td>
	                		<td><a class='easyui-linkbutton'  data-options="iconCls:'icon-cancel'" style="line-height: 25px;width: 80px;color:#a10000;margin-top:5px;margin-left: 50px;" onclick="cancel()">取消</a>					
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		<!-- 弹窗 -->
		
		 <!-- 新建弹出框 -->
		     <div id="add" class="easyui-window" closed="true" data-options="iconCls:'icon-save'" title="导入通讯录" style="width:630px;height:300px;">
         	 <div class="popabsence">
           <form method="POST" id="uploadForm" enctype="multipart/form-data">
           		<table>
           			<tr><td colspan="3" height="10"></td></tr>
           			<tr>
	                    <td class="poptitle" style="font-size: 14px;width: 100px;">通讯录文件：</td>
	                    <td><input class="input" type="text" name="fileName" value="" id="fileName" readonly="readonly" style="font-size: 14px;width: 190px;"></td>                
	                    <td><a class='easyui-linkbutton' onclick="uploadTXL()"  style="line-height: 25px;width: 80px;color:#a10000;margin-left:10px;" data-options="iconCls:'icon-upload'">上传</a>	                    	                    	                    	                    
	                    	
	                    	<div style="display: none"><input type="file" name="file" value="" id="hideupload" onchange="changeFileName()"></div>
	                    </td>
	                </tr>
	                <tr> <td class="poptitle" style="font-size: 14px;width: 100px;">&nbsp;&nbsp;</td>
           				  <td colspan="2" height="10"><a href="<%=basePath %>/upload/example.xls" style="font-family：微软雅黑;color:#a10000;font-size:14px;text-decoration: underline;">文件模板</a></td>	
           			</tr>
	                <tr>
	                	<td colspan="3">

	                		<a class='easyui-linkbutton' id="subm" data-options="iconCls:'icon-save'" style="line-height: 25px;width: 80px;color:#a10000;margin-top:30px;margin-left: 105px;" onclick="saveUpload()">保存</a>					
	                		<a class='easyui-linkbutton'  data-options="iconCls:'icon-cancel'" style="line-height: 25px;width: 80px;color:#a10000;margin-top:30px;margin-left: 20px;"  onclick="cancelUpload()">取消</a>		                		
	                		<button type="reset" name="reset" style="display: none;"></button>
	                	</td>
	               	</tr>
	            </table>
           </form>
           </div>
             <!-- 弹出框结束 -->
             
		 <!-- 查看通讯录权限弹出框 -->
		     <div id="showpermission" class="easyui-window" closed="true" data-options="iconCls:'icon-save'" title="设置权限" style="width:630px;height:400px;">
         	 <div >
           <form method="POST" id="permissionForm">
           		<table class="sysscopeuser" style="margin:0 auto ;height: 90%;margin-top: 30px;">
           			<tr><td colspan="2" height="10"></td></tr>
	                <tr>
	                    <td style="font-size: 12px;height:30px;">所有推送范围</td>
	                    <td style="font-size: 12px;height:30px;">已选推送范围</td>
	                </tr>           			
             	    <tr>
	                    <td>
		                     <select multiple="multiple" id="leftselect" style="width:120px; float: left;" size="8" >
		                    	<s:iterator value="list">
		                    		<option value="<s:property value='id'/>"><s:property value='truename'></s:property></option>
		                        </s:iterator> 
						    </select>  
						    <div style="width:40px;height:60px;position:relative;float:left;margin-left: 25px;">
						    	<img src="<%=basePath %><%=themespath%>images/transright.png" id="rightimg" style="cursor: pointer;margin-top: 30px;"/>
						    	<img src="<%=basePath %><%=themespath%>images/transleft.png" id="leftimg" style="cursor: pointer;margin-top: 15px;"/>
						    </div>
						 </td>
						 <td >
	                        <select multiple="multiple" style="width:120px;float:left;" id="rightselect" size="8" name="usersid">
						    </select>
						 </td>
	                </tr>
	            </table>
	            	<a class='easyui-linkbutton'  data-options="iconCls:'icon-save'" style="line-height: 25px;width: 100px;color:#a10000;position:absolute; bottom:50px;right:150px;" id="savepermission" onclick="savepermission()">保存</a>					
           </form>
           </div>
             <!-- 弹出框结束 -->            
	</div>
	<!--此处内容更替结束-->

</body>
</html>
