<%@page import="RssEasy.MySql.RssList"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.addHeader("Content-Disposition", "attachment;filename=" + DateTimeExtend.format("yyyy-MM-dd") + URLEncoder.encode("汝州市区、市、县、乡人大代信息名册表", "utf-8") + ".xlsx");
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
            <caption>汝州市区、市、县、乡人大代信息名册表</caption>
            <thead>
                <tr>
                    <th rowspan="2">序号</th>
                    <th rowspan="2">姓名</th>
                    <th rowspan="2">性别</th>
                    <th rowspan="2">民族</th>
                    <th rowspan="2">出生年月</th>
                    <th rowspan="2">身份证号</th>
                    <th rowspan="2">单位职务</th>
                    <th rowspan="2">详细住址</th>
                    <th rowspan="2">手机号码(移动)(电信)</th>
                    <th rowspan="2">代表阶层</th>
                    <th rowspan="1">电子版相片</th>
                    <th rowspan="2">备注</th>
                </tr>
                <tr>
                    <th>(注:相片要2寸蓝底照,要求穿白衬衫打领带.)注明有或否</th>
                </tr>
            </thead>
            <%                       
                RssListView user = new RssListView(pageContext, "userrole");
                user.request();
                user.select().where("state=2").get_page_desc("myid");
                int x = 1;
                while (user.for_in_rows()) {
            %>

            <tbody>
                <tr>
                    <td><% out.print(x);%></td>
                    <td><% out.print(user.get("realname"));%></td>
                    <td><% out.print(user.get("sex"));%></td>
                    <td><% out.print(user.get("nationid"));%></td>
                    <td><% out.print(user.get("birthday"));%></td>
                    <td><% out.print(user.get("idcard"));%></td>
                    <td><% out.print(user.get("job"));%></td>
                    <td><% out.print(user.get("homeaddress"));%></td>
                    <td><% out.print(user.get("telphone"));%></td>
                    <td></td>
                    <td>
                        <% 
                            if (user.get("avatar").equals("avatar.png")) {
                                out.print("否");
                            } else {
                                out.print("是");
                            }
                        %></td>
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