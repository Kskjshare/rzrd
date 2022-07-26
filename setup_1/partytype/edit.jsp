<%@page import="RssEasy.MySql.RssClassifyList"%>
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
    RssList entity = new RssList(pageContext, "partytype_classify");
    entity.request();
    if (!entity.get("action").isEmpty()) {
        entity.remove("relationid");
        switch (entity.get("action")) {
            case "append":
                entity.append().submit();
                new RssClassifyList(pageContext, "partytype").createclassifyjson();
                PoPupHelper.adapter(out).iframereload();
                PoPupHelper.adapter(out).showSucceed();
                break;
            case "update":
                entity.remove("id");
                entity.update().where("id=?", entity.get("relationid")).submit();
                new RssClassifyList(pageContext, "partytype").createclassifyjson();
                PoPupHelper.adapter(out).iframereload();
                PoPupHelper.adapter(out).showSucceed();
                break;
        }
    }
    entity.select().where("id=?", entity.get("relationid")).get_first_rows();
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
                <table class="wp100 formor">
                    <tr>
                        <td class="tr w100 ">党派：</td>
                        <td class="backdce"><input type="text" maxlength="80" class="w200" name="name" value="<% entity.write("name"); %>" /></td>
                    </tr>
                    <tr style="display: none;">
                        <td class="tr w100 ">描述：</td>
                        <td class="backdce"><input type="text" maxlength="80" class="w200" name="matter" value="<% entity.write("matter"); %>" /></td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("relationid").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("relationid").isEmpty() ? "增加" : "修改");%></button>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <script src="/data/partytype.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
