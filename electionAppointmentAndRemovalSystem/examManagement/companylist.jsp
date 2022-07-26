<%@page import="RssEasy.MySql.RssList"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.addHeader("Content-Disposition", "attachment;filename=" + DateTimeExtend.format("yyyy-MM-dd") + URLEncoder.encode("考生信息表", "utf-8") + ".xls");
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
            <caption>考生信息表</caption>
            <thead>
                <tr>
                    <th>考生姓名</th>
                    <th>手机号</th>
                    <th>身份证</th>
                    <th>密码</th>
                    <th>考生类别</th>
                </tr>
            </thead>
            <%
                RssList mas = new RssList(pageContext, "question_examinee");
                mas.request();
                mas.pagesize = 30;
                mas.select().where("id in(" + mas.get("id") + ")").get_page_desc("id");
                int x = 1;
                while (mas.for_in_rows()) {
            %>

            <tbody>
                <tr>
                    <td><% out.print(mas.get("name"));%></td>
                    <td><% out.print(mas.get("tel"));%></td>
                    <td><% out.print(mas.get("idCard"));%></td>
                    <td><% out.print(mas.get("pwd"));%></td>
                    <td >
                         <%  
                            switch (mas.get("category")){
                                case "1":
                                    out.print("政府系统");
                                    break;
                                case "2":
                                    out.print("人大系统");
                                    break;
                                case "3":
                                    out.print("监委"); 
                                    break;
                                case "4":
                                     out.print("法院");
                                    break;
                                case "5":
                                     out.print("检察院");
                                     break;
                                default:
                                    out.print("");
                                break;
                            }
                           
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