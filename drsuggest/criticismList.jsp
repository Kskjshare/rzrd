<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
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
            .cellbor tbody>.sel>td{background: #dce6f5}
            .toolbar>ul{position: absolute;right: -180px ;top:33px; z-index: 2;width: 170px;line-height: 26px;font-size: 14px;background: #FFF;border: #cbcbcb solid thin;border-radius: 5px}
            .toolbar>ul input{margin: 0 5px}
            .no{display: none}
            tbody tr:hover{background-color: gainsboro;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch1" select="false" class="quicksearch">快速查询</button>
                <!--<button type="button" transadapter="supersearch" select="false" class="supersearch">高级查询</button>-->
                <!--                <button type="button" transadapter="append" select="false" class="butadd">增加</button>
                -->                
                <button type="button" transadapter="edit" class="butedit">编辑</button>
                <button type="button" transadapter="delete" class="butdelect">删除</button>
                <!--<button type="button" transadapter="butreview" class="butreview">审查</button>-->
                <button type="button" transadapter="butview" class="butview">查看</button>
                <!--                <button type="button" transadapter="butimportance" class="butimportance">重点建议</button>
                                <button type="button" transadapter="butexcellent" class="butexcellent">优秀建议</button>-->
                <!--<button type="button" transadapter="butreports" select="false" class="butreports">报表</button>-->
                <!--<button type="button" class="setup">设置</button>-->
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
                <ul wz="0">
                    <li><label><input type="checkbox" name="field" sel="title" checked="checked">题目</label></li>
                    <li><label><input type="checkbox" name="field" sel="myid" checked="checked">领衔代表</label></li>
                    <li><label><input type="checkbox" name="field" sel="numpeople" checked="checked">提出人数</label></li>
                    <li><label><input type="checkbox" name="field" sel="lwstate">类型</label></li>
                    <li><label><input type="checkbox" name="field" sel="">提交状态</label></li>
                    <li><label><input type="checkbox" name="field" sel="registertype" checked="checked">立案形式</label></li>
                    <li><label><input type="checkbox" name="field" sel="">开案案号</label></li>
                    <li><label><input type="checkbox" name="field" sel="permission">可否网上公开</label></li>
                    <li><label><input type="checkbox" name="field" sel="seconded">可否联名提出</label></li>
                    <li><label><input type="checkbox" name="field" sel="opinioned">征求意见方式</label></li>
                    <li><label><input type="checkbox" name="field" sel="meet">是否会上</label></li>
                    <li><label><input type="checkbox" name="field" sel="methoded">处理情况</label></li>
                    <li><label><input type="checkbox" name="field" sel="shijian">提交日期</label></li>
                    <li><label><input type="checkbox" name="field" sel="reviewclass" checked="checked">审查分类</label></li>
                    <li><label><input type="checkbox" name="field" sel="handle" checked="checked">进度</label></li>
                    <li><label><input type="checkbox" name="field" sel="degree">解决程度</label></li>
                    <li><label><input type="checkbox" name="field" sel="realcompanyname">主办单位</label></li>
                </ul>
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w50">序号</th>
                            <th class="w30"><input name="all" type="checkbox"></th>
                            <!--<th class="w60">序号</th>
                            <th class="w60">编号</th>
                            -->
                            <th class="title no">标题</th>
                            <th class="myid">领衔代表</th>
                            <th>人数</th>
                            <!--<th class="lwstate no">立案形式</th>-->
                            <th class="permission no">可否网上公开</th>
                            <th class="seconded no">可否联名提出</th>
                            <th class="opinioned no">征求意见方式</th>
                            <th class="meet no">是否会上</th>
                            <th class="methoded no">处理方式</th>
                            <th class="shijian no">提交日期</th>
                            <!--<th class="registertype no">立案形式</th>-->
                            <th class="reviewclass no">审查分类</th>
                            <th class="handle no">进度</th>
                            <th class="realcompanyname no">主办单位</th>
                            <th>置回原因</th>
                            <!--zyx--> 
                            <th>操作</th>
                            <!--zyx end-->
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            CookieHelper cookie = new CookieHelper(request, response);
                            HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
                            RssListView list = new RssListView(pageContext, "sort");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                             String keywhere ="realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + "%' and title like '%" + URLDecoder.decode(req.get("title"), "utf-8") + "%' and methoded like '%" + URLDecoder.decode(req.get("methoded"), "utf-8") + "%' and organizer like '%" + URLDecoder.decode(req.get("organizer"), "utf-8") 
                                     + "%' and lwid like '%" + URLDecoder.decode(req.get("lwid"), "utf-8") + "%' and importance like '%" + URLDecoder.decode(req.get("importance"), "utf-8")
                                     + "%' and realid like '%" + URLDecoder.decode(req.get("realid"), "utf-8") + "%' and meetingnum like '%" 
                                     + URLDecoder.decode(req.get("meetingnum"), "utf-8") + "%' and examination=3 and lwstate=3 and draft=2 and myid=" + cookie.Get("myid");
                            if ((cookie.Get("powergroupid")).equals("5") || (cookie.Get("powergroupid")).equals("22")) {
                                list.select().where(keywhere).get_page_desc("shijian");
                            } else {
                                list.select().where(keywhere).get_page_desc("realid");
                            }
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbAbvlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td  class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <!--<td>lw<% out.print(list.get("lwid")); %></td>
                            <td><% out.print(list.get("realid")); %></td>
                            -->
                            <td class="title no"><% out.print(list.get("title")); %></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <td><% out.print(list.get("numpeople")); %></td>
                            <!--<td class="lwstate no" lwstate="<% list.write("lwstate"); %>"></td>-->
                            <td class="permission no" judgment="<% list.write("permission"); %>"></td>
                            <td class="seconded no" seconded="<% list.write("seconded"); %>"></td>
                            <td class="opinioned no" opinioned="<% list.write("opinioned"); %>"></td>
                            <td class="meet no" judgment="<% list.write("meet"); %>"></td>
                            <td class="methoded no" methoded="<% list.write("methoded"); %>"></td>
                            <td class="shijian no" registertype="<% list.write("registertype"); %>"></td>
                            <!--<td class="registertype no" registertype="<% list.write("registertype"); %>"></td>-->
                            <td class="reviewclass no" companytypeeclassify="<% list.write("reviewclass"); %>"></td>
                            <td class="handle no">
                                <%
                                    String handle = "";
                                    if (list.get("examination").equals("3")) {
                                        handle = "<em class='handle no' style='color:CadetBlue;font-weight:bold;'>已置回</em>";
                                    }
                                    out.print(handle);
                                %></td>
                            <td class="realcompanyname no"><% list.write("realcompanyname"); %></td>
                            <td><% out.print(list.get("buyBack")); %></td>
                            <!--zyx-->
                            <td>
                                <span class="ys viewDetail" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >查看内容</span> |
                                <span class="ys edit" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >编辑</span> 
                                |<span class="ys delete" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >删除</span> 
                            </td>
                            <!--zyx end-->
                        </tr>
                        <%
                                a++;
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <div class="footer">
                每页条数<select id="footerpagesize" dict-select="pagesize" def="<% out.print(list.get("pagesize"));%>"></select>
                <%
                    Pagination pagination = new Pagination(list, request);
                    pagination.pageinfo().firstpage().looppage().lastpage().display(out);
                %>
            </div>
        </form>
        <script src="/data/companytypee.js" type="text/javascript"></script>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="controller_1.js"></script>
        <script>
            
            //            zyx
             $(function(){
                ﻿$(".viewDetail").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/suggest/butview.jsp?id=" + id + "&TB_iframe=true", '查看内容', {width: 830, height: 560});
                })
            });
             $(function(){
                ﻿$(".edit").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/billlist/editupdate_1.jsp?id=" + id , '编辑', {width: 830, height: 560});
                })
            });
             $(function(){
                ﻿$(".delete").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/drsuggest/delete.jsp?id=" + id , '删除', {width: 330, height: 80});
                })
            });
//            zyx  end
            
            
            
                            $(".setup").click(function () {
                                if ($(".toolbar>ul").attr("wz") == "0") {
                                    $(".toolbar>ul").attr("wz", "1")
                                    $(".toolbar>ul").animate({"right": 0}, 500);
                                } else {
                                    $(".toolbar>ul").attr("wz", "0")
                                    $(".toolbar>ul").animate({"right": -180}, 500);
                                }
                            })
                            $(".toolbar ul>li").click(function () {
                                $(".no").hide();
                                listshow();
                            })
                            listshow();
                            function listshow() {
                                $("[name='field']").each(function () {
                                    if ($(this).is(":checked")) {
                                        var sel = $(this).attr("sel");
                                        if (sel != undefined && sel != "") {
                                            $("." + sel).show();
                                        }
                                    }
                                })
                            }
        </script>
    </body>
</html>
