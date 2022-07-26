<%@page import="RssEasy.MySql.Staff.StaffPowerGroupList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="org.apache.catalina.User"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    StaffPowerGroupList entity = new StaffPowerGroupList(pageContext);
    entity.request().remove("id");
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "append":
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
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
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
                    <tr><td colspan="4" id="tabheader"><% out.print(entity.get("id").isEmpty() ? "增加" : "编辑");%>角色</td></tr>
                    <tr>
                        <td class="dce w150">角色名称：</td>
                        <td colspan="3">
                            <input type="text" name="name" value="<% entity.write("name"); %>"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="dce w150">角色描述：</td>
                        <td colspan="3">
                            <input name="remark" value="<% entity.write("remark"); %>"></textarea>
                        </td>
                    </tr>
                </table>
            </div>                    
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit" class="btnface"><% out.print(entity.get("id").isEmpty() ? "增加" : "修改");%></button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
        <script src="../../../js/menudata.js" type="text/javascript"></script>
        <script>

            function pwidclick() {
                $("[pwid]").off("click").click(function () {
                    var tattr = $(this).attr("pwid");
                    alert($(this).attr("pwid"));
                    if (tattr) {
                        $(".ueright>." + tattr).show().siblings("ul").hide();
                    }
                })
            }
            function und(n) {
                if (n == "" || n == undefined || n == null) {
                    return "-";
                } else {
                    return n;
                }
            }
        </script>
    </body>
</html>
