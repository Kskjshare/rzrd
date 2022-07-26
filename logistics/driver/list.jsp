<%-- 
    Document   : list
    Created on : 2018-4-3, 10:26:28
    Author     : 高正
--%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.MessageList"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>管理系统</title>
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
                            <th class="w60">创建人</th>
                            <th class="w60">司机姓名</th>
                            <th class="w60">司机手机号</th>
                            <th class="w60">支付宝账号</th>
                            <th class="w60">货车类型</th>
                            <th class="w60">车牌号</th>
                            <th class="w60">车辆状态</th>
                            <th class="w60">时间</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssListView list = new RssListView(pageContext, "driver");
                            list.request();
                            list.select().get_page_desc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr>
                            <td><input type="radio" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td class="w60"><% list.write("realname"); %></td>
                            <td class="w60"><% list.write("drivername"); %></td>
                            <td class="w60"><% list.write("tel"); %></td>
                            <td class="w60"><% list.write("alipay"); %></td>
                            <td class="w60" cartype="<% list.write("freightcartype"); %>"></td>
                            <td class="w60"><% list.write("carnumber"); %></td>
                            <td class="w60" carstate="<% list.write("cartype"); %>"></td>
                            <td class="w60" rssdate="<% list.write("shijian"); %>,yyyy-MM-dd HH:mm:ss"></td>
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
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
    </body>
</html>
