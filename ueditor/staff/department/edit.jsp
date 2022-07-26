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
                entity.keyvalue("marker", entity.getmarkerbyid(entity.get("pid")) + HttpExtend.getPinYin(entity.get("name"))).keyvalue("querykey", entity.createquerykey());
                entity.append().submit();
                break;
            case "update":
                entity.update().where("id=?", entity.get("id")).submit();
                break;
        }
        StaffList.CreateJson(pageContext);
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
            <table class="wp100 vtop">
                <tbody>
                    <tr>
                        <td class="w200">
                            <h2>选择父级</h2>
                            <ul levelhelper="department" dict-key="pid" class="lanmubankuai"></ul>
                        </td>
                        <td>
                            <table class="wp100 cellbor">
                                <tr>
                                    <td class="tr w80">名称：
                                    </td>
                                    <td>
                                        <input type="text" id="name" name="name" class="w100" value="<% entity.write("name"); %>" maxlength="50" /><label for="name"></label>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                        <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                                        <button type="submit" class="btnface"><% out.print(entity.get("id").isEmpty() ? "增加" : "修改"); %></button>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
        <script src="/data/staff.js"></script>
        <%@include  file="/inc/js.html" %>
        <script type="text/javascript">
            $(window).ready(function ()
            {
                $("[name=parentid]").val([<% entity.write("parentid");%>]);
            });
        </script>
    </body>
</html>
