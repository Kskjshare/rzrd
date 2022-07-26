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
    RssList entity = new RssList(pageContext, "socialsecurity");
    entity.request().remove("id");
    if (!entity.get("action").isEmpty()) {
        entity.remove("id");
        switch (entity.get("action")) {
            case "append":
                if (entity.select().get_first_rows()) {
                    out.print("<script>alert('已经有押金基准了！')</script>");
                } else {
                    entity.append().submit();
                }
                break;
            case "update":
                entity.update().where("id=?", entity.get("id")).submit();
                break;
        }
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
        <link href="/css/swfupload.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td class="tr w120">押金金额：</td>
                        <td><input type="number" class="w100" name="socialsecurity" value="<% entity.write("socialsecurity"); %>" />元</td>
                    </tr>
                </table>
                <br/>
                <span>注释：押金是唯一的，如果已经有押金了必须删除后才可以增加押金！</span>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "增加" : "修改");%></button>
            </div>
        </form>
        <script src="/data/goods.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
        <script type="text/javascript">
            //data-val:默认值
            //dict-name:对应表单的name值
            dictdata["area"] = AreaListData;
        </script>
        <script src="../js/upload.js" type="text/javascript"></script>
        <script src="ico.js" type="text/javascript"></script>
        <script>
            var a = 0;
            $("teble input").each(function () {
                a++;
            })
            $("form").submit(function () {
                if (a > 0) {
                    alert("请完善广告信息");
                    return false;
                }
            })
        </script>
    </body>
</html>
