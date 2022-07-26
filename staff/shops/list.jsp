<%@page import="RssEasy.MySql.Staff.StaffListView"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
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
            <button type="button" transadapter="edit">编辑</button>
            <button type="button" transadapter="append" select="false">添加</button>
            <button type="button" transadapter="delete">删除</button>
            <button type="button" transadapter="power">权限</button>
            <input type="hidden" id="transadapter" find="[name='myid']:checked" />
        </div>
        <div class="bodywrap nofooter">
            <table class="wp100 tc cellbor">
                <thead>
                    <tr>
                        <th class="w30">选择</th>
                        <th class="w50">MyID</th>
                        <th class="w150">帐号</th>
                        <th class="w80">姓名</th>
                        <th class="w100">工作地点</th>
                        <th class="w80">入职时间</th>
                        <th>企业邮箱</th>
                        <th>办公电话</th>
                        <th>手机号码</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        StaffListView list=new StaffListView(pageContext);
                        list.request();
                        list.select().where("type=2").query();
                        while (list.for_in_rows())
                        {
                    %>
                    <tr>
                        <td>
                            <input type="radio" name="myid" value="<% out.print(list.get("myid")); %>" /></td>
                        <td><% out.print(list.get("myid")); %></td>
                        <td class="tl"><% out.print(list.get("account")); %></td>
                        <td><% out.print(list.get("realname")); %></td>
                        <td campusid="<% out.print(list.get("campusid")); %>"></td>
                        <td riqidata="<% out.print(list.get("ruzhiriqi")); %>,yyyy-MM-dd"></td>
                        <td><% out.print(list.get("email")); %></td>
                        <td><% out.print(list.get("zuoji")); %></td>
                        <td><% out.print(list.get("telphone")); %></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </form>
    <script src="/data/staff.js"></script>
    <%@include  file="/inc/js.html" %>
    <script src="controller.js"></script>
</body>
</html>
