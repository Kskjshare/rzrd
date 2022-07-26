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
                <!--<button type="button" transadapter="quicksearch" select="false" class="quicksearch">查询</button>-->
                <button type="button" transadapter="append" select="false" class="butadd" powerid="176">增加</button>
                <button type="button" transadapter="delete" class="butdelect" powerid="178">删除</button>
                <!-- 
                <button type="button" transadapter="edit" class="butedit" powerid="177">编辑</button>
                
                <button type="button" transadapter="butview" class="butview" powerid="179">查看</button>
                <button type="button" transadapter="butviewstate" class="butview" powerid="180">已读情况</button>
               -->
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w50">序号</th>
                           
                            <th class="w30"><input name="all"  type="checkbox"></th>
                          
                           
                            <th>信息分类</th>
                            <th>标题</th>
                            <!--<th>类型</th>-->
                            <th>附件</th>
                            <th>发布人</th>
                            <th>发布时间</th>
                            <th>操作</th>
                            
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssList list = new RssList(pageContext, "newinformation");

                            list.request();
                            int a = 1;
                            list.pagesize = 30;
//                            list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%'").get_page_desc("id");
                            list.select().where("state > 0").get_page_desc("id");

                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbcclclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w50"><% out.print(a); %></td>
                           
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                           
                           
                            <td infotype="<% out.print(list.get("infotype")); %>"></td>
                            <td><% out.print(list.get("title")); %></td>
                            <!--<td infotype="<% // out.print(list.get("infotype")); %>"></td>-->
                            <td><% out.print(list.get("enclosurename")); %></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd" ></td>
                            
                             <td>
                            <!--<span class="ys chakan" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight:bold; ">查看内容</span> |-->                          
                            <!--<span class="ys status" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight:bold;">查看状态</span>-->  
                            
                            <% 
                            if (cookie.Get("powergroupid").equals("5")){
                            %> 
                            <%
                               }else{
                            %>
                            <span class="ys edit" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight:bold;">编辑</span> 
                            | <span class="ys delete" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight:bold;">删除</span> 
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
                 popuplayer.display("/newinformation/butview.jsp?id=" + id + "&TB_iframe=true", '查看内容', {width: 830, height: 550});
                })
            });    
            
          $(function(){
                ﻿$(".status").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/newinformation/readstate.jsp?realid=" + id + "&TB_iframe=true", '已读人员列表', {width: 500, height: 400});
                })
            });    
            
          $(function(){
                ﻿$(".edit").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/newinformation/edit.jsp?id=" + id + "&TB_iframe=true", '编辑', {width: 800, height: 740});
                })
            });    
            
          $(function(){
                ﻿$(".delete").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/newinformation/delete.jsp?id=" + id + "&TB_iframe=true", '删除', {width: 300, height: 80});
                })
            });       
            
        </script>
    </body>
</html>