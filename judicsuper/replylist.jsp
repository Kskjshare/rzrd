<%@page import="java.net.URLDecoder"%>

<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
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
<!--                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">快速查询</button>      
                <input type="hidden" id="transadapter" find="[name='id']:checked" />-->
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <!--<th class="w30"><input name="all"  type="checkbox"></th>-->
                            <th>标题</th>
                            <th>线索提供者</th>
                            <th>时间</th>
                            <!--<th>类别</th>-->
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssList user_list = new RssList(pageContext, "user");
                            user_list.request();
                            
                            RssList list = new RssList(pageContext, "clue_reply");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            //list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%'").get_page_desc("id"); 
                            list.select().where("typeid="+req.get("typeid") + " and relationid="+req.get("id") ).get_page_desc("id"); 
                            while (list.for_in_rows()) {
                             
                                user_list.remove();
                                //user_list.select("company").where("myid in (" + list.get("organizationid") + ")").get_first_rows();
                                user_list.select().where("myid=?", list.get("myid")).get_first_rows();
                        %>
                        <tr ondblclick="ck_dbablclick();" idd="<% out.print(list.get("relationid")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <!--<td><input type="checkbox" name="id" value="<% // out.print(list.get("relationid")); %>" /></td>-->
                            <td><% out.print(list.get("title")); %></td>
                            <td><% out.print( user_list.get("realname") ); %></td>
                           
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd" ></td>
                            <!--<td><% out.print("其他线索"); %></td>-->
                            
                            <td >
                            <span style="color:blue;font-weight:bold;" class="ys chakan" typeid="<% out.print(list.get("typeid")); %>" id="<% out.print(list.get("id")); %>">查看内容</span>
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
                    let typeid = $(this).attr("typeid");
                popuplayer.display("/judicsuper/butreplyview.jsp?id=" + id +"&typeid="+typeid , '查看内容', {width: 800, height: 260});
                })
            });
          
         
        </script>

    </body>
</html>