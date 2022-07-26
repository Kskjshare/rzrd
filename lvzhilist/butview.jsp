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
    RssListView entity = new RssListView(pageContext, "user_delegation");
    entity.request();
    entity.select().where("myid=?", entity.get("id")).get_first_rows();
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
            #tabheader{text-align: center;margin: 20px auto;}
            .popupwrap>div:first-child{height: 100%;}
            .popupwrap>div>table {width: 620px;margin: 0 auto;}
            .popupwrap>div>nav{width: 610px;margin: 0 auto;line-height: 32px;}
            .popupwrap>div>nav>span{display: inline-block;width: 150px;}
            table tr>td:first-child{width: 130px;height: 150px;text-align: center;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <h1 id="tabheader">人大代表履职管理信息</h1>
                <nav><span>姓名:<% out.print(entity.get("realname"));%></span><span>证号:<% out.print(entity.get("code"));%></span><span>代表团:<% out.print(entity.get("delegationname"));%></span><span>年度:<% out.print(entity.get("sessionyear"));%></span></nav>
                <table class="wp100 cellbor">
                    <tr><td>建议</td><td></td><tr>
                    <tr><td>议案</td><td></td><tr>
                    <tr><td>列席会议</td><td></td><tr>
                    <tr><td>学习培训</td><td></td><tr>
                    <tr><td>其他</td><td></td><tr>
                    </table>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
