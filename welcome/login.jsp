
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.Core.Encrypt"%>
<%--<%@page import="RssEasy.MySql.Staff.StaffList"%>--%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="java.util.Date"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/data/contants.jsp"%><!--added by jackie //-->
<%    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
       
    out.print("<script> var passwordjsp=0</script>");

    //梁小竹修改
    //判断页面是否第一次加载,解决jsp中java代码加载页面时会先执行一次的问题
    if(req.get("firstjiazai") != null && "1".equals(req.get("firstjiazai")) ){
        String numbercode = "";
        String numbercodepre = "";
        
        numbercode = (String)session.getAttribute("numbercode");
        numbercodepre = req.get("numbercodepre");
        
        if ( numbercode != null ) {
        numbercode = numbercode.replaceAll(" ", "").toUpperCase();
        numbercodepre = numbercodepre.replaceAll(" ", "").toUpperCase();
        }
        
        if("".equals(numbercodepre)){
            out.print("<script>alert('验证码为空')</script>");
        }else
        {
            if(!numbercodepre.equals(numbercode)){
                out.print("<script>alert('验证码错误')</script>");
            } else
            {
                //验证码正确
                UserList userone = new UserList(pageContext);
                userone.select().where("account='" + req.get("account") + "' or telphone='" + req.get("telphone") + "' and telphone != ''").get_first_rows();
                //判断是否密码错误超过了五次，超过禁用账号
                Integer mimacuowu = Integer.parseInt("".equals(userone.get("passworderrornum")) || "null".equals(userone.get("passworderrornum")) ? "0" : userone.get("passworderrornum"));//去数据库看此账号密码错误次数
                if(mimacuowu != null && mimacuowu >= 5){
                    userone.keyvalue("enabled", 2);//设置为2表示禁用账号
                    userone.update().where("account='" + req.get("account") + "' or telphone='" + req.get("telphone") + "' and telphone != ''").submit();
                }
                if ("1".equals(userone.get("enabled"))){
                    //没被禁用
                    if (req.has("account")) {
                        UserList user1 = new UserList(pageContext);
                        if (user1.select().where("account='" + req.get("account") + "' or telphone='" + req.get("telphone") + "' and telphone != ''").get_first_rows()) {
                            String a = req.get("powergroupid");
                            if (user1.get("rolelist").indexOf(a) != -1 || a.equals("0")) {
                //                if (user1.get("enabled").equals("2")
                //                        || (flowtype.equals("2") && user1.get("powergroupid").equals("22"))//流程类型是议审委初审且是代表团登录//added by jackie
                //                        || (flowtype.equals("1") && user1.get("powergroupid").equals("7"))//流程类型是代表团初审且是议审委登录//added by jackie
                //                        ) {
                //                    out.print("<script>alert('该账号已禁用')</script>");
                //                } else 
                                    if (user1.get("pwdshijian").isEmpty()) {
                                    out.print("<script>  alert('新账号首次登陆需先修改密码！');passwordjsp=1</script>");
                                } else {
                                    long pwdshijian = Long.parseLong(user1.get("pwdshijian"));
                                    long time = new Date().getTime() / 1000;
                                    if (time > pwdshijian) { 
                                        out.print("<script>  alert('长时间未修改密码,登陆需先修改密码！');passwordjsp=1</script>"); 
                                    }else{
                                                //2020-2-29被李小东调试注释
                                        try {
                                            long thistime = new Date().getTime() / 1000;

                                            CookieHelper cookie = new CookieHelper(request, response);
                                            UserList user = new UserList(pageContext);
                //                            RssListView user111 = new RssListView(pageContext,"userrole");
                                            if (!req.get("powergroupid").equals("0")) {
                                                user.keyvalue("powergroupid", req.get("powergroupid"));
                                                //2021.02.23梁小竹修改了下面一句，原因为telphone为空时会查询数据库中字段为空的选项,因此修改sql语句判断不为空时才更新
                                                user.update().where("account='" + req.get("account") + "' or telphone = '" + req.get("telphone") + "' and telphone != ''").submit();
                                            }
                //                            user111.select().where("account='" + req.get("account") + "' or telphone='" + req.get("telphone") + "'").get_first_rows();
                                            //2021.02.23梁小竹修改了下面一句，原因为telphone为空时会查询数据库中字段为空的选项,因此修改sql语句判断不为空时才查询
                                            user.select().where("account='" + req.get("account") + "' or telphone='" + req.get("telphone") + "' and telphone != ''").get_first_rows();
                                            cookie.Set("sessionid", user.get("sessionid"));
                                            cookie.Set("parentid", user.get("parentid"));
                                            cookie.Set("powergroupid", user.get("powergroupid"));
                                            cookie.Set("state", user.get("state"));
                                            StaffList staff = new StaffList(pageContext);
                                            staff.request();
                                            //  String s_temp=user1.getParams(key)
                                            // out.print("<script>  alert('ww');</script>");//李小东调试添加的
                                            staff.login();
                                            //说明密码正确，刷新输入密码的错误次数
                                            UserList userthree = new UserList(pageContext);
                                            userthree.keyvalue("passworderrornum", 0);//
                                            userthree.update().where("account='" + req.get("account") + "' or telphone='" + req.get("telphone") + "' and telphone != ''").submit();
                                            
                                            response.sendRedirect("/gateway.jsp");
                                        } catch (Exception ex) {
                                            //密码错误
                                            //判断返回的状态码 105为密码错误
                                            if("105".equals(ex.getMessage())){
                                                UserList usertwo = new UserList(pageContext);
                                                usertwo.select().where("account='" + req.get("account") + "' or telphone='" + req.get("telphone") + "' and telphone != ''").get_first_rows();
                                                //判断之前是否错误，存入session
                                                mimacuowu = Integer.parseInt("".equals(userone.get("passworderrornum")) || "null".equals(userone.get("passworderrornum")) ? "0" : userone.get("passworderrornum"));//去数据库看此账号密码错误次数
                                                if(mimacuowu == null){
                                                    //说明之前没有登陆过，则设置
                                                    usertwo.keyvalue("passworderrornum", 0);//
                                                    usertwo.update().where("account='" + req.get("account") + "' or telphone='" + req.get("telphone") + "' and telphone != ''").submit();
                                                }
                                                else{

                                                    usertwo.keyvalue("passworderrornum", ++mimacuowu);//
                                                    usertwo.update().where("account='" + req.get("account") + "' or telphone='" + req.get("telphone") + "' and telphone != ''").submit();
                                                }
                                                mimacuowu = Integer.parseInt("".equals(usertwo.get("passworderrornum")) || "null".equals(usertwo.get("passworderrornum")) ? "0" : usertwo.get("passworderrornum"));//去数据库看此账号密码错误次数
                                                if(mimacuowu != null && mimacuowu >= 5){
                                                    out.print("<script>alert('用户被冻结，请联系管理员解封')</script>");
                                                }else{
                                                    out.print("<script>alert('密码错误，您还有" + ( 5 - mimacuowu) + "次机会!')</script>");
                                                }
                                            }else{
                                                req.keyvalue("rsscode", ex.getMessage());
                                            }
                                        }
                                    }
                                }
                            } else {
                                out.print("<script>  alert('该账号没有该角色登陆权限');</script>");
                            }
                        } else {
                            out.print("<script>  alert('账号不存在,请确认账号或联系管理员！');</script>");
                        }
                    }
                }else{
                    //被禁用
                    out.print("<script>alert('用户被冻结，请联系管理员解封')</script>");
                }
            }
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv=Content-Type content='text/html; charset=utf-8'>
  <!--      <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
        <meta name="viewport" content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;">
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="apple-mobile-web-app-status-bar-style" content="black">
        <meta name="format-detection" content="telephone=no">
        <meta name="viewport" content="width=device-width" /> -->
        <title>智慧人大综合服务管理系统</title>
        <link rel="icon" type="image/png" href="LoginPage/Images/favicon.png"  />
        <link rel="stylesheet" type="text/css" href="LoginPage/FormWork/easyui/themes/default/easyui.css" />
        <link href="LoginPage/FormWork/fontawesome/css/font-awesome.min.css"  rel="stylesheet" type="text/css" />
        <link rel="stylesheet" type="text/css" href="LoginPage/FormWork/easyui/themes/icon.css"  />
        <link rel="stylesheet" type="text/css" href="LoginPage/Content/Share/common.css"  />
        <link href="css/reset.css" rel="stylesheet" type="text/css" />
        <style>
                #code{ color: white; width:200px;min-height: 50px;min-width: 50px;heigh:200px;position:fixed;top:200px;right:10px;}
                #code img{ width:130px;heigh:130px;margin-top:20px; }
                #co img{ width:130px;heigh:130px;margin-top:20px; }
                #co{ color: white; width:200px;heigh:200px;position:fixed;top:280px;right:10px;}
        </style>
        <script src="LoginPage/Scripts/Share/Help.js" type="text/javascript"></script>
        <script type="text/javascript" src="LoginPage/FormWork/easyui/jquery.min.js" ></script>
        <script type="text/javascript" src="LoginPage/FormWork/easyui/jquery-migrate-1.2.1.min.js" ></script>
        <script type="text/javascript" src="LoginPage/FormWork/easyui/jquery-ui-1.9.2.custom.min.js" ></script>
        <script type='text/javascript' src="LoginPage/FormWork/easyui/autocompelete/jquery.autocomplete.js" ></script>
        <script type="text/javascript" src="LoginPage/FormWork/easyui/jquery.validate.min.js"></script>
        <script type="text/javascript" src="LoginPage/FormWork/easyui/modernizr.min.js"></script>
        <script type="text/javascript" src="LoginPage/Scripts/Share/jquery.cookie.js" ></script>
        <script type="text/javascript" src="LoginPage/FormWork/easyui/jquery.easyui.min.js" ></script>
        <script type="text/javascript" src="LoginPage/FormWork/easyui/locale/easyui-lang-zh_CN.js"></script>
        <script type="text/javascript" src="LoginPage/Scripts/Share/echarts.js" ></script>
        <script type="text/javascript" src="LoginPage/Scripts/Share/common.js" ></script>
        <script type="text/javascript" src="LoginPage/FormWork/easyui/validate.js" ></script>
        <script type="text/javascript" src="LoginPage/Scripts/Share/UnicodeAnsi.js" ></script>
        <script type="text/javascript" src="LoginPage/Scripts/Share/base64.js" ></script>
        <script type="text/javascript" src="LoginPage/Scripts/Share/intro.js" ></script>
        <script type="text/javascript" src="LoginPage/Scripts/Share/timeClear.js"></script>
        <script type="text/javascript" src="LoginPage/Scripts/Share/json2.js" ></script>
        <link rel="stylesheet" type="text/css" href="LoginPage/Content/Share/introjs.css"/>
        <script src="LoginPage/Scripts/Share/jquery-migrate-1.4.1.min.js"  type="text/javascript"></script>
        <script src="LoginPage/Scripts/Share/jqprint-0.3.js" type="text/javascript"></script>

        <link href="LoginPage/Content/globa/Login.css"  rel="stylesheet" type="text/css" />
        <script src="projectSwitching.js"></script>
        <script type="text/javascript">
            if (self !== top) {
                top.location = self.location;
            }
            $(function(){
                $("#loginimg").attr("src",loginImgSrc);
            });
        </script>
        <style>
            #footerBox{
/*                position:absolute;
                left:50%;
                
                bottom:15%;*/
                margin-left:10px;
                margin-top:20px;
            }         
        </style>
    </head>
    
    <body style="text-align: center;min-height:100px;background-color: red;">
<!--        <img src="LoginPage/images/logo.png"  style="margin-top: 60px;" />-->
        <p style="font-size:42px;color:wheat;margin-top:1.8%;letter-spacing:4px;margin-left:70px;">汝州市智慧人大综合服务管理平台</p>
        <div style="width:24%; min-width:432px;max-height:314px; background-image:url(LoginPage/images/dlk.png);background-size:100% 100%; text-align:center;position:absolute; left:50%; margin-left:-202px; top:40%; margin-top:-110px;">
            <form  method="post" id="trylogin" style="min-width:100px; min-height:80px;">
                <!--用来判断是否是第一次加载-->
                <input style="display:none;" id="firstjiazai" name="firstjiazai" value="0"/>
                
                <input name="__RequestVerificationToken" type="hidden" value="jT5z0Ku5xqeh9NuHdjif9clSnTQTzsOoMWeHk9quKOajVdx2mVMofyLKiAq7VL2LJQcjqLSranersSdS3WKDYTQLpgJuDXNEU8inroTjlucvc_NLX75ncC1kKDNM9Pmj2m1ZU2sq2lLyl7IKyVCFWs9kWRqnCJuz48Fe2kKe7o41" />
                <img src="LoginPage/images/logo.png"  style="margin-top: 60px;" />

              
                <!--梁小竹修改不同项目图片切换-->
<!--                <img id="loginimg" src=""  style="margin-top:20px;"/>-->
                <!--<p style="margin-top:14px;font-size:23px;letter-spacing:4px;margin-left:5%;width:200px;">用户登录</p>-->
                <img src="LoginPage/images/yhm-30-lanse.png"  style="margin-top: 12px; position: relative; left:30px;" />
                <input type="text" placeholder=""  id="account" name="account" value="<% out.print(req.get("account")); %>"  style="width:260px;
                       height: 26px; line-height: 20px; font-size: 16px; border: 0px; background: rgba(0, 0, 0, 0); background-color:rgba(0, 0, 0, 0) !important;
                       outline: none; position: relative; top: -26px;left:64px; "/>


                <img src="LoginPage/images/mm-30-lanse.png"  style="margin-top: -14px; position: relative; left:30px;" />
                <input type="password" placeholder=""  id="pwd" name="pwd" value="<% out.print(req.get("pwd"));%>" style="width:260px;
                       height: 26px; line-height: 20px; font-size: 16px; border: 0px; background: rgba(0, 0, 0, 0);
                       outline: none; position: relative;top: -24px; left:64px;"  />
                
                <img src="LoginPage/images/mm-30-1anse.png"  style="margin-top: -18px;" />
                <div style="height:40px; position: absolute;left: 80px;margin-top:-46px;">
                    <input name="numbercodepre" type="text" placeholder="" 
                           style="width:130px;left:64px; height:38px; position: relative; top: -16px; border: none;background: rgba(0, 0, 0, 0);font-size:16px;" />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <img id="imgnumber" src="/number.jsp" style="width:130px; height: 40px;" />
                </div>
               <select style="display: none;" name="powergroupid" dict-select="powergroup"><option value="0">默认角色</option></select>
                <img id="login" src="LoginPage/images/trylogin.png" style="margin-top:10px;border-radius:12px;" />
                <button type="submit" style="display:none;"></button>
                <input type="hidden" name="action" value="login" />
                
            </form>
            <div id="footerBox">
                <!--<a href="http://180.136.3.208:10000/delegatexweb/bmweb.jsp"><img src="css/limg/loginleft.png" alt=""></a>-->
                <a href="/delegatexweb/bmweb.jsp"><img src="css/limg/loginleft.png" alt=""></a>
                <!--<a href="http://180.136.3.208:10000/wangzhan/index.htm"><img src="css/limg/changweihui.png" alt="" style="margin-left: 20px;"></a>-->
                <a href="/wangzhan/index.htm"><img src="css/limg/changweihui.png" alt="" style="margin-left:36px;"></a>
            </div>
                       <div id="footer">
                           <p style="font-size:14px;color:#BE2229;margin-top:28%;">汝州市智慧人大综合服务管理平台</p>
            </div>
        </div>
        
        <div id="code"><b style="letter-spacing:2px;font-family: 微软雅黑;font-size: 16px;">扫一扫，安装手机版</b><span><img src="css/limg/DowloadApp.png" alt=""></span></div>
<!--        <div id="co" ><b style="letter-spacing:2px;font-family: 微软雅黑;font-size: 16px;">进入人大常委会网站</b><span><img src="css/limg/111.gif" alt=""></span></div>-->
        <%@include  file="/inc/js_loginpage.html" %>
        <%@include  file="/inc/js.html" %>
        <!--<script src="LoginPage/Scripts/globa/Login.js" type="text/javascript"></script>-->
        <script type="text/javascript">
            
            //点击验证码图片刷新
            $(function(){
                $("#firstjiazai").val("1");
            });
            
            $("#imgnumber").click(function(){
                //IE存在缓存,需要new Date()实现更换路径的作用  
                $("#imgnumber").attr("src","/number.jsp?"+new Date());
            });
            
             if (passwordjsp == 1) {
                popuplayer.display("/password.jsp?TB_iframe=true", '修改密码', {width: 650, height: 400});
            }
            
            $('#login').click(function () {
                $(this).next().click();
            })
            RssCode.alert("<% out.print(req.get("rsscode"));%>");
           
           
        </script>
    </body>
</html>
