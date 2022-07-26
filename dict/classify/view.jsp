<%@page import="RssEasy.MySql.DictClassifyList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    DictClassifyList entity = new DictClassifyList(pageContext);
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
            <table class="cellbor">
                <tr>
                    <td class="tr w60">名称：</td>
                    <td><% entity.write("name"); %></td>
                </tr>
                <tr>
                    <td class="tr">父级：</td>
                    <td dictclassifyid="<% entity.write("pid");%>"></td>
                </tr>
                <tr>
                    <td class="tr">标识：</td>
                    <td><% entity.write("marker");%></td>
                </tr>
                <tr>
                    <td class="tr">查询KEY：</td>
                    <td><% entity.write("querykey");%></td>
                </tr>
            </table>
        </div>
        <script src="/data/dict.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
