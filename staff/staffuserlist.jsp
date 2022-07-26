<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.addHeader("Content-Disposition", "attachment;filename=" + DateTimeExtend.format("yyyy-MM-dd") + URLEncoder.encode("系统用户表", "utf-8") + ".xls");
    response.addHeader("Content-Type", "application/ms-excel");
    response.addHeader("Pragma", "no-cache");
    response.addHeader("Expires", "0");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="textml; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <table border="1">
            <caption>系统用户表</caption>
            <thead>
                <tr>
                    <th>序号</th>
                    <th>登录名</th>
                    <th>用户(管理员)姓名</th>
                    <th>用户组别</th>
                    <th>角色组别</th>
                    <th>注册日期</th>
                    <th>启用状态</th>
                </tr>
            </thead>
            <%
                RssListView list = new RssListView(pageContext, "user_delegation");
                list.request();
                list.select().where("myid in (" + list.get("relationid") + ")").get_page_desc("myid");
                int a = 1;
                while (list.for_in_rows()) {
            %>

            <tbody>
                <tr>
                    <td><% out.print(a);%></td>
                    <td><% out.print(list.get("account")); %></td>
                    <td><% out.print(list.get("state").equals("3") || list.get("state").equals("4") ? list.get("linkman") : list.get("realname")); %></td>
                    <td><% out.print(list.get("departmentname")); %></td>
                    <td><% out.print(list.get("groupname")); %></td>
                    <td><%
                        if (!list.get("shijian").isEmpty()) {
                            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                        long sj = Long.parseLong(list.get("shijian")) * 1000;
                        String s = simpleDateFormat.format(sj);
                        out.print(s);    
                            }
                        %></td>
                    <td><% out.print(list.get("enabled").equals("1") ? "启用" : "已禁用"); %></td>
                </tr>
            </tbody>
            <tfoot>
                <%
                        a++;
                    }
                %>
            </tfoot>    
        </table>
    </body>
    <ml>