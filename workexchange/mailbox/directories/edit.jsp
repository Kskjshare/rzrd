<%@page import="RssEasy.MySql.RssListView"%>
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
    RssList user = new RssList(pageContext, "user_friend");
    RssListView user2 = new RssListView(pageContext, "fri_user_del");
    user2.request();
    user.request();
    if (!user.get("action").isEmpty()) {
        user.remove("id,myid,action");
        switch (user.get("action")) {
            case "append":
                user.keymyid(UserList.MyID(request));
                user.timestamp();
                user.append().submit();
                PoPupHelper.adapter(out).iframereload();
                PoPupHelper.adapter(out).showSucceed();
                break;
            case "update":
                user.update().where("id="+user2.get("id")).submit();
                PoPupHelper.adapter(out).iframereload();
                PoPupHelper.adapter(out).showSucceed();
                break;
        }
    } else {
        user2.select().where("id=?", user2.get("id")).get_first_rows();
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
        <style>
            body{background: #dce6f5;}
            .dce{;text-indent: 10px}
            .cellbor td{padding: 0 6px}
            .cellbor{border:0;}
            .cellbor>tbody>tr>td{line-height: 34px;border: 0}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .popupwrap>div:first-child{height: 75%;padding: 10px 0;background: #fff;border: #6caddc solid thin;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td class="dce w100 ">收件人类型：</td>
                        <td><select id="usertype" dict-select="usertype" class="w206" def="<% user2.write("state"); %>"></select></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">分组：</td>
                        <td><select name="classify" dict-select="txlclassify" class="w206" def="<% user2.write("classify"); %>"></select></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">收件人名称：</td>
                        <td><input readonly="readonly" selectuser type="text" maxlength="80" class="w200" id="realname" value="<% user2.write("realname"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">邮箱：</td>
                        <td><input readonly="readonly" type="text" maxlength="80" class="w200" id="email" value="<% user2.write("email"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">电话：</td>
                        <td ><input readonly="readonly" type="text" maxlength="80" class="w200" id="telphone" value="<% user2.write("telphone"); %>" /></td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="friendid" value="<% user2.write("myid"); %>">
                <input type="hidden" name="action" value="<% out.print(user2.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(user2.get("id").isEmpty() ? "增加" : "修改");%></button>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
            $('[selectuser]').click(function () {
                var t = $(this).parent();
                var s = $("#usertype").val();
                RssWin.onwinreceivemsg = function (dict) {
                    console.log(dict);
                    $("#realname").val(dict.myname)
                    $("#email").val(dict.email)
                    $("#telphone").val(dict.telphone)
                    $('[name="friendid"]').val(dict.myid);
                }
                RssWin.open("/selectwin/selectoneuser.jsp?state=" + s, 400, 500);
            });
            $(".footer>button").click(function () {
                if ($('[name="friendid"]').val() == "" && $('[name="myid"]').val() == undefined) {
                    alert("请添加收件人")
                    return false;
                }
            })
        </script>
    </body>
</html>
