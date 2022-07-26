<%@page import="RssEasy.MySql.RssList"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.addHeader("Content-Disposition", "attachment;filename=" + DateTimeExtend.format("yyyy-MM-dd") + URLEncoder.encode("自治县十五届人大二次会议代表建议承办单位办理情况满意度测评表","utf-8") + ".xlsx");
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
            <caption>自治县十五届人大二次会议代表建议承办单位办理情况满意度测评表</caption>
                    <thead>
                        <tr>
                            <th rowspan="2">序号</th>
                            <th rowspan="2">承办代表建议单位</th>
                            <th rowspan="2">承办建议数</th>
                            <th colspan="3">代表测评情况</th>
                            <th rowspan="2">排名</th>
                            <th rowspan="2">备注</th>
                        </tr>
                        <tr>
                            <th>满意<p>(80分-100分)</p></th>
                            <th>基本满意<p>(60分-79分)</p></th>
                            <th>不满意<p>(59分以下)</p></th>
                        </tr>
                    </thead>
                   <%
                       
                            RssListView list = new RssListView(pageContext, "userrole");
                            RssListView company = new RssListView(pageContext, "suggest_company");
                            list.request();
                            list.select().where("state like '%3%'").get_page_desc("myid");
                            int x = 1;
                            while (list.for_in_rows()) {
                             company.pagesize = 10000000;
                             company.select().where("companyid=" + list.get("myid")).get_page_desc("suggestid");    
                             
                                %>
                           
                    <tbody>
                        <tr>
                            <td><% out.print(x);%></td>
                            <td><% out.print(list.get("allname"));%></td>
                            <td><% out.print(company.totalrows);%></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <%
                            x++;
                        }
                        %>
<!--                        <tr>
                        </tr>-->
                    </tfoot>    
                </table>
    </body>
<ml>

