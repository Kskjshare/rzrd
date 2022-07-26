<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    RssList entity = new RssList(pageContext, "template");
    entity.request();
    if (entity.get("action").equals("release")) {
        entity.remove("id").keyvalue("state", 1);
        entity.update().where("id in(" + entity.get("id") + ") and state in(0,1)").submit();
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select("state").where("id=?", entity.get("id")).get_first_rows();
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
                <label><input type="radio" name="state" value="1" <% out.print(entity.get("state") == "1" ? "checked=\"checked\"" : ""); %>/> 发布</label>
                <label><input type="radio" name="state" value="0" <% out.print(entity.get("state") == "0" ? "checked=\"checked\"" : "");%> /> 停止</label>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="release" />
                <button type="submit">确认</button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
