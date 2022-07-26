<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    StaffList Staff = new StaffList(pageContext);
    UserList entity = new UserList(pageContext);
    UserList entity1 = new UserList(pageContext);
    entity.request();
    entity1.request();
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "update":
                entity.keyvalue().remove("action", "myid", "account");
//               if (!entity.get("pwd").isEmpty()) {
//                   entity.keyvalue("pwd", Encrypt.Md532(entity.get("account") + entity.get("passwordNO")));
//                } else {
//                   entity.remove("pwd");
//                }
//                entity.keyvalue("pwd", Encrypt.Md532(entity.get("account") + entity.get("passwordNO")));
                entity.update().where("myid in ("+entity.get("myid")+")").submit();
                PoPupHelper.adapter(out).iframereload();
                PoPupHelper.adapter(out).showSucceed();
                break;
        }
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
        <style>
            .cellbor{border: none}
            .cellbor td{border: none;}
            .cellbor td input,.cellbor td select{height: 28px;padding: 0;padding-left:3px;width: 197px }
            /*.w254{width: 254px;}*/
            /*.w260{width: 260px;}*/
            /*.w258{width: 258px;}*/
            .checksel{height: 32px;}
            .checksel>p{min-height: 26px; border: solid 1px #cbcbcb;padding: 0 2px;border-radius: 3px;line-height: 26px;background: #fff;background:url("/css/limg/mnselect.png") no-repeat 183px 10px;width: 173px;padding-right: 20px; }
            #sessionlist>p>span{display: block;}
            .checksel ul{position: relative;z-index: 9999;display: none;background: #fff;border: #cbcbcb solid 1px;width: 197px; height: 100px;overflow: auto;}
            .checksel li{line-height: 32px;font-size: 12px;padding: 0 3px;}
            .checksel li input{width: 14px;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td class="tr">用户组别：</td>
                        <td>
                            <select name="departmentid" dict-select="department" def="<% entity.write("departmentid"); %>"></select>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="update" />
                <button type="submit">修改</button>
                <input type="hidden" name="powergroupid" value="<% entity.write("powergroupid"); %>">
            </div>
        </form>
        <script src="/data/staff.js"></script>
        <script src="/data/session.js"></script>
        <%@include  file="/inc/js.html" %>
        <script>
//            $(".footer>button").click(function () {
//                 var circleslistval = ",";
//                 $("#circleslist p").find("span").each(function () {
//                    var sesid = $(this).attr("sesid");
//                    $("input[name='powergroupid']").val(sesid);
//                    circleslistval += sesid + ","
//                })
//                $("input[name='rolelist']").val(circleslistval)
//                if ($("input[name='rolelist']").val()==",") {
//                alert("请选择用户角色！");
//                return false;
//                };
//            })
//            var circleslist = $("input[name='rolelist']").val().split(",");
//            $.each(dictdata["powergroup"], function (k, v) {
//                console.log(circleslist);
//                 console.log(dictdata["powergroup"]);
//                if (circleslist.indexOf(k) != "-1") {
//                    $("#circleslist p").append("<span sesid=" + k + ">" + v + "</span>,")
//                    $("#circleslist ul").append('<li class="w254"><label><input checked="checked" sesid=' + k + ' type="checkbox" ><span>' + v + '</span></label></li>')
//                } else {
//                    $("#circleslist ul").append('<li class="w254"><label><input sesid=' + k + ' type="checkbox" ><span>' + v + '</span></label></li>')
//                }
//            })
//            checksel();
//            $(".popupwrap").click(function () {
//                $(".checksel").find("ul").hide();
//            })
        </script>
    </body>
</html>
