<%@page import="RssEasy.Core.HttpExtend"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.MySql.Staff.StaffDepartMentList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("utf-8");
    StaffList.IsLogin(request, response);
    StaffDepartMentList entity = new StaffDepartMentList(pageContext);
    entity.request().remove("id");
    if (!entity.get("action").isEmpty()) {
        PoPupHelper.adapter(out).iframereload();
        switch (entity.get("action")) {
            case "append":
                if (entity.select().where("name=?", entity.get("name")).get_first_rows()) {
                    out.print("<script>alert('该用户组已存在！请刷新页面再次查看');</script>");
                } else {
                    entity.keyvalue("marker", entity.getmarkerbyid(entity.get("pid")) + HttpExtend.getPinYin(entity.get("name"))).keyvalue("querykey", entity.createquerykey());
                    entity.append().submit();
                    StaffList.CreateJson(pageContext);
                    PoPupHelper.adapter(out).showSucceed();
                }
                break;
            case "update":
                entity.update().where("id=?", entity.get("id")).submit();
                StaffList.CreateJson(pageContext);
                PoPupHelper.adapter(out).showSucceed();
                break;
        }
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
        <style>
            #tabheader{background: #82bee9;text-align: center; color: #fff;}
            .dce{background: #dce6f5;text-indent: 10px}
            .cellbor td{padding: 0 6px}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 34px;}
            .cellbor{width: 100%}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            .popupwrap>div:first-child{height: 100%;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">
            <div>
                <table class="wp100 cellbor">
                    <tr><td colspan="4" id="tabheader"><% out.print(entity.get("id").isEmpty() ? "增加" : "编辑");%>用户组</td></tr>
                    <tr>
                        <td class="dce w150">用户组名称：</td>
                        <td colspan="3">
                            <input type="text" id="name" name="name" class="w150" value="<% entity.write("name"); %>" maxlength="50" /><label for="name"></label>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit" class="btnface"><% out.print(entity.get("id").isEmpty() ? "增加" : "修改");%></button>
            </div>

        </form>
        <script src="/data/staff.js"></script>
        <%@include  file="/inc/js.html" %>
        <script type="text/javascript">
            $(window).ready(function ()
            {
                $("[name=pid]").val([<% entity.write("pid");%>]);
            });
        </script>
    </body>
</html>
