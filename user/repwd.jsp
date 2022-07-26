<%@page import="RssEasy.Sms.SmsFactory"%>
<%@page import="RssEasy.Sms.SmsExtend"%>
<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    UserList entity = new UserList(pageContext);
    entity.request();

    if (!entity.get("action").isEmpty()) {
        entity.remove("myid");
        
        SmsExtend sms = SmsFactory.get(this.getServletContext());
        sms.telphone = entity.get("account");
        entity.keyvalue("pwd", Encrypt.Md532(entity.get("account") + sms.resetPwd()));
        entity.update().where("myid=?", entity.get("myid")).submit();
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select("account").where("myid=?", entity.get("myid")).get_first_rows();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <form method="post" class="popupwrap">
            <div class="infowrap">
                重置后的密码将已短信的方式发送给用户。
                <input type="hidden" id="account" name="account" value="<% entity.write("account");%>" />
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="repwd" />
                <button type="submit">确认</button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
