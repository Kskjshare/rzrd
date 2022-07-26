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
var url="<%=basePath %>sysdictdata/selectById.action?id="+id;  
        $.ajax({
	        url: url,
	        type: "POST",
		    async: false,  
		    cache: false,  
		    contentType: false,  
		    processData: false,  
		    success: function (data) { 
		    	$("#name").val(data.name);
		    	$("#code").val(data.code);
                $("#type").val(data.type);
                $("#checkcode").html(data.code);
		    },  
	        error: function () {   
	        }  
       }); 
	   $("#savediv").css("display","none");
       $("#updatediv").css("display","block");
       $(".panel-with-icon").html("编辑字典");
       $("#add").window("open");
}

$(function () {
   $("#select").val($("#hidetype").html());
    $("#select").change(function(){  
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
 		$(".panel-with-icon").html("增加字典");
 	    $("input[name=reset]").trigger("click");
 	    $("#name").val("");
		$("#code").val("");
       $("#type").val("");
        $("#checkcode").html("");
	    $("#updatediv").css("display","none");
	    $("#savediv").css("display","block");
		$("#add").window("open");
	});
	$("#savesysuser").click(function(){ 
		 if(!$("#userForm").form('enableValidation').form('validate')){
	    	 	return false;
	     };
	     $("#typename").val($("#type").find("option:selected").text());
    	 var url="<%=basePath %>sysdictdata/saveDictData.action";
    		$.ajax({
    			  url: url,
                  type: "POST",
		          data: $("#userForm").serialize(),  
		          async: false,  
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
		            //document.getElementById("findForm").submit();
       
   	});
	$("#updatesysuser").click(function(){ 
		 if(!$("#userForm").form('enableValidation').form('validate')){
	    	 	return false;
	     };
	      $("#typename").val($("#type").find("option:selected").text());
	     var id=$('#hideid').html();
    	 var url="<%=basePath %>sysdictdata/updateDictData.action?id="+id;
    		$.ajax({
    			  url: url,
                  type: "POST",
		          data: $("#userForm").serialize(),  
		          async: false,  
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
     $('#name').validatebox({
             required: true,
              
             missingMessage:'请输入子项名称',
	});	
     $('#code').validatebox({
             required: true,
             validType:"equalTo",
             missingMessage:'请输入子项编码',
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
               数据字典
            </div>
            <div class="tongzhi_main" style="margin-top:10px;">
              <div class="tongzhi_head">
                <span id="hideid" style="display:none;"></span>
                <form action="<%=basePath%>sysdictdata/selectList.action?pageSize=8" id="findForm" method="post">
	                 <s:hidden name="pageNo" id="page" ></s:hidden>
	                 <div style="display:none" id="hidetype"><s:property value='type'/></div>
	                 <p style="font-size: 16px;margin-top: 5px;margin-left: 0px;">选择字典类别：<select style=" height:25px; margin:5px;width:150px;height:30px;font-size:16px;border: 2px solid #ccc;" name="type" id="select">
                       <option value="">全部</option>
                       <s:iterator value="typelist">
                          <option value="<s:property value="type"/>"><s:property value="typename"/></option>
                       </s:iterator>
                      </select>
                      </p>        
                <!-- <button  class="button3" name="" id="newsysuser" type="button" style="position:absolute; right:0px;">增加字典</button> -->
	            <a class='easyui-linkbutton'  id="newsysuser"  data-options="iconCls:'icon-add'" style="width:100px;color:#a10000; position: absolute;right: 0px;margin-top: 12px;" >增加字典</a>  
                </form>
                </div>
               <div class="sysuser_right">
	           <div style="width:95%;margin:10px auto;">
	                 <table cellpadding="0" cellspacing="0" border="0" width="100%">
	                  <tr>
	                	<th class="th_sysuser" width="10%">序号</th>
	                	<th class="th_sysuser" width="20%">类别名称</th>
	                	<th class="th_sysuser" width="20%">类别编码</th>
	                	<th class="th_sysuser" width="10%">子项编码</th>
	                	<th class="th_sysuser" width="30%">子项名称</th>	   
	                	<th class="th_sysuser" width="10%">操作</th>
	                 </tr>
	                <s:iterator value="page.result" id="stat">
	              	  <tr><td colspan="5" height="5"></td></tr>
	              	  <tr>
	                   <td class="td_sysuser" ><s:property value="id"/></td>
	                	<td class="td_sysuser"><s:property value="typename"/></td>	
                     	<td class="td_sysuser"><s:property value="type"/></td>
 	                	<td class="td_sysuser"><s:property value="code"/></td>                    	
                     	<td class="td_sysuser"><s:property value="name"/></td>
	                	<td class="td_sysuser" style="border-right:none;"><img src="<%=basePath %><%=themespath%>/images/caozuo_03.png"  onclick="showsysuser('<s:property value="id"/>')" style="cursor:pointer;vertical-align: middle;"/>
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
            <div id="add" class="easyui-window" closed="true" data-options="iconCls:'icon-save'" title="增加字典" style="width:630px;height:450px;left:230px;overflow: hidden;">
         	 <div class="sysdicttable">
           <form  id="userForm">
           		<table>
           		 <s:hidden name="pageNo"  />
 	                <tr>
	                    <td>1.选择字典类别：</td>
	                </tr> 
	                <tr>
	                    <td>
	                    	<select style=" height:25px; width:180px;height:25px;font-size:16px;border: 2px solid #ccc;" name="entity.type" id="type">
                       			<s:iterator value="typelist">
                          		<option value="<s:property value="type"/>"><s:property value="typename"/></option>
                       			</s:iterator>
                      		</select>
                        </td>
                         <s:hidden name="entity.typename" id="typename" ></s:hidden>	                	
	                </tr>
	                 <tr>
	                    <td>2.输入子项名称：</td>
	                </tr>              		 
	                <tr>
	                    <td><input class="userinput" type="text"  name="entity.name" value="" id="name" style="width: 180px;"></td>
	                </tr>
	                <tr>
	                    <td>3.输入子项编码：</td>
	                </tr>
           			<tr>
	                    <td><input class="userinput" type="text"  name="entity.code" value="" id="code"  style="width: 180px;">
	                </tr>
	               <div style="display:none" id="checkcode"></div>
	                <tr id="savediv">
	                    <td style=" position:relative;">
<!-- 	                        <button style="margin-top:50px; position:absolute; top:0px;"  type="button" class="button3" id="savesysuser">保存</button>
	                    
	                        <button style="margin-top:50px; position:absolute; left:180px;top:0px;" type="button" class="button3" id="cancelsave">取消</button> -->
	               		    <a class='easyui-linkbutton'  data-options="iconCls:'icon-save'" style="line-height: 25px;width: 100px;color:#a10000;margin-top:50px;position:absolute; top:0px;" id="savesysuser">保存</a>					
	              		    <a class='easyui-linkbutton'  data-options="iconCls:'icon-cancel'" style="line-height: 25px;width: 100px;color:#a10000;margin-top:50px; position:absolute; left:180px;top:0px;" id="cancelsave">取消</a>	                        
	                        
	                        <button type="reset" name="reset" style="display: none;"></button>
	                    </td> 
	                </tr>
	                <tr id="updatediv">
	                    <td  style=" position:relative;">
<!-- 	                        <button style="margin-top:50px; position:absolute; top:0px;"  type="button" class="button3" id="updatesysuser">保存</button>
	                        <button style="margin-top:50px; position:absolute; left:180px;top:0px;" type="button" class="button3" id="cancelupdate">取消</button> -->
	               		    <a class='easyui-linkbutton'  data-options="iconCls:'icon-save'" style="line-height: 25px;width: 100px;color:#a10000;margin-top:50px;position:absolute; top:0px;" id="updatesysuser">保存</a>					
	              		    <a class='easyui-linkbutton'  data-options="iconCls:'icon-cancel'" style="line-height: 25px;width: 100px;color:#a10000;margin-top:50px; position:absolute; left:180px;top:0px;" id="cancelupdate">取消</a>	 	                        
	                        <button type="reset" name="reset" style="display: none;"></button>
	                    </td> 
	                </tr>
	            </table>
           </form>
           </div>

        <!-- 弹窗 -->

</body>
</html>
