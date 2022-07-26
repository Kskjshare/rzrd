<%@ page language="java"  pageEncoding="utf-8"%>
 <%@ include file="/public/common.jspf" %>
<html>
  <head>
  		<base href="<%=basePath%>">
    	<title>海南省人大常委会电子阅文系统</title>

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
				$(linkObj).addClass("content");
			}
			document.getElementById("tabPanel").innerHTML="<iframe scrolling='no'   frameborder='0'  src='"+url+"' style='width:100%;height:100%;'></iframe>";
		}
		
		function clearLinkContentCss(){
			$("#accordion a").each(function(i,data){
				$(data).removeClass("content");
			});
		}
		
		

		function logout(){
			$.messager.confirm('退出提示', "你确定要退出吗？", function(r){
				if (r){
					location = "<%=basePath%>login/logout.action?page="+document.getElementById("loginpage").value;
				}
			});
		}
	
		function help(){
			window.open("<%=basePath%>module/support/index.jsp?type=1");
		}
	$(document).ready(function (){
	    
	       treeOnClick('<%=basePath %>module/main/main.jsp','主页',37);
	    
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
   <body class="easyui-layout" style="overflow:scroll;">
   <input id="loginpage" value="" type="hidden" />
  <div class="header">
   <div class="logo flt"><img src="<%=basePath %><%=themespath%>images/logo.png" /></div>
   
   <div class="icon1 frt">
      <div class="wel flt">欢迎您：<span><%=username%></span> <span id="time"></span>
     
        <script>
                    var myDate = new Date();
					document.getElementById('time').innerHTML=myDate.getFullYear()+"年"+(myDate.getMonth()+1)+"月"+myDate.getDate()+"日";
				</script>
      </div>
      <ul class="flt" onclick="help()">
        <li class="li1 flt"><img src="<%=basePath %><%=themespath%>images/icon_03.png" width="25" height="25"/><li>
        <li class="li1 flt"><span>帮助</span></li>
      </ul>
      <ul class="flt" onclick="logout()">
        <li class="li1 flt"><img src="<%=basePath %><%=themespath%>images/icon_05.png" width="25" height="25"/><li>
        <li class="li1 flt"><span>退出</span></li>
      </ul>
   </div>
</div>

<div class="main">

    <div class="leftbar flt">
       
       <ul id="accordion"><!-- treeOnClick(url,titleName,id,flag) -->
         <% 
       //增加权限控制
 			//Map<String,Object> permission=user.getPermissionmap();
            //String usertype=user.getUsertype().trim();
 			if(usertype!=null&&usertype.equals("1")){  
         %>
      
         <li><a class="content" onclick="treeOnClick('<%=basePath %>module/main/main.jsp','主页',38,this)">主页</a></li>
         <li><a onclick="treeOnClick('<%=basePath %>notify/selectsearch.action?pageNo=1&pageSize=8','通知',37,this)">通知</a></li>
         <li><a onclick="treeOnClick('<%=basePath%>module/calendar/mindex.jsp','年历表',108,this)">年历表</a></li>
         <li><a onclick="treeOnClick('<%=basePath %>/tongxunlun/selectComp.action?pageNo=1&compCode=1','通讯录',101,this)">通讯录</a></li>
         <li><a onclick="treeOnClick('<%=basePath%>/absence/selectSearch.action?pageNo=1&pageSize=8','出缺勤',111,this)">出缺勤</a></li>
         <li><a onclick="treeOnClick('<%=basePath %>/ziliaoku/selectFirstType.action','资料库',124,this)">资料库</a></li>
         <li><a onclick="treeOnClick('<%=basePath %>/groupmember/selectGroup.action','组成人员',109,this)">组成人员</a></li>
         <li><a onclick="treeOnClick('<%=basePath %>filemonitor/select.action','文件监控',127,this)">文件监控</a></li>
         <li><a onclick="treeOnClick('<%=basePath %>/smsdefine/selectSmsdefineLog.action?pageNo=1&pageSize=8','短信管理',8,this)">短信管理</a></li>
         <li><a onclick="treeOnClick('<%=basePath %>/sysuser/selectList.action?pageNo=1&pageSize=8','系统管理',6,this)">系统管理</a></li>
        <%}
 		  else{
 			
 			if(permission!=null){
 				
 			boolean b1=permission.get("1")!=null&&permission.get("1").toString().equals("0");
 			boolean b2=permission.get("2")!=null&&permission.get("2").toString().equals("0");
 			boolean b3=permission.get("3")!=null&&permission.get("3").toString().equals("0");
 			boolean b4=permission.get("4")!=null&&permission.get("4").toString().equals("0");
 			boolean b5=permission.get("5")!=null&&permission.get("5").toString().equals("0");
 			
 			boolean b6=permission.get("6")!=null&&permission.get("6").toString().equals("0");
 			boolean b7=permission.get("7")!=null&&permission.get("7").toString().equals("0");
 			boolean b8=permission.get("8")!=null&&permission.get("8").toString().equals("0");
 			boolean b9=permission.get("9")!=null&&permission.get("9").toString().equals("0");
 			boolean b10=permission.get("10")!=null&&permission.get("10").toString().equals("0");
 			boolean b11=permission.get("11")!=null&&permission.get("11").toString().equals("0");
 			boolean b12=permission.get("12")!=null&&permission.get("12").toString().equals("0");
 			boolean b13=permission.get("13")!=null&&permission.get("13").toString().equals("0");
 			
 	
 	   if(b1||b2||b3||b4||b5){ 
 	    %>
         <li><a class="content" onclick="treeOnClick('<%=basePath %>module/main/main.jsp','主页',38,this)">主页</a></li>
          <%
 	    }
          if(b6){ 
          %>
         <li><a onclick="treeOnClick('<%=basePath %>notify/selectsearch.action?pageNo=1&pageSize=8','通知',37,this)">通知</a></li>
         <%
         }    
      	 if(b7){
         %>
         <li><a onclick="treeOnClick('<%=basePath%>module/calendar/mindex.jsp','年历表',108,this)">年历表</a></li>
         <%
         }    
      	 if(b8){
         %>
         <li><a onclick="treeOnClick('<%=basePath %>/tongxunlun/selectComp.action?pageNo=1&compCode=1','通讯录',101,this)">通讯录</a></li>
         <%
         }    
       	if(b9){
         %>
         <li><a onclick="treeOnClick('<%=basePath%>/absence/selectSearch.action?pageNo=1&pageSize=8','出缺勤',111,this)">出缺勤</a></li>
         <%
         }    
       	if(b10){
         %>
         <li><a onclick="treeOnClick('<%=basePath %>/ziliaoku/selectFirstType.action','资料库',124,this)">资料库</a></li>
         <%
         }    
      	 if(b11){
         %>
         <li><a onclick="treeOnClick('<%=basePath %>/groupmember/selectGroup.action','组成人员',109,this)">组成人员</a></li>
         <%
         }    
       	if(b12){
         %>
         <li><a onclick="treeOnClick('<%=basePath %>filemonitor/select.action','文件监控',127,this)">文件监控</a></li>
         <%
         }    
       	if(b13){
         %>
         <li><a onclick="treeOnClick('<%=basePath %>/smsdefine/selectSmsdefineLog.action?pageNo=1&pageSize=8','短信管理',8,this)">短信管理</a></li>
         <%
         }    
          } 
 		  }
        %>
        <li><a onclick="treeOnClick('<%=basePath%>/absence/selectBM.action?pageNo=1&pageSize=8','批注查看',131,this)">批注查看</a></li>
       </ul>
    </div>
    

<!--
<script>
	$('.leftbar').find('a').click(function() {
		// 为当前点击的导航加上高亮，其余的移除高亮
		$(this).addClass('content').siblings('a').removeClass('content');
	});
</script>
--> 
    <div class="box flt">
    <div class="easyui-tabs1"  id="tabPanel" border="false" fit="true">
<!--此处内容更替-->
     <!--  <div class="mainicon">
        <div class="top">
           <ul>
             <li><a href=""><img src="<%=themespath%>/images/mainicon_03.png"/></a></li>
             <li><a href=""><img src="<%=themespath%>/images/mainicon_05.png"/></a></li>
           </ul>
        </div>
        <div class="bottom">
           <ul>
             <li><a href=""><img src="<%=themespath%>/images/mainicon_13.png"/></a></li>
             <li><a href=""><img src="<%=themespath%>/images/mainicon_15.png"/></a></li>
             <li><a href=""><img src="<%=themespath%>/images/mainicon_10.png"/></a></li>
           </ul>
        </div>
      </div> -->
<!--此处内容更替结束-->
    </div>
    </div>
</div>
  </body>
</html>
