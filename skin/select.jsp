<%@page import="java.io.File"%>
<%@page import="RssEasy.Core.DirectoryExtend"%>
<%@page import="RssEasy.MySql.SkinList"%>
<%@page import="RssEasy.MySql.Article.ArticleList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="org.apache.catalina.Context"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    if (req.get("action").equals("select")) {
        SkinList entity = new SkinList(pageContext);
        entity.select("folder").where("id=?", req.get("id")).get_first_rows();
        DirectoryExtend.Copy(new File(DirectoryExtend.Root(request) + "skin/" + entity.get("folder")), new File(DirectoryExtend.Root(request) + "css"));
        PoPupHelper.adapter(out).topreload();
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
                应用所选择的样式主题？
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="select" />
                <button type="submit">确认</button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
