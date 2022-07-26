<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.StringExtend"%>
<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    CookieHelper cookie = new CookieHelper(request, response);
    RssListView entity = null;
    if (cookie.Get("powergroupid").equals("5")) {
        entity = new RssListView(pageContext, "lzmessage_newsuser");
    } else {
        entity = new RssListView(pageContext, "newinformation");
    }
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
        <style>
            .popupwrap div:first-child{height: 100%;font-size: 18px}
            /*#matter{line-height: 12px;height: 200px;font-size: smaller;}*/
            /*#matter>div{height: 180px;overflow: auto;}*/
/*            div::-webkit-scrollbar {
                display: none;
            }*/
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div><% entity.write("matter");%></div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
