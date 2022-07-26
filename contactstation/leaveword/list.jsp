<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="java.net.URLDecoder"%>
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
            /*.cellbor tbody>.sel>td{background: #dce6f5}*/
            /*             .cellbor thead,.w30{background:#f0f0f0 }
                       .cellbor tbody tr>td:first-child{display: none}
                       .cellbor td, .cellbor th { border: solid 1px #cbcbcb; padding: 8px 2px; }*/
             .res{float: right;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearchh" select="false" class="quicksearch">查询</button>
                <button type="button" transadapter="edit" class="butedit">交接</button>
                <button type="button" transadapter="return" class="butedit">不予接受</button>
                <button type="button" transadapter="butview" class="butview">查看</button>
                <button type="button" class="res">返回上一级</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>标题</th>
                            <th>提出者姓名</th>
                            <th>提出时间</th>
                            <th>联系手机</th>
                            <th>电子邮箱</th>
<!--                            <th>标题</th>-->
                            <th>回复代表</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            CookieHelper cookies = new CookieHelper(request, response);
                            RssListView list = new RssListView(pageContext, "leaveword");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            if ( cookies.Get("powergroupid").equals("7") || cookies.Get("powergroupid").equals("8") || cookies.Get("powergroupid").equals("16")|| cookies.Get("powergroupid").equals("22")) {
                                //list.select().where("state=0 and returnuser=0 and objstate=0").get_page_desc("id");
                                list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%'" + " and state=0 and returnuser=0 and objstate=0").get_page_desc("id"); 
                            }
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbfgflclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><% out.print(list.get("title")); %></td>
                            <td><% out.print(list.get("myname")); %></td>
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd HH:mm:ss" ></td>
                            <td><% out.print(list.get("telphone")); %></td>
                            <td><% out.print(list.get("email")); %></td>
<!--                            <td><% out.print(list.get("title")); %></td>-->
                            <td><% out.print(list.get("allname")); %></td>
                            <!--zyx-->
                            <td>
                            <span class="ys jiaojie" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >交接</span>
                            |<span class="ys notjiaojie" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >不予接受</span>
                            |<span class="ys view" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >查看内容</span>
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
        <!--<script src="/data/suggest.js" type="text/javascript"></script>-->
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
        <script>
            $(function(){
                ﻿$(".view").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/contactstation/leaveword/butview.jsp?id=" + id + "&TB_iframe=true", '查看内容', {width: 830, height: 240});
                })
            });
            $(function(){
                ﻿$(".jiaojie").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/contactstation/leaveword/edit.jsp?id=" + id + "&TB_iframe=true", '交接', {width: 330, height: 80});
                })
            });$(function(){
                ﻿$(".notjiaojie").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/contactstation/leaveword/return.jsp?id=" + id + "&TB_iframe=true", '不予接受', {width: 430, height: 220});
                })
            });
            
              $(".res").click(function () {
                                history.go(-1);
                            });
        </script>
    </body>
</html>