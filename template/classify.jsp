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
    RssList entity = new RssList(pageContext, "template");
    entity.request();
    if (!entity.get("action").isEmpty()) {
        entity.remove("id");
        entity.update().where("id=?", entity.get("id")).submit();
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select("classifyid").where("id=?", entity.get("id")).get_first_rows();
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
    </head>
    <body>
        <form method="post" class="popupwrap">   
            <div>
                <ul levelhelper="templateclassify" key="classifyid" deploy def="<% entity.write("classifyid");%>" offset="1" class="lanmubankuai"></ul>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="update" />
                <button type="submit">确定</button>
            </div>
        </form>
        <script src="/data/template.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
    </body>
</html>