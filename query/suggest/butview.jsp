<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.MySql.RssListView"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    RssListView entity = new RssListView(pageContext, "sort");
    entity.request();
    entity.select().where("id=?", entity.get("id")).get_first_rows();
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
                    <tr><td colspan="4" id="tabheader">建议查看</td></tr>
                    <tr><td class="w120 dce">序号</td><td class="w261"><% entity.write("lwid"); %></td><td class="w120 dce">届次</td><td class="w261" sessionclassify="<% entity.write("sessionid"); %>"></td></tr>
                    <tr><td class="w120 dce">建议编号</td><td class="w261"><% entity.write("realid"); %></td><td class="w120 dce">提交类型</td><td class="w261" lwstate="<% entity.write("lwstate"); %>"></td></tr>
                    <tr><td class="w120 dce">建议题目</td><td colspan="3"><% entity.write("title"); %></td></tr>
                    <tr><td class="w120 dce">分类</td><td class="w261" reviewclass="<% entity.write("reviewclass"); %>"></td><td class="w120 dce">审查状态</td><td class="w261" examination="<% entity.write("examination"); %>" registertype="<% entity.write("registertype"); %>"></td></tr>
                    <tr><td class="w120 dce">可否联名提出</td><td class="w261" seconded="<% entity.write("seconded"); %>"></td><td class="w120 dce">密级</td><td class="w261"><% entity.write("title"); %></td></tr>
                    <tr><td class="w120 dce">处理方式</td><td class="w261" methoded="<% entity.write("methoded"); %>"></td><td class="w120 dce">征求意见方式</td><td class="w261" opinioned="<% entity.write("opinioned"); %>"></td></tr>
                    <tr><td class="w120 dce">是否会上</td><td class="w261"><% entity.write("title"); %></td><td class="w120 dce">可否网上公开</td><td class="w261"><% entity.write("title"); %></td></tr>
                    <tr>
                        <td colspan="4" class="marginauto uetd">
                            <ul><li class="sel">建议内容</li><li>提出者信息</li><li>建议办复信息</li><li>操作相关日志</li></ul>
                            <% entity.write("matter"); %>
                        </td>
                    </tr>
                </table>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="/data/session.js"></script>
        <script>
            $(".uetd>ul>li").click(function () {
                $(this).addClass("sel").siblings("li").removeClass("sel");
            })
        </script>
    </body>
</html>
