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
    RssListView entity = new RssListView(pageContext, "activities");
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
            .cellbor{border:1px}
            .dce{text-indent: 10px}
            .cellbor td{padding: 0 6px}
            .cellbor>tbody>tr>td{border:1;line-height: 34px;position: relative;}
            /*.cellbor>tbody>tr>td>p{border: #eee solid 2px;padding: 0 5px;}*/
            .cellbor .textareadiv{height: 120px;margin-top: 5px;padding: 0 3px;}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor select{width: 256px;height: 32px;} 
            .cellbor textarea{height: 150px;margin-top: 5px} 
            .cellbor .textareadiv{height: 100%;margin-top: 5px}
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            #matter{line-height: 12px;}
            .left>span{position: absolute;top: 10px;left: 6px;}
            .w630{width:630px;}
            #seluserlist em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td class="dce w100 ">标题</td>
                        <td><% entity.write("title"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">活动类型</td>
                        <td activitiestypeclassify="<% entity.write("classify"); %>"></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">组织部门</td>
                        <td><% entity.write("department"); %></td>
                    </tr>
                    <!--
                    <tr>
                        <td class="dce" style="width:110px;">报名截止日期</td>
                        <td rssdate="<% out.print(entity.get("endshijian")); %>,yyyy-MM-dd" ></td>
                    </tr>
                    -->
                    <tr>
                        <td class="dce w100 ">开始时间</td>
                        <td rssdate="<% out.print(entity.get("beginshijian")); %>,yyyy-MM-dd" ></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">结束时间</td>
                        <td rssdate="<% out.print(entity.get("finishshijian")); %>,yyyy-MM-dd" ></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">活动地点</td>
                        <td><% entity.write("place"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">未考勤代表</td>
                        <td id="unseluserlist">
                            <!--<em id="sdsign">点击手动考勤</em>-->
                            <%
                                RssListView entity4 = new RssListView(pageContext, "activities_realname");
                                entity4.select().where("activitiesid=" + entity.get("id") + " and attendancetype=1 and jointype=2").query();
                                while (entity4.for_in_rows()) {
                            %>
                            <em><% out.print(entity4.get("realname"));%></em>
                            <%
                                }
                            %>
                        </td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">已考勤代表</td>
                        <td id="seluserlist">
                            <%
                                RssListView entity3 = new RssListView(pageContext, "activities_realname");
                                entity3.select().where("activitiesid=" + entity.get("id") + " and attendancetype=2").query();
                                while (entity3.for_in_rows()) {
                            %>
                            <em><% out.print(entity3.get("realname"));%></em>
                            <%
                                }
                            %>
                        </td>
                    </tr>
                    <tr>
                        <td class="dce w100 "><span>活动安排</span></td>
                        <td class="textareadiv"><% entity.write("note"); %></td>
                    </tr>
                    <tr>
                        <td colspan="2" class="dce w100">活动报告提纲</td>
                    </tr>
                    <tr>
                        <td colspan="2" class="normalline" class="textareadiv"><% entity.write("savetg"); %></td>
                    </tr>
                    <tr>
                        <td colspan="2" class="dce w100 ">活动报告草案</td>
                    </tr>
                    <tr>
                        <td colspan="2" class="normalline" class="textareadiv"><% entity.write("saveca"); %></td>
                    </tr>
                    <tr>
                        <td colspan="2" class="dce w100 ">活动正式报告</td>
                    </tr>
                    <tr>
                        <td colspan="2" class="normalline" class="textareadiv"><% entity.write("savezs"); %></td>
                    </tr>
                    <tr class="thismyid">
                        <td class="tr">作者ID</td>
                        <td colspan="3"><input type="hidden" name="action" value="append" /><input type="text" name="myid" class="w50" value="<% out.print(UserList.MyID(request));%>" selectuser=""/> <label></label></td>
                </table>
            </div>
            <!--            <div class="footer">
                            <input type="hidden" name="action" value="append" />
                            <button type="submit">确定</button>
                        </div>-->
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="/data/activitiestype.js" type="text/javascript"></script>
    </body>
</html>
