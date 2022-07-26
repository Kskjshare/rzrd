<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="org.apache.catalina.User"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("utf-8");
    StaffList.IsLogin(request, response);
    UserList entity = new UserList(pageContext);
    entity.request();
    if (!entity.get("action").isEmpty()) {

        switch (entity.get("action")) {
            case "append":
                entity.keyvalue("pwd", Encrypt.Md532(entity.get("account") + entity.get("pwd")));
                entity.timestamp();
                entity.append().submit();
                break;
        }

        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
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
        <link href="/css/swfupload.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <form method="post" class="popupwrap">
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td class="tr w60">手机号：</td>
                        <td>
                            <input type="text" name="account" maxlength="11"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="tr">密码：</td>
                        <td>
                            <input type="text" name="pwd" value="123456"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="tr">账号类型：</td>
                        <td>
                            <label><input type="radio" name="classifyid" value="3" <% out.print(entity.get("classifyid") == "3" ? "checked=\"checked\"" : ""); %>/> 管理员</label>
                            <label><input type="radio" name="classifyid" value="4" <% out.print(entity.get("classifyid") == "4" ? "checked=\"checked\"" : "");%> /> 司机</label>
                            <label><input type="radio" name="classifyid" value="1" <% out.print(entity.get("classifyid") == "1" ? "checked=\"checked\"" : "");%> /> 普通用户</label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tr">姓名：</td>
                        <td>
                            <input type="text" name="realname" />
                        </td>
                    </tr>
                    <tr>
                        <td class="tr">昵称：</td>
                        <td>
                            <input type="text" name="nickname" />
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
                                <li><div class="swfuploadimg"><div><img src="/upfile/<% entity.write("avatar"); %>"></div></div></li>
                            </ul>
                            <div>
                                <span swfupload="icourlswf" config="{multimode:0,fileType: [['图形图像(*.jpg;*.png;*jpeg;*gif)','*.jpg;*.png;*jpeg']]}"></span>
                                <br/>

                            </div>
                            <input type="hidden" name="avatar" id="avatar" value="<% entity.write("avatar");%>">
                        </td>
                    </tr>
                </table>
            </div>                    
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("myid").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("myid").isEmpty() ? "增加" : "修改");%></button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
        <script src="edit.js" type="text/javascript"></script>
    </body>
</html>
