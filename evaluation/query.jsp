<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.MySql.RssListView"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    RssListView entity = new RssListView(pageContext, "sort");
//    RssList sessionid = new RssList(pageContext, "session");
    entity.request();
    entity.select().where("id=?", entity.get("id")).get_first_rows();
//    sessionid.select().where("id=?", entity.get("sessionid")).get_first_rows();
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
            .uetd>div>p{height: 180px;background: #FFF;margin: 0 0.9%;padding: 3px;border: #6caddc solid thin;}
            .uetd>#tczxx{height: 180px;background: #FFF;margin: 0 auto;width: 790px;;padding: 3px;border: #6caddc solid thin;display: none}
            .uetd>#tczxx>table{width: 100%}
            .popupwrap>div:first-child{height: 100%;}
            #resumeinfo{display: none;}
            #resumeinfo>h6{margin:0 auto;text-align: center;font-size: 14px;}
            #resumeinfo>.yjsm{height: 80px;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr><td colspan="4" id="tabheader">建议查看</td></tr>
                    <tr><td class="w120 dce">序号</td><td class="w261"><% entity.write("lwid"); %></td><td class="w120 dce">届次</td><td class="w261"  sessionclassify="<% entity.write("sessionid"); %>"></td></tr>
                    <tr><td class="w120 dce">建议编号</td><td class="w261"><% entity.write("realid"); %></td><td class="w120 dce">提交类型</td><td class="w261" lwstate="<% entity.write("lwstate"); %>"></td></tr>
                    <tr><td class="w120 dce">建议题目</td><td colspan="3"><% entity.write("title"); %></td></tr>
                    <tr><td class="w120 dce">分类</td><td class="w261" reviewclass="<% entity.write("reviewclass"); %>"></td><td class="w120 dce">审查状态</td><td class="w261" examination="<% entity.write("examination"); %>" registertype="<% entity.write("registertype"); %>"></td></tr>
                    <tr><td class="w120 dce">可否联名提出</td><td class="w261" seconded="<% entity.write("seconded"); %>"></td><td class="w120 dce">密级</td><td class="w261" rank="<% entity.write("rank"); %>"></td></tr>
                    <tr><td class="w120 dce">处理方式</td><td class="w261" methoded="<% entity.write("methoded"); %>"></td><td class="w120 dce">征求意见方式</td><td class="w261" opinioned="<% entity.write("opinioned"); %>"></td></tr>
                    <tr><td class="w120 dce">是否会上</td><td class="w261" judgment="<% entity.write("meet"); %>"></td><td class="w120 dce">可否网上公开</td><td class="w261" judgment="<% entity.write("permission"); %>"></td></tr>
                    <tr>
                        <td colspan="4" class="marginauto uetd">
                            <ul><li class="sel">建议内容</li><li>提出者信息</li><li>建议办复信息</li><li>操作相关日志</li></ul>
                            <div><% entity.write("matter"); %></div>
                            <div id="tczxx">
                                <%
                                    RssListView user = new RssListView(pageContext, "user_delegation");
                                    if (entity.get("myid").isEmpty()) {
                                        entity.keymyid(UserList.MyID(request));
                                    }
                                    user.select().where("myid=?", entity.get("myid")).get_first_rows();
                                %>   
                                <table>
                                    <tbody>
                                        <tr><td>编号</td><td><% user.write("code"); %></td><td>姓名</td><td><% user.write("realname"); %></td></tr>
                                        <tr><td>性别</td><td sex="<% user.write("sex"); %>"></td><td>民族</td><td><% user.write("nationid"); %></td></tr>
                                        <tr><td>党派</td><td clan="<% user.write("clan"); %>"></td><td>出生年月</td><td rssdate="<% out.print(user.get("birthday")); %>,yyyy-MM"></td></tr>
                                        <tr><td>单位名称</td><td colspan="3"><% user.write("company"); %></td></tr>
                                        <tr><td>代表团</td><td colspan="3"><% user.write("delegationname"); %></td></tr>
                                    </tbody>
                                </table>
                            </div>
                            <div id="resumeinfo">
                                <h6>意见说明</h6>
                                <p class="yjsm"><% entity.write("comments"); %></p>
                                <h6>办理报告</h6>
                                <% entity.write("resumeinfo");%>  
                            </div>
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
                $(".uetd>div").eq($(this).index()).show().siblings("div").hide();
            })
        </script>
    </body>
</html>
