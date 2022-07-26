<%-- 
    Document   : butimportance_1
    Created on : 2021-3-29, 21:18:42
    Author     : EDZ
--%>

<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssHotList"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    RssList entity = new RssList(pageContext, "suggest");
    RssListView list = new RssListView(pageContext, "sort");
    RssList user = new RssList(pageContext, "user");
    entity.request();
   entity.keyvalue("importance","1");
        entity.update().where("id=?", entity.get("id")).submit();
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    list.select().where("id=?", entity.get("id")).get_first_rows();
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
            #tabheader{background: #82bee9;text-align: center; color: #fff;height: 45px}
            .dce{background: #dce6f5;text-indent: 10px}
            .cellbor td{padding: 0 6px}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 38px;}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;width: 92%}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">
            <div class="infowrap">
                <table class="wp120 cellbor">
                    <tr><td class="w120 dce">重点议案</td><td><select class="w206" name="importance" dict-select="importance" def="<% list.write("importance"); %>" value="1"></select></td></tr>
                </table>  
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
