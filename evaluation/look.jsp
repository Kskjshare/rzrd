<%-- 
    Document   : see
    Created on : 2018-5-14, 12:00:34
    Author     : Administrator
--%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    RssListView list = new RssListView(pageContext, "sort");
    String[] ta = {"0", "0", "0"};
    list.query("SELECT myid,resume,consultation,COUNT(*) AS num FROM sort_list_view WHERE draft=2 and myid="+UserList.MyID(request)+" GROUP BY myid,resume,consultation");
    while (list.for_in_rows()) {
        if (list.get("resume").equals("0") && list.get("consultation").equals("0")) {
             ta[0] = list.get("num");
        } else if (list.get("resume").equals("1") && list.get("consultation").equals("0")) {
             ta[1] = list.get("num");
        } else if (list.get("resume").equals("1") && list.get("consultation").equals("1")) {
             ta[2] = list.get("num");
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <style>
            .tabheader{background: #82bee9;text-align: center; color: #fff;line-height: 30px}
            .cellbor>tbody>tr>td,.cellbor>tbody>tr>th{border: #6caddc solid thin;line-height: 20px;}
            .dce{background: #dce6f5;}
            .indent{text-indent: 10px}
        </style>
    </head>
    <body>
        <div>
            <table class="cellbor auto margintop">
                <tr>
                    <td colspan="5" class="tabheader">议案建议提交情况</td>
                </tr>
                <tr class="dce">
                    <th class="w100">项目</th>
                    <th colspan="2">说明</th>
                    <th class="w100">数目</th>
                    <th class="w100">操作</th>
                </tr>

                <tr align="center">
                    <td rowspan="2">未填写</td>
                    <td align="left" class="w300" colspan="2" class="indent">承办单位未答复(没有办理回复报告)的意见建议</td>
                    <td><% out.print(ta[0]); %></td>
                    <td><a href="table.jsp?resume=0&consultation=0">查看</a></td>
                </tr>
                <tr align="center">
                    <td align="left" class="w300" colspan="2" class="indent">承办单位已答复(已有办理回复报告)的意见建议</td>
                    <td><% out.print(ta[1]);%></td>
                    <td><a href="table.jsp?resume=1&consultation=0">查看</a></td>
                </tr>
                <tr align="center">
                    <td>已填写</td>
                    <td align="left" colspan="2" class="indent">代表已填写对议案建议办理答复的意见</td>
                    <td><% out.print(ta[2]);%></td>
                    <td><a href="table.jsp?resume=1&consultation=1">查看</a></td>
                </tr>
                <tr class="dce"> </tr>
            </table>
        </div>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
    </body>
</html>
