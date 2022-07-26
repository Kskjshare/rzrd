<%@page import="RssEasy.MySql.AdvertPlaceList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.MySql.AdvertList"%>
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
        <style>
            .img{height:100px;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="append" select="false">增加</button>
                <button type="button" transadapter="edit">编辑</button>
                <button type="button" transadapter="delete">删除</button>
                <button type="button" transadapter="json" select="false">初始化</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="w500 tc cellbor">
                    <thead>
                        <tr>
                            <th class="w30">选择</th>
                            <th class="w100">名字</th>
                            <th>父级</th>
                            <th>标签</th>
                            <th>查询Key</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            AdvertPlaceList list = new AdvertPlaceList(pageContext);
                            list.request();
                            list.select().get_page_asc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr>
                            <td>
                                <input type="radio" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><% out.print(list.get("name")); %></td>
                            <td advertplace="<% out.print(list.get("pid")); %>"></td>
                            <td><% out.print(list.get("marker")); %></td>
                            <td><% out.print(list.get("querykey")); %></td>
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
        <script src="../../data/advert.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
    </body>
</html>
