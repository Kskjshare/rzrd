<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.addHeader("Content-Disposition", "attachment;filename=" + DateTimeExtend.format("yyyy-MM-dd") + URLEncoder.encode("立法项目库表", "utf-8") + ".xls");
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
            <caption>公开条例</caption>
            <thead>
                <tr>
                    <th>序号</th>
                    <th>标题</th>
                    <th>通过时间</th>
                    <th>批准时间</th>
                    <th>公布时间</th>
                    <th>实施时间</th>
                    <th>创建者</th>
                    <th>创建时间</th>
                </tr>
            </thead>
            <%
                RssList mas = new RssList(pageContext, "disclosure_regulations");
                mas.request();
                mas.pagesize = 30;
                mas.select().where("id in(" + mas.get("legislativeid") + ")").get_page_desc("id");
                int x = 1;
                while (mas.for_in_rows()) {
            %>

            <tbody>
                <tr>
                    <td class="w30"><% out.print(x); %></td>
                    <!--<td><input type="checkbox" name="id" value="<% out.print(mas.get("id")); %>" /></td>-->

                    <td><% out.print(mas.get("title")); %></td>
                    <td><% out.print(mas.get("passtime").replaceAll("-", ".")); %></td>
                    
                    <td><% out.print(mas.get("approvethetime").replaceAll("-", ".")); %></td>
                    <td><% out.print(mas.get("announcementtime").replaceAll("-", ".")); %></td>
                    <td><% out.print(mas.get("implementationtime").replaceAll("-", ".")); %></td>
                    <td>
                        <%
                            RssList user1 = new RssList(pageContext, "user");
                            user1.select().where("myid=?", mas.get("myid")).get_first_rows();
                            out.print(user1.get("realname").isEmpty() ? "无" : user1.get("realname"));
                        %>
                    </td>
                    <%
                        String data1 = DateTimeExtend.format(Integer.parseInt(mas.get("shijian")), "yyyy.MM.dd");
                    %>
                    <td><%=data1 %></td><!-- 显示格式化后的时间 -->
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