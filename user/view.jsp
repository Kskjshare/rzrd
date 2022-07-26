<%@page import="RssEasy.MySql.DictList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    DictList entity = new DictList(pageContext);
    entity.request();
    entity.select().where("id=?", entity.get("id")).get_first_rows();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <div class="popupwrap">           
            <table class="wp100 cellbor">
                <tr>
                    <td class="tr w60">名称：</td>
                    <td><% entity.write("title"); %></td>
                </tr>
                <tr>
                    <td class="tr">摘要：</td>
                    <td><% entity.write("summary");%></td>
                </tr>
                <tr>
                    <td class="tr">内容：</td>
                    <td><% entity.write("matter");%></td>
                </tr>
            </table>
        </div>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
