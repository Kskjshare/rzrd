<%@page import="RssEasy.MySql.RssList"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.addHeader("Content-Disposition", "attachment;filename=" + DateTimeExtend.format("yyyy-MM-dd") + URLEncoder.encode("立法规划表", "utf-8") + ".xls");
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
            <caption>立法规划表</caption>
            <thead>
                <tr>
                    <th>标题</th>
                    <th>通过时间</th>
                    <th>创建者</th>
                    <th>创建时间</th>
                    <th>备注</th>
                </tr>
            </thead>
            <%
                RssList mas = new RssList(pageContext, "legislative_planning");
                mas.request();
                mas.pagesize = 30;
                mas.select().where("id in(" + mas.get("legislativeid") + ")").get_page_desc("id");
                int x = 1;
                while (mas.for_in_rows()) {
            %>

            <tbody>
                <tr>
                    <td><% out.print(mas.get("title"));%></td>
                    <td><% out.print(mas.get("passingtime"));%></td>
                    <td>
                    <%
                        RssList list = new RssList(pageContext, "user");
                        list.select().where("myid=?", mas.get("myid")).get_first_rows();
                        out.print(list.get("realname"));
                        %>
                    </td>
                    <td><% out.print(mas.get("shijian"));%></td>
                    <td><% out.print(mas.get("remarks"));%></td>
                </tr>
            </tbody>
            <tfoot>
                <%
                        x++;
                    }
                %>
            </tfoot>    
        </table>
        <script src="/data/companytype.js" type="text/javascript"></script>
    </body>
    <ml>