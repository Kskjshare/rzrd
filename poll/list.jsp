<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="org.apache.tomcat.jni.User"%>
<%@page import="RssEasy.Core.CookieHelper"%>
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
            tbody tr:hover{background-color: gainsboro;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">查询</button>
                <button type="button" transadapter="append" select="false" class="butadd" powerid="185">增加</button>
                <button type="button" transadapter="edit" class="butedit" powerid="186">编辑</button>
                <button type="button" transadapter="delete" class="butdelect" powerid="187">删除</button>
                <button type="button" transadapter="butview" class="butview">查看</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>序号</th>
                            <th>标题</th>
                            <th>发布者</th>
                            <th>阅读次数</th>
                            <th>发布日期</th>
                            <th>是否发布</th> 
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssListView list = new RssListView(pageContext, "poll");
                            CookieHelper cookies = new CookieHelper(request, response);
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            if (cookies.Get("powergroupid").equals("5")) {
                                list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and myid like '" + cookies.Get("myid") + "' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and state like '%" + URLDecoder.decode(list.get("state"), "utf-8") + "%'").get_page_desc("id");
                            } else if (cookies.Get("powergroupid").equals("22")) {
                                list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and state like '%" + URLDecoder.decode(list.get("state"), "utf-8") + "%' and mission=" + UserList.MyID(request)).get_page_desc("id");
                            } else {
                                list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and state like '%" + URLDecoder.decode(list.get("state"), "utf-8") + "%'").get_page_desc("id");
                            }
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbAbSlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <!--<td clueclassify="<% out.print(list.get("classify")); %>"></td>-->
                            <td><% out.print(a); %></td>
                            <td><% out.print(list.get("title")); %></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <td><% out.print(list.get("readnum")); %></td>
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd" ></td>
                            <td noticestate="<% out.print(list.get("state")); %>"></td>
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
        </script>
    </body>
</html>