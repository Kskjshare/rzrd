<%@page import="RssEasy.MySql.RssVideoList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.StringExtend"%>
<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    RssVideoList entity = new RssVideoList(pageContext, "template");
    entity.request();
    if (!entity.get("action").isEmpty()) {
        entity.remove("id");

        if (entity.get("summary").isEmpty()) {
            entity.keyvalue("summary", StringExtend.substr(StringExtend.delHtmlTag(entity.get("description")), 120));
        }

        switch (entity.get("action")) {
            case "append":
                entity.timestamp().keymyid(UserList.MyID(request));
                entity.append().submit();
                break;
            case "update":
                entity.update().where("id=?", entity.get("id")).submit();
                break;
        }
        response.sendRedirect("list.jsp?relationid=" + entity.get("relationid"));
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
                        <td class="tr w50">标题：</td>
                        <td><input type="text" class="w500" name="title" value="<% entity.write("title"); %>" /></td>
                    </tr>         
                    <tr>
                        <td class="tr">节次：</td>
                        <td>
                            <select name="section" def="<% entity.write("section"); %>">
                                <%
                                    for (int i = 1; i < 50; i++) {
                                        out.print("<option value='" + i + "'>" + i + "</option>");
                                    }
                                %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="tr">地址：</td>
                        <td><input type="text" class="w650" name="url" value="<% entity.write("url");%>" /><br /><label>请从点播平台复制地址</label></td>
                    </tr>
                    <tr>
                        <td class="tr">时长：</td>
                        <td>
                            <input type="text" class="w50" name="duration" value="<% entity.write("duration");%>" readonly=""/>  <button type="button" class="btnface" getduration="url,duration">获取时间长度</button></td>
                    </tr>
                    <tr>
                        <td class="tr">摘要：</td>
                        <td><textarea name="summary" class="w650 h50"><% entity.write("summary"); %></textarea></td>
                    </tr>
                    <tr>
                        <td class="tr">描述：</td>
                        <td>
                            <script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:200" id="description" name="description" class="w650" type="text/plain"><% entity.write("description"); %></script>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "增加" : "修改");%></button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
