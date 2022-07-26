<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>管理系统</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link href="/css/reset.css" rel="stylesheet" type="text/css" />
    <link href="/css/layout.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form method="post" id="mainwrap">
        <div class="toolbar">
            <button type="button" transadapter="append" select="false">增加</button>
            <button type="button" transadapter="edit">编辑</button>
            <button type="button" transadapter="delete">删除</button>
            <button type="button" transadapter="power">权限</button>
                <button type="button" transadapter="json" select="false">创建JSON</button>
            <input type="hidden" id="transadapter" find="[name='parentid']:checked" />
        </div>
        <div class="bodywrap nofooter">
            <ul levelhelper="position" class="lanmubankuai"></ul>
        </div>
    </form>
    <script src="/data/staff.js"></script>
    <%@include  file="/inc/js.html" %>
    <script src="controller.js"></script>
</body>
</html>
