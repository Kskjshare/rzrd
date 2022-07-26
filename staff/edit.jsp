<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
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
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    UserList entity = new UserList(pageContext);
    UserList entity1 = new UserList(pageContext);
    RssList entity4 = new RssList(pageContext, "user");
    RssList user1 = new RssList(pageContext, "userrole");
//    RssListView entity = new RssListView(pageContext, "userrole");
    RssListView list1 = new RssListView(pageContext, "userrole");
    entity.request();
    entity1.request();
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "append":
                entity.keyvalue("passworderrornum", 0);//设置密码输入错误次数为零
                if (entity1.select("myid").where("account=?", entity.get("account")).get_first_rows() == false) {
//                    user1.keyvalue("account", entity.get("account"));
//                    user1.keyvalue("state", entity.get("state"));
//                    user1.append().submit();
                    String[] sta = entity.get("rolelist").split(",");
                    String state = "";
                    user1.delete().where("account=?", entity.get("login")).submit();
                    for (int idx = 1; idx < sta.length; idx++) {
                        state = "";
                        if (sta[idx].equals("22")) {
                            state = "4";
                        }
                        if (sta[idx].equals("18")) {
                            state = "3";
                        }
                        if (sta[idx].equals("24")) {
                            state = "5";
                        }
                        if (sta[idx].equals("5")) {
                            state = "2";
                        }
                        if (state != "2" && state != "3" && state != "4" && state != "5") {
                            state = sta[idx];
                        }
                        if (!(state == "" || state == null)) {
                            user1.keyvalue("account", entity.get("account"));
                            user1.keyvalue("state", state);
                            user1.append().submit();
                        }
//                    user1.update().where("account ='" + entity.get("login") + "'").submit();
                    }

                    entity.remove("login");
                    entity.remove("state");
                    entity.remove("myid");
                    entity.remove("action");
                    entity.timestamp();
                    entity.keyvalue("powergroupid", entity.get("powergroupid"));
                    entity.keyvalue("account", entity.get("account"));
                    entity.keyvalue("pwd", Encrypt.Md532(entity.get("account") + entity.get("passwordNO")));
                    entity.append().submit();

//                    Staff.keyvalue("myid", entity.autoid);
//                    Staff.append().submit();
                    PoPupHelper.adapter(out).iframereload();
                    PoPupHelper.adapter(out).showSucceed();
                } else {
                    out.print("<script>alert('登录名已存在！')</script>");
                }
                break;
            case "update":

                if("1".equals(entity.get("enabled"))){
                    entity.keyvalue("passworderrornum", 0);
                }
                
                String[] sta = entity.get("rolelist").split(",");
                String state = "";
                user1.delete().where("account=?", entity.get("login")).submit();
                for (int idx = 1; idx < sta.length; idx++) {
                    state = "";
                    if (sta[idx].equals("22")) {
                        state = "4";
                    }
                    if (sta[idx].equals("18")) {
                        state = "3";
                    }
                    if (sta[idx].equals("24")) {
                        state = "5";
                    }
                    if (sta[idx].equals("5")) {
                        state = "2";
                    }
                    if (state != "2" && state != "3" && state != "4" && state != "5") {
                        state = sta[idx];
                    }
                    if (!(state == "" || state == null)) {
                        user1.keyvalue("account", entity.get("login"));
                        user1.keyvalue("state", state);
                        user1.append().submit();
                    }
//                    user1.update().where("account ='" + entity.get("login") + "'").submit();
                }
                //entity.remove("login");////commented by jackie
                entity.remove("state");
                entity.remove("account");
                entity.keyvalue().remove("action", "myid");
                if (entity.get("powergroupid").equals("22")) {
                    entity.keyvalue("state", 5);
                }
//                out.print("<script>alert('" + req.get("account")+"');</script>");
               // entity.keyvalue("pwd", Encrypt.Md532(req.get("account") + entity.get("passwordNO")));
               //up commented by jackie//因为req.get("account")会出现"人代委，人代委"账号重复导致数据库密码更登录永远不一样
                 entity.keyvalue("pwd", Encrypt.Md532(entity.get("login") + entity.get("passwordNO")));
//                System.out.println("entity.getlogin::"+entity.get("login"));
//                 System.out.println("entity. entity.getpasswordNO::"+entity.get("passwordNO"));
//                 System.out.println("entity.getpwd::"+entity.get("pwd"));
                 entity.remove("login");
                entity.update().where("myid=?", req.get("myid")).submit();
                PoPupHelper.adapter(out).iframereload();
                PoPupHelper.adapter(out).showSucceed();
                break;
        }
    }
    entity.select().where("myid=?", req.get("myid")).get_first_rows();
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
            .cellbor{border: none;}
            .cellbor td{border: none;}
            .cellbor td input,.cellbor td select{height: 28px;padding: 0;padding-left:3px;width: 197px }
            /*.w254{width: 254px;}*/
            /*.w260{width: 260px;}*/
            /*.w258{width: 258px;}*/
            .checksel{height: 32px;}
            .checksel>p{min-height: 26px; border: solid 1px #cbcbcb;padding: 0 2px;border-radius: 3px;line-height: 26px;background: #fff;background:url("/css/limg/mnselect.png") no-repeat 183px 10px;width: 173px;padding-right: 20px; }
            #sessionlist>p>span{display: block;}
            .checksel ul{position: relative;z-index: 9999;display: none;background: #fff;border: #cbcbcb solid 1px;width: 197px; height: 170px;overflow: auto;}
            .checksel li{line-height: 32px;font-size: 12px;padding: 0 3px;}
            .checksel li input{width: 14px;}
            .red{color: red;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td class="tr w100">登录名称<em class="red">*</em></td>
                        <td><input <% out.print(entity.get("myid").isEmpty() ? "" : "readonly='readonly'");%> type="text" maxlength="16" name="account" value="<% out.print(entity.get("account")); %>" /><input type="hidden" maxlength="80" class="w200" name="login" value="<% entity.write("account"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="tr">登录密码<em class="red">*</em></td>
                        <td>
                            <input type="text" name="passwordNO" maxlength="16" value="<% entity.write("passwordNO"); %>" /> 
                        </td>
                    </tr>
                    <tr>
                        <td class="tr">用户姓名</td>
                        <td>
                            <input type="text" name="<% out.print(entity.get("state").equals("3") || entity.get("state").equals("4") ? "linkman" : "realname"); %>" maxlength="25" value="<% out.print(entity.get("state").equals("3") || entity.get("state").equals("4") ? entity.get("linkman") : entity.get("realname")); %>" />
                        </td>
                    </tr>
                    <tr style="display:none">
                        <td class="tr" >用户类型</td>
                        <td>
                            <select name="state" dict-select="usertype" def="<% entity.write("state"); %>"></select>
                        </td>
                    </tr>
                    <tr>
                        <td class="tr">启用状态</td>
                        <td>
                            <select name="enabled" dict-select="enabled" def="<% entity.write("enabled"); %>"></select>
                        </td>
                    </tr>
            <!--        <tr>
                        <td class="tr">用户组别：</td>
                        <td>
                            <select name="departmentid" dict-select="department" def="<% entity.write("departmentid"); %>"></select>
                        </td>
                    </tr>//-->
                    <tr>
                        <td class="tr">角色组别<em class="red">*</em></td>
                        <td>
                           <!--  <select name="powergroupid" dict-select="powergroup" def="<% entity.write("powergroupid"); %>">-->

                            <div class="checksel" id="circleslist"><p class="w254"></p><ul class="w258"></ul></div>
                            <input type="hidden" name="rolelist" value="<% entity.write("rolelist"); %>">
                        </td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("myid").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("myid").isEmpty() ? "增加" : "修改");%></button>
                <input type="hidden" name="powergroupid" value="<% entity.write("powergroupid");%>">
            </div>
        </form>
        <script src="/data/staff.js"></script>
        <script src="/data/session.js"></script>
        <%@include  file="/inc/js.html" %>
        <script>
            $(".footer>button").click(function () {
                if ($("[name='action']").val() == "append") {
                    if ($("[name='account']").val() == "" || $("[name='account']").val() == undefined) {
                        alert("请填写登录名");
                        $("[name='account']").focus();
                        return false;
                    }
                    if ($("[name='passwordNO']").val() == "" || $("[name='passwordNO']").val() == undefined) {
                        alert("请填写密码");
                        $("[name='passwordNO']").focus();
                        return false;
                    }
                }
                var circleslistval = ",";
                $("#circleslist p").find("span").each(function () {
                    var sesid = $(this).attr("sesid");
                    $("input[name='powergroupid']").val(sesid);
                    circleslistval += sesid + ","
                })

                $("input[name='rolelist']").val(circleslistval)
                if ($("input[name='rolelist']").val() == ",") {
                    alert("请选择用户角色！");
                    return false;
                }

            })

            var circleslist = $("input[name='rolelist']").val().split(",");
            $.each(dictdata["powergroup"], function (k, v) {
//                console.log(circleslist);
//                 console.log(dictdata["powergroup"]);
                if (circleslist.indexOf(k) != "-1") {
                    $("#circleslist p").append("<span sesid=" + k + ">" + v + "</span>,")
                    $("#circleslist ul").append('<li class="w254"><label><input checked="checked" sesid=' + k + ' type="checkbox" ><span>' + v + '</span></label></li>')
                } else {
                    $("#circleslist ul").append('<li class="w254"><label><input sesid=' + k + ' type="checkbox" ><span>' + v + '</span></label></li>')
                }
            })
            checksel();
            $(".popupwrap").click(function () {
                $(".checksel").find("ul").hide();
            })
        </script>
    </body>
</html>
