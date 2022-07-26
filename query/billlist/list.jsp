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
           .toolbar>ul{position: absolute;right: -180px ;top:33px; z-index: 2;width: 170px;line-height: 26px;font-size: 14px;background: #FFF;border: #cbcbcb solid thin;border-radius: 5px}
            .toolbar>ul input{margin: 0 5px}
            tbody tr:hover{background-color: gainsboro;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">快速查询</button>
                <button type="button" transadapter="supersearch" select="false" class="supersearch">高级查询</button>
                <button type="button" transadapter="butview" class="butview">查看</button>
                <!--<button type="button" transadapter="butreports" select="false" class="butreports">报表</button>-->
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30">序号</th>
                            <!--
                            <th class="w30"><input name="all"  type="checkbox"></th>                         
                            <th>编号</th>
                            -->
                            <th>标题</th>
                            <th>提出人</th>
                            <th>人数</th>
                            <!--
                            <th>立案形式</th>
                            -->
                            <th>审查分类</th>
                             <!--
                            <th>办理方式</th>
                              -->
                             <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssListView list = new RssListView(pageContext, "sort");
                            list.request();
                            int a = 1; 
                            list.pagesize = 30;
                            list.select().where("title like '%"+list.get("title")+"%' and methoded like '%"+list.get("methoded")+"%' and organizer like '%"+list.get("organizer")+"%' and lwid like '%"+list.get("lwid")+"%' and realid like '%"+list.get("realid")+"%' and lwstate=2").get_page_desc("realid");
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbAbmlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                             <!--
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td>lw<% out.print(list.get("lwid")); %></td>
                           
                            <td><% out.print(list.get("realid")); %></td>
                            -->
                            <td><% out.print(list.get("title")); %></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <td><% out.print(list.get("numpeople")); %></td>
                            <!--
                            <td registertype="<% list.write("registertype"); %>"></td>
                            -->
                            <td reviewclass="<% list.write("reviewclass"); %>"></td>
                            <!--
                            <td methoded="<% list.write("methoded"); %>">办理方式</td>
                            --> 
                            <td style="color:blue">                        		                         
                            <span class="ys chakan" id="<% out.print(list.get("id")); %>">查看内容</span> 
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
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
        <script>
             $(".setup").click(function () {
                if ($(".toolbar>ul").attr("wz") == "0") {
                    $(".toolbar>ul").attr("wz","1")
                    $(".toolbar>ul").animate({"right": 0}, 500);
                } else {
                    $(".toolbar>ul").attr("wz","0")
                 $(".toolbar>ul").animate({"right": -180}, 500);
                }
            })
            
            
             $(function(){
                ﻿$(".liucheng").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/billlist/butview.jsp?id=" + id , '查看内容', {width: 830, height: 560});
                })
            });
            
        </script>
    </body>
</html>
