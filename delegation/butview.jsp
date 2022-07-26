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
    RssList entity = new RssList(pageContext, "user");
    entity.request();
    entity.select().where("myid=?", entity.get("id")).get_first_rows();
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
            .dce{;text-indent: 10px}
            .cellbor td{padding: 0 6px}
            .cellbor{border:0;}
            .cellbor>tbody>tr>td{line-height: 34px;border:#d0d0d0 solid thin}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td class="dce w100 ">编号：</td>
                        <td><% entity.write("daibiaotuanCode"); %></td>
                        <td class="dce w100 ">代表团名称：</td>
                        <td><% entity.write("allname"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">联系地址：</td>
                        <td colspan="3"><% entity.write("missionAddr"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">登录账号：</td>
                        <td  colspan="3"><% entity.write("account"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">管理员：</td>
                        <td><% entity.write("linkman"); %></td>
                        <td class="dce w100 ">联系电话：</td>
                        <td><% entity.write("telphone"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">代表团邮编：</td>
                        <td colspan="3"><% entity.write("missionpostcode"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">电子邮箱：</td>
                        <td colspan="3"><% entity.write("email");%></td>
                    </tr>
                </table>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
    </body>
</html>