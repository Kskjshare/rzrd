<%@page import="java.sql.Date"%>
<%@page import="RssEasy.Core.StringExtend"%>
<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <link href="/css/swfupload.css" rel="stylesheet" type="text/css"/>
        <style>
            .mainwrapassist{ margin:10px; } 
            .mainwrapassist>ul{padding: 20px 0;;text-align: center;}
            .mainwrapassist>ul>li{width: 100px;height: 50px; background: #dce6f5;line-height: 50px;border-radius: 10px; font-size: 16px;margin: 0 10px; cursor: pointer; display: inline-block;}
            .mainwrapassist>ul>li:hover{color: #186aa3;}
        </style>
    </head>
    <body>
        <form method="post"  class="labelright nomargin" id="uesrupfile">           
            <div class="mainwrapassist notitletoolbar">
                <ul><li seltype="staffuserlist">用户导出</li><li seltype="delegate">代表导出</li><li seltype="company">单位导出</li></ul>
            </div>
            <input type="hidden" value="<%=req.get("relationid")%>">
        </form>
        <%@include  file="/inc/js.html" %>
        <!--<script src="uploads.js" type="text/javascript"></script>-->
        <script>
            $(".mainwrapassist li").click(function () {
                var seltype = $(this).attr("seltype");
                var relationid = $("#uesrupfile>input").val();
                switch (seltype) {
                    case "staffuserlist":
                        location.href = "/staff/staffuserlist.jsp?relationid=" + relationid;
                        break;
                    case "delegate":
                        location.href = "/delegate/userlist.jsp?relationid=" + relationid;
                        break;
                    case "company":
                        location.href = "/company/companylist.jsp?relationid=" + relationid;
                        break;
                    case "company/companyuser":
                        location.href = "company/companyuser/userlist.jsp?relationid=" + relationid;
                        break;
                }
            })
        </script>
    </body>
</html>