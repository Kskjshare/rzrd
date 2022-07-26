<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    RssListView list = new RssListView(pageContext, "user_delegation");
    list.request();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>汝州智慧人大服务管理平台</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <style>
            #mainwrap>ul{overflow: auto;margin: 3px 15px;float: left;width: 100%}
            #mainwrap>ul>li{float: left;padding: 6px 20px; border: #eee solid 1px; margin: 2px 5px; border-radius: 5px; background: #dce6f5;cursor: pointer;background: url("/css/limg/buttonbg.png") no-repeat;background-size: 100% 100%;}
            #mainwrap>ol{overflow: auto;width: 100% ;height: 80%}
            #mainwrap>ol>li{ float: left;width: 100px;margin: 10px; height: 130px;position: relative; border-radius: 5px; border: #eee solid 2px;overflow: hidden;}
            #mainwrap>ol>li>input{display: none;}
            #mainwrap>ol>li.sel{border: #6caddc solid 2px;box-shadow:1px 2px 4px 3px #6caddc}
            #mainwrap>ol>li>img{ width: 100%;min-height: 110px;}
            #mainwrap>ol>li>h6{position: absolute;width: 100%;bottom: 0;background: #fff;height: 24px;text-align: center;line-height: 24px;}
            #mainwrap>ul>li.sel{background: url("/css/limg/buttonbg2.png") no-repeat;background-size: 100% 100%;}
            /*#mainwrap{overflow: auto;}*/
            #missionul{;margin: 0 15px; padding: 5px; border-top: #000 solid 1px}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">查询</button>
                <button type="button" transadapter="append" select="false" class="butadd"  powerid="114">增加</button>
                <button type="button" transadapter="edit" class="butedit" powerid="115" >编辑</button>
                <button type="button" transadapter="delete" class="butdelect"  powerid="116">删除</button>
                <button type="button" transadapter="butview" class="butview"  powerid="117">查看</button>
                <button type="button" transadapter="change" class="butview"  powerid="118">换届</button>
                <button type="button" transadapter="apd" select="false" class="butreports" powerid="119" >导入</button>
                <button type="button" transadapter="export" class="butreports" powerid="120" >导出</button>
                <button type="button" class="setup">样式切换</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
                
            </div>

            
            <ul><li circlesnum="4">全国人大代表</li><li circlesnum="3">省人大代表</li><li circlesnum="2">平顶山市人大代表</li><li circlesnum="1">汝州市人大代表</li><li circlesnum="0">乡镇人大代表</li></ul>
            <ul id="missionul">
                <%
                    RssListView delegation = new RssListView(pageContext, "userrole");
                    delegation.request();
                    if (delegation.get("circlesnum").equals("0") || delegation.get("circlesnum").equals("1")) {
                        delegation.query("select * from userrole_list_view where state like '%4%' and (level like '%0%' or level like '%1%') order by daibiaotuanCode;");
//                        delegation.select().where("state like '%4%' and (level like '%0%' or level like '%1%')").query("order by daibiaotuanCode");

                        while (delegation.for_in_rows()) {
                %>
                <li levelnum="<% out.print(delegation.get("level"));%>" missionmyid="<% out.print(delegation.get("myid"));%>"><% out.print(delegation.get("circlesnum").equals("1") ? delegation.get("allname") : delegation.get("allname"));%></li>
                    <%
                            }
                        }
                    %>
            </ul>
            <ol>
                <% RssListView userlist = new RssListView(pageContext, "userrole");
                    userlist.request();
                    String sql = "state=2 and mission=" + userlist.get("missionmyid") + " and circleslist like '%" + userlist.get("circlesnum") + "%'";
                    if (userlist.get("missionmyid").isEmpty()) {
                        sql = "state=2 and circleslist  like '%" + userlist.get("circlesnum") + "%'";
                    }
                    if (userlist.get("circlesnum").isEmpty()) {
                        sql = "state=2 and mission=" + userlist.get("missionmyid");
                    }
                    if (userlist.get("circlesnum").isEmpty() && userlist.get("missionmyid").isEmpty()) {
                        sql = "state=2";
                    }
                    userlist.query("select myid,realname,avatar from userrole_list_view where " + sql + " order by convert(realname using gbk) collate gbk_chinese_ci;");
                    while (userlist.for_in_rows()) {
                        String upfile = userlist.get("avatar");
                        if (!upfile.equals("avatar.png")) {
                            upfile = upfile.replace(".", "s.");
                        }
                %>
                <li myid="<% out.print(userlist.get("myid"));%>"><img src='/upfile/<% out.print(upfile);%>'/><h6><% out.print(userlist.get("realname"));%></h6><input name='id' type='checkbox' value='<% out.print(userlist.get("myid"));%>'></li>
                        <%
                            }
                        %>
            </ol>
            <input type="hidden" name="circlesnum" value="<% out.print(delegation.get("circlesnum"));%>">
            <input  type="hidden" name="missionmyid" value="<% out.print(delegation.get("missionmyid"));%>">
        </form>
        <!--<script src="/data/suggest.js" type="text/javascript"></script>-->
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
        <script>
            $("ul>li").click(function () {
                if ($(this).attr("circlesnum")) {
                    $("input[name='circlesnum']").val($(this).attr("circlesnum"));
                    $("input[name='missionmyid']").val("");
                } else {
                    $("input[name='missionmyid']").val($(this).attr("missionmyid"));
                }
                $("#mainwrap").submit();
            })
            var circlesnum = $("input[name='circlesnum']").val();
            var missionmyid = $("input[name='missionmyid']").val();
            $("li[circlesnum='" + circlesnum + "']").addClass("sel")
            $("li[missionmyid='" + missionmyid + "']").addClass("sel")


            $("ol>li").off("click").click(function () {
                if ($(this).attr("class") == "sel") {
                    $(this).removeClass("sel");
                    $(this).find("input").prop("checked", "false");
                } else {
                    $(this).addClass("sel");
                    $(this).find("input").prop("checked", "checked");
                }
            })
            $("ol>li").off("dblclick").dblclick(function () {
                var relationid = $(this).find("[name='id']").val();
                popuplayer.display("/delegate/butview.jsp?relationid=" + relationid + "&TB_ifram.e=true", '查看', {width: 830, height: 560});
            })
            $(".setup").click(function () {
                location.href = "/delegate/list.jsp"
            })

        </script>
    </body>
</html>