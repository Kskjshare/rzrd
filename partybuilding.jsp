<%@page import="sun.misc.BASE64Encoder"%>
<%@page import="java.util.Base64"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>

<%@page import="java.math.BigInteger"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.security.NoSuchAlgorithmException"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.Base64"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            h1{ border:thin solid ;height:80px; }
            body .calendarwrap,.popuplayer{
                display: none;
            }
        </style>
    </head>
    
    <body>
        <%
            HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
            StaffList.IsLogin(request, response);
            CookieHelper cookie = new CookieHelper(request, response);
            RssList list = new RssList(pageContext, "user");
            list.keymyid(cookie.Get("myid"));
            list.select().where("myid=?", list.get("myid")).get_first_rows();

            //假设为用户名
            String username = list.get("account");
            String ip = "42.193.106.246";
            String Appid = "WHOA";
            String MD5handle = username + ip + Appid;
            
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            String sMd5 = new BASE64Encoder().encode(md5.digest(MD5handle.getBytes()));

        %>

        <%@include  file="/inc/js.html" %>
        <script>           
            window.location.href = "http://ypt.cdlhyj.com/web/login";
        </script>
    </body>

