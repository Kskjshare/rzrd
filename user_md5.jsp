<%@page import="java.net.URLEncoder"%>
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
<html>
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
//            String ip = "10.1.14.7";
            String ip = "117.158.113.36";
            String Appid = "WHOA";
            String MD5handle = username + ip + Appid;
          
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            String s = new BASE64Encoder().encode(md5.digest(MD5handle.getBytes()));
            s = URLEncoder.encode(s,"UTF-8");
        %>

        <%@include  file="/inc/js.html" %>
        <script>
//            window.location.href = "http://10.1.14.7:7001/defaultroot/loginsso?verify=<% out.print(s); %>&username=<% list.write("account");%>&ip=10.1.14.7";
            window.location.href = "http://117.158.113.36:7001/defaultroot/loginsso?verify=<% out.print(s); %>&username=<% list.write("account");%>&ip=117.158.113.36";
        </script>
    </body>
</html>
