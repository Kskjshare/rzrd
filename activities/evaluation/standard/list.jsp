<%@page import="RssEasy.Core.HttpRequestHelper"%>
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
//    RssList list = new RssList(pageContext, "evaluation_standard");
    RssList list = new RssList(pageContext, "evaluation_new_standard");
    CookieHelper cookie = new CookieHelper(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    list.request();
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
                <!--<button type="button" transadapter="quicksearch" select="false" class="quicksearch">查询</button>-->
                <button type="button" transadapter="append" select="false" class="butadd">添加</button>
                <!--
                <button type="button" transadapter="edit" class="butedit">编辑</button>
                -->
                <button type="button" transadapter="delete" class="butdelect">删除</button>
                <!--
                <button type="button" transadapter="butview" class="butview">查看</button>
                -->
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th>序号</th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>标题</th>
                            <th>创建时间</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (!list.get("pagesize").isEmpty()) {
                                list.pagesize = Integer.valueOf(list.get("pagesize"));
                            } else {
                                list.pagesize = 30;
                            }
                            int a = 1;
                            String sql = "1=1";
                            sql += " and title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%'";
                            list.select().where(sql).get_page_desc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><% out.print(list.get("title")); %></td>

                            <td rssdate="<%list.write("shijian");%>,yy-MM-dd hh:mm:ss"></td>

                            
                            
                        <td>
                        <%
                        String powergroupid = cookie.Get("powergroupid");
                        if (powergroupid.equals("5")) { // 代表
                        %>
                        <span class="ys view" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight:bold;">查看内容</span>
                        <%
                        }else{
                        %>
                        <span class="ys view" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight:bold;">查看内容</span>
                        |<span class="ys edit" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight:bold;">编辑</span> 
                        | <span class="ys delete" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight:bold;">删除</span>  
                        <%
                        };
                        %>    
                        </td>   
                            
                            
                            
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
                     popuplayer.display("/activities/evaluation/standard/butview.jsp?id=" + id + "&TB_iframe=true", '查看内容', {width: 1000, height: 550});
                })
            });
            
             $(function(){
                ﻿$(".delete").click(function(){
                    let id = $(this).attr("id");
                     popuplayer.display("/activities/evaluation/standard/delete.jsp?id=" + id + "&TB_iframe=true", '删除', {width: 300, height: 100});
                })
            });
            $(function(){
                ﻿$(".edit").click(function(){
                    let id = $(this).attr("id");
                    popuplayer.display("/activities/evaluation/standard/edit.jsp?id=" + id + "&TB_iframe=true", '编辑', {width: 1000, height: 550});
                })
            });
            
        </script>
    </body>
</html>