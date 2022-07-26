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
        <title>汝州市人大代表履职服务平台</title>
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
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">查询</button>
                <button type="button" transadapter="butview" class="butview">查看</button>
                <!--<button type="button" transadapter="butreports" class="butreports">报表</button>-->
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30">序号</th>
                            <!--
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th class="w60">编号</th>
                            -->
                            <th class="w60">名称</th>
                            <th class="w60">性别</th>
                            <th class="w60">民族</th>
                            <th class="w60">代表团</th>
                            <th class="w60">党派</th>
                            <th class="w60">层次</th>
                            <th class="w60">出生年月</th>
                            <th class="w60">职务</th>
                            <th class="w60">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssListView list = new RssListView(pageContext, "user_delegation");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            list.select().where("code like '%" + list.get("code") + "%' and realname like '%" + list.get("realname") + "%' and sex like '%" + list.get("sex") + "%' and nationid like '%" + list.get("nationid") + "%' and state=2").get_page_desc("myid");
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbAbBlclick();" idd="<% out.print(list.get("myid")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <!--
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("myid")); %>" /></td>
                            <td>lw<% out.print(list.get("code")); %></td>
                            -->
                            <td><% out.print(list.get("realname")); %></td>
                            <td sex="<% out.print(list.get("sex")); %>"></td>
                            <td nationid="<% out.print(list.get("nationid")); %>"></td>
                            <td><% out.print(list.get("delegationname")); %></td>
                            <td clan="<% out.print(list.get("clan")); %>"></td>
                            <td circles="<% out.print(list.get("circles")); %>"></td>
                            <td rssdate="<% out.print(list.get("birthday")); %>,yyyy-MM"></td>
                            <td><% out.print(list.get("job")); %></td>
                            <td style="color:blue">                        		                         
                            <span class="ys chakan" id="<% out.print(list.get("id")); %>">查看</span> 
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
                ﻿$(".chakan").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/delegate/butview.jsp?id=" + id , '查看内容', {width: 830, height: 560});
                })
            });  
        </script>
    </body>
</html>