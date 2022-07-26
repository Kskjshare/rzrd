<%@page import="RssEasy.MySql.RssSetup"%>
<%@page import="RssEasy.Core.FileExtend"%>
<%@page import="RssEasy.MySql.RssModuleList"%>
<%@page import="java.io.File"%>
<%@page import="RssEasy.Core.DirectoryExtend"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.Core.HttpExtend"%>
<%@page import="RssEasy.MySql.Staff.StaffPowerList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();

    RssModuleList entity = new RssModuleList(req.pageContext);

    if (!req.get("action").isEmpty()) {
        entity.request();
        entity.select().where("id=?", req.get("id")).get_first_rows();
        if (entity.get("virtual") == "0") {
            File file = new File(DirectoryExtend.Root(request).replace("\\build", "") + entity.get("module"));

            RssSetup.Drop(entity);
            DirectoryExtend.delete(file);

            DirectoryExtend.Copy(new File(DirectoryExtend.Root(request) + "rssframe"), file);

            FileExtend.replacedir(file, "rssframe", entity.get("module"));
            FileExtend.replacedir(file, req.get("module") + "classify", req.get("module").replace("_", "") + "classify");
            FileExtend.replacedir(file, req.get("module") + ".js", req.get("module").replace("_", "") + ".js");
        }
        RssSetup.Setup(entity);

        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>管理系统</title>
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
    </head>
    <body>
        <form method="post" class="popupwrap">
            <div class="infowrap">
                重新安装此模块？
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="reset" />
                <button type="submit">确认</button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
