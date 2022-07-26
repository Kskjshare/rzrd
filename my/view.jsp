<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" />
    </head>
    <body>
        <div id="mainwrap">
            <%
                UserList entity = new UserList(pageContext);
                entity.select().where("myid=?", UserList.MyID(request)).get_first_rows();
            %>
            <div class="bodywrap">
                <table class="cellbor w400">
                    <tbody>
                        <tr>
                            <td class="tr w80">MyID：</td>
                            <td><% entity.write("myid"); %></td><!--
                        </tr>-->
                        <tr>
                            <td class="tr">帐号：</td>
                            <td><%entity.write("account");%></td>
                        </tr>
                        <tr>
                            <td class="tr">姓名：</td>
                            <td><%entity.write("realname");%></td>
                        </tr>
                        <tr>
                            <td class="tr">手机号：</td>
                            <td><%entity.write("account");%></td>
                        </tr>
<!--                        <tr>
                            <td class="tr">座机号：</td>
                            <td><%entity.write("zuoji");%></td>
                        </tr>-->
                    </tbody>
                </table>
            </div>
        </div>
        <script src="/data/staff.js"></script>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
