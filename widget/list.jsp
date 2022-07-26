<%@page import="RssEasy.Core.DirectoryExtend"%>
<%@page import="java.io.File"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="javax.servlet.jsp.JspWriter"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="json" select="false">初始化全局数据</button>
                <input type="hidden" id="transadapter" find="[name='myid']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 cellbor">
                    <tbody>
                        <%
                            File file = new File(DirectoryExtend.Root(request) + "data");
                            for (File f : file.listFiles()) {
                                out.print("<tr><td><a href='/data/" + f.getName() + "' target='_blank'>" + f.getName() + "</a></td></tr>");
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
    </body>
</html>
