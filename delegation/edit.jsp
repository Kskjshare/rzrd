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
    RssList user4 = new RssList(pageContext, "userrole");
    RssList entity6 = new RssList(pageContext, "user");
    RssListView userrole = new RssListView(pageContext, "userrole");
    StaffList Staff = new StaffList(pageContext);
    user.request();
    if (!user.get("action").isEmpty()) {
        user.remove("id,myid,action");

        switch (user.get("action")) {
            case "append":
                user.keyvalue("passworderrornum", 0);//设置密码输入错误次数为零
                user.remove("account");
                if (user23.select().where("allname='" + user.get("allname") + "'").get_first_rows()) {
                    out.print("<script>alert('该代表团已存在！');</script>");
                } else {
                    if (user23.select().where("daibiaotuanCode='" + user.get("daibiaotuanCode") + "'").get_first_rows()) {
                        out.print("<script>alert('该代表团编号已存在！');</script>");
                    } else {
                        if (userrole.select().where("account='" + user.get("account") + "' and state like '%4%'").get_first_rows()) {
                            out.print("<script>alert('该登录账号已经注册过了！');</script>");
                            break;
                        } else {
                            if (user.get("account").isEmpty() && !user.get("telphone").isEmpty()) {
                                out.print("<script>console.log('登录名为空，电话不为空！');</script>");
                                if (user23.select().where("account='" + user.get("telphone") + "'").get_first_rows()) {
                                    out.print("<script>alert('该联系电话已经注册过了！');</script>");
                                    break;
                                } else {
                                    user.remove("login");
                                    if (user23.select().where("account='" + user.get("telphone") + "'").get_first_rows()) {
                                        user1.keyvalue("account", user.get("telphone"));
                                    } else {
                                        user1.keyvalue("account", user.get("telphone"));
                                        user.keyvalue("account", user.get("telphone"));
                                        user.keyvalue("pwd", Encrypt.Md532(user.get("telphone") + user.get("passwordNO")));
                                    }
                                }
                            } else {
                                user.remove("login");
                                if (user23.select().where("account='" + user.get("account") + "'").get_first_rows()) {
                                    user1.keyvalue("account", user.get("account"));
                                } else {
                                    user1.keyvalue("account", user.get("account"));
                                    user.keyvalue("account", user.get("account"));
                                    user.keyvalue("pwd", Encrypt.Md532(user.get("account") + user.get("passwordNO")));
                                    out.print("<script>console.log('登录名123！');</script>");
                                }
                            }
                            user.timestamp();

                            user1.keyvalue("state", 4);
//                        user.keyvalue("state", 4);
                            user.keyvalue("missionAddr", user.get("missionAddr"));
                            user.keyvalue("daibiaotuanCode", user.get("daibiaotuanCode"));
                            user.keyvalue("realname", user.get("allname"));
                            if (entity6.select().where("account='" + user.get("account") + "'").get_first_rows()) {
                                if (entity6.get("rolelist").indexOf(",22,") != 1) {
                                    user.keyvalue("rolelist", entity6.get("rolelist") + ",22,");
                                }
                            } else {
                                user.keyvalue("rolelist", ",22,");
                            }

                            // 登录账号为空，电话不为空
                            if (user.get("account").isEmpty() && !user.get("telphone").isEmpty()) {
                                // 查找相同登录账号的行数
                                user4.select("count(*) as n").where("account='" + user.get("telphone") + "'").get_first_rows();
                                // 不等于1则默认权限为代表 3   等于1则设当前角色为默认角色
                                if (Integer.parseInt(user4.get("n")) != 1) {
//                                    user.keyvalue("powergroupid", 5);
                                    user.keyvalue("powergroupid", 22);
                                } else {
                                    user.keyvalue("powergroupid", 22);
                                }

                                // 判断当前登录账号是否存在 存在则修改账号信息 让数据以修改的方式添加进去
                                if (user23.select().where("account='" + user.get("telphone") + "'").get_first_rows()) {
                                    user.update().where("account=?", user.get("telphone")).submit();//修改一个账号的角色信息，相当于一行数据里面添加字段内容
                                } else {
                                    user.append().submit();//不存在 提交
                                }
                                user1.append().submit();//登录账号增加一个角色 提交
                            } else {
                                user4.select("count(*) as n").where("account='" + user.get("account") + "'").get_first_rows();
                                if (Integer.parseInt(user4.get("n")) != 1) {
                                    user.keyvalue("powergroupid", 22);
//                                    user.keyvalue("powergroupid", 5);
                                } else {
                                    user.keyvalue("powergroupid", 22);
                                }
                                user.keyvalue("loginNameDw", user.get("account"));
                                if (user23.select().where("account='" + user.get("account") + "'").get_first_rows()) {
                                    user.update().where("account=?", user.get("account")).submit();
                                    out.print("<script>console.log('修改成功');</script>");
                                } else {
                                    out.print("<script>console.log('修改失败');</script>");
                                    user.append().submit();
                                }
                                user1.append().submit();
                            }
                            if (!Staff.select().where("myid=?", String.valueOf(user.autoid)).get_first_rows()) {
                                Staff.keyvalue("myid", user.autoid);
                                Staff.append().submit();
                            }
                            PoPupHelper.adapter(out).iframereload();
                            PoPupHelper.adapter(out).showSucceed();
                        }
                    }
                }
                break;
            case "update":
                if("1".equals(user.get("enabled"))){
                    user.keyvalue("passworderrornum", 0);
                }
                if (user23.select().where("allname='" + user.get("allname") + "' and myid <> " + user.get("id") + "").get_first_rows()) {
                    out.print("<script>alert('该代表团已存在！');</script>");
                } else {
                    if (user23.select().where("account='" + user.get("account") + "' and myid <> " + user.get("id") + "").get_first_rows()) {
                        out.print("<script>alert('该登录账号已存在！');</script>");
                    } else {
                        if (user23.select().where("daibiaotuanCode='" + user.get("daibiaotuanCode") + "' and myid <> " + user.get("id") + "").get_first_rows()) {
                            out.print("<script>alert('该代表团编号已存在！');</script>");
                        } else {
                            user.keyvalue("realname", user.get("allname"));
                            user.remove("id");
                            user4.remove("n");
                            user.remove("account");
                            user.keyvalue("loginNameDw", user.get("account"));
                            user.keyvalue("account", user.get("account"));
                            user.keyvalue("pwd", Encrypt.Md532(user.get("account") + user.get("passwordNO")));

                            user4.keyvalue("account", user.get("account"));
                            user4.update().where("account ='" + user.get("login") + "'").submit();

                            user.remove("login");
                            user.update().where("myid=?", user.get("id")).submit();

                            PoPupHelper.adapter(out).iframereload();
                            PoPupHelper.adapter(out).showSucceed();
                        }
                    }
                }
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
                        <td class="dce w100 ">编号</td>
                        <td><input type="text" maxlength="80" class="w200" name="daibiaotuanCode" value="<% user.write("daibiaotuanCode"); %>" /></td>
                        <td class="dce w100 ">代表团名称<em class="red">*</em></td>
                        <td><input type="text" maxlength="80" class="w200" name="allname" value="<% user.write("allname"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">联系地址</td>
                        <td><input type="text" maxlength="80" class="w200" name="missionAddr" value="<% user.write("missionAddr"); %>" /></td>
                        <td class="dce w100 ">层次<em class="red">*</em></td>
                        <td><select type="text" maxlength="80" class="w200" name="level" dict-select="circles" def="<% user.write("level"); %>" ></select></td>

                    </tr>
                    <tr>
                        <td class="dce w100 ">登录账号<em class="red">*</em></td>
                        <td><input type="text" maxlength="80" class="w200" name="account" value="<% user.write("account"); %>" /><input type="hidden" maxlength="80" class="w200" name="login" value="<% user.write("account"); %>" /></td>
                        <td class="dce w100 ">登录密码<em class="red">*</em></td>
                        <td><input type="text" maxlength="80" class="w200" name="passwordNO" value="<% user.write("passwordNO"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">管理员</td>
                        <td><input type="text" maxlength="80" class="w200" name="linkman" value="<% user.write("linkman"); %>" /></td>
                        <td class="dce w100 ">联系电话<em class="red">*</em></td>
                        <td><input type="text" maxlength="80" class="w200" name="telphone" value="<% user.write("telphone"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">代表团邮编</td>
                        <td colspan="3"><input type="text" maxlength="80" class="jynum w200" name="missionpostcode" value="<% user.write("missionpostcode"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">电子邮箱</td>
                        <td><input type="text" maxlength="80" class="w200" name="email" value="<% user.write("email"); %>" /></td>
                        <td class="dce w100 ">状态</td>
                        <td><select class="w200" name="enabled" dict-select="enabled" def="<% user.write("enabled"); %>"></select></td>
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
                if ($("[name='daibiaotuanCode']").val() == undefined || $("[name='daibiaotuanCode']").val() == "") {
                    alert("请填写代表团编号");
                    $("[name='daibiaotuanCode']").focus();
                    return false;
                }
                if ($("[name='passwordNO']").val() == undefined || $("[name='passwordNO']").val() == "") {
                    alert("请填写登录密码");
                    $("[name='passwordNO']").focus();
                    return false;
                }
                if ($("[name='allname']").val() == undefined || $("[name='allname']").val() == "") {
                    alert("请填写代表团名称");
                    $("[name='allname']").focus();
                    return false;
                }
                if ($("[name='telphone']").val() == undefined || $("[name='telphone']").val() == "") {
                    alert("请填写联系电话");
                    $("[name='telphone']").focus();
                    return false;
                } else {
                    var str = $("[name='telphone']").val()
                    if (!str.match(/^([0-9]|[._-]){4,19}$/)) {
                        alert("请填写正确的手机号");
                        return false;
                    }
                }
                if ($("[name='telphone']").val().length > 11) {
                    alert("手机号格式不正确");
                    $("[name='telphone']").focus();
                    return false;
                }
                var tf = "0";

                $(".jynum").each(function () {
                    var val = $(this).val();
                    var e = $(this).attr("name");
                    if (val) {
                        var patrn = /^[0-9]*$/;
                        if (!patrn.test(val)) {
                            alert('邮编应是纯数字');
                            $("[name='" + e + "']").focus();
                            tf = "1"
                        }
                    }
                })
                if (tf == "1") {
                    return false;
                }
            })
        </script>
    </body>
</html>
