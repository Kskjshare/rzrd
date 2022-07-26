<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.Staff.StaffPowerGroupList"%>
<%@page import="RssEasy.Core.CookieHelper"%>
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
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <style>
            .cellbor{width: 600px}
            .cellbor span{color: #186aa3;cursor: default;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">查询</button>
                <button type="button" transadapter="append" select="false">增加</button>
                <button type="button" transadapter="edit">修改</button>
                <!--<button type="button" transadapter="delete">删除</button>-->
                <button type="button" transadapter="power">权限设置</button>
                <button type="button" transadapter="json" select="false">创建JSON</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input type="checkbox" name="all"></th>
                            <th class="w50">操作</th>
                            <th class="w200">角色名称</th>
                            <th>角色描述</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            StaffPowerGroupList list = new StaffPowerGroupList(pageContext);
                            list.request();
                            list.select().where("name like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%'").query();
                            int a = 0;
                            while (list.for_in_rows()) {
                                a++;
                        %>
                        <tr>
                            <td><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% list.write("id"); %>" /></td>
                            <td><span style="font-weight:bold;" tid="<% list.write("id"); %>">编辑</span></td>
                            <td><% list.write("name"); %></td>
                            <td><% list.write("remark"); %></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <div class="footer">
                每页条数<select id="footerpagesize" dict-select="pagesize" def="<% out.print(list.get("pagesize"));%>"></select>
                <%
                    Pagination pagination = new Pagination(list, request);
                    pagination.pageinfo().firstpage().looppage().lastpage().display(out);
                %>
            </div>
        </form>
        <script src="/data/user.js"></script>
        <script src="/data/areadata.js"></script>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
        <script>
            $("span[tid]").click(function () {
                var tid = $(this).attr("tid")
                popuplayer.display("/staff/power/group/edit.jsp?id=" + tid + "&TB_iframe=true", '编辑', {width: 400, height: 200});
            })
        </script>
    </body>
</html>
