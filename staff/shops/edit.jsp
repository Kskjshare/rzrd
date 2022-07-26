<%@page import="api.saas.TimeConvert"%>
<%@page import="RssEasy.MySql.Staff.StaffListView"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    StaffList staff = new StaffList(pageContext);
    staff.request().remove("action", "myid");
    if (!staff.get("action").isEmpty()) {
        if (!staff.get("ruzhiriqi").isEmpty()) {
            long firstdeliverytime = DateTimeExtend.timestamp(staff.get("ruzhiriqi"), "yyyy-MM-dd HH:mm");
            staff.keyvalue("ruzhiriqi", firstdeliverytime);
        }
        staff.keyvalue("type",2);
        staff.update().where("myid=?", staff.get("myid")).submit();
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    StaffListView entity = new StaffListView(pageContext);
    entity.request();
    entity.select().where("myid=?", entity.get("myid")).get_first_rows();
    String ruzhiriqi = "";
    if (!entity.get("ruzhiriqi").equals("") && !entity.get("ruzhiriqi").equals(null) && !entity.get("ruzhiriqi").isEmpty()) {
        ruzhiriqi = TimeConvert.timeStamp2Date(entity.get("ruzhiriqi"), "");
    }
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
                        <td class="tr w100">帐号：</td>
                        <td><% out.print(entity.get("account")); %></td>
                    </tr>
                    <tr>
                        <td class="tr">入职日期：</td>
                        <td>
                            <input type="text" class="Wdate" name="ruzhiriqi" value="<% out.print(ruzhiriqi); %>">
                        </td>
                    </tr>
                    <tr>
                        <td class="tr">基本薪酬：</td>
                        <td>
                            <input type="text" allowinput="number" name="xinchou" maxlength="25" value="<% out.print(entity.get("xinchou")); %>" />
                        </td>
                    </tr>
                    <tr>
                        <td class="tr">银行卡号：</td>
                        <td>
                            <input type="text" name="yinghanka" maxlength="25" value="<% out.print(entity.get("yinghanka")); %>" />
                        </td>
                    </tr>
                    <tr>
                        <td class="tr">微信号：</td>
                        <td>
                            <input type="text" name="weixin" maxlength="25" value="<% out.print(entity.get("weixin")); %>" />
                        </td>
                    </tr>
                    <tr>
                        <td class="tr">办公电话：</td>
                        <td>
                            <input type="text" name="phone" maxlength="25" value="<% out.print(entity.get("phone")); %>" />
                        </td>
                    </tr>
                    <tr>
                        <td class="tr">企业邮箱：</td>
                        <td>
                            <input type="text" name="email" maxlength="25" value="<% out.print(entity.get("email"));%>" />
                        </td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="update" />
                <button type="submit">修改</button>
            </div>
        </form>
        <script src="/data/staff.js"></script>
        <%@include  file="/inc/js.html" %>
    </body>
</html>