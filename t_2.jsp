<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Order.OrderList"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="java.util.Date"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@ page import="RssEasy.MySql.RssList" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/data/contants.jsp"%><!--added by jackie //-->
<%    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    out.print("<script> var passwordjsp=0</script>");
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
            #editor{font-size: 20px;}
        </style>
    </head>
    <body>

        <div id="editor">
            <p>Hello World!</p>
            <p>Some initial <strong>bold</strong> text</p>
            <p><br></p>

        </div>
        <div id="accountsoft">
            <ul>
                <li>title:<em title>1584686892</em></li>
                <li>姓名<em summary>欧侯敏</em></li>
            </ul>
        </div>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
<script>
//    new Ajax("getmd5").keyvalue({"account": "1", "pwd": "123456"}).getJson(function (json) {});
    RssApi.View.List("userrole").keyvalue({"pagesize":10000,"orderby":"myid"}).condition({}).getJson(function (json) {

        console.log(json);
        
        $("#accountsoft ul").mapview(json, {

        })
    });
//    new Ajax("Deviceid").keyvalue({"myid":11185,"deviceid":"5755"}).getJson(function (json) {
////        var rsscode = json['deviceid'];
//        var html = "";
//        $.each(json, function (k, v) {
//            html = "<p>" + v.deviceid + "</p>"
//            $(".infowrap").append(html);
//        })
//        alert(json)
//    })
</script>
