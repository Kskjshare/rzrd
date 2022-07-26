<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
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
            tbody tr:hover{background-color: gainsboro;}
        </style>
    </head>
    <body>
      
        <form method="post" id="mainwrap">          
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                   
                   
                </table>
            </div>
            <div class="footer">
             
            </div>
        </form>      
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
        <script>
                            $("#blockul>li").click(function () {
                                $(this).addClass("sel").siblings().removeClass("sel");
                                $(this).find("input").prop("checked", true);
                            })
        </script>
    </body>
</html>