<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="org.apache.catalina.User"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("utf-8");
    StaffList.IsLogin(request, response);
    UserList entity = new UserList(pageContext);
    entity.request();
    if (!entity.get("action").isEmpty()) {

        switch (entity.get("action")) {
            case "append":
                entity.keyvalue("pwd", Encrypt.Md532(entity.get("account") + entity.get("pwd")));
                entity.timestamp();
                entity.append().submit();
                break;
            case "upd":
                entity.update().where("myid="+entity.get("myid"));
                entity.print("<script>alert("+entity.sql+");</script>");
                break;
        }

        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select().where("myid=" + entity.get("myid")).get_first_rows();
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
                <table class="wp100 cellbor">
                    <tr>
                        <td class="tr">账号类型：</td>
                        <td><select name="classifyid" dict-select="classifyid" def="<% entity.write("classifyid"); %>"></select></td>
                    </tr>
                </table>
            </div>                    
            <div class="footer">
                <input type="hidden" name="upd" value="<% out.print(entity.get("myid").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("myid").isEmpty() ? "增加" : "修改");%></button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
        <script src="edit.js" type="text/javascript"></script>
    </body>
</html>
