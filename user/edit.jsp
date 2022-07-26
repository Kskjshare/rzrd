<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="org.apache.catalina.User"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.StringExtend"%>
<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("utf-8");
    StaffList.IsLogin(request, response);
    UserList entity = new UserList(pageContext);
    UserList user = new UserList(pageContext);
    entity.request();
    if (!entity.get("action").isEmpty()) {

        switch (entity.get("action")) {
            case "append":
                entity.keyvalue("pwd", Encrypt.Md532(entity.get("account") + entity.get("pwd")));
                entity.timestamp();
                entity.append().submit();
                break;
            case "update":
                entity.remove("myid","shijian","account","pwd");
                entity.keyvalue("pwd", Encrypt.Md532(entity.get("account") + entity.get("pwd")));
                entity.update().where("myid=?",entity.get("myid")).submit();
                break;
        }
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    user.request();
    user.select().where("myid=?", entity.get("myid")).get_first_rows();
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
                    <tr class="account">
                        <td class="tr w60">手机号：</td>
                        <td>
                            <input type="text" class="tel" name="account" maxlength="11" value="<% user.write("account"); %>"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="tr" class="pwd">密码：</td>
                        <td>
                            <input type="text" name="pwd" value="123456"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="tr">账号类型：</td>
                        <td>
                            <label><input type="radio" name="classifyid" value="3" <% out.print(user.get("classifyid") == "3" ? "checked=\"checked\"" : ""); %>/> 管理员</label>
                            <label><input type="radio" name="classifyid" value="4" <% out.print(user.get("classifyid") == "4" ? "checked=\"checked\"" : "");%> /> 司机</label>
                            <label><input type="radio" name="classifyid" value="1" <% out.print(user.get("classifyid") == "1" ? "checked=\"checked\"" : "");%> /> 普通用户</label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tr">姓名：</td>
                        <td>
                            <input type="text" name="realname" value="<% user.write("realname"); %>"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="tr">昵称：</td>
                        <td>
                            <input type="text" name="nickname" value="<% user.write("nickname"); %>"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="tr">性别：</td>
                        <td dict-radio="sex" def="1" class="labelright">
                        </td>
                    </tr>
                    <tr>
                        <td class="tr">头像：</td>
                        <td>
                            <ul id="icourlwrap" class="swfuploadwrap">
                                <li><div class="swfuploadimg"><div><img src="/upfile/<% user.write("avatar"); %>"></div></div></li>
                            </ul>
                            <div>
                                <span swfupload="icourlswf" config="{multimode:0,fileType: [['图形图像(*.jpg;*.png;*jpeg;*gif)','*.jpg;*.png;*jpeg']]}"></span>
                                <br/>

                            </div>
                            <input type="hidden" name="avatar" id="avatar" value="<% user.write("avatar");%>">
                        </td>
                    </tr>
                </table>
            </div>                    
            <div class="footer">
                <input type="hidden" class="action" name="action" value="<% out.print(entity.get("myid").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("myid").isEmpty() ? "增加" : "修改");%></button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
        <script src="edit.js" type="text/javascript"></script>
        <script>
            $(document).ready(function () {
                if ($(".action").val() == "update") {
                    $(".pwd,.account").hide();
                } else {
                    $(".pwd,.account").show();
                    $(".popupwrap").submit(function () {
                        if (!$(".tel").val().match(/^1[3|4|5|7|8][0-9]{9}$/)) {
                            alert("手机号格式错误！");
                            return false;
                        }
                    });
                }
            })
        </script>
    </body>
</html>
