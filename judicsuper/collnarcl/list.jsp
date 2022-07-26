<%@page import="java.net.URLDecoder"%>

<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page import="RssEasy.Core.CookieHelper"%>
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
                <% 
                CookieHelper cookie = new CookieHelper(request, response);
                if (cookie.Get("powergroupid").equals("5")) {
                %>
                
                <%
                    }else{
                %>
                <button type="button" transadapter="append" select="false" class="butadd">增加</button>
                <!--<button type="button" transadapter="edit" class="butedit">编辑</button>-->
                <button type="button" transadapter="delete" class="butdelect">删除</button>
                <%
                };
                %>
                <!--zyx 增加判断，个人代表登录，不可以添加、编辑、删除-->
<!--                <button type="button" transadapter="butview" class="butview" powerid="149">查看</button>-->
<!--                <button type="button" transadapter="export" class="butreports" powerid="120" >导出</button>
                <button type="button" transadapter="handle" class="butreports" powerid="120" >办理方式</button>-->
                
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>标题</th>
                           
                            <th>时间</th>
                            <th>类别</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssList list = new RssList(pageContext, "judicsup");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                             list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%'").get_page_desc("id"); 
//                            list.select().where("typeid=1").get_page_desc("id"); 
                            list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%'" + " and typeid=2").get_page_desc("id"); 
                            //list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%'").get_page_desc("id"); 
//                            list.select().where("typeid=2").get_page_desc("id"); 
                            while (list.for_in_rows()) {
//                                user_delegation.select("company").where("myid in (" + list.get("organizationid") + ")").get_first_rows();
//                                list.keyvalue("userrolecompany", user_delegation.get("company"));
                        %>
                        <tr ondblclick="ck_dbablclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><% out.print(list.get("title")); %></td>
                           
                           
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd" ></td>
                              <td><% out.print("述法线索"); %></td>
                            <td >
                            <% 
                            if (cookie.Get("powergroupid").equals("16")){
                            %> 
                            <!--<span style="color:blue;font-weight:bold;" class="ys chakan" id="<% out.print(list.get("id")); %>">查看内容</span>-->
                            <span style="color:blue;font-weight:bold;" class="ys viewreply" id="<% out.print(list.get("id")); %>">查看回复</span>                         
                             |<span style="color:blue;font-weight:bold;" class="ys shanchu" id="<% out.print(list.get("id")); %>">删除</span>
                             |<span style="color:blue;font-weight:bold;" class="ys bianji" id="<% out.print(list.get("id")); %>">编辑</span>
                             |<span style="color:blue;font-weight:bold;" class="ys chakan" id="<% out.print(list.get("id")); %>">查看内容</span>
                            <%
                            }else{
                            %>
                            <span style="color:blue;font-weight:bold;" class="ys chakan" id="<% out.print(list.get("id")); %>">查看内容</span>
                            |<span style="color:blue;font-weight:bold;" class="ys reply" id="<% out.print(list.get("id")); %>">提供线索</span>
                            <%
                            }
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
                ﻿$(".chakan").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/judicsuper/collnarcl/butview.jsp?id=" + id , '查看内容', {width: 800, height: 260});
                })
            });
            $(function(){
                ﻿$(".bianji").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/judicsuper/collnarcl/edit.jsp?id=" + id , '编辑', {width: 800, height: 500});
                })
            });
            $(function(){
                ﻿$(".viewreply").click(function(){
                    let id = $(this).attr("id");
//                popuplayer.display("/judicsuper/collnarcl/butview_1.jsp?id=" + id , '查看回复', {width: 800, height: 380});
                 popuplayer.display("/judicsuper/replylist.jsp?id=" + id +"&typeid=2", '查看回复', {width: 800, height: 380});
                })
            });
            
            $(function(){
                ﻿$(".reply").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/judicsuper/collnarcl/replyview.jsp?id=" + id , '提供线索', {width: 800, height: 380});
                })
            });
            
             $(function(){
                ﻿$(".shanchu").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/judicsuper/collnarcl/delete_1.jsp?id=" + id , '删除', {width: 300, height:80});
                })
            });
        </script>

    </body>
</html>