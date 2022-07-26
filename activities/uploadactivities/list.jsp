<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.text.*"%>
<%
    StaffList.IsLogin(request, response);
    CookieHelper cookie = new CookieHelper(request, response);
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
                <!--<button type="button" transadapter="quicksearch" select="false" class="quicksearch">查询</button>-->
                
                <button type="button" transadapter="append" select="false" class="butadd">新增履职活动</button>
                 <button type="button" transadapter="delete" class="butdelect">删除</button>
                 <!--
                <button type="button" transadapter="edit" class="butedit">编辑</button>
                
               
                <button type="button" transadapter="butview" class="butview">查看</button>
                <button type="button" transadapter="export" class="butreports">导出</button>
                  -->
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w50">序号</th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>履职标题</th>
                            <th>履职主题</th>
                            <th>履职地点</th>                          
                             <th>发起日期</th>
                            <th>履职时间</th>
                           
                            <!--<th>状态</th>-->
                             <th>操作</th>
                            <!--<th>活动内容</th>-->
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssListView list = new RssListView(pageContext, "activitiesmy");
                            list.request();
                            list.pagesize = 30;
                            int a = 1;                       
                         
//                            if (cookie.Get("powergroupid").equals("22")) {
//                                list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and name like '%" + URLDecoder.decode(list.get("name"), "utf-8") + "%' and department like '%" + URLDecoder.decode(list.get("department"), "utf-8") + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and private=1 and mission =" + UserList.MyID(request)).get_page_desc("id");
//                            }
//                            else if ( cookie.Get("powergroupid").equals("7")  ) {
//                                list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and name like '%" + URLDecoder.decode(list.get("name"), "utf-8") + "%' and department like '%" + URLDecoder.decode(list.get("department"), "utf-8") + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and private=3" ).get_page_desc("id");
//   
//                            }
//                            else {
//                                list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and name like '%" + URLDecoder.decode(list.get("name"), "utf-8") + "%' and department like '%" + URLDecoder.decode(list.get("department"), "utf-8") + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%'" ).get_page_desc("id");
//                            }
                            list.select().where("private=1 and myid=" +  UserList.MyID(request) ).get_page_desc("id");

                            
                            
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbcglclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><% out.print(list.get("title")); %></td>                          
                            <td><% out.print(list.get("name")); %></td>
                             <td><% out.print(list.get("place")); %></td>
                             <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd" ></td>
                            <td rssdate="<% out.print(list.get("beginshijian")); %>,yyyy-MM-dd" ></td>
                                                   
                       
                            
                            
                             <td>
		            <span class="ys view" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold;">查看内容</span>
                             <% 
                            if (cookie.Get("powergroupid").equals("5")){
                            %> 
                            <%
                               }else{
                            %>
                            | <span class="ys delete" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold;">删除</span> 
                            </td>  
                            <%
                               };
                            %>
                            
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
                     popuplayer.display("/activities/uploadactivities/butview.jsp?id=" + id + "&TB_iframe=true", '查看内容', {width: 800, height: 480});
                })
            });
            
             $(function(){
                ﻿$(".delete").click(function(){
                    let id = $(this).attr("id");
                    popuplayer.display("/activities/uploadactivities/delete.jsp?id=" + id + "&TB_iframe=true", '删除', {width: 300, height: 80});
                })
            });
           
            </script>
        
    </body>
</html>