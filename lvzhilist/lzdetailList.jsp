<%-- 
    Document   : list_3
    Created on : 2021-3-26, 10:07:44
    Author     : Administrator
--%>

<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    CookieHelper cookie = new CookieHelper(request, response);
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
            tbody tr:hover{background-color: gainsboro;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
               
                 <button type="button" class="res">返回上一级</button>
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th>主题</th>
                            <th>地点</th>
                            <!--<th>类型</th>-->
                            <th>组织单位</th>
                            <th>类型</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssList list = new RssList(pageContext, "deputyActivity");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            list.select().where("topic like '%" + 
                                    URLDecoder.decode(list.get("topic"), "utf-8") + "%' and content like '%" + 
                                    URLDecoder.decode(list.get("content"), "utf-8") +
                                    "%'and  typeid="+ list.get("typeid")).get_page_desc("typeid");
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbcclclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <!--<td class="w30"><% out.print(a); %></td>-->
                            <td infotype="<% out.print(list.get("topic")); %>"></td>
                            <td><% out.print(list.get("place")); %></td>
                            <!--<td infotype="<% // out.print(list.get("infotype")); %>"></td>-->
                            <td><% out.print(list.get("organization")); %></td>
                            <td><% out.print(list.get("type")); %></td>
                            <!--<td rssdate="<% out.print(list.get("organization")); %>,yyyy-MM-dd" ></td>-->
                            <td><span class="ys chakan" id="<% out.print(list.get("id")); %>" style="color:blue; cursor: pointer;">查看</span> </td>
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
                ﻿$(".chakan").click(function(){
                    let id = $(this).attr("id");
                    popuplayer.display("./newinformation/chakan.jsp?id=" + id + "&TB_iframe=true", '查看', {width: 830, height: 500});
                })
            });
            $(".res").click(function () {
                                history.go(-1);
                            });
        </script>
    </body>
</html>
