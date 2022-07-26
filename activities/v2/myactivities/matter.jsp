<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssList entity = new RssList(pageContext, "activities_userlist");
    entity.request();
    if (req.get("action").equals("update")) {
        entity.remove("title","id");
        entity.update().where("id in(" + req.get("id") + ")").submit();
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select("id,matter").where("id=?",entity.get("id")).get_first_rows();
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
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td class="dce">标题：</td>
                        <td><sapn><% entity.write("title"); %></sapn></td>
                    </tr>
                    <tr>
                        <td class="dce">心得：</td>
                        <td><textarea type="text" class="w500 h200" name="matter"><% entity.write("matter"); %></textarea></td>
                    </tr>

                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="update" />
                <button type="submit">提交</button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
