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
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td class="tr w50">音频：</td>
                        <td><input type="text" class="w650" name="audio" value="<% entity.write("audio"); %>" />
                            <br />
                            <label>请从点播平台复制地址</label></td>
                    </tr>
                    <tr>
                        <td class="tr w50">时长：</td>
                        <td><input type="text" class="w60" name="audioduration" value="<% entity.write("audioduration"); %>" /> <button type="button" class="btnface" getduration="audio,audioduration">获取时间长度</button>
                        </td>
                    </tr>
                    <tr>
                        <td class="tr">视频：</td>
                        <td><input type="text" class="w650" name="video" value="<% entity.write("video");%>" /><br /><label>请从点播平台复制地址</label></td>
                    </tr>
                    <tr>
                        <td class="tr">时长：</td>
                        <td><input type="text" class="w60" name="videoduration" value="<% entity.write("videoduration");%>" /> <button type="button" class="btnface" getduration="video,videoduration">获取时间长度</button>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="update" />
                <button type="submit">确定</button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
