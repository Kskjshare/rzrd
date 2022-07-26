<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
 <%@ include file="/public/common.jspf" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0"> 
	<%
	String meetid=request.getParameter("meetid");
	String type=request.getParameter("type");
	 %> 
	<script type="text/javascript" src="<%=basePath %>third/My97DatePicker/WdatePicker.js"></script> 
    <script type="text/javascript">
    	function jump(locate){
    		window.location.href=locate+"?type="+<%=type%>;
    	}
         function deletenotify(id){
         			 $.messager.confirm("删除提示","<span>确定要删除？</span>",function(r){
                	if(r){
    	             var url="<%=basePath%>meet_deleteBriefing.action?briefid="+id+"&meetid="+<%=meetid%>;  
    	             $.ajax({
	    			  url: url,
                      type: "POST",
			          async: false,  
			          cache: false,  
			          contentType: false,  
			          processData: false,  
			          success: function (data) { 
			              $.messager.alert("删除提示",data.msg,"info",function(){
						        document.getElementById("findForm").submit();
					      })
			          },  
			          error: function () {  
			            $.messager.alert("删除提示", "删除失败！","error");   
			          }  
			          }); 
			        
    	        }
    	     
            }
            )};
    	        function shownotify(id){
                     var url="<%=basePath%>meet_getBriefing.action?briefid="+id;  
                     $("#hideid").html(id);
    	             $.ajax({
	    			  url: url,
                      type: "POST",
			          async: false,  
			          cache: false,  
			          contentType: false,  
			          processData: false, 
			          dataType:"json", 
			          success: function (datas) {
			          var arr=new Array()
			          $.each(datas['briefsendscopelist'],function(n,value){
			               arr[n]=value.scopeid;
			           });
			           $('#scopeselect').combotree('setValues', arr);
			            $('#scopeselect').combotree('disable');
			            var data=datas['briefEntity'];			          
			            $("#filetext").val(data.filename);
			            //$("#notifyname").val(data.title);  
			            var date=data.sendtime;
			            var time=date.replace(/T/," "); 
			            var sendType=data.sendtype;
			            if(sendType=="2"){
			               $("#lateInfo").prop("checked",true);
			               $("#datenotify").val(time); 
			         	   $('#datenotify').validatebox({
			                    required: true,
			                    missingMessage:'请选择日期',
			                 }); 			               
			            }
			            if(sendType=="1"){
			            	 $("#nowInfo").prop("checked",true);
			            	 $("#datenotify").val(""); 
			            	 $("#datenotify").validatebox('remove');
			            }
			            // $("#upload").val(data.path);
			          },  
			          error: function () {  
			            $.messager.alert("操作提示", "操作失败！","error");   
			          }  
			          }); 
			           $("#savediv").css("display","none");
			           $("#updatediv").css("display","block");
			           $("#add").window("open");
    	        }
    	         
    	$(function(){
    	   $("#searchlist").click(function(){
    	               document.getElementById("page").value=1;
			           document.getElementById("findForm").submit();
	       });
    	    $("#nowInfo").focus(function(){
    	        $("#datenotify").val(""); 
    	        $("#datenotify").validatebox('remove');
    	    });
	    	$("#publishnotify").click(function(){
	    	    $("button[name=reset]").trigger('click');
	    	    $('#scopeselect').combotree('enable');
	    	    $("#updatediv").css("display","none");
	    	    $("#savediv").css("display","block");
	    	    $("#padsend").attr("checked",false);
		        $("#mobilesend").attr("checked",false);
		        $('#scopeselect').combotree('setValue','1' );
		        $("#datenotify").validatebox('remove');
	    		$("#add").window("open");
	    	});
	    	$("img[name=imgnotify]").click(function(){
	    		$("#tongzhijiankong").window("open");
	    	});
	    	$("#cancelnotify").click(function(){
	    		$("#add").window("close");
	    	});
	    	$("#cancelupdate").click(function(){
	    		$("#add").window("close");
	    	});
	    	$("#closenotify").click(function(){
	    		$("#tongzhijiankong").window("close");
	    	});
	    	$("#buttonupload").click(function(){
	    		$("#upload").click();
	    	});
	    	$("#upload").change(function(){
	    	var a=$("#upload").val();
	    	if(a.indexOf("\\")>0){
	    		a=a.substring(a.lastIndexOf("\\")+1)
	    	}
	           $("#filetext").val(a);
	           $("#fileFileName").val(a.substring(0,a.lastIndexOf('.')));
	    	});	 	    	
	    	$("#savenotify").click(function(){
    		if(!$("#uploadForm").form('enableValidation').form('validate')){
    	 		return false;
    	 	};
    	 	var filetext=$("#filetext").val();
						if(filetext.indexOf('.pdf')==-1){
						//	$.messager.alert('提示','请选择上传的pdf文件',"info",function(){});
						//	return;
						}
    	 	$("#pushflag").val("0");
	    	$("input[name=reset]").trigger("click");
	    	 var formData = new FormData($("#uploadForm")[0]);  
	    	 var url="<%=basePath%>meet_addBriefing.action?meetid="+<%=meetid%>;
	    		$.ajax({
	    			  url: url,
                      type: "POST",
			          data: formData, 
			          dataType:"json", 
			          async: false,  
			          cache: false,  
			          contentType: false,  
			          processData: false,  
			          success: function (data) { 
			             $("#add").window("close");	            
			             $.messager.alert("提示","保存纪要成功！","info",function(){
			             	document.getElementById("findForm").submit();
			             });
			          },  
			          error: function () {  
			             $.messager.alert("提示","保存纪要失败！","info",function(){
			             	document.getElementById("findForm").submit();
			             });  
			          }  
	    		});
			           $("#savediv").css("display","block");
			           $("#updatediv").css("display","none");
	    	});
	    	$("#pushnotify").click(function(){
    		if(!$("#uploadForm").form('enableValidation').form('validate')){
    	 		return false;
    	 	};
    	 	var filetext=$("#filetext").val();
						if(filetext.indexOf('.pdf')==-1){
						//	$.messager.alert('提示','请选择上传的pdf文件',"info",function(){});
						//	return;
						}
    	 	$("#pushflag").val("1");
	    	$("input[name=reset]").trigger("click");
	    	 var formData = new FormData($("#uploadForm")[0]);  
	    	 var url="<%=basePath%>meet_addBriefing.action?meetid="+<%=meetid%>;
	    		$.ajax({
	    			  url: url,
                      type: "POST",
			          data: formData, 
			          dataType:"json", 
			          async: false,  
			          cache: false,  
			          contentType: false,  
			          processData: false,  
			          success: function (data) { 
			             $("#add").window("close");	            
			             $.messager.alert("发布提示","发布纪要成功！","info",function(){
			             	document.getElementById("findForm").submit();
			             });
			          },  
			          error: function () {  
			             $.messager.alert("发布提示","发布纪要失败！","info",function(){
			             	document.getElementById("findForm").submit();
			             });  
			          }  
	    		});
			           $("#savediv").css("display","block");
			           $("#updatediv").css("display","none");
	    	});	    	
	    	$("#updatenotify").click(function(){
	    		if(!$("#uploadForm").form('enableValidation').form('validate')){
	    	 		return false;
	    	 	};
	    	 		$("#pushflag").val("0");
	    	 	    $('#scopeselect').combotree('enable');
	    	        $("#noticeid").val($('#hideid').html());
				   	 var formData = new FormData($("#uploadForm")[0]);  
				    	 var url="<%=basePath%>meet_updateBriefing.action?meetid="+<%=meetid%>;
				    		$.ajax({
				    			  url: url,
			                      type: "POST",
						          data: formData, 
						          dataType:"json", 
						          async: false,
						          cache: false,  
						          contentType: false,  
						          processData: false,  
						          success: function () { 
						             $("#add").window("close"); 	            
						             $.messager.alert("修改提示","修改纪要成功！","info",function(){
						             	  document.getElementById("findForm").submit();
						             });
						          },  
						          error: function () {  
						             $.messager.alert("修改提示","修改纪要失败！","info",function(){
						             	  document.getElementById("findForm").submit();
						             }); 
						          }  
				    		}); 
				    			   $("#filetext").val("");
			                       $("#fileFileName").val("");  
			                       $("#nowInfo").prop("checked",true);
			                       $("#datenotify").val("");  
                                  //document.getElementById("uploadForm").submit();
                                 
	    	          		 });
	    	$("#updatepush").click(function(){
	    		if(!$("#uploadForm").form('enableValidation').form('validate')){
	    	 		return false;
	    	 	};
	    	 		$("#pushflag").val("1");
	    	 	    $('#scopeselect').combotree('enable');
	    	        $("#noticeid").val($('#hideid').html());
				   	 var formData = new FormData($("#uploadForm")[0]);  
				    	 var url="<%=basePath%>meet_updateBriefing.action?meetid="+<%=meetid%>;
				    		$.ajax({
				    			  url: url,
			                      type: "POST",
						          data: formData, 
						          dataType:"json", 
						          async: false,
						          cache: false,  
						          contentType: false,  
						          processData: false,  
						          success: function () { 
						             $("#add").window("close"); 	            
						             $.messager.alert("发布提示","发布纪要成功！","info",function(){
						             	  document.getElementById("findForm").submit();
						             });
						          },  
						          error: function () {  
						             $.messager.alert("发布提示","发布纪要失败！","info",function(){
						             	  document.getElementById("findForm").submit();
						             }); 
						          }  
				    		}); 
				    			   $("#filetext").val("");
			                       $("#fileFileName").val("");  
			                       $("#nowInfo").prop("checked",true);
			                       $("#datenotify").val("");  
                                  //document.getElementById("uploadForm").submit();
                                 
	    	          		 });	    	          		 
			    	$.extend($.fn.validatebox.defaults.rules, {
			    		  mymobile: {validator: function (value, param) {
			                          return /^(((13[0-9])|(15[^4,\\D])|(18[0,2,5-9]))\d{8}\,)*(((13[0-9])|(15[^4,\\D])|(18[0,2,5-9]))\d{8})$/.test(value); }
			                          }
			    	
			    	})
			    	  $.extend($.fn.validatebox.methods, {    
		                  remove: function(jq, newposition){    
		                  return jq.each(function(){    
		                       $(this).removeClass("validatebox-text validatebox-invalid").unbind('focus').unbind('blur');  
		                  });    
		             },  
					    reduce: function(jq, newposition){    
					        return jq.each(function(){    
					           var opt = $(this).data().validatebox.options;  
					           $(this).addClass("validatebox-text").validatebox(opt);  
					        });    
					    }     
					});			    	
			   		 $('#phonenums').validatebox({
			              validType: 'mymobile',
			              invalidMessage:'请输入正确格式'
			            });
		            $("#lateInfo").bind("focus", function () {
		         		 $('#datenotify').validatebox({
		                    required: true,
		                    //validType: 'mymobile',
		                    missingMessage:'请选择日期',
						});
		            });			            
    				}); 
    				function backMeet(){
    					window.location.href="<%=basePath %>selectCurMeeting.action?type="+<%=type%>;
    				}
    				
    				 function fileOpen(fileid){
	$.ajax({
	type:"post",
	async:false,
	cache:false,
	url:"<%=basePath%>meet_getExistFileByName.action?filePath="+fileid,
	data:{},
	success:function(data){
	//alert(fileUrl+"ee1936bc-7ad9-4aac-b88b-3cd01d27e9e3.doc");
	//href="javascript:fileOpen('<s:property value="path" />');"
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
<style type="text/css">
    #page a.current_page{
    background: #DEE5FA;
    border: #89bdd8 solid 1px;
    color: #2e6ab1;
    font-size: 15px;
	}
	#page a, #page a.current_page:hover
	{
    padding: 5px 7px;
    text-decoration:none;
     color: #2e6ab1;
     font-size: 15px;
	}
	#page{
	margin-top:20px;
	}
	
    </style>
</head>

<body>
    <div>
        <div class="cwh_head">
           纪要 <!-- <button  class="button1" style="margin-top: 10px;"  id="backMeet" onclick="javascript:backMeet()" type="button" style="">返回</button> -->
        </div>
        <a class='easyui-linkbutton'  id="backMeet" onclick="javascript:backMeet()" data-options="iconCls:'icon-Undo'" style="right:20px;position:absolute;margin-top:10px;z-index: 9px;top:5px;" >返回</a>                        
<!--此处内容更替-->
<%--         <div class="icon_head">
<!--          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button  class="button1" name="" type="button" id="publishnotify">发布简报</button>
 -->            <button class="button1" name="" type="button" onclick="jump('<%=basePath %>selectCurMeeting.action')">返回纪要</button>
        </div> --%>
        <div class="tongzhi">
            <span id="hideid" style="display:none;"></span>
             <div class="tongzhi_head">
                <!-- <button  class="button3" name="" type="button" id="publishnotify" style="position:absolute; left:10px;">发布纪要</button>   -->
       		    <a class='easyui-linkbutton'  id="publishnotify"  data-options="iconCls:'icon-add'" style="position:absolute;margin-top:10px;z-index: 9px;top:5px;left:10px;width:80px;" >发布纪要</a>                                              
               </form>
            </div>
            <div class="jianbao_right">
            <div style="width:90%;margin:10px auto;">
            <form  id="findForm" action="<%=basePath%>meet_getJiyaoList.action" enctype="multipart/form-data">
                  <table cellpadding="0" cellspacing="0" border="0" width="100%">
                  <s:hidden name="meetid" id="meetid"/>
                  <s:hidden name="type" id="type"/>  
                   <tr>
                 	<th class="th_jianbao" width="50%">标题</th>
                 	<th class="th_jianbao" width="14%">保存时间</th>
                 	<th class="th_jianbao" width="14%">最后发布时间</th>
                 	<th class="th_jianbao" width="14%">推送范围</th>
                 	<th class="th_jianbao" width="8%">操作</th>
                  </tr>
                 <s:iterator value="briefinglist" id="rodo">
                 <tr><td colspan="4" height="5"></td></tr>
                 	<tr>
                    <td class="td_jianbao" width="50%" style="text-align: left;">&nbsp;&nbsp;<a href="javascript:fileOpen('<s:property value="filepath" />');" style="cursor: hand;" title="<s:property value="briefname"/>">
                    <s:if test="%{#rodo.briefname.length()>30}"> 
				    <s:property value="%{#rodo.briefname.substring(0,30)}" />...
					</s:if>
					<s:else> 
						<s:property value="briefname" />
					</s:else>
                    </a></td>
                    <td  class="td_jianbao" width="14%">
                    	<s:date name="%{#rodo.pubtime}" format="yyyy-MM-dd HH:mm"/>
                    </td>
                    <td  class="td_jianbao" width="14%">
                    	<s:if test="#rodo.sendtime==null">&nbsp;</s:if>
                    	<s:date name="%{#rodo.sendtime}" format="yyyy-MM-dd HH:mm"/>
                    </td>                    
                     <td  class="td_jianbao" width="14%">
					<span title="<s:property value="scopename"/>">
						<s:if test="%{#rodo.scopename.length()>8}"> 
				    <s:property value="%{#rodo.scopename.substring(0,8)}" />...
					</s:if>
					<s:else> 
						<s:property value="scopename" />
					</s:else>
					</span>
                    </td>                    
                 	 <td class="td_jianbao" width="8%" style="border-right:none;"><img src="<%=basePath %><%=themespath%>/images/caozuo_03.png"  onclick="shownotify(<s:property value="briefid"/>)"  style="cursor:pointer;vertical-align: middle;"/>
                 	<img src="<%=basePath %><%=themespath%>/images/caozuo_05.png"  onclick="deletenotify(<s:property value="briefid"/>)" style="cursor:pointer;vertical-align: middle;" />
                 	</td>
               	 </tr>
                  </s:iterator>
               </table>
               </form>
             </div>  
  <!-- 弹出框 -->           
            <div id="add" class="easyui-window" closed="true" data-options="iconCls:'icon-save'" title="发布纪要" style="width:630px;height:500px;;left:230px;top:100px;padding:10px;">
         	<div class="noticepopinner">
	            <form  id="uploadForm" action="<%=basePath%>notify/update.action?" enctype="multipart/form-data">
           		<table cellpadding="0" cellspacing="0">
           			<tr>
           			 <s:hidden name="noticeId" id="noticeid" ></s:hidden>
           			 <s:hidden name="pushflag" id="pushflag" ></s:hidden>
	                    <td width="100px;">纪要文件：</td>
	                    <td><input  type="text" name="fileFileName" value="" id="filetext" class="easyui-validatebox" missingMessage="请选择上传文件" data-options="required:true"></td>
	                   <!--  <td><button type="button" class="button3" id="buttonupload">上传</button> -->
	                    <td><a class='easyui-linkbutton' id="buttonupload"  style="line-height: 25px;width: 80px;color:#a10000;margin-left:10px;" data-options="iconCls:'icon-upload'">上传</a>	                    	                    
	                    	<div style="display: none"><input type="file" name="file" value="" id="upload"></div>
	                    </td>
	                </tr>
	                <tr style="display: none;">
	                    <td width="100px;">通知名称：</td>
	                    <td colspan="2"><input   type="text" name="name" value="" id="notifyname" ></td>
	                </tr>
	                <tr>
	                    <td width="100px;">推送范围：</td>
	                    <td colspan="2">
	                    <select style="line-height:25px; height:25px; width:280px;" bgcolor="#ccc" name="sendScopes" class="easyui-combotree"  data-options="url:'<%=basePath%>notify/listScope.action',required:true" multiple id="scopeselect">  </select></td>
	                </tr>	                	                	                
	                <tr>
	                    <td width="100px;">提醒时间：</td>
	                    <td colspan="2"><input  type="radio" name="sendType" value="1" checked="checked" id="nowInfo">立即提醒</td>
	                </tr>
	                <tr>
	                	<td width="100px;"></td>
	                    <td colspan="2"><input  type="radio" name="sendType" value="2" id="lateInfo">定时提醒
	                    </td>
	                </tr>
	                <tr>
	                	<td width="100px;"></td>
	                    <td colspan="2">
	                    	<input type="text" name="sendTimeStr" class="Wdate" style="width:200px;height:25px;margin-left:5px;border:2px solid #ccc;" id="datenotify" onClick="WdatePicker({lang:'zh-cn',dateFmt:'yyyy-MM-dd HH:mm:ss'})"/>
	                    </td>
	                </tr>	                
	                <tr id="savediv">
<!-- 	                	<td><button style="margin-top:35px; " type="button" class="button3" id="savenotify">保存</button>
	                	<td><button style="margin-top:35px; margin-left:30px;" type="button" class="button3" id="pushnotify">保存并发布</button></td>
	                	<td><button style="margin-top:35px; margin-left:30px;" type="button" class="button3" id="cancelnotify">取消</button></td> -->
	                	
	               	    <td><a class='easyui-linkbutton'  data-options="iconCls:'icon-save'" style="line-height: 25px;width: 115px;color:#a10000;margin-top:35px;" id="savenotify">保存</a></td>
	       				<td><a class='easyui-linkbutton'  data-options="iconCls:'icon-push'" style="line-height: 25px;width: 115px;color:#a10000;margin-top:35px; margin-left:30px;" id="pushnotify">保存并发布</a></td>		
	       				<td><a class='easyui-linkbutton'  data-options="iconCls:'icon-cancel'" style="line-height: 25px;width: 115px;color:#a10000;margin-top:35px; margin-left:30px;" id="cancelnotify">取消</a></td>	
	                </tr>
	                 <tr  id="updatediv">
<!-- 	                	<td ><button style="margin-top:35px;" type="button" class="button3" id="updatenotify" >保存</button>
	                	<td ><button style="margin-top:35px; margin-left:30px;" type="button" class="button3" id="updatepush" >保存并发布</button></td>
	                	<td><button style="margin-top:35px; margin-left:30px;" type="button" class="button3" id="cancelupdate">取消</button> -->
	                	
	                	<td><a class='easyui-linkbutton'  data-options="iconCls:'icon-save'" style="line-height: 25px;width: 115px;color:#a10000;margin-top:35px;" id="updatenotify">保存</a></td>
	       				<td><a class='easyui-linkbutton'  data-options="iconCls:'icon-push'" style="line-height: 25px;width: 115px;color:#a10000;margin-top:35px; margin-left:30px;" id="updatepush">保存并发布</a></td>		
	       				<td><a class='easyui-linkbutton'  data-options="iconCls:'icon-cancel'" style="line-height: 25px;width: 115px;color:#a10000;margin-top:35px; margin-left:30px;" id="cancelupdate">取消</a></td>	                	
	                	<button type="reset" name="reset" style="display: none;"></button>
	                	</td>
	                </tr>	                	
	            </table>
           </form>
          </div>
          </div> 
  <!-- 弹出框结束 -->        
 <!-- 监控弹出框 -->  
           <div  id="tongzhijiankong"  class="easyui-window" closed="true" data-options="iconCls:'icon-save'" title="监控"  style="width:900px; height:500px; left:230px;top:100px;">	
		    <div class="jiankong_left2 flt">
		        <p>总人数<br/><span id="totalSize"></span></p>
		        <ul>
		          <li>参会人员<span id="attendSize" onclick="shownoticereply('2')"></span></li>
		          <li>请假人员<span id="absenceSize" onclick="shownoticereply('1')"></span></li>
		          <li>待定人员<span id="unconfirmSize" onclick="shownoticereply('3')"></span></li>
		        </ul>
		     </div>
		    <div class="jiankong_right2 frt">
		        <p id="title">参会人员:</p>
		        <div style="width:100%;margin:10px auto;overflow-x:hidden;overflow-y:scroll;height: 350px;" >
		           <table cellpadding="0" cellspacing="0" border="1" width="100%"  id="replytitle">
		             <tr class="jiankong_title2" id="titletr" >
		               <th>编号</td>
		               <th>姓名</td>
		               <th>手机号码</td>
		             </tr>
		           </table>
		        </div>
		    </div>
		 </div>
         </div>       
 <!--结束  -->                                        
         </div>
<!--此处内容更替结束-->
    </div>
</body>
</html>
