<%@page import="RssEasy.MySql.RssList"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.addHeader("Content-Disposition", "attachment;filename=" + DateTimeExtend.format("yyyy-MM-dd") + URLEncoder.encode("抚州市政协管理信息表", "utf-8") + ".xls");
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
            <caption>抚州市政协管理信息表</caption>
            <thead>
                <tr>
                    <!--<th>序号</th>-->
                    <th>编号</th>
                    <th>代表团名称</th>
                    <th>联系地址</th>
                    <th>层次</th>
                    <th>登录密码</th>
                    <th>联系电话</th> 
                    <th>登录账号</th>
                    <th>管理员</th>
                    <th>代表团邮编</th>
                    <th>电子邮箱</th>
                </tr>
            </thead>
            <%
                RssListView user = new RssListView(pageContext, "userrole");
                user.request();
                user.pagesize = 30;
                user.select().where("state like '%4%' and myid in (" + user.get("relationid") + ")").get_page_desc("myid");
                int x = 1;
                String cengci1[] = {"乡镇人大", "县人大", "市人大", "区人大", "全国人大"};
                while (user.for_in_rows()) {
            %>

            <tbody>
                <tr>
                    <!--<td><% out.print(x);%></td>-->
                    <td><% out.print(user.get("daibiaotuanCode"));%></td>
                    <td><% out.print(user.get("allname"));%></td>
                    <td><% out.print(user.get("missionAddr"));%></td>
                    <td><%
                        int sex = Integer.valueOf(user.get("level"));
                        out.print(cengci1[sex]);
                        %></td>
                    <td><% out.print(user.get("passwordNO"));%></td>
                    <td><% out.print(user.get("telphone"));%></td>
                    <td><% out.print(user.get("account"));%></td>
                    <td><% out.print(user.get("linkman"));%></td>
                    <td><% out.print(user.get("missionpostcode"));%></td>
                    <td><% out.print(user.get("email"));%></td>
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