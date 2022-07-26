<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.MySql.BankList"%>
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
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="w600 tc cellbor">
                    <thead>
                        <tr>
                            <th class="w30">选择</th>
                            <th class="w100">名字</th>
                            <th class="w80">代码</th>
                            <th>单笔限额</th>
                            <th>单日限额</th>
                            <th>ICO</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            BankList list = new BankList(pageContext);
                            list.request();
                            list.select().get_page_asc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr>
                            <td>
                                <input type="radio" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><% out.print(list.get("name")); %></td>
                            <td><% out.print(list.get("code")); %></td>
                            <td><% out.print(list.get("danbi")); %></td>
                            <td><% out.print(list.get("danri")); %></td>
                            <td popup="popup" href="/upfile/<% out.print(list.get("ico")); %>"><% out.print(list.get("ico")); %></td>
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
        <script src="/data/user.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
    </body>
</html>
