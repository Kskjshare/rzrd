<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffPositionList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="org.apache.catalina.Context"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    RssList entity = new RssList(pageContext, "syslog");
    entity.request();
    //System.out.println("id::"+entity.get("id"));//jackie debug
    String str_ids[] = entity.get("id").split(",");//added by jackie
    if (entity.get("action").equals("delete")) {
        String str_id ="";
        for(int i=0;i<str_ids.length;i++){
          str_id=str_ids[i];
          entity.delete().where("id=?", str_id).submit();
        }
             
        StaffList.CreateJson(pageContext);
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <form method="post" class="popupwrap">
            <div class="infowrap">
                删除后不可恢复，请谨慎操作？
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="delete" />
                <button type="submit">确认</button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
