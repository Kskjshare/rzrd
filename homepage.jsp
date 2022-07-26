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
            ul{margin:70px auto;min-width: 272px;padding-left: 50px}
            ul>li{;width: 120px;height: 120px;border:#cbcbcb solid 1px;border-radius: 6px;text-align: center;display: inline-block;background:#f0f5fc;margin:0 50px;margin-bottom: 45px  }
            ul>li img{margin-top: 15px;margin-bottom: 10px;}
        </style>
    </head>
    <body>
        <ul>
<!--            <li transadapter="append" select="false" powerid="13" ><img src="../css/limg/homepage1.png" alt=""/><p>添加代表信息</p></li>
            <li bindli="mywelcomerepresentative" powerid="13"><img src="../css/limg/homepage2.png" alt=""/><p>代表信息管理</p></li>
            <li powerid="3" eqli="3"><img src="../css/limg/homepage3.png" alt=""/><p>建议议案审查</p></li>
            <li powerid="6" eqli="6"><img src="../css/limg/homepage4.png" alt=""/><p>信息统计分析</p></li>
            <li powerid="7" eqli="8"><img src="../css/limg/homepage5.png" alt=""/><p>系统管理</p></li>
            <li powerid="7" eqli="8"><img src="../css/limg/homepage6.png" alt=""/><p>学习培训</p></li>
            <li powerid="7" eqli="8"><img src="../css/limg/homepage6.png" alt=""/><p>工作交流</p></li>
            <li powerid="7" eqli="8"><img src="../css/limg/homepage6.png" alt=""/><p>双联培训</p></li>-->
            <li powerid="2" ><img src="../css/limg/homepage1.png" alt=""/><p>添加代表信息</p></li>
            <li powerid="2"><img src="../css/limg/homepage2.png" alt=""/><p>代表信息管理</p></li>
            <li powerid="44"  bindclick="top3" ><img src="../css/limg/homepage3.png" alt=""/><p>建议议案审查</p></li>
            <li powerid="60" bindclick="top3"><img src="../css/limg/homepage4.png" alt=""/><p>信息统计分析</p></li>
            <li powerid="6"  bindclick="top1"><img src="../css/limg/homepage5.png" alt=""/><p>系统管理</p></li>
            <li powerid="70" ><img src="../css/limg/homepage6.png" alt=""/><p>学习培训</p></li>
            <li powerid="75" ><img src="../css/limg/homepage6.png" alt=""/><p>工作交流</p></li>
            <li powerid="80" ><img src="../css/limg/homepage6.png" alt=""/><p>双联服务</p></li>
            <li powerid="82" ><img src="../css/limg/homepage6.png" alt=""/><p>代表网</p></li>
        </ul>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
        <script>
            $("[bindclick]").click(function() {
          parent.bindli($(this).attr("bindclick"))
})
//            $("[bindli]").click(function () {
//                parent.bindli($(this).attr("bindli"))
//            })
//             $("[eqli]").click(function () {
//                parent.eqli($(this).attr("eqli"))
//            })
        </script>
    </body>
</html>
