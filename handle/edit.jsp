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
    RssList entity = new RssList(pageContext, "deal");
    entity.request();
    if (!entity.get("action").isEmpty()) {
        entity.remove("id");
        if (entity.get("myid").isEmpty()) {
            entity.keymyid(UserList.MyID(request));
        }
        entity.remove("myid");
        entity.update().where("jyyanid=?", entity.get("id")).submit();
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select().where("jyyanid=?", entity.get("id")).get_first_rows();
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
            table{padding: 20px 80px; display: block;width: 65%;}
            table ul{height: 20px;border: 2px solid #dce6f5;border-radius: 20px;display: block;}
            table ul li{width: 20%;background: #6caddc;height: 21px;display: block;border-radius: 10px;margin-top: -.5px;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table>
                    <tr>
                        <td>正式交办日期：</td>
                        <td><input type="text" class="w200 Wdate" name="start" value="<% out.print(entity.get("start")); %>" onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly"></td>
                    </tr>
                    <tr>
                        <td>要求结办日期：</td>
                        <td><input type="text" class="w200 Wdate" name="stop" value="<% out.print(entity.get("stop"));%>" onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly"></td>
                    </tr>
                    <tr><td colspan="2"><ul><li></li></ul></td></tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="1" />
                <button type="submit">交办</button>
            </div>
        </form>
        <script src="/data/bill.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
