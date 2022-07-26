
<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="java.util.Date"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/data/contants.jsp"%><!--added by jackie //-->
<%    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    out.print("<script> var passwordjsp=0</script>");

    if (req.has("account")) {
        UserList user1 = new UserList(pageContext);
        if (user1.select().where("account='" + req.get("account") + "' or telphone='" + req.get("telphone") + "'").get_first_rows()) {
            String a = req.get("powergroupid");
            if (user1.get("rolelist").indexOf(a) != -1 || a.equals("0")) {
                if (user1.get("enabled").equals("2")
                        || (flowtype.equals("2") && user1.get("powergroupid").equals("22"))//流程类型是议审委初审且是代表团登录//added by jackie
                        || (flowtype.equals("1") && user1.get("powergroupid").equals("7"))//流程类型是代表团初审且是议审委登录//added by jackie
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
                            response.sendRedirect("/index.jsp");
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
    <head><meta http-equiv=Content-Type content='text/html; charset=utf-8'>

        <meta name="viewport" content="width=device-width" />
        <title>智慧人大综合服务管理系统</title>
        <link rel="icon" type="image/png" href="../Images/favicon.png"  />
        <link rel="stylesheet" type="text/css" href="../FormWork/easyui/themes/default/easyui.css" />
        <link href="../FormWork/fontawesome/css/font-awesome.min.css"  rel="stylesheet" type="text/css" />
        <link rel="stylesheet" type="text/css" href="../FormWork/easyui/themes/icon.css"  />
        <link rel="stylesheet" type="text/css" href="../Content/Share/common.css"  />
        <script src="../Scripts/Share/Help.js" type="text/javascript"></script>
        <script type="text/javascript" src="../FormWork/easyui/jquery.min.js" ></script>
        <script type="text/javascript" src="../FormWork/easyui/jquery-migrate-1.2.1.min.js" ></script>
        <script type="text/javascript" src="../FormWork/easyui/jquery-ui-1.9.2.custom.min.js" ></script>
        <script type='text/javascript' src="../FormWork/easyui/autocompelete/jquery.autocomplete.js" ></script>
        <script type="text/javascript" src="../FormWork/easyui/jquery.validate.min.js"></script>
        <script type="text/javascript" src="../FormWork/easyui/modernizr.min.js"></script>
        <script type="text/javascript" src="../Scripts/Share/jquery.cookie.js" ></script>
        <script type="text/javascript" src="../FormWork/easyui/jquery.easyui.min.js" ></script>
        <script type="text/javascript" src="../FormWork/easyui/locale/easyui-lang-zh_CN.js"></script>
        <script type="text/javascript" src="../Scripts/Share/echarts.js" ></script>
        <script type="text/javascript" src="../Scripts/Share/common.js" ></script>
        <script type="text/javascript" src="../FormWork/easyui/validate.js" ></script>
        <script type="text/javascript" src="../Scripts/Share/UnicodeAnsi.js" ></script>
        <script type="text/javascript" src="../Scripts/Share/base64.js" ></script>
        <script type="text/javascript" src="../Scripts/Share/intro.js" ></script>
        <script type="text/javascript" src="../Scripts/Share/timeClear.js"></script>
        <script type="text/javascript" src="../Scripts/Share/json2.js" ></script>
        <link rel="stylesheet" type="text/css" href="../Content/Share/introjs.css"/>
        <script src="../Scripts/Share/jquery-migrate-1.4.1.min.js"  type="text/javascript"></script>
        <script src="../Scripts/Share/jqprint-0.3.js" type="text/javascript"></script>

        <link href="../Content/globa/Login.css"  rel="stylesheet" type="text/css" />
    </head>
    <body style="text-align: center;">

        <div style="width: 444px; height: 527px; background-image:url(../images/dlk.png);background-size:100% 100%; text-align:center;position:absolute; left:50%; margin-left:-222px; top:50%; margin-top:-263px;">
            <form  method="post" id="trylogin">
                <input name="__RequestVerificationToken" type="hidden" value="jT5z0Ku5xqeh9NuHdjif9clSnTQTzsOoMWeHk9quKOajVdx2mVMofyLKiAq7VL2LJQcjqLSranersSdS3WKDYTQLpgJuDXNEU8inroTjlucvc_NLX75ncC1kKDNM9Pmj2m1ZU2sq2lLyl7IKyVCFWs9kWRqnCJuz48Fe2kKe7o41" />
                <img src="../images/logo.png"  style="margin-top: 60px;" />
                <img src="../images/yhm-30-lanse.png"  style="margin-top: 40px;" />
                <input type="text" placeholder="账&nbsp;号"  id="account" name="account" value="<% out.print(req.get("account")); %>"  style="width: 160px;
                       height: 20px; line-height: 20px; font-size: 14px; border: 0px; background: rgba(0, 0, 0, 0); background-color:rgba(0, 0, 0, 0) !important;
                       outline: none; position: relative; top: -40px; left: -10px;" />


                <img src="../images/mm-30-lanse.png"  style="margin-top: 20px;" />
                <input type="password" placeholder="密&nbsp;码"  id="pwd" name="pwd" value="<% out.print(req.get("pwd"));%>" style="width: 160px;
                       height: 20px; line-height: 20px; font-size: 14px; border: 0px; background: rgba(0, 0, 0, 0);
                       outline: none; position: relative; top: -40px; left: -10px;"  />
                <img id="login" src="../images/trylogin.png" style="margin-top: 10px;" />
                <button type="submit" style="display:none;"></button>
                <input type="hidden" name="action" value="login" />
                
            </form>
        </div>
        <%@include  file="/inc/js_loginpage.html" %>
        <!--<script src="../Scripts/globa/Login.js" type="text/javascript"></script>-->
        <script type="text/javascript">
//            if (passwordjsp == 1) {
//                popuplayer.display("/password.jsp?TB_iframe=true", '修改密码', {width: 650, height: 400});
//            }
            $('#login').click(function () {
                $(this).next().click();
            })
            RssCode.alert("<% out.print(req.get("rsscode"));%>");


        </script>
    </body>
</html>
