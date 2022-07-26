<%@page import="RssEasy.MySql.Staff.StaffPowerList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    StaffPowerList list = new StaffPowerList(pageContext);
    list.select("max(offsetid) as offsetid").get_first_rows();
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
                <button type="button" transadapter="append" select="false">增加</button>
                <button type="button" transadapter="update">编辑</button>
                <button type="button" transadapter="delete">删除</button>
                <button type="button" transadapter="json" select="false">创建JSON</button>
                最大权限位：<% list.write("offsetid");%>
                <input type="hidden" id="transadapter" find="[name='pid']:checked" />
            </div>
            <div class="bodywrap nofooter">
                <ul levelhelper="power" offset="2" class="lanmubankuai"></ul>
            </div>
        </form>
        <script src="/data/staff.js"></script>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
    </body>
</html>
