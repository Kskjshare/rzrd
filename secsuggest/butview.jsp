<%@page import="RssEasy.MySql.RssList"%>
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
            .uetd>div>p{height: 180px;background: #FFF;margin: 0 0.9%;padding: 3px;border: #6caddc solid thin;}
            .uetd>#tczxx{height: 100%;background: #FFF;margin: 0 auto;width: 790px;;padding: 3px;border: #6caddc solid thin;display: none}
            .uetd>#tczxx>table{width: 100%}
            .popupwrap>div:first-child{height: 100%;}
            #resumeinfo{display: none;}
            #resumeinfo>h6{margin:0 auto;text-align: center;font-size: 14px;}
            #resumeinfo>.yjsm{height: 80px;}
            .xz{width: 70%;border: 0px;};
            .popupwrap div>tr:last-of-type{height: 297px;}
            .iframe{height: 90%;height: 245px;}
            .bg{font-size:14px;height:100%;background:#FFF;margin:0 .9%;padding:3px;border:#6caddc solid thin;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr><td colspan="4" id="tabheader">建议查看</td></tr>
                    <tr><td class="w120 dce">建议题目</td><td colspan="3"><% entity.write("title"); %></td></tr>
                    <tr><td class="w120 dce">建议编号</td><td class="w261"><% entity.write("realid"); %></td><td class="w120 dce">提交类型</td><td class="w261" lwstate="<% entity.write("lwstate"); %>"></td></tr>
                    <tr><td class="w120 dce">届次</td><td class="w261"  sessionclassify="<% entity.write("sessionid"); %>" colspan="3"></td></tr>
                    <tr><td class="w120 dce">分类</td><td class="w261" reviewclass="<% entity.write("reviewclass"); %>"></td><td class="w120 dce">审查状态</td><td class="w261" examination="<% entity.write("examination"); %>" registertype="<% entity.write("registertype"); %>"></td></tr>
                    <tr><td class="w120 dce">层次：</td>
                        <td class="w261" circles="<% entity.write("level"); %>"></td><td class="w120 dce">可否联名提出</td><td class="w261" seconded="<% entity.write("seconded"); %>"></td></tr>
                    <tr><td class="w120 dce">是否会上</td><td class="w261" judgment="<% entity.write("meet"); %>"></td><td class="w120 dce">可否网上公开</td><td class="w261" judgment="<% entity.write("permission"); %>"></td></tr>
                    <tr><td class="w120 dce">建议附件</td><td colspan="3">
                            <%
                                RssList user1 = new RssList(pageContext, "suggest");
                                user1.select().where("id=?", entity.get("id")).get_first_rows();
                                String[] arry1 = {"", "", ""};
                                if (!entity.get("enclosure").isEmpty()) {
                                    String[] str = entity.get("enclosure").split(",");
                                    for (int idx = 0; idx < str.length; idx++) {
                                        arry1[idx] = str[idx];
                            %>
                            <input class="xz" value="<% out.print(arry1[idx]); %>"/><a href="/upfile/<% out.print(arry1[idx]); %>" style="cursor: pointer;color: red;">点击下载</a>
                            <%
                                    }
                                }
                            %></td>
                    </tr>
                    <tr>
                        <td colspan="4" class="marginauto uetd">
                            <ul><li class="sel">建议内容</li><li>提出者信息</li><li>建议办复信息</li><li>代表意见</li></ul>
                            <div class="iframe"><p><iframe src="butview_1.jsp?id=<% out.print(entity.get("id"));%>"></iframe></p></div>
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
                                        <tr><td>联名代表</td><td colspan="3"><ul id="blfyr">
                                                    <%
                                                        if (!entity.get("id").isEmpty()) {
                                                            RssListView secondlist = new RssListView(pageContext, "second_user");
                                                            secondlist.select().where("suggestid=" + entity.get("id")).query();
                                                            while (secondlist.for_in_rows()) {
                                                    %>
                                                    <li myid='<% out.print(secondlist.get("userid"));%>'>
                                                        <% out.print(secondlist.get("realname"));%></li>
                                                        <%
                                                                }
                                                            }
                                                        %>
                                                </ul></td></tr>
                                    </tbody>
                                </table>
                            </div>
                            <div id="resumeinfo">
                                <h6>办复附件</h6>
                                <%
                                    RssList user11 = new RssList(pageContext, "suggest");
                                    user11.select().where("id=?", entity.get("id")).get_first_rows();
                                    String[] arry11 = {"", "", ""};
                                    if (!entity.get("dfenclosure").isEmpty()) {
                                        String[] str = entity.get("dfenclosure").split(",");
                                        for (int idx = 0; idx < str.length; idx++) {
                                            arry11[idx] = str[idx];
                                %>
                                <p><input class="xz" value="<% out.print(arry11[idx]); %>"/><a href="/upfile/<% out.print(arry11[idx]); %>" style="cursor: pointer;color: red;">点击下载</a></p>
                                    <%
                                            }
                                        }
                                    %>
                                <h6>意见说明</h6>
                                <p class="yjsm"><% entity.write("comments"); %></p>
                                <h6>办理报告</h6>
                                <div class="bg"><% entity.write("resumeinfo");%>  </div>
                            </div>        
                            <div id="resumeinfo">
                                <p class="yjsm"><% entity.write("opinion");%></p>
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
