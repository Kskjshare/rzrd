<%@page import="RssEasy.MySql.RssSetup"%>
<%@page import="java.io.File"%>
<%@page import="RssEasy.Core.DirectoryExtend"%>
<%@page import="RssEasy.MySql.RssModuleList"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssModuleList entity = new RssModuleList(pageContext);
    entity.request();
    if (req.get("action").equals("delete")) {
        entity.select().where("id=?", req.get("id")).get_first_rows();
        if (!entity.get("module").isEmpty()) {
            File file = new File(DirectoryExtend.Root(request).replace("\\build", "") + entity.get("module"));
            RssSetup.Drop(entity);
            DirectoryExtend.delete(file);
        }
        entity.delete().where("id=?", req.get("id")).submit();
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
