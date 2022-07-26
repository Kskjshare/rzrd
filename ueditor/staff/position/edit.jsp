<%@page import="RssEasy.Core.HttpExtend"%>
<%@page import="RssEasy.MySql.Staff.StaffPositionList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("utf-8");
    StaffList.IsLogin(request, response);
    StaffPositionList entity = new StaffPositionList(pageContext);
    entity.request().remove("id");
    if (!entity.get("action").isEmpty()) {
        if (!entity.get("jiezhiriqi").isEmpty()) {
            entity.keyvalue("jiezhiriqi", DateTimeExtend.timestamp(entity.get("jiezhiriqi")));
        }
        switch (entity.get("action")) {
            case "append":                
                entity.keyvalue("marker", entity.getmarkerbyid(entity.get("pid")) + HttpExtend.getPinYin(entity.get("name"))).keyvalue("querykey", entity.createquerykey());
                entity.append().submit();
                break;
            case "update":
                entity.update().where("id=?", entity.get("id")).submit();
                break;
        }
        StaffList.CreateJson(pageContext);
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select().where("id=?", entity.get("id")).get_first_rows();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
    </head>
    <body>
        <form method="post" class="popupwrap">
            <div>
                <table class="wp100 wp100 cellbor vtop">                   
                    <tr>
                        <td class="tr">上级：</td>
                        <td>
                            <ul levelhelper="position" dict-name="pid" class="lanmubankuai"></ul>
                        </td>
                    </tr>
                    <tr>
                        <td class="tr w80">角色名称：</td>
                        <td>
                            <input type="text" name="name" class="w300" value="<% entity.write("name"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="tr">角色描述：</td>
                        <td>
                            <script id="miaoshu" ueditor="'toolbars':[['undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','blockquote','pasteplain','|','forecolor','backcolor','template','background']]" name="miaoshu" class="w700" type="text/plain"><% entity.write("miaoshu"); %></script>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><%  out.print(entity.get("id").isEmpty() ? "增加" : "修改");%></button>
            </div>
        </form>
        <script src="/data/staff.js"></script>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
