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
function showsysuser(id,username){
$("#hideid").html(id);
$("#destory").attr("disabled",false);
var url="<%=basePath %>sysuser/selectById.action?pageNo=1&pageSize=6&userid="+id;  
        $.ajax({
	        url: url,
	        type: "POST",
		    async: false,  
		    cache: false,  
		    contentType: false,  
		    processData: false,  
		    success: function (data) { 
		        //$("#username").attr("disabled",true);
		        //$("#username").validatebox('remove'); 
		    	$("#truename").val(data.truename);
		    	$("#passwd").val(data.passwd);
		    	$("#repasswd").val(data.passwd);
		    	$("#username").val(data.username);
		    	$("#hidemyusername").html(data.username);
		    	$("#tel").val(data.tel);
		    	$("#hideimeinum").html(data.tel);
		    	$("#email").val(data.email);
		    	$("#phone2").val(data.padmobile);
		    	$("#hidemobile").html(data.padmobile);
		    	$("#phone3").val(data.officetel);
		    	$("#zhiwu").val(data.zhiwu);
		    	$("#danwei").val(data.danwei);
		    	$("#phone2").attr("disabled",false);
		    	if(data.sex=='0'){
		    		$("#nan").attr("selected",true);
		    	}else{
		    		$("#nv").attr("selected",true);
		    	}
		    	if(data.isdestroy=='0'){
		    		$("#notdestroy").attr("selected",true);
		    	}else{
		    		$("#isdestroy").attr("selected",true);
		    	}
		    	if(data.usertype=='1'){
		    		$("#sysadmin").attr("selected",true);
		    		$("#passwd").attr("disabled",false);
		    		$("#repasswd").attr("disabled",false);
		    		$("#nameinfo").html("");
 	                $("#passwdinfo").html("");
 	               // $("#phone2").unbind('keyup');
		    	}else if(data.usertype=='2'){
		    		$("#backadmin").attr("selected",true);
		    		$("#passwd").attr("disabled",false);
		    		$("#repasswd").attr("disabled",false);
		    		$("#nameinfo").html("");
 	                $("#passwdinfo").html("");
 	              //  $("#phone2").unbind('keyup');
		    	}else{
		    	    //$("#nameinfo").html("(用户名默认PAD手机号码)");
 	                $("#passwdinfo").html("(PAD端为默认密码)");
/*  	                $("#phone2").bind('keyup',function(){
              			$("#username").val($("#phone2").val());
              		});	 */
		    		$("#padadmin").attr("selected",true);
		    		$("#passwd").attr("disabled",true);
		    		$("#repasswd").attr("disabled",true);
		    		$("#phone2").validatebox('remove'); 
				    $("#phone2").validatebox({  
				   		 required: true, 
				         validType: ['mymobile',"mobileexist[$('#hidemobile').html()]"],
				    }); 
		    	} 
		    	$("#usertype").attr("disabled",true);
		    },  
	        error: function () {   
	        }  
       }); 
       if(username=='padpush'||username=='admin'){
       	$("#phone2").validatebox('remove'); 
       	$("#phone2").attr("disabled",true);
       }
	   $("#savediv").css("display","none");
       $("#updatediv").css("display","block");
       $(".panel-with-icon").html("编辑用户");
       $("#add").window("open");
       
}
function uploadTXL(){
	$("#hideupload").click();
}
function saveUpload(){
	if(!$("#uploadForm").form('enableValidation').form('validate')){
	 		return false;
	 	}; 
	var formData = new FormData($("#uploadForm")[0]);  
		var url="<%=basePath%>sysuser/autoImportUser.action";
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
function cancelUpload(){
	$('#addYH').window('close');
}
function importcontent(){
	$(".panel-with-icon").html("导入用户");
	$("button[name=reset]").trigger("click");
	$('#addYH').window('open');
}
function changeFileName(){
	   var a=$("#hideupload").val();
	   if(a.indexOf("\\")>0){
		a=a.substring(a.lastIndexOf("\\")+1)
	   }
    $("#fileName").val(a);
}; 
function deletesysuser(id,username){
	   if(username=='admin'){
	   		$.messager.alert("删除提示", "<span>此系统用户不能被删除！</span>","warning"); 
	   }else if(username=='padpush'){
	   		$.messager.alert("删除提示", "<span>此用户不能被删除！</span>","warning"); 
	   }else{
	       $.messager.confirm("删除提示","<span>确定要删除？</span>",function(data){
	       if(data){
	        var url="<%=basePath %>sysuser/delete.action?pageNo=1&pageSize=6&userid="+id;  
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
}
$(function () {
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
 		 $(".panel-with-icon").html("新增用户");
 	   $("button[name=reset]").trigger("click");
 	   //$("#phone2").unbind('keyup');
 	   $("#usertype").attr("disabled",false);
 	   $("#phone2").attr("disabled",false);
 	   $("#usertype").val("3");
 	   $("#hidemobile").html("");
 	   $("#hideimeinum").html("");
 	   $("#hidemyusername").html("");
 	   $("#phone2").validatebox('remove'); 	    	      
       $("#passwd").validatebox('reduce');
       $("#repasswd").validatebox('reduce');		       
	   $("#updatediv").css("display","none");
	   $("#savediv").css("display","block");
       $("#destory").attr("disabled",true);
      // $("#nameinfo").html("(用户名默认PAD手机号码)");
 	   $("#passwdinfo").html("(PAD端为默认密码)");
       $('#phone2').validatebox({
               required: true,
               validType: ['mymobile',"mobileexist[$('#hidemobile').html()]"],
               missingMessage:'请输入手机号码',
         });
		$('#tel').validatebox({
		    required: true,
        	validType:['tellength',"padimeiexist[$('#hideimeinum').html()]"],
        	missingMessage:'请输入平板IMEI号码',
		});
       $("#passwd").val('1');
       $("#repasswd").val('1');
       $("#passwd").attr("disabled",true);
       $("#repasswd").attr("disabled",true);
       $("#passwd").validatebox('remove');
       $("#repasswd").validatebox('remove');
      // $("#username").attr("disabled",true);	
/*        $("#phone2").bind('keyup',function(){
             $("#username").val($("#phone2").val());
        });	 */
      //  $("#username").validatebox('remove');
/*               if($("#phone2").val().trim()!=null){
                   $("#username").val($("#phone2").val());
              }	  */   
		$("#add").window("open");
	});
	$("#savesysuser").click(function(){ 
	     if($("#usertype").val()=='3'){
	        $("#passwd").validatebox('remove');
	        $("#repasswd").validatebox('remove');
	     }else{
	     	$("#passwd").validatebox('reduce');
	        $("#repasswd").validatebox('reduce');
	     }
		 if(!$("#userForm").form('enableValidation').form('validate')){
	    	 	return false;
	     };	 
	     $("#passwd").attr("disabled",false);
	     $("#repasswd").attr("disabled",false);
	     $("#username").attr("disabled",false);
	     $("#destory").attr("disabled",false);    
    	 var url="<%=basePath %>sysuser/saveUser.action";
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
       
   	});
	$("#updatesysuser").click(function(){ 
		 if($("#hidemobile").html()== $("#phone2").val()){
	     	$("#phone2").validatebox('remove');
	     }
 		 if($("#hideimeinum").html()== $("#tel").val()){
	     	$("#tel").validatebox('remove');
	     } 
		 if($("#hidemyusername").html()== $("#username").val()){
	     	$("#username").validatebox('remove');
	     }
	     if($("#usertype").val()=='3'){
	        $("#passwd").validatebox('remove');
	        $("#repasswd").validatebox('remove');
	        //$("#nameinfo").html("(用户名默认PAD手机号码)");
 	        $("#passwdinfo").html("(PAD端为默认密码)");
			$('#tel').validatebox({
			    required: true,
	        	validType:['tellength',"padimeiexist[$('#hideimeinum').html()]"],
	        	missingMessage:'请输入平板IMEI号码',
			});
    		 $('#phone2').validatebox({
                 required: true,
                 validType: ['mymobile',"mobileexist[$('#hidemobile').html()]"],
                 missingMessage:'请输入手机号码',
               });
	     }else{
	     	$("#passwd").validatebox('reduce');
	     	$("#tel").validatebox('remove');
	     	$("#phone2").validatebox('remove');
			$('#tel').validatebox({
			    required: false,
	        	validType:['tellength',"padimeiexist[$('#hideimeinum').html()]"],
	        	missingMessage:'请输入平板IMEI号码',
			});
    		 $('#phone2').validatebox({
                 required: false,
                 validType: ['mymobile',"mobileexist[$('#hidemobile').html()]"],
                 missingMessage:'请输入手机号码',
               });     	
	        $("#repasswd").validatebox('reduce');
	     }
	     $("#username").validatebox('reduce');
	      if(!$("#userForm").form('enableValidation').form('validate')){
	    	 	return false;
	     };
	     $("#phone2").attr("disabled",false);
	     $("#passwd").attr("disabled",false);
	     $("#repasswd").attr("disabled",false);
	     $("#usertype").attr("disabled",false);
	     var id=$('#hideid').html();
    	 var url="<%=basePath %>sysuser/updateUser.action?userid="+id;
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
              return $(param[0]).val() == value;
           },
           message:'两次输入密码不匹配'
      },
     mymobile: {validator: function (value, param) {
            return /^1[3|4|5|8|9]\d{9}$/.test(value); },
             message:'请输入正确格式'
     },
     myusername: {validator: function (value, param) {
		    if(value==param){
		    	return true;
		    }
            var flag=true;
            var url="<%=basePath %>sysuser/checkUsername.action?users="+value;
     		$.ajax({
    			  url: url,
                  type: "POST", 
		          async: false,  
		          success: function (data) { 
						if(data.msg=='false'){
							flag=false;
						}
		          },  
		          error: function () {  
		              $.messager.alert("操作提示","操作失败","error");    
		          }      		
     		
     		})
            return flag; },
            message:'此用户名已存在'
     },  
     mobileexist: {validator: function (value, param) {
		    if(value==param){
		    	return true;
		    }
            var flag=true;
            var url="<%=basePath %>sysuser/checkPadmobile.action?padmobile="+value;
     		$.ajax({
    			  url: url,
                  type: "POST", 
		          async: false,  
		          success: function (data) { 
						if(data.msg=='false'){
							flag=false;
						}
		          },  
		          error: function () {  
		              $.messager.alert("操作提示","操作失败","error");    
		          }      		
     		
     		})
            return flag; },
            message:'此手机号码已存在'
     },
     padimeiexist: {validator: function (value, param) {
		    if(value==param){
		    	return true;
		    }
            var flag=true;
            var url="<%=basePath %>sysuser/checkImeiNum.action?imeinum="+value;
     		$.ajax({
    			  url: url,
                  type: "POST", 
		          async: false,  
		          success: function (data) { 
						if(data.msg=='false'){
							flag=false;
						}
		          },  
		          error: function () {  
		              $.messager.alert("操作提示","操作失败","error");    
		          }      		
     		
     		})
            return flag; },
            message:'此平板IMEI号码已存在'
     },
     tellength: {validator: function (value, param) {
         return /^\d{15}$/.test(value); },
          message:'请输入15位数字'
  	}
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
     $('#username').validatebox({
             required: true,
             validType:"myusername[$('#hidemyusername').html()]",
             missingMessage:'请输入用户名',
	});	
     $('#passwd').validatebox({
             required: true,
             missingMessage:'请输入密码',
	});
     $('#repasswd').validatebox({
             required: true,
             validType:"equalTo['#passwd']",
             missingMessage:'请输入确认密码',
	});	
	$('#truename').validatebox({
             required: true,
             missingMessage:'请输入真实姓名',
	});
	$('#tel').validatebox({
		    required: false,
        	validType:['tellength',"padimeiexist[$('#hideimeinum').html()]"],
        	missingMessage:'请输入平板IMEI号码',
	});
     $("#usertype").bind("change", function () {
     if( $("#usertype").val()=='3'){
     	    // $("#nameinfo").html("(用户名默认PAD手机号码)");
 	         $("#passwdinfo").html("(PAD端为默认密码)");
     		 $('#phone2').validatebox({
                required: true,
                validType: ['mymobile',"mobileexist[$('#hidemobile').html()]"],
                missingMessage:'请输入手机号码',
              });
	     	 $('#tel').validatebox({
	    		    required: true,
	            	validType:['tellength',"padimeiexist[$('#hideimeinum').html()]"],
	            	missingMessage:'请输入平板IMEI号码',
	    	  });
              $("#passwd").val('1');
              $("#repasswd").val('1');
              $("#passwd").attr("disabled",true);
              $("#repasswd").attr("disabled",true);
              $("#passwd").validatebox('remove');
              $("#repasswd").validatebox('remove');
              //$("#username").attr("disabled",true);	
/*               $("#phone2").bind('keyup',function(){
              		$("#username").val($("#phone2").val());
              }); */	
             // $("#username").validatebox('remove');
/*               if($("#phone2").val().trim()!=null){
                   $("#username").val($("#phone2").val());
              } */
     }else{
           $("#nameinfo").html("");
 	       $("#passwdinfo").html("");
           //$("#username").attr("disabled",false);	
           //$("#phone2").unbind('keyup');
           $("#username").validatebox('reduce');
           $("#phone2").validatebox('remove');
		   $('#phone2').validatebox({  
		   		 required: false,
		         validType: ['mymobile',"mobileexist[$('#hidemobile').html()]"],
		   });	
		    $("#tel").validatebox('remove');
			$('#tel').validatebox({
			    required: false,
	        	validType:['tellength',"padimeiexist[$('#hideimeinum').html()]"],
	        	missingMessage:'请输入平板IMEI号码',
			});
           $("#passwd").val("");
           $("#repasswd").val("");
           $("#passwd").attr("disabled",false);
           $("#repasswd").attr("disabled",false);	
           $("#passwd").validatebox('reduce');
           $("#repasswd").validatebox('reduce');	   
     
     }

    });	
   $('#phone2').validatebox({ 
   		 required: false, 
         validType: ['mymobile',"mobileexist[$('#hidemobile').html()]"],
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
               用户管理
            </div>
            <div class="tongzhi_main" style="margin-top:10px;">
              <div class="tongzhi_head">
                <span id="hideid" style="display:none;"></span>
                <form action="<%=basePath%>sysuser/selectList.action?pageSize=8" id="findForm" method="post">
	                 <s:hidden name="pageNo" id="page" ></s:hidden>
	                 <div style="display:none" id="hideusertype"><s:property value='usertype'/></div>
	                 <p style="margin-left: 0px;"><select style=" height:25px; margin:5px;width:150px;height:30px;font-size:16px;border: 2px solid #ccc;" name="usertype" id="select">
                       <option value="0">全部</option>
                       <option value="1">系统管理员</option>
                       <option value="2">后台用户</option>
                       <option value="3">PAD端用户</option>
                      </select>
                      </p>
	                  <p style="margin-left:5px;"><input  type="text" name="username" value='<s:property value='username'/>' id="searchtitle"
	                  class="input"  placeholder="名字/手机号/IMEI号码：" border="0" style="color: #333; font-size: 16px; font-family: '微软雅黑';border: 2px solid #ccc;margin-left: 0px;line-height: 25px;w"/>
<!-- 	                  <button style="margin-left: 0px;"  class="button3" name="" type="button"  id="searchList" >查询</button>
 -->      		    	  <a class='easyui-linkbutton'  id="searchList"  data-options="iconCls:'icon-search'" style="width:80px;color:#a10000;margin-left: 8px;" >查询</a>                                	       	 
                              	       	 
	                  </p>
	                  <a class='easyui-linkbutton' id="query_by_name" data-options="iconCls:'icon-textadd'" style="line-height: 25px;width: 100px;color:#a10000;position:absolute; right:99px;top:9px;" onclick="importcontent();">导入用户</a>	  
	                  <a class='easyui-linkbutton'  id="newsysuser"  data-options="iconCls:'icon-add'" style="width:80px;color:#a10000; position: absolute;right: 0px;margin-top: 9px;" >增加用户</a>  
                <!-- <button  class="button3" name="" id="newsysuser" type="button" style="position:absolute; right:0px;">增加用户</button> -->
                </form>
                </div>
               <div class="sysuser_right">
	           <div style="width:95%;margin:5px auto;">
	                 <table cellpadding="0" cellspacing="0" border="0" width="100%">
	                  <tr>
	                	<th class="th_sysuser" width="13%">用户名</th>
	                	<th class="th_sysuser" width="17%">真实姓名</th>
	                	<th class="th_sysuser" width="5%">性别</th>
	                   
	                	<th class="th_sysuser" width="12%">办公电话</th>
	                	<th class="th_sysuser" width="15%">平板IMEI号码</th>
                        <th class="th_sysuser" width="12%">手机号码</th>	                		                		                		                	             		                	
	                	<th class="th_sysuser" width="9%">用户类型</th>
	                	<th class="th_sysuser" width="8%">是否销毁</th>	                	
	                	<th class="th_sysuser" width="8%">操作</th>
	                 </tr>
	                <s:iterator value="page.result" id="stat">
	              	  <tr><td colspan="5" height="5"></td></tr>
	              	  <tr>
	                   <td class="td_sysuser" width="13%"><s:property value="username"/></td>
	                	<td class="td_sysuser" width="17%"><s:property value="truename"/></td>	
                     	<td class="td_sysuser" width="5%"><s:if test='#stat.sex==0'>男</s:if>
                     		<s:if test='#stat.sex==1'>女</s:if>
                     	</td>
                     	                  	
                     	<td class="td_sysuser" width="12%"><s:property value="officetel"/></td>
                     	<td class="td_sysuser" width="15%"><s:property value="tel"/></td> 
                      	<td class="td_sysuser" width="12%"><s:property value="padmobile"/></td>                      	             	               	               	               	                      	
	                	<td class="td_sysuser" width="9%"><s:if test="#stat.usertype==1">系统管理员</s:if>
	                	<s:if test="#stat.usertype==2">后台用户</s:if><s:if test="#stat.usertype==3">PAD端用户</s:if>
	                	</td>
                     	<td class="td_sysuser" width="8%"><s:if test="#stat.isdestroy==1">是</s:if>
                     		<s:if test="#stat.isdestroy==0">否</s:if>
                     	</td> 	                	
	                	<td class="td_sysuser" style="border-right:none;" width="8%"><img src="<%=basePath %><%=themespath%>/images/caozuo_03.png"  onclick="showsysuser('<s:property value="id"/>','<s:property value="username"/>')" style="cursor:pointer;vertical-align: middle;"/>
	                	<img src="<%=basePath %><%=themespath%>/images/caozuo_05.png"  onclick="deletesysuser('<s:property value="id"/>','<s:property value="username"/>')" style="cursor:pointer;vertical-align: middle;"/>
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
		     <div id="addYH" class="easyui-window" closed="true" data-options="iconCls:'icon-save'" title="导入用户" style="width:630px;height:300px;">
         	 <div class="popabsence">
           	<form method="POST" id="uploadForm" enctype="multipart/form-data">
           		<table>
           			<tr><td colspan="3" height="10"></td></tr>
           			<tr>
	                    <td class="poptitle" style="font-size: 14px;width: 100px;">用户文件：</td>
	                    <td><input class="input" type="text" name="fileName" value="" id="fileName" readonly="readonly" style="font-size: 14px;width: 190px;"></td>                
	                    <td><a class='easyui-linkbutton' onclick="uploadTXL()"  style="line-height: 25px;width: 80px;color:#a10000;margin-left:10px;" data-options="iconCls:'icon-upload'">上传</a>	                    	                    	                    	                    
	                    	<div style="display: none"><input type="file" name="file" value="" id="hideupload" onchange="changeFileName()"></div>
	                    </td>
	                </tr>
	                <tr> <td class="poptitle" style="font-size: 14px;width: 100px;">&nbsp;&nbsp;</td>
           				  <td colspan="2" height="10"><a href="<%=basePath %>/upload/userManagement.xls" style="font-family:微软雅黑; color:#a10000;font-size:14px;text-decoration: underline;">文件模板</a></td>	
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
             
            <!-- 弹窗 -->
            <div id="add" class="easyui-window" closed="true" data-options="iconCls:'icon-save'" title="新建用户" style="width:630px;height:550px;left:230px;overflow: hidden;">
         	 <div class="sysusertable">
           <form  id="userForm" autocomplete="off" >
           		<table>
           		 <s:hidden name="pageNo"  />
 	                 <tr>
	                    <td>用户类别：</td>
	                    <td colspan="2"><select  name="entity.usertype" style="height:25px;border: 2px solid #ccc;width: 152px;" id="usertype">
	                    	<option  value="1" id="sysadmin">系统管理员</option>
	                        <option  value="2" id="backadmin">后台用户</option>
	                        <option  value="3" id="padadmin">PAD端用户</option>
	                    </select></td>
	                </tr>
 	                <tr>
	                    <td>用户名：</td>
	                    <td><input class="userinput" type="text"  name="entity.username" value="" id="username" ></td>
	                    <td><div id="nameinfo" style="font-size: 12px;"></div></td>
	                </tr> 
	                <div style="display: none" id="hidemyusername"></div> 
	                 <tr>
	                    <td>手机号码：</td>
	                    <td colspan="2"><input class="userinput"  type="text" name="entity.padmobile" value="" id="phone2" autocomplete="off"></td>
	                </tr> 
	                <div style="display: none" id="hidemobile"></div>   
	                <tr>
	                    <td>平板IMEI号码：</td>
	                    <td colspan="2"><input class="userinput"  type="text" name="entity.tel" value="" id="tel"></td>
	                </tr>	
	                 <div style="display: none" id="hideimeinum"></div>                           		 
	                <tr>
	                    <td>登录密码：</td>
	                    <td><input class="userinput" type="password"  name="entity.passwd" value="" id="passwd" ></td>
	                     <td><div id="passwdinfo" style="font-size: 12px;"></div></td>
	                </tr>
	                <tr>
	                    <td>确认密码：</td>
	                    <td colspan="2"><input class="userinput"  type="password" name="entity.repasswd" value="" id="repasswd" ></td>
	                </tr>
           			<tr>
	                    <td>真实姓名：</td>
	                    <td colspan="2"><input class="userinput" type="text"  name="entity.truename" value="" id="truename" >
	                    </td>
	                </tr>
	                <tr>
	                    <td>性别：</td>
	                    <td colspan="2"><select  name="entity.sex" style="height:25px;border: 2px solid #ccc;width: 152px;">
	                    	<option  value="0" id="nan">男</option>
	                        <option  value="1" id="nv">女</option>
	                    </select></td>
	                </tr>
	                <tr>
	                    <td>单位：</td>
	                    <td colspan="2"><input class="userinput"  type="text" name="entity.danwei" value="" id="danwei"></td>
	                </tr>
	                <tr>
	                    <td>职务：</td>
	                    <td colspan="2"><input class="userinput"  type="text" name="entity.zhiwu" value="" id="zhiwu"> </td>
	                </tr>
	                <tr>
	                    <td>办公电话(内部)：</td>
	                    <td colspan="2"><input class="userinput"  type="text" name="entity.officetel" value="" id="phone3"></td>
	                </tr>
	                <tr>
	                    <td>电子邮箱：</td>
	                    <td colspan="2"><input class="userinput"  type="text" name="entity.email" value="" id="email"></td>
	                </tr>
	                <tr>
	                    <td>是否销毁：</td>
	                    <td colspan="2"><select  name="entity.isdestroy" style="height:25px;width: 152px;border: 2px solid #ccc;" disabled="disabled" id="destory">
	                    	<option  value="0" id="notdestroy">&nbsp;&nbsp;否</option>
	                        <option  value="1" id="isdestroy">&nbsp;&nbsp;是</option>
	                    </select></td>
	                </tr>
	                <tr style="display: none;">
	                    <td></td>
	                    <td colspan="2"><input class="userinput"  type="text" name="entity.isdel" value="0" ></td>
	                </tr>
	                <tr id="savediv">
	                    <td cosplan="3" style=" position:relative;">
<!-- 	                        <button style="margin-top:20px; position:absolute; top:0px;"  type="button" class="button3" id="savesysuser">保存</button>
	                    
	                        <button style="margin-top:20px; position:absolute; left:180px;top:0px;" type="button" class="button3" id="cancelsave">取消</button> -->
	              		    <a class='easyui-linkbutton'  data-options="iconCls:'icon-save'" style="line-height: 25px;width: 100px;color:#a10000;margin-top:20px;position:absolute; top:0px;" id="savesysuser">保存</a>					
	                        <a class='easyui-linkbutton'  data-options="iconCls:'icon-cancel'" style="line-height: 25px;width: 100px;color:#a10000;margin-top:20px; position:absolute; left:180px;top:0px;" id="cancelsave">取消</a>		                        
	                        <button type="reset" name="reset" style="display: none;"></button>
	                    </td> 
	                </tr>
	                <tr id="updatediv">
	                    <td cosplan="3" style=" position:relative;">
<!-- 	                        <button style="margin-top:20px; position:absolute; top:0px;"  type="button" class="button3" id="updatesysuser">保存</button>
	                        <button style="margin-top:20px; position:absolute; left:180px;top:0px;" class="button3" id="cancelupdate">取消</button> -->
	              		    <a class='easyui-linkbutton'  data-options="iconCls:'icon-save'" style="line-height: 25px;width: 100px;color:#a10000;margin-top:20px;position:absolute; top:0px;" id="updatesysuser">保存</a>					
	                        <a class='easyui-linkbutton'  data-options="iconCls:'icon-cancel'" style="line-height: 25px;width: 100px;color:#a10000;margin-top:20px; position:absolute; left:180px;top:0px;" id="cancelupdate">取消</a>		                        
	                        <button type="reset" name="reset" style="display: none;"></button>
	                    </td> 
	                </tr>
	            </table>
           </form>
           </div>
        <!-- 弹窗 -->

</body>
</html>
