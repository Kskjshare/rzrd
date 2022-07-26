<%-- 
    Document   : newjsp
    Created on : 2020-12-10, 17:29:25
    Author     : EDZ
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .popuplayer,.calendarwrap{
                display: none;
            }
            .box{
                display: flex;
                justify-content: space-around;
                flex-wrap: wrap;
            }
            .echart{
                border: thin dashed rgb(91, 161, 241);
                margin: 20px 0px;
                /* padding: 20px 0px; */
                width: 49%;
                height: 400px;
                text-align: left;
            }
        </style>
    </head>
    <script src="./echarts.min.js"></script>
    <body>
        <div class="box">
            <div class="echart" id="main">sfdsfds</div>
            <div class="echart" id="main2">sdfdsf</div>
            <div class="echart" id="main3">sdfds</div>
            <div class="echart" id="main4">sdfds</div>
        </div>
        <div id="qwe">
            <p rssid> </p>
        </div>
    <%@include  file="/inc/js.html" %>
    <script src="./echart1.js"></script>
    <script src="./echart2.js"></script>
    <script src="./echart3.js"></script>
    <script src="./echart4.js"></script>
    <script>    
    </script>
    </body>
</html>
