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
        entity.remove("myid");
        entity.update().where("myid=?", entity.get("myid")).submit();
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
    </head>
    <body>
        <form method="post" class="popupwrap">
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td class="tr">状态：</td>
                        <td dict-radio="usertype" dict-name="type" def="<% entity.write("type"); %>"></td>
                    </tr>
                </table>
            </div>                    
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("myid").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("myid").isEmpty() ? "增加" : "修改");%></button>
            </div>
        </form>
        <script src="/data/dictdata.js" type="text/javascript"></script>
        <script src="/data/channel.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
