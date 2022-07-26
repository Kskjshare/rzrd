<%@page import="RssEasy.MySql.RssList"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.addHeader("Content-Disposition", "attachment;filename=" + DateTimeExtend.format("yyyy-MM-dd") + URLEncoder.encode("主办单位信息表", "utf-8") + ".xls");
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
            <caption>主办单位信息表</caption>
            <thead>
                <tr>
                    <th>单位编号</th>
                    <th>单位类别</th>
                    <th>单位名称</th>
                    <th>单位地址</th>
                    <th>负责人</th>
                    <th>单位管理员</th>
                    <th>联系人</th>
                    <th>登录密码</th>
                    <th>单位电话</th>
                    <th>登录名</th>
                    <th>电子邮箱</th>
                </tr>
            </thead>
            <%
                RssListView user = new RssListView(pageContext, "userrole");
                user.request();
                user.pagesize = 30;
                user.select().where("state like '%3%' and myid in(" + user.get("relationid") + ")").get_page_desc("myid");
                int x = 1;
                while (user.for_in_rows()) {
            %>

            <tbody>
                <tr>
                    <td><% out.print(user.get("danweiCode"));%></td>
                    <td><%
                        RssList list = new RssList(pageContext, "companytype_classify");
                        list.select().where("id=?", user.get("comtype")).get_first_rows();
                        out.print(list.get("name"));
                        %></td>
                    <td><% out.print(user.get("company"));%></td>
                    <td><% out.print(user.get("workaddress"));%></td>
                    <td><% out.print(user.get("person"));%></td>
                    <td><% out.print(user.get("dwadmin"));%></td>
                    <td><% out.print(user.get("linkman"));%></td>
                    <td><% out.print(user.get("passwordNO"));%></td>
                    <td><% out.print(user.get("worktel"));%></td>
                    <td><% out.print(user.get("account"));%></td>
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
        <script src="/data/companytype.js" type="text/javascript"></script>
    </body>
    <ml>