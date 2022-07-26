<%@page import="RssEasy.MySql.SkinList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.MySql.Article.ArticleList"%>
<%@page import="RssEasy.Core.StringExtend"%>
<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    SkinList entity = new SkinList(pageContext);
    entity.request();
    if (!entity.get("action").isEmpty()) {
        entity.remove("id");
        switch (entity.get("action")) {
            case "append":
                entity.append().submit();
                break;
            case "update":
                entity.update().where("id=?", entity.get("id")).submit();
                break;
        }
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.keyvalue("ico", "/white.gif");
    entity.select().where("id=?", entity.get("id")).get_first_rows();
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
                        <td class="tr">标题：</td>
                        <td><input type="text" name="name" value="<% entity.write("name"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="tr">图标：</td><td>
                            <div class="imgupload">
                                <ul id="icourlwrap" class="swfuploadwrap">
                                    <li><div class="swfuploadimg"><div><img src="<% entity.write("icodef"); %>"></div></div></li>
                                </ul>
                                <div>
                                    <span swfupload="icourlswf" config="{multimode:0,fileType: [['图形图像(*.jpg;*.png;*jpeg;*gif)','*.jpg;*.png;*jpeg']]}"></span>
                                    <br/>
                                </div>
                            </div>
                            <input type="hidden" name="ico" id="ico" value="<% entity.write("ico"); %>">
                        </td>
                    </tr>
                     <tr>
                        <td class="tr">文件夹名：</td>
                        <td><input type="text" name="folder" value="<% entity.write("folder"); %>" /></td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "增加" : "修改");%></button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
        <script src="upload.js" type="text/javascript"></script>
    </body>
</html>
