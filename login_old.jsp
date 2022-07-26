
<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="java.util.Date"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/data/contants.jsp"%><!--added by jackie //-->
<%
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    out.print("<script> var passwordjsp=0</script>");

    if (req.has("account")) {
        UserList user1 = new UserList(pageContext);
        if (user1.select().where("account='" + req.get("account") + "' or telphone='" + req.get("telphone") + "'").get_first_rows()) {
            String a = req.get("powergroupid");
            if (user1.get("rolelist").indexOf(a) != -1 || a.equals("0")) {
                if (user1.get("enabled").equals("2")
                          ||(flowtype.equals("2")&&user1.get("powergroupid").equals("22"))//流程类型是议审委初审且是代表团登录//added by jackie
                        ||(flowtype.equals("1")&&user1.get("powergroupid").equals("7"))//流程类型是代表团初审且是议审委登录//added by jackie
                        ) {
                    out.print("<script>alert('该账号已禁用')</script>");
                } else if (user1.get("pwdshijian").isEmpty()) {
                    out.print("<script>  alert('新账号首次登陆需先修改密码！');passwordjsp=1</script>");
                } else {
                    long pwdshijian = Long.parseLong(user1.get("pwdshijian"));
                    long time = new Date().getTime() / 1000;
                    if (time > pwdshijian) {
                        out.print("<script>  alert('长时间未修改密码,登陆需先修改密码！');passwordjsp=1</script>");
                    } else {//2020-2-29被李小东调试注释
                        try {
                            long thistime = new Date().getTime() / 1000;

                            CookieHelper cookie = new CookieHelper(request, response);
                            UserList user = new UserList(pageContext);
                            if (!req.get("powergroupid").equals("0")) {
                                System.out.println("!!!!!!!!");
                                user.keyvalue("powergroupid", req.get("powergroupid"));
                                user.update().where("account='" + req.get("account") + "' or telphone='" + req.get("telphone") + "'").submit();
                            }
                            user.select().where("account='" + req.get("account") + "' or telphone='" + req.get("telphone") + "'").get_first_rows();
                            cookie.Set("sessionid", user.get("sessionid"));
                            cookie.Set("parentid", user.get("parentid"));
                            cookie.Set("powergroupid", user.get("powergroupid"));
                            cookie.Set("state", user.get("state"));
                            StaffList staff = new StaffList(pageContext);
                            staff.request();
                          //  String s_temp=user1.getParams(key)
                            // out.print("<script>  alert('ww');</script>");//李小东调试添加的
                            staff.login();
                            response.sendRedirect("index.jsp");
                        } catch (Exception ex) {
                            req.keyvalue("rsscode", ex.getMessage());
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
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>乌兰浩特市人大代表履职服务平台</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="css/reset.css" rel="stylesheet" type="text/css" />
        <link href="css/login.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript">
            if (self !== top) {
                top.location = self.location;
            }
        </script>
    </head>
    <body>
        <div id="mainwrap">
            <div id="code"><h1>扫一扫，安装手机版</h1><span><img src="css/limg/ewm.png" alt=""/></span></div>
             <div id="webhref">
                <img id="loginleft" src="css/limg/loginleft.png" alt=""/>
                <img id="loginright" src="css/limg/loginright.png" alt=""/>
            </div>
        
            <form method="post">
                <table id="login">
                    <tbody>
                        <tr>
                            <td id="logo" colspan="4">用户登入</td>
                        </tr>
                        <tr>
                            <td>用户名</td>
                            <td colspan="3">
                                <input type="text" placeholder="请输入用户名" id="account" name="account" value="<% out.print(req.get("account")); %>" />
                            </td>
                        </tr>
                        <tr>
                            <td>密&nbsp;&nbsp;&nbsp;码</td>
                            <td colspan="3">
                                <span id="pwdimg"><input type="password" placeholder="请输入密码" id="pwd" name="pwd" value="<% out.print(req.get("pwd"));%>" />
                                    <img src="css/limg/pwdhide.png" alt=""/></span>
                            </td>
                        </tr>
                        <tr>
                            <td id="forgetmm" colspan="2" style="display: none;"><select name="powergroupid" dict-select="powergroup"><option value="0">默认角色</option></select></td>
                            <td colspan="4">
                                <div>
                                    <input type="hidden" name="action" value="login" />
                                    <button type="submit">登录</button>
                                    <!--<a class="register" href="register.jsp">注册</a>-->
                                </div>
                            </td>
                        </tr>
                        <tr class="disnone"><td></td><td class="w100"></td><td></td><td></td></tr>
                    </tbody>
                </table>
            </form>
        </div>      
        <div id="masklayer" class="masklayer"><!--遮罩层--></div>
        <%@include  file="/inc/js.html" %>
        <script type="text/javascript" src="/js/login.js"></script>
        <script src="/data/staff.js"></script>
        <script type="text/javascript">
            if (passwordjsp == 1) {
                popuplayer.display("/password.jsp?TB_iframe=true", '修改密码', {width: 650, height: 400});
            }

            RssCode.alert('<% out.print(req.get("rsscode"));%>');
            $("#loginleft").click(function () {
                window.open("/delegatexweb/bmweb.jsp")
//                location.href = "/delegatexweb/bmweb.jsp"
            })
            $("#loginright").click(function () {
                window.open("/download.jsp")
//                location.href = "/download.jsp"
            })
            $("#pwdimg>img").click(function () {
                var inputtype = $(this).siblings("input").attr("type");
                if (inputtype == "password") {
                    $(this).siblings("input").attr("type", "text")
                    $(this).attr("src", "css/limg/pwdshow.png")
                } else {
                    $(this).siblings("input").attr("type", "password")
                    $(this).attr("src", "css/limg/pwdhide.png")
                }

            })
        </script>
    </body>
</html>
