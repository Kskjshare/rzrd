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
    StaffList staff = new StaffList(pageContext);
    entity.request();
    if (!entity.get("action").isEmpty()) {
//        if (entity.select("myid").where("account=?", entity.get("account")).get_first_rows() == false) {
//        entity.keyvalue("pwd", Encrypt.Md532(entity.get("account") + "123456")).timestamp().keyvalue("type", 2);
//        entity.append().submit();
//        entity.keyvalue("myid", entity.autoid);
//        }
//        try {
//            StaffList staff = new StaffList(pageContext);
//        staff.keyvalue("myid", entity.get("myid")).timestamp().keyvalue("type", 2);
//        staff.append().submit();
//        } catch (Exception e) {
//        }
        if (entity.select().where("account=?", entity.get("account")).get_first_rows()) {
            staff.keyvalue("myid", entity.get("myid")).timestamp().keyvalue("type", 2);
            staff.append().submit();
        } else {
            entity.keyvalue("pwd", Encrypt.Md532(entity.get("account") + "123456")).timestamp();
            entity.append().submit();
            staff.keyvalue("myid", entity.autoid).timestamp().keyvalue("type", 2);
            staff.append().submit();
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
                        <td><input class="account" type="text" name="account" value=""/></td>
                    </tr>
                    <tr>
                        <td class="tr w100">类型：</td>
                        <td><label><input type="radio" name="classifyid" value="3"/>交易中心管理员</label> <label><input type="radio" name="classifyid" value="2"/>商户</label></td>
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
        <script>
            $(".popupwrap").submit(function () {
                if (!$(".account").val().match(/^[1][3,4,5,7,8][0-9]{9}$/)) {
                    alert("手机号格式错误！");
                    return false;
                }
            })
        </script>
    </body>
</html>
