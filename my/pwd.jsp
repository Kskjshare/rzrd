<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.MySql.RssCodeList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    UserList entity = new UserList(pageContext);
    entity.request();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <link href="/css/swfupload.css" rel="stylesheet" />
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="bodywrap">
                <table class="cellbor">
                    <tr>
                        <td class="tr w80">原始密码：</td>
                        <td><input name="oldpwd" type="password" value="<% entity.write("oldpwd"); %>"/></td>
                    </tr>
                    <tr>
                        <td class="tr w80">新密码：</td>
                        <td><input name="pwd" type="password" value="<% entity.write("pwd"); %>"/></td>
                    </tr>
                    <tr>
                        <td class="tr w80">确认密码：</td>
                        <td><input name="repwd" type="password" value="<% entity.write("repwd"); %>"/></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <input type="hidden" name="action" value="update"/>
                            <button type="submit" class="btnface">修改</button>
                        </td>
                    </tr>
                </table>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>

        <%
            if (!entity.get("action").isEmpty()) {
                try {
                    entity.keyvalue("myid", UserList.MyID(request));
                    entity.updatepwd();
                    PoPupHelper.adapter(out).alert("修改成功");
                } catch (Exception e) {
                    entity.rsscode(e);
                    PoPupHelper.adapter(out).showRsscode(RssCodeList.getCode(pageContext, e.getMessage()));
                }
            }
        %>

    </body>
</html>