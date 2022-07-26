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
function deletesyshelp(id){
    $.messager.confirm("删除提示","<span>确定要删除？</span>",function(data){
       if(data){
         var url="ssyhelp/delete.action?pageNo=1&pageSize=8&id="+id;  
         $.ajax({
			  url: url,
	          type: "POST",  
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
   
function showsyshelp(id){
$("#hideid").html(id);
var url="<%=basePath %>syshelp/selectById.action?id="+id;  
        $.ajax({
	        url: url,
	        type: "POST",
		    success: function (data) { 
		    	$("#title").val(data.title);
                $("#filetype").val(data.filetype);
                $("#fileName").val(data.filename);
		    },  
	        error: function () {   
	        }  
       }); 
	   $("#savediv").css("display","none");
       $("#updatediv").css("display","block");
       $(".panel-with-icon").html("编辑");
       $("#add").window("open");
}

$(function () {
 $("#select").val($("#hidetype").html());
    $("#select").change(function(){  
 		    document.getElementById("page").value=1;
 			document.getElementById("findForm").submit();
    });
   	$("#buttonUpload").click(function(){
   		$("#helpUpload").click();
   	});
    $("#helpUpload").change(function(){
 	   var a=$("#helpUpload").val();
 	   if(a.indexOf("\\")>0){
 		a=a.substring(a.lastIndexOf("\\")+1)
 	   }
        $("#fileName").val(a);
        $("#title").val(a.substring(0,a.lastIndexOf(".")));
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
 		$(".panel-with-icon").html("新建");
 	    $("input[name=reset]").trigger("click");
 	    $("#fileName").val("");
 	    $("#title").val("");
	    $("#updatediv").css("display","none");
	    $("#savediv").css("display","block");
		$("#add").window("open");
	});
	$("#savehelp").click(function(){ 
		 if(!$("#helpForm").form('enableValidation').form('validate')){
	    	 	return false;
	     }; 
	     var filetext=$("#fileName").val();
						if(filetext.indexOf('.pdf')==-1){
							//$.messager.alert('提示','请选择上传的pdf文件',"info",function(){});
							//return;
						}
    	 var url="<%=basePath %>syshelp/saveHelpInfo.action";
    	 var formData = new FormData($("#helpForm")[0]); 
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
   	});
	$("#updatehelp").click(function(){ 
 		 if(!$("#helpForm").form('enableValidation').form('validate')){
	    	 	return false;
	     };
	     var id=$('#hideid').html();
    	 var url="<%=basePath %>syshelp/updateHelpInfo.action?id="+id;
    	 var formData = new FormData($("#helpForm")[0]); 
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
	$.extend($.fn.validatebox.defaults.rules, {
       equalTo: {
           validator:function(value,param){
           if($("#checkcode").html()!=value){
           var flag=true;
            var url="<%=basePath %>sysdictdata/checkdictdaratype.action?type="+$('#type').val()+"&code="+value;
	        $.ajax({
		        url: url,
		        type: "POST",
			    async: false,  
			    cache: false,  
			    contentType: false,  
			    processData: false,  
			    success: function (data) { 
					if(data.msg==1){
					  flag=false;
					};	
			    },  
		        error: function () {   
		        }  
	       }); 
           var flag2=true;
           if(value>1&&value<99){
               flag2=true;
           }else{
               flag2=false;
           }
              return  flag&&flag2;
              }else{
              return true;
              }
           },
           message:'(1-99)不允许重复'
      },
	 });
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
     $('#fileName').validatebox({
             required: true,
             missingMessage:'请选择上传文件',
	});		
});

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
             帮助维护
            </div>
            <div class="tongzhi_main" style="margin-top:10px;">
              <div class="tongzhi_head">
                <span id="hideid" style="display:none;"></span>
                <form action="<%=basePath%>syshelp/selectAllHelpList.action?pageSize=8" id="findForm" method="post">
	                 <s:hidden name="pageNo" id="page" ></s:hidden>     
	                 <div style="display:none" id="hidetype"><s:property value='type'/></div>
	                 <p style="font-size: 16px;margin-top: 5px;margin-left: 0px;">选择帮助文件类别：<select style=" height:25px; margin:5px;width:150px;height:30px;font-size:16px;border: 2px solid #ccc;" name="type" id="select">
                       <option value="">全部</option>
                          <option value="1">人大系统</option>
                          <option value="2">Pad端</option>
                      </select>
                      </p>  	                   
                <!-- <button  class="button3" name="" id="newsysuser" type="button" style="position:absolute; right:0px;">新建</button> -->
                <a class='easyui-linkbutton'  id="newsysuser"  data-options="iconCls:'icon-add'" style="width:100px;color:#a10000; position: absolute;right: 0px;margin-top: 12px;" >新建</a>    
                </form>
                </div>
               <div class="sysuser_right">
	           <div style="width:95%;margin:10px auto;">
	                 <table cellpadding="0" cellspacing="0" border="0" width="100%">
	                  <tr>
	                	<th class="th_sysuser" width="10%">序号</th>
	                	<th class="th_sysuser" width="60%">文件名称</th>
	                	<th class="th_sysuser" width="20%">文件类别</th>   
	                	<th class="th_sysuser" width="10%">操作</th>
	                 </tr>
	                <s:iterator value="page.result" id="stat" var="rodo">
	              	  <tr><td colspan="5" height="5"></td></tr>
	              	  <tr>
	                   <td class="td_sysuser" ><s:property value="id"/></td>
	                	<td class="td_sysuser" style="text-align: left;"><a href="javascript:fileOpen('<s:property value="filepath" />');" title="<s:property value="title"/>">
	                	<s:if test="%{#rodo.title.length()>35}"> 
				    		<s:property value="%{#rodo.title.substring(0,35)}" />...
						</s:if>
						<s:else> 
							<s:property value="title" />
						</s:else>	
	                	</a></td>	
                     	<td class="td_sysuser"><s:if test="#rodo.filetype==1">人大系统</s:if>
                     	<s:if test="#rodo.filetype==2">Pad端</s:if>
                     	</td>
	                	<td class="td_sysuser" style="border-right:none;"><img src="<%=basePath %><%=themespath%>/images/caozuo_03.png"  onclick="showsyshelp('<s:property value="id"/>')" style="cursor:pointer;vertical-align: middle;"/>
	                	<img src="<%=basePath %><%=themespath%>/images/caozuo_05.png"  onclick="deletesyshelp('<s:property value='id'/>')" style="cursor:pointer;vertical-align: middle;"/>
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

  <!-- 新建弹出框 -->
          <div id="add" class="easyui-window" closed="true" data-options="iconCls:'icon-save'" title="新建" style="width:630px;height:300px;">
         	<div class="popabsence">
           <form method="POST" id="helpForm" enctype="multipart/form-data">
           		<table>
					<tr><td colspan="3" height="5"></td></tr>
           			<tr>
           			    <s:hidden name="title" id="title"/>
           				<td class="poptitle" style="font-size: 12px;width: 100px;">文件类别：</td>
           				<td><select name="filetype" style=" margin:2px;height:25px; width:152px;line-height:25px;font-size:12px;border: 2px solid #ccc;" id="filetype">
           					<option value="1" selected="selected">人大系统</option>
           					<option value="2">Pad端</option>
           					</select>
           				</td>
           			</tr>
           			<tr>
	                    <td class="poptitle" style="font-size: 12px;width: 100px;">帮助文件：</td>
	                    <td><input class="input" type="text" name="fileName" value="" id="fileName" readonly="readonly" style="font-size: 12px;width: 152px; height: 25px;line-height: 25px;"></td>                
	                    <td><!-- <button type="button" class="button3" id="buttonUpload">上传</button> -->
	               		    <a class='easyui-linkbutton'  data-options="iconCls:'icon-upload'" style="line-height: 25px;width: 100px;color:#a10000;" id="buttonUpload">上传</a>					
	                    	<div style="display: none"><input type="file" name="file" value="" id="helpUpload"></div>
	                    </td>
	                </tr>
	                <tr id="savediv">
	                	<td colspan="3">
<!-- 	                		<button style="margin-top:30px; margin-left:105px;" type="button" class="button3" id="savehelp">确定</button>
	                		<button style="margin-top:30px; margin-left:20px;" type="button" class="button3" id="cancelsave">取消</button> -->
	               		    <a class='easyui-linkbutton'  data-options="iconCls:'icon-save'" style="line-height: 25px;width: 100px;color:#a10000;margin-top:30px; margin-left:105px;" id="savehelp">保存</a>					
	              		    <a class='easyui-linkbutton'  data-options="iconCls:'icon-cancel'" style="line-height: 25px;width: 100px;color:#a10000;margin-top:30px; margin-left:20px;" id="cancelsave">取消</a>	                		
	                		<button type="reset" name="reset" style="display: none;"></button>
	                	</td>
	                 <tr  id="updatediv">
	                	<td colspan="3">
<!-- 	                	<button style="margin-top:30px; margin-left:100px;" type="button" class="button3" id="updatehelp" >修改</button>
	                	<button style="margin-top:15px; margin-left:30px;" type="button" class="button3" id="cancelupdate">取消</button> -->
	               		<a class='easyui-linkbutton'  data-options="iconCls:'icon-save'" style="line-height: 25px;width: 100px;color:#a10000;margin-top:30px; margin-left:105px;" id="updatehelp">保存</a>					
	              		<a class='easyui-linkbutton'  data-options="iconCls:'icon-cancel'" style="line-height: 25px;width: 100px;color:#a10000;margin-top:30px; margin-left:20px;" id="cancelupdate">取消</a>		                	
	                	<button type="reset" name="reset" style="display: none;"></button>
	                	</td>
	                </tr>	
	            </table>
           </form>
           </div>
             <!-- 弹出框结束 -->

</body>
</html>
