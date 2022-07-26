<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Fund.WithdrawList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    WithdrawList entity = new WithdrawList(pageContext);
    entity.request();
    if (!entity.get("action").isEmpty()) {
        entity.remove("id","myid").keyvalue("staffmyid", UserList.MyID(request));
        entity.update().where("id=? and state in(0,1)", entity.get("id")).submit();
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    if (entity.select("myid").where("id=? and state in(0,1)", entity.get("id")).get_first_rows() == false) {
        PoPupHelper.adapter(out).showDisabled();
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
        <form method="post" class="labelright">           
            <div>
                <input type="hidden" name="myid" value="<% entity.write("myid"); %>"/>
                <table class="wp100 cellbor">
                    <tr>
                        <td class="tr w60">审核：</td>
                        <td dict-radio="finstate" dict-name="state" dict-keys="1,3" def="0"></td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit" class="btnface"><% out.print(entity.get("id").isEmpty() ? "增加" : "修改");%></button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
