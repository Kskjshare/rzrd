<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.MySql.RssListView"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    RssList entity = new RssList(pageContext, "user");
    entity.request();
    entity.select().where("myid=?", entity.get("relationid")).get_first_rows();
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
            #tabheader{background: #82bee9;text-align: center; color: #fff;}
            .dce{background: #dce6f5;text-indent: 10px}
            .cellbor td{padding: 0 6px}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 34px;}
            .cellbor{width: 100%}
            .uetd>ul{ background: #82bee9;border: #6caddc solid 1px;height: 28px;margin: 0px auto; width: 98%;;padding: 3px 0px; position: relative;left: 0;border-radius: 2px;cursor: default;}
            .uetd>ul>li{ float: left;color: #FFF;display: inline;padding: 6px 20px;; margin: 0 10px;border-radius: 4px;line-height: 14px}
            .uetd>ul>.sel{color: #186aa3;background: #FFF}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            .uetd>p{height: 180px;background: #FFF;margin: 0 0.9%;padding: 3px;border: #6caddc solid thin;}
            .popupwrap>div:first-child{height: 100%;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr><td colspan="4" id="tabheader">单位信息</td></tr>
                    <tr><td class="w120 dce">单位编号</td><td class="w261"><% entity.write("code"); %></td><td class="w120 dce">单位类别</td><td class="w261" companytypeclassify="<% entity.write("comtype"); %>"></td></tr>
                    <tr><td class="w120 dce">单位名称</td><td class="w261"><% entity.write("nickname"); %></td><td class="w120 dce">归口系统</td><td class="w261" returnxt="<% entity.write("returnxt"); %>"></td></tr>
                    <tr><td class="w120 dce">单位全称</td><td colspan="3"><% entity.write("allname"); %></td></tr>
                    <tr><td class="w120 dce">单位地址</td><td colspan="3"><% entity.write("workaddress"); %></td></tr>
                    <tr><td class="w120 dce">负责人</td><td class="w261"><% entity.write("person"); %></td><td class="w120 dce">单位邮编</td><td class="w261"><% entity.write("postcode"); %></td></tr>
                    <tr><td class="w120 dce">联系人</td><td class="w261"><% entity.write("linkman"); %></td><td class="w120 dce">联系电话</td><td class="w261"><% entity.write("telphone"); %></td></tr>
                    <tr><td class="w120 dce">电子邮箱</td><td class="w261"><% entity.write("email"); %></td><td class="w120 dce">单位排序</td><td class="w261"><% entity.write("companysort"); %></td></tr>
                    <tr>
                        <td colspan="4" class="marginauto uetd">
                            <ul><li class="sel">承办议案建议信息</li><li>议案建议办复信息</li></ul>
                            <% entity.write("matter"); %>
                        </td>
                    </tr>
                </table>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="/data/session.js"></script>
        <script src="/data/companytype.js" type="text/javascript"></script>
        <script>
            $(".uetd>ul>li").click(function () {
                $(this).addClass("sel").siblings("li").removeClass("sel");
            })
        </script>
    </body>
</html>