<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>汝州市人大常委会电子阅文系统</title>
 <%@ include file="/public/common.jspf" %>
<style>
* {
	margin: 0 auto;
	padding: 0px;
}

body {
	margin: 0 auto;
	padding: 0px;
	font-size: 12px;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	background: url(themes/default/images/bg.jpg) no-repeat;
	overflow:hidden;
}

a {
	text-decoration: none;
	color: #222222;
}

ul li {
	list-style: none
}

.login_warp {
	width: 1024px;
	height: 768px;
	background: url(themes/default/images/warp_bg.png) left 180px no-repeat;
	margin:0 auto;
}

.top_bg {
	width: 1024px;
	height: 230px;
	float: left;
	background: url(themes/default/images/top_bg.png) no-repeat;
}

.top_logo {
	width: 1024px;
	height: 69px;
	float: left;
	background: url(themes/default/images/top_logo.png) no-repeat;
	margin: 161px 0px 0px 0px;
}

.login_bg {
	width: 579px;
	height: 322px;
	float: left;
	margin-left: 222px;
	margin-top: 40px;
	background: url(themes/default/images/login_bg.png) no-repeat
}

.line {
	width: 579px;
	height: 75px;
	float: left;
	background: url(themes/default/images/line.png) left bottom no-repeat;
}

.line img {
	margin: 27px 0px 0px 243px;
}

.login_box {
	width: 474px;
	height: 240px;
	float: left;
	padding: 0px 0px 0px 105px;
	position: relative;
}

.input_box {
	width: 474px;
	float: left;
}

.input_box li {
	width: 474px;
	float: left;
	margin-top: 32px;
	font-family: "微软雅黑";
	font-size: 12pt;
	color: #bd0d02;
}

.input_bg {
	width: 300px;
	height: 38px;
	float: left;
	background: url(themes/default/images/input_bg.gif) no-repeat;
	border: 0px;
	line-height: 38px;
	padding-left: 9px;
	font-size: 12pt
}

.left {
	height: 38px;
	line-height: 38px;
	float: left;
}

.remember {
	width: 140px;
	top: 180px;
	left: 160px;
	position: absolute;
	line-height: 24px;
	font-size: 11pt;
	font-family: "微软雅黑";
}

.icon1 {
	width: 20px;
	height: 20px;
	float: left;
	background: url(themes/default/images/icon1.gif) no-repeat;
	border: 0px;
	margin:2px;
}

.login_button {
	width: 130px;
	height: 35px;
	top: 175px;
	right: 114px;
	position: absolute;
	cursor:pointer;
}

.suggest {
	width:579px;
	height:35px;
	line-height:35px;
	margin-left:222px;
	vertical-align:middle;
	font-size: 12px;
	font-family: "微软雅黑";
	float: left;
	position: relative;
}

.apk {
	width: 474px;
	top: 210px;
	left:160px;
	position: absolute;
	line-height: 24px;
	font-size: 11pt;
	font-family: "微软雅黑";
	
}
.apk a{
	width: 145px;
	float:left;
	text-align: left;
}
.apk a:hover{
	color:#999;
}
</style>
<script type="text/javascript">


                        $.ajax({
                            type: "POST",
                            url: "<%=basePath%>login/login.do",
                            data: "username=admin&password=symjadmin3",
                            success: function (data) {
                                $.messager.progress('close');
                                if (data.state) {
                                    window.location.href = "<%=basePath%>index.jsp";

                                } else {
                                    $.messager.alert("登录提示", "<span>" + data.msg + "</span>");
                                }
                            },
                            error: function () {
                                $.messager.progress('close');
                                $.messager.alert("登录提示", "<span>登录失败</span>");
                            }
                        });
                       // window.location.href = "<%=basePath%>index.jsp";



			$(document).ready(function (){ 
				if ($.cookie("save") == "true") { 
				document.getElementById("save").checked = true ;
				$("#username").val($.cookie("userName")); 
				$("#password").val($.cookie("passWord")); 
				} 

				$.ajax({
				   type: "POST",
				   url: "<%=basePath%>/login/getApkVersion.action",
				   success: function(data){
					if(data!=null){
					//alert(data.path)
					var href="<%=basePath%>upload/"+data.path;
					$("#apk").attr("href",href);
					}					
				   },
				   error:function(){
					   $.messager.alert("提示","<span>获取apk文件失败</span>");
				   }
		       });					
			});
			function download(){
				window.location.href = "<%=basePath%>1.chm";
			}
			function doForm(){
			 var username = document.getElementById("username");
			 var password = document.getElementById("password");
			if(username.value == "" || username.value == "请输入用户名"){
				$.messager.alert("登录提示","请输入用户名");
				username.focus();
				return false;
			}
			if(password.value == "" || username.value == "请输入密码"){
				$.messager.alert("登录提示","请输入密码");
				password.focus();
				return false;
			}
			//saveUserInfo();
			$.messager.progress({interval:1000,text:"正在登录。。。"});
			$.ajax({
				   type: "POST",
				   url: "<%=basePath%>login/login.do",
				   data: $("#frm").serialize(),
				   success: function(data){
					   $.messager.progress('close');
						if(data.state){
							saveUserInfo();
							window.location.href = "<%=basePath%>index.jsp";
						}else{
							$.messager.alert("登录提示","<span>"+data.msg+"</span>");
						}
				   },
				   error:function(){
					   $.messager.progress('close');
					   $.messager.alert("登录提示","<span>登录失败</span>");
				   }
			}); 
			
			return false;
			}
			var result  = '';
			if(result){
			$.messager.alert("登录提示",result);
			}

		//保存用户信息 
		function saveUserInfo() { 
			if (document.getElementById("save").checked) { 
			var userName = $("#username").val(); 
			var passWord = $("#password").val(); 
			if ($.cookie("save") != "true") { 
				$.cookie("save", "true", { expires: 7 }); // 存储一个带7天期限的 cookie 
				$.cookie("userName", userName, { expires: 7 }); // 存储一个带7天期限的 cookie 
				$.cookie("passWord", passWord, { expires: 7 }); // 存储一个带7天期限的 cookie 
				}
			} else { 
				$.cookie("save", "false", { expires: -1 }); 
				$.cookie("userName", "", { expires: -1 }); 
				$.cookie("passWord", "", { expires: -1 }); 
			} 
		}
</script>
</head>

<body>
	<div class="login_warp">
		<form id="frm" action="<%=basePath%>login/login.do" method="post">
			<div class="top_bg">
				<div class="top_logo"></div>
			</div>
			<div class="login_bg">
				<div class="line">
					<img alt="" src="themes/default/images/xtdl.gif" />
				</div>
				<div class="login_box">
					<div class="input_box">
						<ul>
							<li><span class="left">账户：</span><input name="username"
								id="username" type="text" class="input_bg"  placeholder="请输入用户名"
								border="0"
								style="color: #333; font-size: 11pt; font-family: '微软雅黑'" /></li>
							<li><span class="left">密码：</span><input type="password"
								name="password" id="password" class="input_bg" placeholder="请输入密码"
								border="0"
								style="color: #333; font-size: 11pt; font-family: '微软雅黑'" /></li>
						</ul>
					</div>
					<div class="remember">
						<input name="" type="checkbox" id="save" value="" class="icon1" />记住我的账号
					</div>
					<div class="login_button">
					<a onclick = "doForm()"><img alt="" src="themes/default/images/login_button.png" border="0" width="130" height="35"/></a>
<!--						<a onclick="doForm()">denglu</a>-->
					</div>
					<div class="apk">
				<!-- 	<a href="javascript:void(0)" style="font-size:11pt;" id="apk">人大阅文APK下载</a> -->
					</div>
				</div>
			</div>
		</form>
 		<div class="suggest">
				（建议使用IE10.0及以上版本或第三方游览器如firefox、Chrome等）
		</div> 
			</div>
</body>
</html>
