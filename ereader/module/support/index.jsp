<%@ page language="java"  pageEncoding="utf-8"%>
 <%@ include file="/public/common.jspf" %>
<html>
  <head>
  		<base href="<%=basePath%>">
  		<% 
  		String type=request.getParameter("type");
  		%>
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
</style>
     <script type="text/javascript">
		function treeOnClick1(url,titleName,id,flag)
		{	
			if(!url)
			{
				return ;
			}
			if($("#tabPanel").tabs("exists",titleName)){	 	
			alert('a');
	 		    $('#tabPanel').tabs('select',titleName);
	 		    if(flag){
				document.getElementById("tab"+id).src = url;
			   }	
	 		}else {
	 		$('#tabPanel').tabs('add',{
	 			closable:true,
	 			content:"<iframe scrolling='yes'  id = 'tab"+id+"' frameborder='0'  src='"+url+"' style='width:100%;height:100%;'></iframe>",
	 			title : titleName,
	 			tools:[{
	 				iconCls: "icon-mini-refresh" ,
	 				handler: function (){
	 				document.getElementById("tab"+id).src = document.getElementById("tab"+id).src;
	 				}
	 			}]
	 		});
	 		}
		}
		
		function treeOnClick(url,titleName,id,linkObj)
		{	
			if(!url)
			{
				return ;
			}
			if(linkObj){
				clearLinkContentCss();
				$(linkObj).addClass("historycontent");
			}
			document.getElementById("tabPanel").innerHTML="<iframe scrolling='no'   frameborder='0'  src='"+url+"' style='width:100%;height:100%;'></iframe>";
		}
		
		function clearLinkContentCss(){
			$("#accordion a").each(function(i,data){
				$(data).removeClass("historycontent");
			});
		}
		
	
	
	$(document).ready(function (){
	    
	       treeOnClick('<%=basePath %>syshelp/selectErHelpList.action?type=<%=type%>&pageNo=1','主页',37);
	    
	});
		var collapse = true ;
		function collpasePanel(){
		if(collapse){
			$('body').layout('collapse','west');
			$('body').layout('collapse','north');
			collapse = false ;
		}else {
			$('body').layout('expand','north');
			$('body').layout('expand','west');
			collapse = true ;
		}
		
		}
		
 	    </script>
  </head>
   <body class="easyui-layout" style="overflow:no;">
  <div >
    <div class="historycwh_head">
           帮助
    </div>
   
    <s:hidden name="meetid"><s:property value="meetid"/></s:hidden>
<div class="historymain">
    <div class="historyleftbar flt">
       <ul id="accordion"><!-- treeOnClick(url,titleName,id,flag) -->
         <li><a class="historycontent" onclick="treeOnClick('<%=basePath %>syshelp/selectErHelpList.action?type=<%=type%>&pageNo=1','议程',37,this)"><img src="<%=basePath %><%=themespath %>/images/rd_icon27.png" width="20px" height="20px" style="float: left;position: absolute;left:7px;top:13px;">帮助文件</a></li>
       </ul>                           
    </div>

    <div class="box flt">
    <div class="easyui-tabs1"  id="tabPanel" border="false" fit="true">

    </div>
    </div>
</div>
  </body>
</html>
