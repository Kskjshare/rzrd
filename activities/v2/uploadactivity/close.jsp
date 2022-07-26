<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssList entity = new RssList(pageContext, "activities");
    entity.request();
    if (req.get("action").equals("update")) {
        entity.remove("id");
        entity.keyvalue("state","2");
        entity.update().where("id in(" + req.get("id") + ")").submit();
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select("id,closenote").where("id=?",entity.get("id")).get_first_rows();
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
                <table class="wp100 tollbor">
                    <tr>
                        <td class="dec"><textarea type="text" class="wp98 h250" name="closenote"><% entity.write("closenote"); %></textarea></td>
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
