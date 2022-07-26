<%-- 
    Document   : listinfopage
    Created on : 2018-7-20, 21:26:46
    Author     : Administrator
--%>

<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>云上人大代表联络站</title>
        <style>
            body>div{width: 1100px;margin: 0 auto;}
            #header{width: 100%;background:url(../img/tophead.png) no-repeat ;background-size: cover;height:123px;  }  
            #webbody{margin: 10px;border: #cccccc solid thin; padding: 0;}
            #webbody h1{line-height: 39px;color:#039f62;font-size: 15px;;background:linear-gradient(#e2fffc,#fff); font-weight: 400;margin: 0;text-align: left;text-indent: 10px; }
            #webbody h1>span{display: block;margin: 0 10px;border-bottom: #a3dbd3 solid 1px;}
            #webbody h2{font-size: 14px;text-align: center;}
            #webbody h3{font-size: 12px;font-weight: 400;text-align: center;}
            #webbody>div{margin: 0 23px;}
            #footer{background: linear-gradient(to top, #f8fdff, #e2fffc);width: 1096px;text-align: center;margin: 0 auto;height: 88px;border: #95c2c9 solid thin;}
            #footer p{line-height: 22px;font-size: 12px; margin: 0;color: #333333}
            h1{text-align: center;}
            #webbody img{max-width: 80%;max-height: 580px;text-align:center;}
            /*#webbody>img{}*/
            .w200{width: 200px;height: 338px;background:#f3f3f3; }
            .popuplayer,.calendarwrap{display: none;}
        </style>
    </head>
    <body>
        <%
            HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
            String view = "personsystem";
            RssListView entity = new RssListView(pageContext, view);
            entity.select().where("id=?", req.get("ind")).get_first_rows();
        %>
        <div>
            <div id="header"></div>
            <div id="webbody">
                <h1><span><% out.print(req.get("contacttype").equals("2") ? "其他条例" : "规章制度");%></span></h1>
                <h2><% out.print(entity.get("title"));%></h2>
                <h3 rssdate="<% out.print(entity.get("shijian")); %>,yyyy-MM-dd hh:mm:ss"></h3>
                <div><% out.print(entity.get("matter"));%></div>
            </div>
            <div id="footer">
                <p>抚州市政协主办</p>
                <p>抚州市政协信息中心承办</p>
                <p>技术支持：抚州市政协信息中心</p>
            </div>
        </div>
        <%@include  file="/inc/js.html" %>
        <script>

        </script>
    </body>
</html>
