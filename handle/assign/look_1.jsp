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
    list.pagesize=1000000;
    list.select().where("type=1 and deal=0 and draft=2 and examination=2 and handlestate=3").get_page_desc("id");
    RssListView list1 = new RssListView(pageContext, "sort");
    list1.pagesize=1000000;
    list1.select().where("type=1 and deal=1 and draft=2 and examination=2 and handlestate=3").get_page_desc("id");
    RssListView list2 = new RssListView(pageContext, "sort");
    list2.pagesize=1000000;
    list2.select().where("type=2 and deal=0 and draft=2 and examination=2 and handlestate=3").get_page_desc("id");
    RssListView list3 = new RssListView(pageContext, "sort");
    list3.pagesize=1000000;
    list3.select().where("type=2 and deal=1 and draft=2 and examination=2 and handlestate=3").get_page_desc("id");
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
                    <th class="w100">分类</th>
                    <th class="w100">项目</th>
                    <th class="w100">说明</th>
                    <th class="w100">数目</th>
                    <th class="w100">操作</th>
                </tr>
                <tr align="center">
                    <td rowspan="2">建议</td>
                    <td>未交办</td>
                    <td align="left" class="w400 indent">未正式交办的建议</td>
                    <td><% out.print(list.totalrows); %></td>
                    <td><a href="table.jsp?type=1&deal=0&examination=2&handlestate=3">查看</a></td>
                </tr>
                <tr align="center">
                    <td>已交办</td>
                    <td align="left" class="indent">已正式交办的建议</td>
                    <td><% out.print(list1.totalrows); %></td>
                    <td><a href="table.jsp?type=1&deal=1&examination=2&handlestate=3">查看</a></td>
                </tr>
                <tr align="center">
                    <td rowspan="2">议案</td>
                    <td>未交办</td>
                    <td align="left" class="w400 indent">未正式交办的议案</td>
                    <td><% out.print(list2.totalrows); %></td>
                    <td><a href="table.jsp?type=2&deal=0&examination=2&handlestate=3">查看</a></td>
                </tr>
                <tr align="center">
                    <td>已交办</td>
                    <td align="left" class="indent">已正式交办的议案</td>
                    <td><% out.print(list3.totalrows); %></td>
                    <td><a href="table.jsp?type=2&deal=1&examination=2&handlestate=3">查看</a></td>
                </tr>
            </table>
        </div>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
    </body>
</html>
