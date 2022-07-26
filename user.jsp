<%-- 
    Document   : password
    Created on : 2018-7-26, 14:52:14
    Author     : Administrator
--%>

<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="java.util.Date"%>
<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
//    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
//    StaffList.IsLogin(request, response);
//    RssList entity2 = new RssList(pageContext, "user");
//    entity2.request();
//    entity.request();
    UserList list = new UserList(pageContext);
    list.request();
    list.select().where("myid=?", UserList.MyID(request)).get_first_rows();
//    if (!list.get("account").isEmpty()) {
//        RssList entity = new RssList(pageContext, "user");
//        entity.select().where("myid=?", UserList.MyID(request)).get_first_rows();
//        String a = list.get("powergroupid");
//        if (list.get("rolelist").indexOf(a) != -1 || a.equals("0")) {
//            try {
//                out.print("<script> Cookie.RemoveAll(); alert('" + a + "');</script>");
//                CookieHelper cookie = new CookieHelper(request, response);
//                UserList user = new UserList(pageContext);
//                cookie.Set("sessionid", entity.get("sessionid"));
//                cookie.Set("parentid", entity.get("parentid"));
//                cookie.Set("powergroupid", a);
//                cookie.Set("state", entity.get("state"));
//                if (!a.equals("0")) {
//                    user.keyvalue("powergroupid", a);
//                    user.update().where("account='" + list.get("account") + "' or telphone='" + list.get("telphone") + "'").submit();
//                }
//                StaffList staff = new StaffList(pageContext);
//                staff.request();
//                staff.login();
//                response.sendRedirect("index.jsp");
//            } catch (Exception ex) {
//                list.keyvalue("rsscode", ex.getMessage());
//            }
//        } else {
//            out.print("<script>  alert('该账号没有该角色登陆权限');</script>");
//        }
//    }

    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    if (req.has("account")) {
        UserList user1 = new UserList(pageContext);
        if (user1.select().where("account='" + req.get("account") + "' or telphone='" + req.get("telphone") + "'").get_first_rows()) {
            String a = req.get("powergroupid");
            if (user1.get("rolelist").indexOf(a) != -1 || a.equals("0")) {
                try {
                    out.print("<script> Cookie.RemoveAll(); </script>");
                    CookieHelper cookie = new CookieHelper(request, response);
                    UserList user = new UserList(pageContext);
                    cookie.Set("sessionid", user1.get("sessionid"));
                    cookie.Set("parentid", user1.get("parentid"));
                    cookie.Set("powergroupid", a);
                    cookie.Set("state", user1.get("state"));
                    if (!req.get("powergroupid").equals("0")) {
                        user.keyvalue("powergroupid", req.get("powergroupid"));
                        user.update().where("account='" + req.get("account") + "' or telphone='" + req.get("telphone") + "'").submit();
                    }
                    StaffList staff = new StaffList(pageContext);
                    staff.request();
                    staff.login();
                    response.sendRedirect("gateway.jsp");
                } catch (Exception ex) {
                    req.keyvalue("rsscode", ex.getMessage());
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>修改个人密码</title>
        <link href="css/resetold.css" rel="stylesheet" type="text/css" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <style>
            form>table{margin: 30px auto;width: 100%;}
            form>table tr>td:first-child{text-align: end;}
            form>table tr>td input{width: 190px;border: #eee solid 2px;height: 32px;}
            form>table tr>td span{color: red;font-size: 12px;display: none;}
            form{}
            form td>button{background: rgb(101, 113, 128);color:#fff; padding: 5px 12px; margin: 0 5px;font-size: 14px;}
            #right{text-align: right;}
            p{margin: 10px auto;width: 540px;}
            p>span{display: inline-block;width: 30px;color: red;}
            form select{height:31px;margin-left:66px;}
            form button{border:1px solid #dce6f5;width:60%;background-color:red;height:31px;color:white;}
        </style>
    </head>
    <body>

        <form method="post">
            <table id="login">
                <tbody>
                    <tr style="display:none;">
                        <td>用户名</td>
                        <td colspan="3">
                            <input type="text" placeholder="请输入用户名" id="account1" name="account1" value="<% out.print(list.get("account")); %>" />
                            <input type="text" id="account" name="account" value="<% out.print(req.get("account")); %>" />
                        </td>
                    </tr>
                    <tr style="display:none;">
                        <td>密&nbsp;&nbsp;&nbsp;码</td>
                        <td colspan="3">
                            <span id="pwdimg"><input type="password" placeholder="请输入密码" id="pwd1" name="pwd1" value="<% out.print(list.get("passwordNO"));%>" />
                                <input type="password" id="pwd" name="pwd" value="<% out.print(req.get("pwd"));%>" />
                                <img src="css/limg/pwdhide.png" alt=""/></span>
                        </td>
                    </tr>
                    <tr>
                        <td id="forgetmm" colspan="3"><select name="powergroupid" dict-select="powergroup"><option value="0">默认角色</option></select></td>
                        <td>
                            <div>
                                <input type="hidden" name="action" value="login" />
                                <button type="submit">点击切换</button>
                                <!--<a class="register" href="register.jsp">注册</a>-->
                            </div>
                        </td>
                    </tr>
                    <tr class="disnone"><td></td><td class="w100"></td><td></td><td></td></tr>
                </tbody>
            </table>
        </form>
        <%@include  file="/inc/js.html" %>
        <script type="text/javascript" src="/js/login.js"></script>
        <script src="/data/staff.js"></script>
        <!--<script src="js/rsseasy.min.js"></script>-->
        <script>
//            $("button").click(function () {
//                Cookie.RemoveAll();
//            })
//            $("#forgetmm select").change(function () {
//                alert($(this).val());
//            })
            RssCode.alert('<% out.print(req.get("rsscode"));%>');
            $(function () {
                $('input[name="account"]').val($('input[name="account1"]').val());
                $('input[name="pwd"]').val($('input[name="pwd1"]').val());
                console.log($('input[name="account1"]').val());
                console.log($('input[name="pwd1"]').val());
                console.log($('input[name="account"]').val());
                console.log($('input[name="pwd"]').val());
            })

        </script>
    </body>
</html>
