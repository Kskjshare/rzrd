<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/public/common.jspf" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>人大会议助理_常委会会议</title>
<script type="text/javascript" src="<%=path%>/third/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=basePath%>fckeditor/fckeditor.js"></script>
<style type="text/css">
.Wdate{ height:30px; margin:5px; border-style:ridge;width:250px;}
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
<%
	int meetid=Integer.parseInt(request.getParameter("meetid"));
	//int type=Integer.parseInt(request.getParameter("type"));
%>
.erjileftbar dl{ margin-top:15px;}
.erjileftbar dt{ margin-top:5px;}
</style>
<style type="text/css">
	ul li{
				list-style:none
			}
			#head li.current{
				background-color:#2aa9df;
				color: #ffffff;
			}
			#head li{
				list-style-type: none;
				float:left;				
				line-height: 40px;
				width: 100px;
				height: 40px;
				cursor: pointer;
				font-size: 18;
				font-family:"微软雅黑";
				margin: 0px 20px;
			}
			#head1 ul{
				padding-left:0px;
				padding-left: 0px;
				margin-left: 0px;
			}
			#head ul{
			 	text-align:center;
			 	margin-left: 300px;
			}
			.tabclass{
				background-color: #7295e4;
			}
</style>
<script type="text/javascript">
	 $(function(){
    	$('#begin').click(function(){
    		//alert("OK");
    		WdatePicker({lang:'zh-cn',dateFmt:'yyyy-MM-dd HH:mm:ss'});
    	});
    	$('#end').click(function(){
    		//alert("OK");
    		WdatePicker({lang:'zh-cn',dateFmt:'yyyy-MM-dd HH:mm:ss'});
    	});
    	$('#submitData').click(function(){
    		saveW();
    	})
    	$("#publishgroup").click(function(){
	        $("button[name=reset]").trigger("click");
	    	 $("#groupno").attr("disabled",false);
    		$("#add").window("open");
    	})
    	$("#cancelAbsence").click(function(){
    		$("#add").window("close");
    	}); 
       $("#absenceUpload").change(function(){
    	   var a=$("#absenceUpload").val();
    	   if(a.indexOf("\\")>0){
    		a=a.substring(a.lastIndexOf("\\")+1)
    	   }
           $("#fileName").val(a);
           $("#title").val(a.substring(0,a.lastIndexOf(".")));
    	});
    	$("#buttonUpload").click(function(){
    		$("#absenceUpload").click();
    	});
    	$("#saveAbsence").click(function(){
    	 	if(!$("#uploadForm").form('enableValidation').form('validate')){
    	 		return false;
    	 	};	 
    	 		var filetext=$("#fileName").val();
						if(filetext.indexOf('.pdf')==-1){
						//	$.messager.alert('提示','请选择上传的pdf文件',"info",function(){});
						//	return;
						}
    	 	$("#pushflag").val("0");   	
	    	 var formData = new FormData($("#uploadForm")[0]);  
	    	 var url="<%=basePath%>meet_addFenzu.action?";
	    	 $("#groupno").attr("disabled",false);
	    		$.ajax({
	    			  url: url,
                      type: "POST",
			          data: formData,  
			          async: false,  
			          cache: false,  
			          contentType: false,  
			          processData: false,  
			          success: function (data) { 
			          $("#add").window("close"); 	
                      $.messager.alert("发布提示",data.msg,"info",function(){
			            document.getElementById("findForm").submit();
		              });
			          },  
			          error: function () {  
			             $.messager.alert("操作提示", "操作失败！","error");   
			          }  
	    		});
    	});    	
    	$("#pushAbsence").click(function(){
    	 	if(!$("#uploadForm").form('enableValidation').form('validate')){
    	 		return false;
    	 	};	 
    	 	var filetext=$("#fileName").val();
						if(filetext.indexOf('.pdf')==-1){
						//	$.messager.alert('提示','请选择上传的pdf文件',"info",function(){});
						//	return;
						}
    	 	$("#pushflag").val("1");   	
	    	 var formData = new FormData($("#uploadForm")[0]);  
	    	 var url="<%=basePath%>meet_addFenzu.action?";
	    	 $("#groupno").attr("disabled",false);
	    		$.ajax({
	    			  url: url,
                      type: "POST",
			          data: formData,  
			          async: false,  
			          cache: false,  
			          contentType: false,  
			          processData: false,  
			          success: function (data) { 
			          $("#add").window("close"); 	
                      $.messager.alert("发布提示",data.msg,"info",function(){
			            document.getElementById("findForm").submit();
		              });
			          },  
			          error: function () {  
			             $.messager.alert("操作提示", "操作失败！","error");   
			          }  
	    		});
    	});   
		 $('#fileName').validatebox({
             required: true,
             missingMessage:'请选择上传文件',
           });	
    	//alert("OK");
    })
    	var groupIndex=1;
    	var checkflag=false;//判断是否已保存
    	function changegroup(index){
			if(checkflag==false){
				 $.messager.confirm('提示信息','内容未保存，是否保存？',function(data){
				 	if(data){
	 					 checkflag=true;
						 $('#pushflag').val("0");
						 $('#meetid').val(<%=meetid%>)
						 $('#findForm').form('submit', {    
								    success: function(data){
								    var json = eval('(' + data + ')'); 
								    if(json.state=="true"||json.state){
										 $('#groupid').val(json.msg);
										 $.messager.alert("提示","录入成功","info",function(){
										 	change(index);
										 });
								    }else{
								    	$.messager.alert("提示","录入失败","info");
								    }
								    }    
								});
				 		
				 	}else{
				 	   change(index);
				 	}
				 });
			}else{
				change(index);
			}
    	}
<%--     	function change(index){
    			//alert("index:"+index);
    			checkflag=false;
    			if(index==1){
    				document.getElementById('img1').src="<%=path%>/themes/default/images/zu1_1.png";
    				document.getElementById('img2').src="<%=path%>/themes/default/images/zu2.png";
    				document.getElementById('img3').src="<%=path%>/themes/default/images/zu3.png";
    				$("#groupinfo").html("第一组：");
    			}else if(index==2){
    				document.getElementById('img1').src="<%=path%>/themes/default/images/zu1.png";
    				document.getElementById('img2').src="<%=path%>/themes/default/images/zu2_2.png";
    				document.getElementById('img3').src="<%=path%>/themes/default/images/zu3.png";
    				$("#groupinfo").html("第二组：");
    			}else if(index==3){
    				document.getElementById('img1').src="<%=path%>/themes/default/images/zu1.png";
    				document.getElementById('img2').src="<%=path%>/themes/default/images/zu2.png";
    				document.getElementById('img3').src="<%=path%>/themes/default/images/zu3_3.png";
    				$("#groupinfo").html("第三组：");
    			}else if(index==4){
    				document.getElementById('img1').src="<%=path%>/themes/default/images/zu1.png";
    				document.getElementById('img2').src="<%=path%>/themes/default/images/zu2.png";
    				document.getElementById('img3').src="<%=path%>/themes/default/images/zu3.png";
    				$("#groupinfo").html("注意事项：");
    			}
    			groupIndex=index;
    			$('#groupno').val(index);
    			$.messager.progress({interval:1000,text:"正在加载。。。"});
    			var editor = FCKeditorAPI.GetInstance("groupcontent");
				
				$.ajax({
				   type: "POST",
				   url: "<%=basePath%>meet_getFenzu.action",
				   data: {"groupno":index,"meetid":<%=meetid%>},
				   success: function(data){
					   $.messager.progress('close');
					   editor.EditorDocument.body.innerHTML="";
					   //alert("state:"+data.state);
					   $("#pushtime").html(data.pushtime);
						if(data.state){
							editor.EditorDocument.body.innerHTML=data.groupcontent;
							$('#groupid').val(data.groupid);
						}else{
							$('#groupid').val("0");
						}
				   },error:function(){
					   $.messager.progress('close');
				   }
			}); 
    	}
		 $(function(){
			var oFCKeditor = new FCKeditor( 'groupcontent' ) ; // 提交表单时本字段使用的参数名-->
			oFCKeditor.BasePath	= "<%=basePath%>fckeditor/" ; // 必须要有，这是指定editor文件夹所在的路径，一定要以'/'结尾-->
			oFCKeditor.Height	= "380";
			oFCKeditor.Width	= "860";
			oFCKeditor.ToolbarSet = "Basic" ;
			oFCKeditor.ReplaceTextarea(); // 替换id或name为指定值的textarea
		});--%>
	   	 function shownotify(groupno){
	         var url="<%=basePath%>meet_getFenzu.action?groupno="+groupno+"&meetid="+<%=meetid%>;  
	        //$("#hideid").html(id);
	            $.ajax({
			 	 url: url,
	          	 success: function (data) {
					if(data.state){
						$("#groupno").val(data.groupno);
						$("#fileName").val(data.filename);
						$("#groupid").val(data.groupid);
			            $("#groupno").attr("disabled",true);
				        $("#add").window("open"); 
					}else{
						$.messager.alert("提示", "查询失败！","error");  
					}
	          },  
	          error: function () {  
	              $.messager.alert("操作提示", "操作失败！","error");   
	          }  
	          });      
	     }	
         function deletenotify(id){
             $.messager.confirm("删除提示","<span>确定要删除？</span>",function(data){
                if(data){
   	             var url="<%=basePath%>meet_deleteFenzu.action?groupid="+id;  
   	             $.ajax({
    			  url: url,
		          success: function (data) { 
		            $.messager.alert("删除提示",data.msg,"info",function(){
						 document.getElementById("findForm").submit();
					})
		          },  
		          error: function () {  
		             $.messager.alert("操作提示", "操作失败！","error");   
		          }  
		          }); 
    	         }
    	        })
    	   }	   	 
		function saveW(){
			 checkflag=true;
			 $('#pushflag').val("0");
			 $('#meetid').val(<%=meetid%>)
			 $('#findForm').form('submit', {    
					    success: function(data){
					    var json = eval('(' + data + ')'); 
					    if(json.state=="true"||json.state){
					    	 //var editor = FCKeditorAPI.GetInstance("groupcontent");
							 //editor.EditorDocument.body.innerHTML=data.groupcontent; 
							 $('#groupid').val(json.msg);
							 $.messager.alert("提示","录入成功","info");
					    }else{
					    	$.messager.alert("提示","录入失败","info");
					    }
					    }    
					});
		}
		var timer ;
		$(function(){
		//checkload();
		window.setTimeout(function(){
			checkload();
			},2000);
		});
	
	function checkload() {
			 // var editor = FCKeditorAPI.GetInstance("groupcontent");
			  //alert("editor:"+editor);
        if (document.readyState == "complete") {
          // clearInterval(timer);
            //alert(document.readyState == "complete");
           // alert(document.readyState == "complete");
            //change(1);
        } else{
            timer = setTimeout("checkload()", 1000);
        }
    	}
	   
	   function backMeet(){
    		window.location.href="<%=basePath %>selectCurMeeting.action?type=2";
    	}
<%--     	function saveAndP(){
    		 checkflag=true;
			 $('#meetid').val(<%=meetid%>);
			 $('#pushflag').val("1");
			 $('#findForm').form('submit', {    
					    success: function(data){
					    var json = eval('(' + data + ')'); 
					    if(json.state=="true"||json.state){
					    	 //var editor = FCKeditorAPI.GetInstance("groupcontent");
							 //editor.EditorDocument.body.innerHTML=data.groupcontent; 
							 $('#groupid').val(json.msg);
							 $('#pushtime').html(json.pushtime);
							 $.messager.alert("提示","发布成功","info");
					    }else{
					    	$.messager.alert("提示","发布失败","info");
					    }
					    }    
					});
		} --%>	
		
		function fileOpen(fileid){
	$.ajax({
	type:"post",
	async:false,
	cache:false,
	url:"<%=basePath%>meet_getExistFileByName.action?filePath="+fileid,
	data:{},
	success:function(data){
	//alert(fileUrl+"ee1936bc-7ad9-4aac-b88b-3cd01d27e9e3.doc");
	//window.location=fileUrl+"ee1936bc-7ad9-4aac-b88b-3cd01d27e9e3.doc";
	var json=eval("("+data+")");
    if(json.state){
			window.open("<%=basePath%>"+fileid);
				    	}else{
				    		$.messager.alert('提示',"此附件已不存在");
				    	}
	}
	});
	}
</script>
</head>

<body>
<!--此处内容更替-->
        <div class="cwh_head">
            主页>常委会会议>分组信息 <!-- <button  class="button1" style="margin-top: 10px;"  id="backMeet" onclick="javascript:backMeet()" type="button" style="">返回</button> -->
        </div>
        <a class='easyui-linkbutton' onclick="javascript:backMeet()" id="backMeet" data-options="iconCls:'icon-Undo'" style="right:20px;position:absolute;margin-top:10px;z-index: 9px;top:5px;" >返回</a>        
        <div class="erjileftbar">
             <dl>
             <dl>
               <dt><a id="indexInfo" href="<%=basePath %>module/main/meet/changwh/index.jsp?meetid=<%=meetid%>"><img src="<%=path%>/themes/default/images/icon1.png"/></a></dt>
               <dt><a id="yichengmanage" href="<%=basePath %>module/main/meet/changwh/yichengmanage.jsp?meetid=<%=meetid%>"><img src="<%=path%>/themes/default/images/icon3.png"/></a></dt>
               <dt><a id="richengmanage"  href="<%=basePath %>module/main/meet/changwh/richengmanage.jsp?meetid=<%=meetid%>"><img src="<%=path%>/themes/default/images/icon4.png"/></a></dt>
               <dt><a id="meetfile1"  href="<%=basePath %>meet_getMeetFile2.action?meetid=<%=meetid%>&fileown=1&filetype=&pageNo=1&pageSize=8&bindtype=0"><img src="<%=path%>/themes/default/images/icon2.png"/></a></dt>
               <dt><a id="groupInfo" href="<%=basePath %>meet_getFenzuList.action?meetid=<%=meetid%>"><img src="<%=path%>/themes/default/images/icon05.png"/></a></dt>
               <dt><a id="meetfile2"  href="<%=basePath %>meet_getMeetFile.action?meetid=<%=meetid%>&fileown=2&filetype=&pageNo=1&pageSize=8"><img src="<%=path%>/themes/default/images/icon9.png"/></a></dt>
            </dl>
            </dl>
        </div>
        <div class="erjimain">             
<%--            <div class="huiyi_main" >
              <div style="text-align: center;">
              <form action="<%=basePath %>meet_addFenzu.action" id="findForm" method="post" style="margin-left:30px; margin-top:20px;">
                  	<div style="text-align: center;">
                  	<table style="background: url('');">
                  	<tr>
                  		<td style="text-align: center;">
                  		<div>
						<a href="javascript:changegroup(1);"><img id="img1" src="<%=path%>/themes/default/images/zu1_1.png"/></a>
						<a href="javascript:changegroup(2);"><img id="img2" src="<%=path%>/themes/default/images/zu2.png"/></a>
						<a href="javascript:changegroup(3);"><img id="img3" src="<%=path%>/themes/default/images/zu3.png"/></a>
						<a href="javascript:changegroup(4);"><span style="color: #A10000;margin-left: 180px;float:right;position: absolute;top: 48px;">注意事项</span></a>
						</div>
                  		</td>
                  	</tr>
                  	<tr>
                  		<td height="10px;">
                  		    <span id="groupinfo" style="font-size:14px; color:#333; text-indent:26px;margin-left: 15px; ">第一组：</span>
                  		</td>
                  	</tr>
                  	<tr>
                  		<td>
                  		<div style="text-align: center;">
							<textarea id="groupcontent" name="groupcontent"></textarea>
						</div>
                  		</td>
                  	</tr>
                  		<tr>
                  		<td height="10px;">
                  		
                  		</td>
                  	</tr>
                  	<tr>
                  		<td style="text-align: center;">
                  			<div >
						    <span style="font-size: 14px;margin-left: 10px;margin-top:10px;float: left;">最后一次发布时间：<span id="pushtime"></span></span>
	               		    <a class='easyui-linkbutton'  data-options="iconCls:'icon-save'" style="line-height: 25px;width: 115px;color:#a10000;margin-right:80px;margin-top:10px;" id="submitData">保存</a>
	               	 		<a class='easyui-linkbutton'  data-options="iconCls:'icon-push'" style="line-height: 25px;width: 115px;color:#a10000;margin-right:80px;margin-top:10px;" onclick="saveAndP();">保存并发布</a>	
							</div>
                  		</td>
                  	</tr>
                  	</table>
                  	
					</div>
					<input type="hidden" name="groupno" value="1" id="groupno"/>
					<input type="hidden" name="groupid" id="groupid" value="0"/>
					<input type="hidden" name="meetid" id="meetid" value="0"/>
					<input type="hidden" name="pushflag" id="pushflag" value="0"/>
              </form>
              </div>
           </div> --%>
       <div class="tongzhi"> 
            <div class="tongzhi_head"  style="margin:15px 5% 5px 4%">
       		 <a class='easyui-linkbutton'  id="publishgroup"  data-options="iconCls:'icon-add'" style="margin-top:10px;z-index: 9px;margin-left: 15px;width:80px;float: left;color:#a10000;" >新增分组</a>                                	       	 
            </div>
            <form action="<%=basePath %>meet_getFenzuList.action?meetid=<%=meetid%>" id="findForm" method="post" style="margin-left:30px;"> 	
            </form>
            <div class="tongzhi_right">
            <div style="width:90%;margin:10px auto;">
                  <table cellpadding="0" cellspacing="0" border="0" width="100%"  style="table-layout:fixed;">
                   <tr>
                 	<th class="thsecond_tongzhi" >分组类别</th>
                 	<th class="thfirst_tongzhi" >文件标题</th>
                 	<th class="thsecond_tongzhi" >保存时间</th>
                 	<th class="thsecond_tongzhi" >最后发布时间</th>
                 	<th class="th_tongzhi" style="width:9%">操作</th>
                  </tr>
                 <s:iterator value="meetgrouplist" id="rodo">
               	  <tr><td colspan="5" height="5"></td></tr>
               	  <tr>
                    <td class="tdsecond_tongzhi">
                    	<s:if test="#rodo.groupno==1">第一组</s:if>
                    	<s:if test="#rodo.groupno==2">第二组</s:if>
                    	<s:if test="#rodo.groupno==3">第三组</s:if>
                    	<s:if test="#rodo.groupno==4">注意事项</s:if>
                    </td>
                 	<td class="tdfirst_tongzhi" ><a href="javascript:fileOpen('<s:property value="filepath" />');" style="cursor: hand;" title="<s:property value="title" />">&nbsp;&nbsp;<s:property value="title" /></a></td>
                 	<td class="tdsecond_tongzhi" ><s:date name="uploadtime" format="yyy-MM-dd HH:mm"/></td>
                 	<td class="tdsecond_tongzhi"><s:if test="#rodo.pushtime==null">&nbsp;</s:if><s:date name="pushtime" format="yyy-MM-dd HH:mm"/></td>
                 	<td class="td_tongzhi" style="border-right:none;"><img src="<%=basePath %><%=themespath%>/images/caozuo_03.png"  onclick="shownotify('<s:property value="groupno"/>')" style="cursor:pointer;vertical-align: middle;"/>
                 	<img src="<%=basePath %><%=themespath%>/images/caozuo_05.png"  onclick="deletenotify('<s:property value="groupid"/>')" style="cursor:hand;cursor:pointer;vertical-align: middle;"/>
                 	</td>
               	 </tr>
                  </s:iterator>
               </table>
             </div>  
  <!-- 新建弹出框 -->
          <div id="add" class="easyui-window" closed="true" data-options="iconCls:'icon-save'" title="新建" style="width:630px;height:300px;">
         	 <div class="popabsence">
           <form method="POST" id="uploadForm" enctype="multipart/form-data">
           		<table>
           			<input type="text" style="display: none;" name="meetid" value="<%=meetid %>"></input>
           			<tr><td colspan="3" height="10"></td></tr>
         			<tr>
	                    <td class="poptitle" style="font-size: 14px;width: 100px;"> 分组类别：</td>
	                    <td><select  name="groupno" style="margin:5px;height:30px; width:190px;line-height:30px;font-size:14px;border: 2px solid #ccc;" id="groupno">
	                    		<option value="1" >第一组</option>
	                    		<option value="2">第二组</option>
	                    		<option value="3">第三组</option>
	                    		<option value="4">注意事项</option>
	                    	</select>
	                    </td>                
	                </tr>           			
           			<tr>
           			<s:hidden name="groupid" id="groupid" ></s:hidden>
           			<s:hidden name="pushflag" id="pushflag" ></s:hidden>
	                    <td class="poptitle" style="font-size: 14px;width: 100px;">分组文件：</td>
	                    <td><input class="input" type="text" name="fileName" value="" id="fileName" readonly="readonly" style="font-size: 14px;width: 190px;"></td>                
	     	            <td><a class='easyui-linkbutton' id="buttonUpload"  style="line-height: 25px;width: 80px;color:#a10000;margin-left:10px;" data-options="iconCls:'icon-upload'">上传</a>	                    	                    	                                  
	                    	<div style="display: none"><input type="file" name="file" value="" id="absenceUpload"></div>
	                    </td>
	                </tr>
	                <tr id="savediv">
	                	<td colspan="3">
	       					<a class='easyui-linkbutton'  data-options="iconCls:'icon-ok'" style="line-height: 25px;width: 115px;color:#a10000;margin-top:40px; " id="saveAbsence">保存</a>	
	       			    	<a class='easyui-linkbutton'  data-options="iconCls:'icon-push'" style="line-height: 25px;width: 115px;color:#a10000;margin-top:40px; margin-left:30px;" id="pushAbsence">保存并发布</a>			       				
	       					<a class='easyui-linkbutton'  data-options="iconCls:'icon-cancel'" style="line-height: 25px;width: 115px;color:#a10000;margin-top:40px; margin-left:20px;" id="cancelAbsence">取消</a>		                		
	                		<button type="reset" name="reset" style="display: none;"></button>
	                	</td>
	            </table>
           </form>
           </div>
             <!-- 弹出框结束 -->   
             </div>                              
        </div>
<!--此处内容更替结束--> 
</body>
</html>
