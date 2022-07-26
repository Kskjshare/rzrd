<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.MySql.RssListView"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    RssListView entity = new RssListView(pageContext, "company_user");
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
            .cellbor td img{width: 100%}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 34px;}
            .cellbor{width: 100%}
            .uetd>ul{ background: #82bee9;border: #6caddc solid 1px;height: 28px;margin: 0px auto; width: 98%;;padding: 3px 0px; position: relative;left: 0;border-radius: 2px;cursor: default;}
            .uetd>ul>li{ float: left;color: #FFF;display: inline;padding: 6px 20px;; margin: 0 10px;border-radius: 4px;line-height: 14px}
            .uetd>ul>.sel{color: #186aa3;background: #FFF}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            .uetd>p{height: 180px;background: #FFF;margin: 0 0.9%;padding: 3px;border: #6caddc solid thin;}
            .popupwrap>div:first-child{height: 100%;}
            td>h1{text-align: center;margin:0;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr><td colspan="7" id="tabheader">工作人员信息</td></tr>
                    <tr><td rowspan="4"><img src="/upfile/<% entity.write("avatar"); %>"></td><td class="w100 dce">编号</td><td><% entity.write("lianxirenCode"); %></td><td class="w100 dce">姓名</td><td><% entity.write("realname"); %></td><td class="w100 dce">出生年月</td><td rssdate="<% entity.write("birthday"); %>,yyyy-MM"></td></tr>
                    <tr><td class="w100 dce">性别</td><td sex="<% entity.write("sex"); %>"></td><td class="w100 dce">民族</td><td id="nationid" colspan="3"></tr>
                    <tr><td class="w100 dce">学历</td><td eduid="<% entity.write("eduid"); %>"></td><td class="w100 dce">学位</td><td degree="<% entity.write("degree"); %>"></td></tr>
                    <tr><td class="w100 dce">电子邮箱</td><td colspan="3"><% entity.write("email"); %></td><td class="w100 dce">职业</td><td><% entity.write("profession"); %></td></tr>
                    <tr><td class="w100 dce">手机</td><td colspan="6"><% entity.write("telphone"); %></td></tr>
                    <tr><td class="w100 dce">登录账号</td><td colspan="6"><% entity.write("account"); %></td></tr>
                    <tr><td class="w100 dce">职务</td><td colspan="6"><% entity.write("job"); %></td></tr>
                    <tr><td class="w100 dce">单位名称</td><td colspan="4"><% entity.write("companyallname"); %></td><td class="w100 dce">单位电话</td><td ><% entity.write("companytel"); %></td></tr>
                    <tr><td class="w100 dce">单位地址</td><td colspan="4"><% entity.write("companyaddress"); %></td><td class="w100 dce">单位邮编</td><td><% entity.write("companypost"); %></td></tr>
                    <tr><td class="w100 dce">家庭住址</td><td colspan="4"><% entity.write("homeaddress"); %></td><td class="w100 dce">家庭电话</td><td  lwstate="<% entity.write("hometel"); %>"></td></tr>
                </table>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="/data/nationality.js"></script>
        <script>
            $(".uetd>ul>li").click(function () {
                $(this).addClass("sel").siblings("li").removeClass("sel");
            })
            if (<% entity.write("nationid"); %>) {
     $("#nationid").text(dictdata["nationalityid"][<% entity.write("nationid"); %>][0])
}
           
        </script>
    </body>
</html>