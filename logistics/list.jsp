<%-- 
    Document   : list
    Created on : 2018-4-2, 22:14:48
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
                            <th class="w60">物流发布人</th>
                            <th class="w60">起点</th>
                            <th class="w60">终点</th>
                            <th class="w60">煤炭吨数</th>
                            <th class="w60">煤炭价格</th>
                            <th class="w60">装车费</th>
                            <th class="w60">卸车费</th>
                            <th class="w60">运费</th>
                            <th class="w60">车辆数</th>
                            <th class="w60">时间</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssListView list = new RssListView(pageContext, "logistics_user");
                            list.request();
                            list.select().get_page_desc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr>
                            <td><input type="radio" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td class="w60"><% list.write("realname"); %></td>
                            <td class="w60"><% list.write("zero"); %></td>
                            <td class="w60"><% list.write("end"); %></td>
                            <td class="w60"><% list.write("coalnumber"); %></td>
                            <td class="w60"><% list.write("coalprice"); %></td>
                            <td class="w60"><% list.write("shipmentprice"); %></td>
                            <td class="w60"><% list.write("unloadingprice"); %></td>
                            <td class="w60"><% list.write("shippingcost"); %></td>
                            <td class="w60"><% list.write("carnumber"); %></td>
                            <td rssdate="<% list.write("shijian"); %>,yyyy-MM-dd HH:mm:ss" class="w60"></td>
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
