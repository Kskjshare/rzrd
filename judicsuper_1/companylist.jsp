<%@page import="RssEasy.MySql.RssList"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.addHeader("Content-Disposition", "attachment;filename=" + DateTimeExtend.format("yyyy-MM-dd") + URLEncoder.encode("信访信息表", "utf-8") + ".xls");
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
            <caption>信访信息表</caption>
            <thead>
                <tr>
                    <th>信访件编号</th>
                    <th>信访人</th>
                    <th>信访主题</th>
                    <th>信访日期</th>
                    <th>主办单位</th>
                    <th>信访形式</th>
                    <th>问题属地</th>
                    <th>信访原因</th>
                </tr>
            </thead>
            <%
                RssList user = new RssList(pageContext, "petition");
                user.request();
                user.pagesize = 30;
                user.select().where("id in(" + user.get("relationid") + ")").get_page_desc("id");
                int x = 1;
                while (user.for_in_rows()) {
            %>

            <tbody>
                <tr>
                    <td><% out.print(user.get("petition"));%></td>
                    <td><% out.print(user.get("petitioner"));%></td>
                    <td><% out.print(user.get("title"));%></td>
                    <td><% out.print(user.get("datapetition"));%></td>
                    <td><% out.print(user.get("organizer"));%></td>
                    <td>
                    <%
                        RssList list = new RssList(pageContext, "petition_classify");
                        list.select().where("id=?", user.get("petitionclassify")).get_first_rows();
                        out.print(list.get("title"));
                        %>
                    </td>
                    <td><% out.print(user.get("problemter"));%></td>
                    <td>
                    <%
                        RssList list1 = new RssList(pageContext, "petitionform_classify");
                        list1.select().where("id=?", user.get("reapetition")).get_first_rows();
                        out.print(list1.get("title"));
                        %>
                    </td>
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