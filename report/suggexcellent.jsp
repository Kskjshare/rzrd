<%@page import="RssEasy.MySql.RssList"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.addHeader("Content-Disposition", "attachment;filename=" + DateTimeExtend.format("yyyy-MM-dd") + URLEncoder.encode("自治县十五届人民代表大会第二次会议优秀建议目录","utf-8") + ".xlsx");
    response.addHeader("Content-Type","application/ms-excel");
    response.addHeader("Pragma","no-cache");
    response.addHeader("Expires","0");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="textml; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <table border="1">
            <caption>自治县十五届人民代表大会第二次会议优秀建议目录</caption>
                    <thead>
                        <tr>
                            <th rowspan="2">序号</th>
                            <th rowspan="2">建议编号</th>
                            <th colspan="2">提建议人</th>
                            <th rowspan="2">建议标题</th>
                            <th rowspan="2">拟主办单位</th>
                            <th rowspan="2">备注</th>
                        </tr>
                        <tr>
                            <th>单位</th>
                            <th>姓名</th>
                        </tr>
                    </thead>
                   <%
                       
                            RssListView list = new RssListView(pageContext, "sort");
                            list.request();
                            list.select().where("excellent=2 and lwstate=1").get_page_desc("id");
                            int x = 1;
                            while (list.for_in_rows()) {
                                %>
                           
                    <tbody>
                        <tr>
                            <td><% out.print(x);%></td>
                            <td><% out.print(list.get("realid"));%></td>
                            <td><% out.print(list.get("company"));%></td>
                            <td><% out.print(list.get("realname"));%></td>
                            <td><% out.print(list.get("title"));%></td>
                            <td><% out.print(list.get("organizer"));%></td>
                            <td></td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <%
                            x++;
                        }
                        %>
                    </tfoot>    
                </table>
    </body>
<ml>