<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.MySql.RssListView"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    RssListView entity = new RssListView(pageContext, "user_delegation");
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
                    <tr><td colspan="6" id="tabheader">代表信息</td></tr>
                    <tr><td class="w120 dce">编号</td><td><% entity.write("code"); %></td><td class="w120 dce">姓名</td><td>"<% entity.write("realname"); %>"</td><td class="w120 dce">代表团</td><td><% entity.write("delegationname"); %></td></tr>
                    <tr><td class="w120 dce">性别</td><td sex="<% entity.write("sex"); %>"></td><td class="w120 dce">民族</td><td><% entity.write("nationid"); %></td><td class="w120 dce">党派</td><td clan="<% entity.write("clan"); %>"></td></tr>
                    <tr><td class="w120 dce">层次</td><td circles="<% entity.write("circles"); %>"></td><td class="w120 dce">学历</td><td eduid="<% entity.write("eduid"); %>"></td><td class="w120 dce">学位</td><td degree="<% entity.write("degree"); %>"></td></tr>
                    <tr><td class="w120 dce">电子邮箱</td><td><% entity.write("email"); %></td><td class="w120 dce">出生年月</td><td rssdate="<% entity.write("birthday"); %>,yyyy-MM"></td><td class="w120 dce">职业</td><td><% entity.write("email"); %></td></tr>
                    <tr><td class="w120 dce">手机</td><td colspan="3"><% entity.write("telphone"); %></td><td class="w120 dce">职称</td><td><% entity.write("worktitle"); %></td></tr>
                    <tr><td class="w120 dce">职务</td><td colspan="5"><% entity.write("job"); %></td></tr>
                    <tr><td class="w120 dce">单位名称</td><td colspan="3"><% entity.write("company"); %></td><td class="w120 dce">单位电话</td><td ><% entity.write("worktel"); %></td></tr>
                    <tr><td class="w120 dce">单位地址</td><td colspan="3"><% entity.write("workaddress"); %></td><td class="w120 dce">单位邮编</td><td><% entity.write("postcode"); %></td></tr>
                    <tr><td class="w120 dce">家庭住址</td><td colspan="3"><% entity.write("homeaddress"); %></td><td class="w120 dce">家庭电话</td><td  lwstate="<% entity.write("hometel"); %>"></td></tr>
                    
                    <tr>
                        <td colspan="6" class="marginauto uetd">
                            <ul><li class="sel">主提议案建议信息</li><li>联名议案建议信息</li></ul>
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