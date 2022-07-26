<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.MySql.RssListView"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    RssList entity = new RssList(pageContext, "statute");
//    RssList sessionid = new RssList(pageContext, "session");
    entity.request();
    entity.select().where("id=?", entity.get("id")).get_first_rows();
//    sessionid.select().where("id=?", entity.get("sessionid")).get_first_rows();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <style>
            .popupwrapa>div:first-child{height: 100%;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrapa">           
            <div><% entity.write("matter");%></div>
        </form>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
