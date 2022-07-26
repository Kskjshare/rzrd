<%@page import="RssEasy.MySql.RssCodeList"%>
<%@page import="RssEasy.MySql.BankList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("utf-8");
    StaffList.IsLogin(request, response);
    RssCodeList entity = new RssCodeList(pageContext);
    entity.request().remove("id");
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "append":
                entity.append().submit();
                break;
            case "update":
                entity.update().where("id=?", entity.get("id")).submit();
                break;
        }
        RssCodeList.CreateJson(pageContext);
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select().where("id=?", entity.get("id")).get_first_rows();
    if (!entity.has("id")) {
        entity.keyvalue("id", "").keyvalue("remark", "");
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
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td class="tr w80">代码：</td>
                        <td>
                            <input type="text" name="id" class="w100" value="<% entity.write("id"); %>" maxlength="50" />
                        </td>
                    </tr>
                    <tr>
                        <td class="tr">描述：</td>
                        <td>
                            <input type="text" name="remark" class="w100" value="<% entity.write("remark"); %>" maxlength="50" />
                        </td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit" class="btnface"><% out.print(entity.get("id").isEmpty() ? "增加" : "修改"); %></button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
        <%
            entity.outinfo();
        %>
    </body>
</html>
