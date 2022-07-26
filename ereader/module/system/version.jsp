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

function showsysuser(id){
$("#hideid").html(id);
var url="<%=basePath %>sysversion/selectById.action?pageNo=1&pageSize=8&versionid="+id;  
        $.ajax({
	        url: url,
	        type: "POST",
		    async: false,  
		    cache: false,  
		    contentType: false,  
		    processData: false,  
		    success: function (data) {  
		    	$("#versionnum").val(data.versionnum);
		    	$("#upcontent").val(data.upcontent);
                $("#filetype").val(data.filetype);
                $("#filetext").val(data.filename);
		    },  
	        error: function () {   
	        }  
       }); 
	   $("#savediv").css("display","none");
       $("#updatediv").css("display","block");
	   $(".panel-with-icon").html("编辑版本");
       $("#add").window("open");
}
function deletesysuser(id){
	       $.messager.confirm("删除提示","<span>确定要删除？</span>",function(data){
	       if(data){
	        var url="<%=basePath %>sysversion/delete.action?pageNo=1&pageSize=8&versionid="+id;  
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
		         $.messager.alert("操作提示","操作失败","error");    
		        }  
	       }); 
	   	  }
		 });
}
$(function () {
   	$("#buttonupload").click(function(){
   		$("#upload").click();
   	});
   	$("#upload").change(function(){
   	var a=$("#upload").val();
   	if(a.indexOf("\\")>0){
   		a=a.substring(a.lastIndexOf("\\")+1)
   	}
          $("#filetext").val(a);
          $("#filename").val(a.substring(0,a.lastIndexOf('.')));
   	});
    $("#select").val($("#hideusertype").html());
    $("#searchList").click(function(){  
 		    document.getElementById("page").value=1;
 			document.getElementById("findForm").submit();
    });
    $("#cancelsave").click( function() {
		$('#add').window("close");
	});
	$("#cancelupdate").click( function() {
		$('#add').window("close");
	});
	$("#cancel").click( function() {
		$('#add').window("close");
	});
	$("#closepush").click(function(){
	    $('#add').window("close");
	});
 	$("#newsysuser").click(function(){
 		$(".panel-with-icon").html("新增版本");
 	    $("input[name=reset]").trigger("click"); 	    
	    $("#updatediv").css("display","none");
	    $("#savediv").css("display","block");
		$("#add").window("open");
	});
	$("#saveversion").click(function(){ 
		 if(!$("#versionForm").form('enableValidation').form('validate')){
	    	 	return false;
	     };
	   	 var formData = new FormData($("#versionForm")[0]); 
    	 var url="<%=basePath %>sysversion/saveVersion.action";
    		$.ajax({
    			  url: url,
                  type: "POST",
		          data: formData,  
		          async: false,  
		          cache: false,  
		          contentType: false,  
		          processData: false, 
		          success: function (data) { 
		             $('#add').window("close");
                     $.messager.alert("新增提示",data.msg,"info",function(){
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
	$("#updateversion").click(function(){ 
		 if(!$("#versionForm").form('enableValidation').form('validate')){
	    	 	return false;
	     };
	     var id=$('#hideid').html();
	     var formData = new FormData($("#versionForm")[0]); 
    	 var url="<%=basePath %>sysversion/updateVersion.action?versionid="+id;
    		$.ajax({
    			  url: url,
                  type: "POST",
		          data: formData,  
			      async: false,  
			      cache: false,  
			      contentType: false,  
			   	  processData: false,  
		          success: function (data) { 
		             $('#add').window("close"); 	
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
     $('#versionnum').validatebox({
             required: true,
             missingMessage:'请输入版本号',
	});	
     $('#filename').validatebox({
             required: true,
             missingMessage:'请选择上传文件',
	});	
     $('#upcontent').validatebox({
             required: true,
             missingMessage:'请输入更新内容',
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
               版本管理
            </div>
            <div class="tongzhi_main" style="margin-top:10px;">
              <div class="tongzhi_head">
                <span id="hideid" style="display:none;"></span>
                <form action="<%=basePath%>sysversion/selectVersionList.action?pageSize=8" id="findForm" method="post">
	                 <s:hidden name="pageNo" id="page" ></s:hidden>
	                 <div style="display:none" id="hideusertype"><s:property value='usertype'/></div>
	                 <p style="margin-left: 0px;font-size: 16px;">版本号：
                      <input  type="text" name="versionnum" value='<s:property value='versionnum'/>' id="searchtitle" class="input"  style="font-size: 16px;"/>
                      </p>
	                  <p style="margin-left:5px;font-size: 16px;">型号：<input  type="text" name="filetype" value='<s:property value='filetype'/>' id="searchtitle" class="input" style="font-size: 16px;"/>
	                  <!-- <button style="margin-left: 0px;"  class="button3" name="" type="button"  id="searchList" >查询</button> -->
    		    	  <a class='easyui-linkbutton'  id="searchList"  data-options="iconCls:'icon-search'" style="width:80px;color:#a10000;margin-left: 8px;" >查询</a>                                	       	 
	                  
	                  </p>
	            <a class='easyui-linkbutton'  id="newsysuser"  data-options="iconCls:'icon-add'" style="width:80px;color:#a10000; position: absolute;right: 0px;margin-top: 9px;" >新增版本</a>  
                <!-- <button  class="button3" name="" id="newsysuser" type="button" style="position:absolute; right:0px;">新增版本</button> -->
                </form>
                </div>
               <div class="sysuser_right">
	           <div style="width:95%;margin:10px auto;">
	                 <table cellpadding="0" cellspacing="0" border="0" width="100%">
	                  <tr>
	                	<th class="th_sysuser" width="45%">更新内容</th>
	                	<th class="th_sysuser" width="10%">型号</th>
	                	<th class="th_sysuser" width="10%">版本号</th>
	                	<th class="th_sysuser" width="15%">创建时间</th>	                	
	                	<th class="th_sysuser" width="10%">操作</th>
	                 </tr>
	                <s:iterator value="page.result" id="stat">
	              	  <tr><td colspan="5" height="5"></td></tr>
	              	  <tr>
	                   <td class="td_sysuser" width="45%"><s:property value="upcontent"/></td>
	                	<td class="td_sysuser" width="10"><s:property value="filetype"/></td>	
                     	<td class="td_sysuser" width="10%"><s:property value="versionnum"/></td>
                     	<td class="td_sysuser" width="15%"><s:date name="createtime" format="yyyy-MM-dd HH:mm"/></td>                  	
	                	<td class="td_sysuser" style="border-right:none;" width="10%"><img src="<%=basePath %><%=themespath%>/images/caozuo_03.png"  onclick="showsysuser('<s:property value="id"/>')" style="cursor:pointer;vertical-align: middle;"/>
	                	<img src="<%=basePath %><%=themespath%>/images/caozuo_05.png"  onclick="deletesysuser('<s:property value="id"/>')" style="cursor:pointer;vertical-align: middle;"/>
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
   <div id="add" class="easyui-window" closed="true" data-options="iconCls:'icon-save'" title="新增版本" style="width:630px;height:500px;overflow:hidden">
 	 <div class="sysversiontable">
	   <form id="versionForm">
	   	<table >
	   		    <tr>
	                <td width="25%">版本号：</td>
	                <td colspan="2"><input class="userinput"  type="text" name="versionnum" value="" id="versionnum" style="width:260px;"></td>
	            </tr>
	            <tr><td colspan="3" height="10"></td></tr>
	   		    <tr>
	                <td width="25%" style="vertical-align: middle;">更新内容：</td>
	                <td colspan="2"><textarea cols="34" rows="5"  style="resize: none;border: 1px solid #aaa;font-size: 14px;" name="upcontent" id="upcontent" class="easyui-validatebox"  data-options="required:true"></textarea></td>
	            </tr>
	            <tr><td colspan="3" height="10"></td></tr>
	            <tr>
	             	<td width="25%">文件类型：</td>
	             	<td colspan="2">
	             		<select  name="filetype" style="height:25px;width: 152px;border: 2px solid #ccc;" id="filetype">
	                    	<option  value="ANDROID" >ANDROID</option>
	                    </select>
	             	</td>
	            </tr>
	            <tr><td colspan="3" height="10"></td></tr>
	            <tr>
	             	<td width="25%">上传文件：</td>
	             	<td><input  type="text" name="filename" value="" id="filetext"  readonly="readonly" class="easyui-validatebox" missingMessage="请选择上传文件" data-options="required:true" style="height:25px;line-height:25px;width: 152px;border: 2px solid #ccc;vertical-align: middle;"></td>
	                <td><!-- <button type="button" class="button3" id="buttonupload">上传</button> -->
	                    <a class='easyui-linkbutton'  data-options="iconCls:'icon-upload'" style="line-height: 25px;width:80px;color:#a10000;"  id="buttonupload">上传</a>					
	                    <div style="display: none"><input type="file" name="file" value="" id="upload"></div>
	                </td>
	            </tr>	            
	            <tr><td colspan="3" height="10"></td></tr>            
	            <tr id="savediv">
	        	   <td width="25%"></td>
	               <td colspan="2" style=" position:relative;">
<!-- 	               <button style="margin-top:40px; position:absolute; top:0px;left:30px;"  type="button" class="button3" id="saveversion">保存</button> 
	               <button style="margin-top:40px; position:absolute; left:230px;top:0px;" type="button" class="button3" id="cancelsave">取消</button> -->
	               <a class='easyui-linkbutton'  data-options="iconCls:'icon-save'" style="line-height: 25px;width: 100px;color:#a10000;margin-top:40px;position:absolute; top:0px;left:80px;" id="saveversion">保存</a>					
	               <a class='easyui-linkbutton'  data-options="iconCls:'icon-cancel'" style="line-height: 25px;width: 100px;color:#a10000;margin-top:40px; position:absolute; left:220px;top:0px;" id="cancelsave">取消</a>		               
	               <input type="reset" name="reset" style="display: none;" /></td>
	            </tr>
	            <tr id="updatediv">
	        	   <td width="25%"></td>
	               <td colspan="2" style=" position:relative;">
<!-- 	               <button style="margin-top:40px; position:absolute; top:0px;left:30px;"  type="button" class="button3" id="updateversion">保存</button>
	               <button style="margin-top:40px; position:absolute; left:230px;top:0px;" type="button" class="button3" id="cancelupdate">取消</button> -->
	               <a class='easyui-linkbutton'  data-options="iconCls:'icon-save'" style="line-height: 25px;width: 100px;color:#a10000;margin-top:40px;position:absolute; top:0px;left:80px;" id="updateversion">保存</a>					
	               <a class='easyui-linkbutton'  data-options="iconCls:'icon-cancel'" style="line-height: 25px;width: 100px;color:#a10000;margin-top:40px; position:absolute; left:220px;top:0px;" id="cancelupdate">取消</a>	               
	               <input type="reset" name="reset" style="display: none;" /></td>
	            </tr>	            
	     </table>
	   </form>
   </div>
</div>
        <!-- 弹窗 -->

</body>
</html>
