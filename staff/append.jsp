<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    UserList entity = new UserList(pageContext);
    entity.request();
    if (!entity.get("action").isEmpty()) {
        if (entity.select("myid").where("account=?", entity.get("account")).get_first_rows() == false) {
            entity.keyvalue("pwd", Encrypt.Md532(entity.get("account") + "123456")).timestamp();
            entity.append().submit();
            entity.keyvalue("myid", entity.autoid);
        }
        try {
            StaffList staff = new StaffList(pageContext);
            staff.keyvalue("myid", entity.get("myid")).timestamp();
            staff.append().submit();
        } catch (Exception e) {
        }
        PoPupHelper.adapter(out).display("/staff/edit.jsp?myid=" + entity.get("myid") + "&TB_iframe=true", "编辑", 500, 500);
        out.close();
    }
    entity.select().where("myid=?", entity.get("myid")).get_first_rows();
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
                <table class="wp100 cellbor">
                    <tr>
                        <td class="tr w100">手机号：</td>
                        <td><input type="text" name="account" value=""/></td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="update" />
                <button type="submit">增加</button>
            </div>
        </form>
        <script src="/data/staff.js"></script>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
