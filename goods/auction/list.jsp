<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
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
                <table class="wp100 tc cellbor">
                    <thead>
                        <tr>
                            <th class="w30">选择</th>
                            <th class="w60">名称</th>
                            <th class="w200">图片</th>
                            <th class="w120">时间</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssList list = new RssList(pageContext, "goods");
                            list.request();
                            list.select().where("type=2").get_page_desc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr>
                            <td>
                                <input type="radio" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td artstate="<% list.write("title"); %>"></td>
                            <td popup="popup" href="/upfile/<% out.print(list.get("ico")); %>"><% out.print(list.get("ico")); %></td>
                            <td rssdate="<% list.write("shijian"); %>,yyyy-MM-dd HH:mm:ss"></td>
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
        <script src="/data/goods.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
    </body>
</html>
