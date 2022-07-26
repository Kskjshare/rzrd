<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
 <%@ include file="/public/common.jspf" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">  
<script type="text/javascript" >
	    function jump(locate){
    	    window.location.href=locate;
    	} ;
    	function toPage(page){
            document.getElementById("page").value=page;
            document.getElementById("findForm").submit();
        }
         function deletenotify(id){
             $.messager.confirm("删除提示","<span>确定要删除？</span>",function(data){
                if(data){
   	             var url="absence/delete.action?pageNo=1&pageSize=8&absentid="+id;  
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
		             $.messager.alert("操作提示", "操作失败！","error");   
		          }  
		          }); 
    	         }
    	        })
    	   }
    	 function shownotify(id){
    		   $(".panel-with-icon").html("编辑");
                 var url="<%=basePath%>absence/selectById.action?absentid="+id;  
                $("#hideid").html(id);
   	             $.ajax({
    			  url: url,
                  type: "POST",
		          async: false,  
		          cache: false,  
		          dataType:"json", 
		          success: function (data) {
		             $("#fileName").val(data.filename);
		             $("#title").val(data.title);  
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
    		$("#searchList").click(function(){
    		    document.getElementById("page").value=1;
    			document.getElementById("findForm").submit();
    		});
    	    $("#newAbsence").click(function(){
    	    	$(".panel-with-icon").html("新建");
    	        $("button[name=reset]").trigger("click");
    	        $("#savediv").css("display","block");
    	        $("#updatediv").css("display","none");
    		   $("#add").window("open")
    		    
    	    });
	    	$("#cancelAbsence").click(function(){
	    		$("#add").window("close");
	    	});
	    	$("#cancelupdate").click(function(){
	    		$("#add").window("close");
	    	});
	    	$("#closepush").click(function(){
	    		$("#add").window("close");
	    	});
    	    $("#searchList").click(function(){
    	         document.getElementById("page").value=1;
			     document.getElementById("findForm").submit();
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
	    	$("#modifyabsence").click(function(){
	    	        $("#absentid").val($('#hideid').html());
	    	        $("#pushflag").val("0"); 
				   	 var formData = new FormData($("#uploadForm")[0]);  
				    	 var url="<%=basePath%>absence/update.action";
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
						             $.messager.alert("修改提示",data.msg,"info",function(){
						          		 document.getElementById("findForm").submit();
						          	})
						          },  
						          error: function () {  
						              $.messager.alert("操作提示", "操作失败！","error");   
						          }  
				    		}); 
                                   
	    	           });
	    	$("#modifypush").click(function(){
	    			$("#pushflag").val("1"); 
	    	        $("#absentid").val($('#hideid').html());
				   	 var formData = new FormData($("#uploadForm")[0]);  
				    	 var url="<%=basePath%>absence/update.action";
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
						             $.messager.alert("提示",data.msg,"info",function(){
						          		 document.getElementById("findForm").submit();
						          	})
						          },  
						          error: function () {  
						              $.messager.alert("操作提示", "操作失败！","error");   
						          }  
				    		}); 
                                   
	    	           });
	    	$("#saveAbsence").click(function(){
	    	 	if(!$("#uploadForm").form('enableValidation').form('validate')){
	    	 		return false;
	    	 	};	 
	    	 	var filetext=$("#fileName").val();
						if(filetext.indexOf('.pdf')==-1){
							//$.messager.alert('提示','请选择上传的pdf文件',"info",function(){});
							//return;
						}
	    	 	$("#pushflag").val("0");   	
		    	 var formData = new FormData($("#uploadForm")[0]);  
		    	 var url="<%=basePath%>absence/saveAbsence.action";
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
		    				$("#savediv").css("display","block");
			                $("#updatediv").css("display","none");
	    	});
	            		 $('#fileName').validatebox({
	                       required: true,
	                       missingMessage:'请选择上传文件',
	                     });	
	    	$("#pushAbsence").click(function(){
	    	 	if(!$("#uploadForm").form('enableValidation').form('validate')){
	    	 		return false;
	    	 	};	  
	    	 	var filetext=$("#fileName").val();
						if(filetext.indexOf('.pdf')==-1){
							//$.messager.alert('提示','请选择上传的pdf文件',"info",function(){});
							//return;
						}  	
	    	 	$("#pushflag").val("1");
		    	 var formData = new FormData($("#uploadForm")[0]);  
		    	 var url="<%=basePath%>absence/saveAbsence.action";
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
				             $.messager.alert("提示", "操作失败！","error");   
				          }  
		    		});
		    				$("#savediv").css("display","block");
			                $("#updatediv").css("display","none");
	    	});	                         	
    	})			   	
    	
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
</head>
<body>
    <div >

        <div class="cwh_head">
            出缺勤
        </div>
<!--此处内容更替-->
<!--         <div class="icon_head">
        </div> -->
        <div class="tongzhi">
        <div style="text-align: left;height: 35px;width: 90%;margin: 2px 4%; 10px 4%;">
       	<!--  <button  class="button3" name="" type="button" id="publishnotify" style="margin-left: 15px;">发布通知</button> -->
      		 <a class='easyui-linkbutton'  id="newAbsence"  data-options="iconCls:'icon-add'" style="margin-top:10px;z-index: 9px;margin-left: 15px;width:80px;color:#a10000;" >新建</a>                                	       	 
        </div>        
        <span id="hideid" style="display:none;"></span>
            <div class="tongzhi_head" style="margin:5px 5% 0px 4%">
              <form action="<%=basePath%>absence/selectSearch.action?pageSize=8" id="findForm" method="post">
               <s:hidden name="pageNo" id="page" ></s:hidden>
                <p>标 题：<input class="input" type="text" name="title" value="<s:property value='title'/>"></p>
 <!--                <button  class="button3" name="" type="button" style="position:absolute; left:300px;" id="searchList">查询</button> -->
      		    <a class='easyui-linkbutton'  id="searchList"  data-options="iconCls:'icon-search'" style="margin-top:7px;z-index: 9px;width:80px;color:#a10000;float:left;margin-left: 8px;" >查询</a>                                	       	 
   <!--              <button  class="button3" name="" type="button" style="position:absolute; right:70px;" id="newAbsence">新建</button>   -->
               </form>
            </div>
            <div class="absence_right">
                <div style="width:90%;margin:10px auto;">
                  <table cellpadding="0" cellspacing="0" border="0" width="100%" style="table-layout:fixed;">
                   <tr>
                 	<th class="thfirst_absence">标题</th>
                 	<th class="th_absence">保存时间</th>
                 	<th class="th_absence">最后发布时间</th>
                 	<th class="th_absence">操作</th>
                 </tr>
                 <s:iterator value="page.result" id="rodo">
                  <tr><td colspan="9" height="5"></td></tr>
               	  <tr>
               	 	<td class="tdfirst_absence" ><a href="javascript:fileOpen('<s:property value="path" />');" style="cursor: hand;" title="<s:property value="title"/>">&nbsp;&nbsp;<s:property value="title"/></a></td>
                 	<td class="td_absence"><s:date name="pubtime" format="yyyy-MM-dd HH:mm"/></td>
                 	<td class="td_absence"><s:if test="#rodo.pushdate==null">&nbsp;</s:if><s:date name="pushdate" format="yyyy-MM-dd HH:mm"/></td>
                 	<td class="td_absence" style="border-right:none;"><img src="<%=basePath %><%=themespath%>/images/caozuo_03.png"  onclick="shownotify('<s:property value="absentid"/>')" style="cursor:pointer;vertical-align: middle;"/>
                 	<img src="<%=basePath %><%=themespath%>/images/caozuo_05.png"  onclick="deletenotify('<s:property value="absentid"/>')" style="cursor:pointer;vertical-align: middle;"/>
                    </td>
                  </s:iterator>
               </tr>
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
        </form>               
            </div>           
        </div>
        <div id="add" class="easyui-window" closed="true" data-options="iconCls:'icon-save'" title="新建" style="width:630px;height:300px;">
 <!-- 新建弹出框 -->
         	 <div class="popabsence">
           <form method="POST" id="uploadForm" enctype="multipart/form-data">
           		<table>
           			<tr><td colspan="3" height="10"></td></tr>
           			<tr>
           			<s:hidden name="absentid" id="absentid" ></s:hidden>
           			<s:hidden name="pushflag" id="pushflag" ></s:hidden>
	                    <td class="poptitle" style="font-size: 14px;width: 100px;">出缺勤文件：</td>
	                    <td><input class="input" type="text" name="fileName" value="" id="fileName" readonly="readonly" style="font-size: 14px;width: 190px;"></td>                
	                   <!--  <td><button type="button" class="button3" id="buttonUpload">上传</button> -->
	     	            <td><a class='easyui-linkbutton' id="buttonUpload"  style="line-height: 25px;width: 80px;color:#a10000;margin-left:10px;" data-options="iconCls:'icon-upload'">上传</a>	                    	                    	                                  
	                    	<div style="display: none"><input type="file" name="file" value="" id="absenceUpload"></div>
	                    </td>
	                </tr>
	                <tr style="display:none;">
	                    <td class="poptitle">名称：</td>
	                    <td colspan="2"><input  class="input" type="text" name="title" value="" id="title"></td>
	                </tr>
	                <tr id="savediv">
	                	<td colspan="3">
<!-- 	                		<button style="margin-top:40px; margin-left:105px;" type="button" class="button3" id="saveAbsence">确定</button>
	                		<button style="margin-top:40px; margin-left:20px;" type="button" class="button3" id="cancelAbsence">取消</button> -->
	       					<a class='easyui-linkbutton'  data-options="iconCls:'icon-ok'" style="line-height: 25px;width: 115px;color:#a10000;margin-top:40px; " id="saveAbsence">保存</a>	
	       			    	<a class='easyui-linkbutton'  data-options="iconCls:'icon-push'" style="line-height: 25px;width: 115px;color:#a10000;margin-top:40px; margin-left:30px;" id="pushAbsence">保存并发布</a>			       				
	       					<a class='easyui-linkbutton'  data-options="iconCls:'icon-cancel'" style="line-height: 25px;width: 115px;color:#a10000;margin-top:40px; margin-left:20px;" id="cancelAbsence">取消</a>		                		
	                		<button type="reset" name="reset" style="display: none;"></button>
	                	</td>
	                 <tr  id="updatediv">
 	                	<td colspan="3">
 	                	<!--<button style="margin-top:15px; margin-left:100px;" type="button" class="button3" id="modifyabsence" >修改</button>
	                	<button style="margin-top:15px; margin-left:40px;" type="button" class="button3" id="cancelupdate">取消</button> -->
	       				<a class='easyui-linkbutton'  data-options="iconCls:'icon-ok'" style="line-height: 25px;width: 115px;color:#a10000;margin-top:40px; " id="modifyabsence">保存</a>	
	       				<a class='easyui-linkbutton'  data-options="iconCls:'icon-push'" style="line-height: 25px;width: 115px;color:#a10000;margin-top:40px; margin-left:30px;" id="modifypush">保存并发布</a>			       				
	       				<a class='easyui-linkbutton'  data-options="iconCls:'icon-cancel'" style="line-height: 25px;width: 115px;color:#a10000;margin-top:40px; margin-left:20px;" id="cancelupdate">取消</a>		                	
	                	<button type="reset" name="reset" style="display: none;"></button>
	                	</td>
	                </tr>	
	            </table>
           </form>
           </div>
             <!-- 弹出框结束 -->
        </div>
<!--此处内容更替结束-->
    </div>
</body>
</html>
