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
//    RssList user = new RssList(pageContext, "user_delegation");
    RssList user = new RssList(pageContext, "user");
    RssList user23 = new RssList(pageContext, "user");
    RssList user1 = new RssList(pageContext, "userrole");
    RssListView userrole = new RssListView(pageContext, "userrole");
    StaffList Staff = new StaffList(pageContext);
    user.request();
    if (!user.get("action").isEmpty()) {
        switch (user.get("action")) {
            case "append":
                if (userrole.select().where("account='" + user.get("account") + "'").get_first_rows()) {
                    out.print("<script>alert('该登录账号已经注册过了！');</script>");
                    break;
                }
                user.keyvalue("pwd", Encrypt.Md532(user.get("account") + user.get("passwordNO")));
                user.timestamp();
                user.keyvalue("rolelist", ",32,");
                user.keyvalue("powergroupid", 32);
                user.append().submit();
                user1.keyvalue("account", user.get("account"));
                user1.keyvalue("state", 32);
                user1.append().submit();
                if (!Staff.select().where("myid=?", String.valueOf(user.autoid)).get_first_rows()) {
                    Staff.keyvalue("myid", user.autoid);
                    Staff.append().submit();
                }
                PoPupHelper.adapter(out).iframereload();
                PoPupHelper.adapter(out).showSucceed();
                break;
            case "update":
                if (user23.select().where("account='" + user.get("account") + "' and myid <> " + user.get("id") + "").get_first_rows()) {
                    out.print("<script>alert('该登录账号已存在！');</script>");
                    PoPupHelper.adapter(out).iframereload();
                    PoPupHelper.adapter(out).showError("修改失败！");
                    break;
                }
                user.remove("id", "regaccount");
                user.keyvalue("pwd", Encrypt.Md532(user.get("account") + user.get("passwordNO")));
                user.update().where("myid=?", user.get("id")).submit();
                user1.keyvalue("account", user.get("account"));
                user1.update().where("account=?", user.get("regaccount")).submit();
                PoPupHelper.adapter(out).iframereload();
                PoPupHelper.adapter(out).showSucceed();
                break;
        }
    } else {
        user.select().where("myid=?", user.get("id")).get_first_rows();
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
            .red{font-size: 12px;color: red;margin-left: 2px;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td class="dce w100 ">小组名称：<em class="red">*</em></td>
                        <td><input type="text" maxlength="80" class="w200" name="realname" value="<% user.write("realname"); %>" /></td>
                        <td class="dce w100 ">所属代表团：<em class="red">*</em></td>
                        <td>
                            <%
                                RssListView dbtlist = new RssListView(pageContext, "userrole");
                                if (user.get("id").isEmpty()) {%>
                            <select type="text" name="groupfordbtid" class="w200" >
                                <%

                                    dbtlist.select("myid,allname").where("allname is not null and state=4").query();
                                %>
                                <option value=""></option>
                                <%
                                    while (dbtlist.for_in_rows()) {
                                %>
                                <option value="<%dbtlist.write("myid");%>"><%dbtlist.write("allname");%></option>
                                <%
                                    }
                                %>
                            </select>
                            <%} else {
                                dbtlist.select("myid,allname").where("myid=" + user.get("groupfordbtid")).get_first_rows();
                            %>
                            <input readonly="true" type="text" maxlength="80" class="w200" value="<% dbtlist.write("allname"); %>" />
                            <input type="hidden" maxlength="80" class="w200" name="groupfordbtid" value="<% user.write("groupfordbtid"); %>" />
                            <%}%>
                    </tr>
                    <tr>
                        <td class="dce w100 ">登录账号：<em class="red">*</em></td>
                        <td><input type="text" maxlength="80" class="w200" name="account" value="<% user.write("account"); %>" />
                            <%if (!user.get("id").isEmpty()) {%>
                            <input type="hidden" maxlength="80" class="w200" name="regaccount" value="<% user.write("account"); %>" />
                            <%}%>
                        </td>
                        <td class="dce w100 ">登录密码：<em class="red">*</em></td>
                        <td><input type="text" maxlength="80" class="w200" name="passwordNO" value="<% user.write("passwordNO"); %>" /></td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(user.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(user.get("id").isEmpty() ? "增加" : "修改");%></button>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
            $(".footer>button").click(function () {
                if ($("[name='realname']").val() == undefined || $("[name='realname']").val() == "") {
                    alert("请填写小组名称");
                    $("[name='realname']").focus();
                    return false;
                }
                if ($("[name='groupfordbtid']").val() == undefined || $("[name='groupfordbtid']").val() == "") {
                    alert("请选择代表团");
                    $("[name='groupfordbtid']").focus();
                    return false;
                }
                if ($("[name='account']").val() == undefined || $("[name='account']").val() == "") {
                    alert("请填写账号");
                    $("[name='account']").focus();
                    return false;
                }
                if ($("[name='passwordNO']").val() == undefined || $("[name='passwordNO']").val() == "") {
                    alert("请填写登录密码");
                    $("[name='passwordNO']").focus();
                    return false;
                }
            })
        </script>
    </body>
</html>
