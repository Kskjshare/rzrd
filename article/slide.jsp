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
    RssList entity = new RssList(pageContext, "article");
    entity.request();
    if (!entity.get("action").isEmpty()) {
        entity.remove("id");
        entity.update().where("id=?", entity.get("id")).submit();
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select("picture").where("id=?", entity.get("id")).get_first_rows();
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
                <ul id="pictureurlwrap" class="swfuploadwrap">
                    <%
                        if (!entity.get("picture").isEmpty()) {
                            String[] picture = entity.get("picture").split(",");
                            for (String url : picture) {
                                out.print("<li><div class=\"swfuploadimg\"><div><img src=\"/upfile/" + url + "\"></div></div><del></del></li>");
                            }
                        }
                    %>
                </ul>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="update" />
                <input type="hidden" name="picture" id="picture" value="<% entity.write("picture");%>">
                <span swfupload="pictureurlswf" config="{multimode:1,fileType: [['图形图像(*.jpg;*.png;*jpeg;*gif)','*.jpg;*.png;*jpeg']]}"></span> <span>建议尺寸：320*260</span>
                <button type="submit" class="right">确定</button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
        <script src="slide.js" type="text/javascript"></script>
    </body>
</html>
