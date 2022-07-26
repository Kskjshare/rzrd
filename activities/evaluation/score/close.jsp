<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.User.UserList"%>
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
            table th{
                font-weight: normal;
            }
            table,th,td{
                font-family: 仿宋;
                font-size: large;
                /*border: 1px solid #000;*/
                height: 53px;
                /* width: 100px; */
            }
            .FistRow>td:first-child{
                box-sizing: border-box;
                width: 40px!important;
                padding: 4px 20px!important;
            }
            .FistRow>td:nth-child(2){
                width: 100px;
            }
            #tabheader{background: #82bee9de;text-align: center; color: #fff; height: 10px;
            }
            #section th:nth-of-type(2n+1){
                font-weight: bold;
            }
            .details td:last-child{
                width: 100px;
            }
            #section tr th{
                font-size: large;
            }
            .userData{ height: 70px;}
            tr td>input{
                width: 90%;
                height: 100%;
                border: none;
                background-color: transparent;
                text-align: center;
            }
        </style>
    </head>
    <body>
        
        <form method="post" id="mainwrap">
            <div class="bodywrap" style="color:red">
              当前非考核打分时间！
            </div> 

        </form>
        <%@include  file="/inc/js.html" %>


    </body>
</html>