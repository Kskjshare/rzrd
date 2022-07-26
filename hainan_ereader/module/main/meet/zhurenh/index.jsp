<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/public/common.jspf" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>人大会议助理_主任会议</title>
<script type="text/javascript" src="<%=path%>/third/My97DatePicker/WdatePicker.js"></script>
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
.erjileftbar dt{ margin-top:15px;}
<%
	int meetid=Integer.parseInt(request.getParameter("meetid"));
	System.out.println("types2:"+request.getParameter("type"));
	int type=Integer.parseInt(request.getParameter("type"));
	System.out.println("types:"+type);
%>
</style>
<script type="text/javascript">
	 $(function(){
	 $('#meetid').val(<%=meetid%>);
	 $('#mtype').val(<%=type%>);
    $('#begin').click(function(){
    		//alert("OK");
    		WdatePicker({lang:'zh-cn',dateFmt:'yyyy-MM-dd HH:mm',minDate:'%y-%M-%d 00:00:00'});
    	});
    	$('#end').click(function(){
    		//alert("OK");
    		WdatePicker({lang:'zh-cn',dateFmt:'yyyy-MM-dd HH:mm',minDate:'%y-%M-%d 00:00:00'});
    	});
    	$('#saveSub').click(function(){
    	    var reg=/^[1-9]\d*$/;
    		var cs=document.getElementById('cishu').value;
    		var beginDate=document.getElementById('begin').value;
    		var endDate=document.getElementById('end').value;
    		var bdate=new Date(beginDate.replace("-","/").replace(":",""));
    		var edate=new Date(endDate.replace("-","/").replace(":",""));
    		var type=<%=type%>;
    		if(cs==''||cs==null){
    			if(type == 5) {
	    			$.messager.alert('提示','请输入会议名称',"info");
    			}else {
    				$.messager.alert('提示','请输入会议次数',"info");
    			}
    		}else{
    		if(beginDate<endDate){
    			$('#findForm').form('submit', {    
   				 	success: function(data){    
      				  var json = eval('(' + data + ')'); 
      				 //alert(json.state);
      				// alert(data.state);
      				var meetid=json.msg;
      				var type=<%=type%>;
      				 	 document.getElementById('indexInfo').href="<%=basePath %>module/main/meet/zhurenh/index.jsp?meetid="+meetid+"&type="+type;
      				 	 document.getElementById('yichengmanage').href="<%=basePath %>module/main/meet/zhurenh/yichengmanage.jsp?meetid="+meetid+"&type="+type;
      				 	 document.getElementById('meetfile1').href="<%=basePath %>meet_getMeetFile2.action?fileown=1&filetype=&pageNo=1&pageSize=8&meetid="+meetid+"&type="+type;
        				  if(json.state=="true"||json.state==true){
        				 		$.messager.alert('提示','录入成功',"info");
			 					//$("#treeGrid").treegrid("reload");
						 }else{
			 					$.messager.alert('提示','录入失败',"info");
			 					//$('#treegrid').window('close');
						 }
   					}    
				});
    			//document.getElementById('findForm').submit();
    		}else{
    			$.messager.alert('提示','录入失败',"error");
    		}
    		}
    	});
    	//alert("OK");
    	getSelects();
    })
    
    function getSelects(){
    	 $.post("<%=basePath%>meet_getSelects.action",{},
			 function(data){
			 	if(data.state){
			 		var jieshu=document.getElementById('jieshu');
			 		//var cishu=document.getElementById('cishu');
			 		var array=data.jslist;
			 		var array1=data.cslist;
			 		for(var i=0;i<array.length;i++){
			 			var action=array[i].name;
			 			var actionname=array[i].name;
			 			jieshu.options.add(new Option(actionname,action));
			 		}
/* 			 		for(var i=0;i<array1.length;i++){
			 			var action=array1[i].name;
			 			var actionname=array1[i].name;
			 			 cishu.options.add(new Option(actionname,action));
			 		} */
			 		if(<%=meetid%>==0){
			 		getcnum();
			 		}
			 		loadMeet();
			 	}else{
			 		$.messager.alert('提示','操作失败',"info");
			 	};
			 });
    }
    function getcnum(){
    	 var jnum=$("#jieshu").val()+"届";
    	 $.post("<%=basePath%>meet_getSelects.action",{fmtype:<%=type%>,jieshu:jnum},
    	 		function(data){
			 	if(data.state){
			 		//$('#cishu').val(data.cslist);
			 	}
		});
    }    
    function loadMeet(){
    		//alert(<%=meetid%>);
    		if(<%=meetid%>!=0){
    		//var now=new Date();
				//var number = now.getYear().toString()+now.getMonth().toString()+now.getDate().toString()+now.getHours().toString()+now.getMinutes().toString()+now.getSeconds().toString();
				
    		$('#findForm').form('load','<%=basePath%>meet_loadMeeting.action?meetid=<%=meetid%>');
    	}
    	}
    	function backMeet(){
    			window.location.href="<%=basePath %>selectCurMeeting.action?type=<%=type%>";
    		}
</script>
</script>
</head>

<body>
<!--此处内容更替-->
        <div class="cwh_head">
        	<%if(type==1){ %>
        		 主页 >主任会议>新建会议
        	<%}else if(type==3){ %>
        		主页 >法制委员会会议>新建会议
        	<%}else if(type==4){ %>
        		主页 >财政经济委员会会议>新建会议
        	<%}else if(type==5){ %>
        		主页 >其他会议>新建会议
        	<%} %><!-- <button  class="button1" style="margin-top: 10px;"   onclick="javascript:backMeet()" type="button" style="">返回</button> -->
        </div>
        <a class='easyui-linkbutton' onclick="javascript:backMeet()" id="backMeet" data-options="iconCls:'icon-Undo'" style="right:20px;position:absolute;margin-top:10px;z-index: 9px;top:5px;" >返回</a>
        <div class="erjileftbar">
             <dl>
               <dt><a id="indexInfo" href="<%=basePath %>getMeetingInfo.action?meetid=<%=meetid%>&type=<%=type %>"><img src="<%=path%>/themes/default/images/huiyi_03.png"/></a></dt>
              <%--  <%if(type==1){ %> --%>
               		 <dt><a id="yichengmanage" href="<%=basePath %>module/main/meet/zhurenh/yichengmanage.jsp?meetid=<%=meetid%>&type=<%=type %>"><img src="<%=path%>/themes/default/images/1_05.png"/></a></dt>
              <%--  <%} %> --%>
               <dt><a id="meetfile1" href="<%=basePath %>meet_getMeetFile2.action?meetid=<%=meetid%>&fileown=1&filetype=&type=<%=type %>&bindtype=0"><img src="<%=path%>/themes/default/images/1_07.png"/></a></dt>
            </dl>
        </div>
        <div class="erjimain">             
           <div class="huiyi_main">
              <p>基本信息</p>
              <form action="<%=basePath %>saveOrUpdateMeeting.action" id="findForm" method="post" style="margin-left:30px; margin-top:20px;">
                  <%if(type!=5){ %>
                  <p style="font-size:16px;font-family:'宋体'">会议名称：海南省第
                  <select style="width:150px; height:30px;" name="jieshu" id="jieshu" onchange="getcnum()"> </select>
            <%if(type==1){ %>
        		届人民代表大会常务委员会主任会议第
        	<%}else if(type==3){ %>
        		届人民代表大会法制委员会第
        	<%}else if(type==4){ %>
        		届人民代表大会财政经济委员会第
        	<%-- <%}else if(type==5){ %>
        		届第 --%>
        	<%} %>
        	
            <input  style="width:350px; height:30px;line-height:30px;border:1px solid #7A7A7A;" name="cishu" id="cishu">
            </input>
            <%if(type==1){ %>
        		次会议
        	<%}else if(type==3){ %>
        		次会议
        	<%}else if(type==4){ %>
        		次会议
        	<%-- <%}else if(type==5){ %>
        		次海南人大会议 --%>
        	<%}}else if(type==5){ %>
        		<p style="font-size:16px;font-family:'宋体'">会议名称：
        		<input  style="width:450px; height:30px;line-height:30px;border:1px solid #7A7A7A;" name="cishu" id="cishu" value="${cishu}">
        		<input style="hidden" name="jieshu"/>
        	<%} %>
                              </p>
                <s:hidden name="meeting.mtype" id="mtype"></s:hidden>
                <s:hidden name="meetid" id="meetid"></s:hidden>
                  <p style="height:30px;font-family:'宋体'; line-height:30px;font-size:16px; margin-top:40px;">
                  	开始时间：<s:textfield name="meeting.sdateStr" size="11" id="begin" cssClass="Wdate"/> 
<!--                  	<input id="begin" class="Wdate" onFocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy-MM-dd HH:mm:ss'})" type="text" name="" value="">--></p>
                  <p style="height:30px;font-family:'宋体'; line-height:30px;font-size:16px; margin-top:70px;">
                  	结束时间：<s:textfield name="meeting.edateStr" size="11" id="end"  cssClass="Wdate"/> 
<!--                  	<input id="end" class="Wdatde" onFocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy-MM-dd HH:mm:ss'})" type="text" name="" value=""></p>-->
               	<div><a class='easyui-linkbutton' id="saveSub"  data-options="iconCls:'icon-save'" style="line-height: 25px;width: 100px;color:#a10000; float:right; margin-right:35%;margin-top: 20px;">保存</a></div>             	
              </form>
           </div>
           
        </div>
<!--此处内容更替结束-->
</body>
</html>
