<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.MySql.RssListView"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    RssListView entity = new RssListView(pageContext, "summaryreport");
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
                    <tr><td colspan="4" id="tabheader">总结报告</td></tr>
                    <tr><td class="w120 dce">建议题目</td><td colspan="3"><% entity.write("title"); %></td></tr>
                    <tr><td class="dce">提交单位</td><td><% entity.write("realname"); %></td><td class="dce">录入日期</td><td class="w230" rssdate="<% out.print(entity.get("shijian")); %>,yyyy-MM-dd" ></td></tr>
                    <tr>
                        <td colspan="4" class="marginauto uetd">
                            <% entity.write("matter"); %>
                        </td>
                    </tr>
                </table>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
