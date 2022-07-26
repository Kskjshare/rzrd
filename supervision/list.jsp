<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
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
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">快速查询</button>
                <button type="button" transadapter="append" select="false" class="butadd">增加</button>
                <button type="button" transadapter="edit" class="butedit">编辑</button>
                <button type="button" transadapter="delete" class="butdelect">删除</button>
                <button type="button" transadapter="file" class="butdfile">归档</button>

                <button type="button" transadapter="butview" class="butview">查看</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>标题</th>
                            <th>视察调研类别</th>
                            <th>制定方案时间</th>
                            <th>视察调研时间</th>
                            <th>视察调研地点</th>
                            <th>状态</th>
                            <!--
                            <th>上会时间</th>
                            <th>会次</th>
                            -->
                            
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssList list = new RssList(pageContext, "supervision_topic");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%'and state like '%" + URLDecoder.decode(list.get("state"), "utf-8") + "%' and state<>2 and myid="+UserList.MyID(request)).get_page_desc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbAbTlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><% out.print(list.get("title")); %></td>
                            <td><% out.print(list.get("reviewclass")); %></td>
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd" ></td>
                            <td rssdate="<% out.print(list.get("inspectTime")); %>,yyyy-MM-dd" ></td>
                            <td><% out.print(list.get("place")); %></td>                          
                            <td><% 
                                if ( list.get("progress").equals("1") )
                                out.print( "视察调研中" ); 
                                else 
                                 out.print( "视察调研中" );
                            %></td>
                         
                            <td>
                            <span class="ys viewDetail" id="<% out.print(list.get("id")); %>" style="color:blue" >查看详情</span> | 
                            <span class="ys submitToMeeting" id="<% out.print(list.get("id")); %>" style="color:blue" >提交主任会议</span> 
                            <!--a href="duty/list.jsp?id=<% out.print(list.get("id")); %>&status=1">议题管理页面</a-->
                            </td>
                            
                            <td>
                           
                            <a href="duty/list.jsp?id=<% out.print(list.get("id")); %>&status=1">议题管理页面</a>
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
                ﻿$(".viewDetail").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/topic/duty/inspectReport.jsp?topicid=" + id + "&TB_iframe=true", '查看详情', {width: 830, height: 560});
                })
            });
            $(function(){
                ﻿$(".submitToMeeting").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/topic/duty/inspectReport.jsp?topicid=" + id + "&TB_iframe=true", '提交主任会议', {width: 830, height: 560});
                })
            });
        </script>
    </body>
</html>