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
};

$(function () {
 	$("#newsysuser").click(function(){
 	       if($('input:radio:checked').val()==null||$('input:radio:checked').val()=='undefined'){
 	       	   $.messager.alert("注销提示","请选择一条要注销的会议","error");    
 	       	   return false;
 	       }
	       $.messager.confirm("注销提示","<span>确定要注销？</span>",function(data){
	       if(data){
	        var id=$('input:radio:checked').val();
	        var url="<%=basePath %>sysmeetmaintain/deleteMeet.action?meetid="+id;  
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
               会议维护
            </div>
            <div class="tongzhi_main" style="margin-top:10px;">
              <div class="tongzhi_head">
                <form action="<%=basePath%>sysmeetmaintain/selectAllTypeCurMeeting.action" id="findForm" method="post">
	                  <p  style="font-size: 16px;margin-top: 5px;margin-left: 0px;">所有当前会议：</p>   
                   <!-- <button  class="button3" name="" id="newsysuser" type="button" style="position:absolute; right:0px;">注销会议</button> -->
                   	  <a class='easyui-linkbutton'  id="newsysuser"  data-options="iconCls:'icon-remove'" style="width:100px;color:#a10000; position: absolute;right: 0px;margin-top: 12px;" >注销会议</a>    
                </form>
                </div>
               <div class="sysmeet_right">
	           <div style="width:95%;margin:10px auto;">
	                 <table cellpadding="0" cellspacing="0" border="0" width="100%">
	                  <tr>
	                	<th class="th_sysmeet" width="5%">选择</th>
	                	<th class="th_sysmeet" width="5%">序号</th>
	                	<th class="th_sysmeet" width="14%">会议类型</th>
	                	<th class="th_sysmeet" width="48%">会议名称</th>
	                	<th class="th_sysmeet" width="14%">开始时间</th>	   
	                	<th class="th_sysmeet" width="14%">结束日期</th>
	                 </tr>
	                <s:iterator value="list" id="stat">
	              	  <tr><td colspan="5" height="5"></td></tr>
	              	  <tr>
                     	<td class="td_sysmeet"><input type="radio" name="deleteid" value="<s:property value="meetid"/>"/></td>
 	                	<td class="td_sysmeet"><s:property value="meetid"/></td>                    	
                     	<td class="td_sysmeet"><s:property value="mtype"/></td>
                     	<td class="td_sysmeet"><s:property value="mname"/></td>
                     	<td class="td_sysmeet"><s:date name="sdate" format="yyyy-MM-dd HH:mm"/></td>
                     	<td class="td_sysmeet"><s:date name="edate" format="yyyy-MM-dd HH:mm"/></td>               	               	               	               	                      	
	              	 </tr>
	                 </s:iterator>
	              </table>
	            </div>  
	          </div>
	       </div>
	   </div>  
</body>
</html>
