<%@ page language="java"  pageEncoding="utf-8"%>
<%@ include file="/public/common.jspf" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>人大会议助理_常委会会议</title>
<script type="text/javascript"> 
function toPage(page){
       document.getElementById("page").value=page;
       document.getElementById("findForm").submit();
} 
window.onload=function(){
	if($(".icon_head").html().trim()=='用户管理'){
	$("#bg1").find("img").attr("src","<%=path%>/themes/default/images/xtglbg_03.png");
    }
    if($(".icon_head").html().trim()=='角色管理'){
	$("#bg2").find("img").attr("src","<%=path%>/themes/default/images/xtglbg_08.png");
    }
    if($(".icon_head").html().trim()=='推送范围管理'){
	$("#bg3").find("img").attr("src","<%=path%>/themes/default/images/xtglbg_11.png");
    }
    if($(".icon_head").html().trim()=='会议维护'){
	$("#bg4").find("img").attr("src","<%=path%>/themes/default/images/xtglbg_10.png");
    }
    if($(".icon_head").html().trim()=='数据字典'){
	$("#bg5").find("img").attr("src","<%=path%>/themes/default/images/shuju_10.png");
    }     
    if($(".icon_head").html().trim()=='版本管理'){
	$("#bg6").find("img").attr("src","<%=path%>/themes/default/images/xtglbg_12.png");
    }
    if($(".icon_head").html().trim()=='帮助维护'){
	$("#bg7").find("img").attr("src","<%=path%>/themes/default/images/xtglbg_13.png");
    }         
}
function showsysrole(id){
$("#hideid").html(id);
var url="<%=basePath %>sysrole/selectById.action?roleid="+id;  
        $.ajax({
	        url: url,
	        type: "POST",
		    async: false,  
		    success: function (data) { 
		    	$("#rolename").val(data['roleentity'].rolename);
		    	$("#des").val(data['roleentity'].des);
		    	$.each(data['rolePermission'],function(n,value){
		    		$("input:checkbox[value="+value.permissioncode+"]").attr('checked','true'); 
		    	});
		    },  
	        error: function () {   
	        }  
       }); 
	   $("#savediv").css("display","none");
       $("#updatediv").css("display","block");
	   $(".panel-with-icon").html("编辑角色");
       $("#add").window("open");
}
function deletesysrole(id){
       $.messager.confirm("删除提示","<span>确定要删除？</span>",function(data){
       if(data){
        var url="<%=basePath %>sysrole/delete.action?roleid="+id;  
        $.ajax({
	        url: url,
	        type: "POST",
		    async: false,  
		    cache: false,  
		    success: function (data) { 
				$.messager.alert("删除提示",data.msg,"info",function(){
					 document.getElementById("findForm").submit();
				})
		    },  
	        error: function () {  
	         $.messager.alert("操作提示","操作失败","error");
	        }  
       }); 
        }
        });
}
function showroleusers(roleid){
       $("#hideid").html(roleid);
       $("#titletr").siblings().empty();
       var url="<%=basePath %>sysrole/selectUserList.action?pageNoUser=1&pageSizeUser=6&roleid="+roleid;  
        $.ajax({
	        url: url,
	        type: "POST",
		    async: false,  
		    cache: false,  
		    success: function (data) { 
 		    	$.each(data.result,function(n,value){
		    		$("#usertable tbody").append("<tr><td>"+value.id+"</td><td >"+value.username+"</td><td >"+value.danwei+"</td></tr>")
		    	});
		    },  
	        error: function () {   
	         $.messager.alert("操作提示","操作失败","error");
	        }  
       }); 
       $("#roleuser").window("open");
 }   
function showeditorusers (id){
 $("#hideid").html(id);
var url="<%=basePath %>sysrole/selectById.action?roleid="+id;  
        $.ajax({
	        url: url,
	        type: "POST",
		    async: false,  
		    success: function (data) { 
		    	$("#rolesname").html(data['roleentity'].rolename);
 		    	$("#leftselect").find("option").remove();
		    	$("#rightselect").find("option").remove();
		    	$.each(data['userlist'],function(n,value){
		    		$("#leftselect").append("<option value='"+value.id+"'>"+value.truename+"</option"); 
		    	});
		    	$.each(data['roleuserlist'],function(m,val){
		    		$("#rightselect").append("<option value='"+val.userid+"'>"+val.username+"</option"); 
		    	}) ;
		    },  
	        error: function () {   
	        }  
       }); 
	   $("#savediv").css("display","none");
       $("#updatediv").css("display","block");
       $("#editoruser").window("open");
}
$(function () {
    $("#rightimg").click(function(){
    	if($("#leftselect option:selected").length>0) { 
           $("#leftselect option:selected").each(function(){ 
                   $("#rightselect").append("<option value='"+$(this).val()+"'>"+$(this).text()+"</option"); 
                       $(this).remove();
           }) ;
        }     
    })
    $("#leftimg").click(function(){
    	if($("#rightselect option:selected").length>0) { 
           $("#rightselect option:selected").each(function(){ 
                   $("#leftselect").append("<option value='"+$(this).val()+"'>"+$(this).text()+"</option"); 
                       $(this).remove();
           }) ;
        }     
    })
	$("#show").click( function() {
		$(".panel-with-icon").html("增加角色");
	 	$("input[name=reset]").trigger("click");
        $("input[name='persimoncode']").removeAttr("checked"); 
	    $("#updatediv").css("display","none");
	    $("#savediv").css("display","block");
		$("#add").window("open");
	});
	$("#cancel").click( function() {
		$("#add").window("close");
	});
	$("#closeuser").click(function(){
	   $('#scopeuser').hide();
	});
	$("#savesysrole").click(function(){
	if(!$("#roleForm").form('enableValidation').form('validate')){
	    	return false;
	};
	var url="<%=basePath %>sysrole/saveRole.action";
		   $.ajax({
   			  url: url,
              type: "POST",
	          data: $("#roleForm").serialize(),  
	          async: false,  
	          success: function (data) { 
	          $("#add").window("close");	
                     $.messager.alert("新建提示",data.msg,"info",function(){
							document.getElementById("findForm").submit();
					 });   
	          },  
	          error: function () {  
	              $.messager.alert("操作提示","操作失败","error"); 
	          }  
    		});
   				$("#savediv").css("display","block");
                $("#updatediv").css("display","none");

	})
    $("#cancelsave").click( function() {
		$("#add").window("close");
	});
	$("#cancelupdate").click( function() {
		$("#add").window("close");
	});
	$("#cancelupdateuser").click( function() {
		$('#editoruser').window("close");
	});
	$("#closeeditoruser").click( function() {
		$('#editoruser').window("close");
	});
	$("#closeuser").click(function(){
	   $("#roleuser").window("close");
	});  
	$("#closepush").click(function(){
	   $("#add").window("close");
	});
	$("#updatesysrole").click(function(){ 
	if(!$("#roleForm").form('enableValidation').form('validate')){
	    	return false;
	};
     var id=$('#hideid').html();
     var str="";
	   if($("#rightselect option").length>0) { 
	       str = $("#rightselect option").map(function(){
	       return $(this).val();
	       }).get().join("&usersid=");
	   } 
   	 var url="<%=basePath %>sysrole/updateRole.action?roleid="+id+"&usersid="+str;
   		$.ajax({
   			  url: url,
              type: "POST",
	          data: $("#roleForm").serialize(),  
	          async: false,  
	          success: function (data) { 
	             $("#add").window("close"); 	
                 $.messager.alert("修改提示",data.msg,"info",function(){
					document.getElementById("findForm").submit();
				});
	          },  
	          error: function () {  
	              $.messager.alert("操作提示","操作失败","error");  
	          }  
   		});
   				$("#savediv").css("display","block");
                $("#updatediv").css("display","none");
      
  	});
$("#saveroleuser").click(function(){
	   var id=$('#hideid').html();
 	   var str="";
	   if($("#rightselect option").length>0) { 
	       str = $("#rightselect option").map(function(){
	       return $(this).val();
	       }).get().join("&usersid=");
	   } 
	var url="<%=basePath %>sysrole/updateRoleUser.action?usersid="+str+"&roleid="+id;
		   $.ajax({
   			  url: url,
              type: "POST",
	          data: {},  
	          async: false,  
	          success: function (data) { 
	           $('#editoruser').window("close");	
                     $.messager.alert("修改提示",data.msg,"info",function(){
							document.getElementById("findForm").submit();
					 });   
	          },  
	          error: function () {  
	              $.messager.alert("操作提示","操作失败","error"); 
	          }  
    		});
	})
	 $('#rolename').validatebox({  
			 required: true,
	         missingMessage:'请输入角色名称',
	 });
});
</script>
<style type="text/css">
.erjimain{
margin:0;
float:left;
width:88%;
height:570px;
}
</style>
</head>

<body>
<!--此处内容更替-->
        <div class="cwh_head">
            系统管理
        </div>
        
        <div class="syserjileftbar">
            <dl>
               <dt id="bg1" ><a href="<%=basePath %>/sysuser/selectList.action?pageNo=1&pageSize=8" ><img src="<%=path%>/themes/default/images/xtglbgold_03.png"  /></a></dt>
               <dt id="bg2" ><a href="<%=basePath %>/sysrole/selectList.action?pageNo=1&pageSize=8" ><img src="<%=path%>/themes/default/images/xtglbgold_08.png" /></a></dt>
               <dt id="bg3" ><a href="<%=basePath %>/sysscope/selectList.action?pageNo=1&pageSize=8" ><img src="<%=path%>/themes/default/images/xtglbgold_11.png" /></a></dt>
               <dt id="bg5" ><a href="<%=basePath %>/sysdictdata/selectList.action?pageNo=1&pageSize=8" ><img src="<%=path%>/themes/default/images/shuju1_10.png" /></a></dt>
               <dt id="bg4" ><a href="<%=basePath %>/sysmeetmaintain/selectAllTypeCurMeeting.action" ><img src="<%=path%>/themes/default/images/xtglbgold_10.png" /></a></dt>
               <dt id="bg6" ><a href="<%=basePath %>/sysversion/selectVersionList.action?pageNo=1&pageSize=8" ><img src="<%=path%>/themes/default/images/xtglbgold_12.png" /></a></dt> 
               <dt id="bg7" ><a href="<%=basePath %>/syshelp/selectAllHelpList.action?pageNo=1&pageSize=8" ><img src="<%=path%>/themes/default/images/xtglbgold_13.png" /></a></dt>                                            
            </dl>
        </div>
        <div class="erjimain">
            <div class="icon_head">
               角色管理
            </div>
            <div class="tongzhi_main" style="margin-top:10px;">
              <div class="tongzhi_head">
              <span id="hideid" style="display:none;"></span>
                <form action="<%=basePath%>sysrole/selectList.action?pageSize=8" id="findForm" method="post">
	                  <s:hidden name="pageNo" id="page"></s:hidden>
	            <p  style="font-size: 16px;margin-left: 0px;margin-top: 5px;">针对后台用户进行权限设置：</p>  
                <!-- <button  class="button3" name="" id="show" type="button" style="position:absolute; right:0px;">增加角色</button> -->
	            <a class='easyui-linkbutton'  id="show"  data-options="iconCls:'icon-add'" style="width:80px;color:#a10000; position: absolute;right: 0px;margin-top: 12px;" >增加角色</a>  
                </form>
                </div>
               <div class="sysrole_right">
	           <div style="width:95%;margin:10px auto;">
	                 <table cellpadding="0" cellspacing="0" border="0" width="100%">
	                  <tr>
	                	<th class="th_sysrole">角色名称</th>
	                	<th class="th_sysrole">角色描述</th>
	                	<th class="th_sysrole">查看/编辑用户</th>
	                	<th class="th_sysrole">操作</th>
	                 </tr>
	                <s:iterator value="page.result" id="rodo">
	              	  <tr><td colspan="4" height="5"></td></tr>
	              	  <tr>
	                   <td class="td_sysrole"><s:property value="rolename"/></td>
	                	<td class="td_sysrole"><s:if test="#rodo.des==''">&nbsp;</s:if><s:property value="des"/></td>
	                	<td class="td_sysrole">
	                		<img src="<%=basePath %><%=themespath%>/images/jiankongicon.png" onclick="showroleusers('<s:property value='roleid'/>')" style="cursor:pointer;vertical-align: middle;"/>
	                	    <img src="<%=basePath %><%=themespath%>/images/caozuo_03.png" onclick="showeditorusers('<s:property value='roleid'/>')" style="cursor:pointer;vertical-align: middle;"/>
	                	</td>
	                	<td class="td_sysrole" style="border-right:none;"><img src="<%=basePath %><%=themespath%>/images/caozuo_03.png"  onclick="showsysrole('<s:property value='roleid'/>')" style="cursor:pointer;vertical-align: middle;"/>
	                	<img src="<%=basePath %><%=themespath%>/images/caozuo_05.png"  onclick="deletesysrole('<s:property value='roleid'/>')" style="cursor:pointer;vertical-align: middle;"/>
	                	</td>
	              	 </tr>
	                 </s:iterator>
	              </table>
	            </div>  
	             <!-- 分页 --> 
	             <s:if test="totalPage>1">
               <div id="page">
                	<s:if test="totalPage==0"></s:if>
             <s:else>
                  <a href="javascript:toPage(1);">首页</a>
                  <s:if test="pageNo==1"><a href="javascript:;">上一页</a></s:if>
                  <s:else><a href="javascript:toPage(<s:property value="pageNo-1"/>);">上一页</a></s:else>
                  <%--小于12页 --%>
                  <s:if test="pageNo<8">
                    	<s:if test="totalPage<12">
                   			 <s:iterator begin="1" end="totalPage" var="p">
                    			<s:if test="#p==pageNo">
                    				<a href="javascript:toPage(<s:property value="#p"/>);" class="current_page"><s:property value="#p"/></a>
                    			</s:if>
                    			<s:else>
                    				<a href="javascript:toPage(<s:property value="#p"/>);"><s:property value="#p"/></a>
                    			</s:else>
                    		</s:iterator>
                   	   	</s:if>
                    	<s:else>
                    		<s:iterator begin="1" end="12" var="p">
                    			<s:if test="#p==pageNo">
                    				<a href="javascript:toPage(<s:property value="#p"/>);" class="current_page"><s:property value="#p"/></a>
                    			</s:if>
                    			<s:else>
                    				<a href="javascript:toPage(<s:property value="#p"/>);"><s:property value="#p"/></a>
                   				 </s:else>
                  			</s:iterator>
                    	</s:else>
                  </s:if>
                   <%--大于7页 小于12--%>
                   <s:if test="pageNo>7">
                   		<s:if test="totalPage<13">
                   			<s:iterator begin="1" end="totalPage" var="p">
                    			<s:if test="#p==pageNo">
                    				<a href="javascript:toPage(<s:property value="#p"/>);" class="current_page"><s:property value="#p"/></a>
                    			</s:if>
                    			<s:else>
                    				<a href="javascript:toPage(<s:property value="#p"/>);"><s:property value="#p"/></a>
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
                     			<a href="javascript:toPage(${pageNo-ii});" class="current_page">${pageNo+ii }</a>
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
                     			<a href="javascript:toPage(${pageNo-ii});" class="current_page">${pageNo+ii }</a>
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
                    <s:if test="pageNo==totalPage"><a href="javascript:;">下一页</a></s:if>
                    <s:else><a href="javascript:toPage(<s:property value="pageNo+1"/>);">下一页</a></s:else>
                    <a href="javascript:toPage(<s:property value="totalPage"/>);">末页</a>
          </s:else> 
                    <a>共<s:property value="totalPage"/> 页</a>
                </div>  
                </s:if>
            </div>
        </div>
<!--此处内容更替结束-->

            <!-- 弹窗 -->
            <div id="add" class="easyui-window" closed="true" data-options="iconCls:'icon-save'" title="增加角色" style="width:630px;height:500px;left:230px;top:100px;overflow: hidden;">
         	 <div class="sysroleadd">
           <form  id="roleForm">
           		<table >
           			<tr>
	                    <td width="20%">角色名称：</td>
	                    <td width="40%"><input class="userinput" type="text"  name="rolename" value="" id="rolename"></td>
	                    <td width="40%"> </td>
	                </tr>
	                <tr>
	                    <td width="20%">角色描述：</td>
	                    <td width="40%"><input class="userinput" type="text"  name="des" value="" id="des"></td>
	                     <td width="40%"></td>
	                </tr>
	                <tr>
	                    <td width="20%">选择权限：</td>
	                     <td width="40%"></td>
	                      <td width="40%"></td>
	                </tr>
	                <tr>
	                    <td colspan="3" >
	                    	<div style="width:100%;height: 250px;overflow-x:hidden;overflow-y:scroll;">
	                    	<table class="rolepermison" cellpadding="0" cellspacing="0">
	                    		<tr>
	                    			<th>权限编码</td>
	                    			<th>模块名称</td>
	                    			<th>操作权限</td>
	                    			<th>选择</td>
	                    		</tr>
	                    		<s:iterator value="permissionList">
	                    		<tr>
		                    		<td><s:property value="persimoncode"/></td>
	                    			<td><s:property value="modulename"/></td>
	                    			<td><s:property value="opename"/></td>
	                    			<td><input type="checkbox" name="persimoncode" value="<s:property value='persimoncode'/>" /></td>
		                    	</tr>
		                        </s:iterator> 
	                    	</table> 
	                    	</div>
	                    </td>
	                </tr>
	                <tr id="savediv">
	                     <td width="20%"></td>
	                     <td  cosplan="2" style=" position:relative;">
<!-- 	                      <button style="margin-top:20px; position:absolute; left:20px;top:0px;"  type="button" class="button3" id="savesysrole">保存</button>
	                      <button style="margin-top:20px; position:absolute; left:200px;top:0px;" type="button" class="button3" id="cancelsave">取消</button> -->
	               		  <a class='easyui-linkbutton'  data-options="iconCls:'icon-save'" style="line-height: 25px;width: 100px;color:#a10000;margin-top:30px;position:absolute; top:0px;left:40px;" id="savesysrole">保存</a>					
	              		  <a class='easyui-linkbutton'  data-options="iconCls:'icon-cancel'" style="line-height: 25px;width: 100px;color:#a10000;margin-top:30px; position:absolute; left:220px;top:0px;" id="cancelsave">取消</a>		                      
	                      <input type="reset" name="reset" style="display: none;" /></td>
	        
	                </tr>
	                <tr id="updatediv">
	                    <td width="20%"></td>
	                     <td cosplan="2" style=" position:relative;">
<!-- 	                     <button style="margin-top:20px; position:absolute; left:20px;top:0px;"  type="button" class="button3" id="updatesysrole">修改</button>
	                     <button style="margin-top:20px; position:absolute; left:200px;top:0px;" type="button" class="button3" id="cancelupdate">取消</button> -->
	               		  <a class='easyui-linkbutton'  data-options="iconCls:'icon-save'" style="line-height: 25px;width: 100px;color:#a10000;margin-top:30px;position:absolute; top:0px;left:40px;" id="updatesysrole">保存</a>					
	              		  <a class='easyui-linkbutton'  data-options="iconCls:'icon-cancel'" style="line-height: 25px;width: 100px;color:#a10000;margin-top:30px; position:absolute; left:220px;top:0px;" id="cancelupdate">取消</a>		                     
	                      </td>  
	                </tr> 
	            </table>
           </form>
           </div>
        </div>
        <!-- 弹窗 -->
        
		<!-- 弹窗 2-->
		<div id="roleuser" class="easyui-window" closed="true" data-options="iconCls:'icon-save'" title="查看用户" style="width:630px;height:300px;padding:10px;">
		<div class="sysuserscanf">
		<form  id="userForm" action="<%=basePath %>sysrole/selectUserList.action" >
		   		<table id="usertable" cellpadding="0" cellspacing="0" width="90%">
		   			<tr class="jiankong_title" id="titletr">
		             <th>编号：</td>
		             <th>姓名：</td>
		             <th>单位：</td>
		         </tr>
		     </table>
		   </form>
		   </div>
		</div>
		<!-- 弹窗 -->
		
		
        <!-- 弹窗3 -->
       <div id="editoruser" class="easyui-window" closed="true" data-options="iconCls:'icon-save'" title="编辑用户" style="width:630px;height:500px;padding:10px;overflow: hidden;">
    	 <div class="sysroleusertable">
      <form  id="editorUserForm">
      		<table cellpadding="0" cellspacing="0">
      		<tr>
                <td width="20%" >角色名称：</td>
                <td><span id="rolesname"></span></td>
                <td></td>
            </tr>
            <tr>
                <td width="20%">角色用户：</td>
                <td></td>
                <td></td>
            </tr>
             <tr>
                <td width="20%"></td>
                <td style="font-size: 12px;">后台用户</td>
                <td style="font-size: 12px;">已选用户</td>
            </tr>
            <tr>
                <td width="20%"></td>
                <td style="width: 180px;">
                  <select multiple="multiple" id="leftselect" style="width:120px; float: left;" size="8" >
                 	<s:iterator value="list">
                 		<option value="<s:property value='id'/>"><s:property value="truename"></s:property></option>
                     </s:iterator> 
	             </select>  
	             <div style="width:40px;height:60px;position:relative;float:left;margin-left: 15px;">
	    	     	<img src="<%=basePath %><%=themespath%>images/transright.png" id="rightimg" style="cursor: pointer;margin-top: 20px;"/>
	    	        <img src="<%=basePath %><%=themespath%>images/transleft.png" id="leftimg" style="cursor: pointer;margin-top: 20px;"/>
	             </div>
	            </td>
	            <td>
               	    <select multiple="multiple" style="width:120px;float:left;" id="rightselect" size="8" name="usersid">
	             	</select>
	            </td>
            </tr> 
            <tr>
                  <td width="20%"></td>
                  <td cosplan="2" style=" position:relative;">
<!--                   	<button style="margin-top:55px; position:absolute; top:0px;"  type="button" class="button3" id="saveroleuser">保存</button>
                    <button style="margin-top:55px; position:absolute; left:180px;top:0px;" type="button" class="button3" id="cancelupdateuser">取消</button> -->
 	               	<a class='easyui-linkbutton'  data-options="iconCls:'icon-save'" style="line-height: 25px;width: 100px;color:#a10000;margin-top:30px;position:absolute; top:35px;" id="saveroleuser">保存</a>					
	              	<a class='easyui-linkbutton'  data-options="iconCls:'icon-cancel'" style="line-height: 25px;width: 100px;color:#a10000;margin-top:30px; position:absolute; left:190px;top:35px;" id="cancelupdateuser">取消</a>	                   
                  </td>
            </tr>
        </table>
      </form>
      </div>
   </div>
   <!-- 弹窗 -->
</body>
</html>
