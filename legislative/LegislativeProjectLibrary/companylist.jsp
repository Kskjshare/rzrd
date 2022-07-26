<%@page import="RssEasy.MySql.RssList"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
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
            <caption>立法项目库表</caption>
            <thead>
                <tr>
                    <th>序号</th>
                    <th>标题</th>
                    <th>提出人</th>
                    <th>提出单位或代表团</th>
                    <th>提出时间</th>
                    <th>创建者</th>
                    <th>创建时间</th>
                </tr>
            </thead>
            <%
                RssList mas = new RssList(pageContext, "legislative_project_library");
                mas.request();
                mas.pagesize = 30;
                mas.select().where("id in(" + mas.get("legislativeid") + ")").get_page_desc("id");
                int x = 1;
                while (mas.for_in_rows()) {
            %>

            <tbody>
                <tr>
                    <td class="w30"><% out.print(x); %></td>
                    <td><% out.print(mas.get("title"));%></td>
                    <td><% out.print(mas.get("proposer"));%></td>
                    <td><% out.print(mas.get("proposingunit")); %></td>
                    <!--<td rssdate="<% // out.print(mas.get("proposaltime")); %>,yyyy-MM-dd" ></td>-->
                    <%
                        String data2 = DateTimeExtend.format(Integer.parseInt(mas.get("proposaltime")), "yyyy.MM.dd");
                    %>
                    <td><%=data2 %></td><!-- 显示格式化后的时间 -->
                    <td>
                        <%
                            RssList user1 = new RssList(pageContext, "user");
                            user1.select().where("myid=?", mas.get("myid")).get_first_rows();
                            out.print(user1.get("realname").isEmpty() ? "无" : user1.get("realname"));
                        %>
                    </td>
                    <!--<td rssdate="<% // mas.write("shijian"); %>,yyyy-MM-dd hh:mm:ss" ></td> 显示格式化后的时间 -->
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