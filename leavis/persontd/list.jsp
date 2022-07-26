<%@page import="RssEasy.Core.CookieHelper"%>
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
<!--                <button type="button" transadapter="append" select="false" class="butadd">增加</button>
                <button type="button" transadapter="edit" class="butedit">编辑</button>
                <button type="button" transadapter="delete" class="butdelect">删除</button>-->
                <button type="button" transadapter="export" class="butreports" powerid="120" >导出</button>
                <!--<button type="button" transadapter="handle" class="butreports" powerid="120" >办理方式</button>-->
                
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <!--<th>信访件编号</th>-->
                            <th>信访人</th>
                            <th>信访主题</th>
                            <th>信访日期</th>
                            <th>主办单位</th>
                            <th>信访形式</th>
                            <th>问题属地</th>
                            <th>信访原因</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssList list = new RssList(pageContext, "petition");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            
                            
                            CookieHelper cookie = new CookieHelper(request, response);
                            String powergroupid = cookie.Get("powergroupid");
                            String parentid = cookie.Get("parentid");
                            String sql = "";
                            if (powergroupid.equals("16")) {
                                sql = "title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and handle is null";
                            } else {
                                sql = "title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and handle is null and gtdepar="+parentid+"";
                            }
                            
                            list.select().where(sql).get_page_desc("id"); 
                            while (list.for_in_rows()) {
//                                user_delegation.select("company").where("myid in (" + list.get("organizationid") + ")").get_first_rows();
//                                list.keyvalue("userrolecompany", user_delegation.get("company"));
                        %>
                        <tr ondblclick="ck_dbablclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <!--<td><% out.print(list.get("petition")); %></td>-->
                            <td><% out.print(list.get("petitioner")); %></td>
                            <td><% out.print(list.get("title")); %></td>
                            <td rssdate="<% out.print(list.get("datapetition")); %>,yyyy-MM-dd"></td>
                            <td><% out.print(list.get("organizer")); %></td>
                            <td petitionclassify="<% out.print(list.get("petitionclassify")); %>"></td>
                            <td><% out.print(list.get("problemter")); %></td>
                            <td reapetitionclassify="<% out.print(list.get("reapetition")); %>"></td>
<!--                            <td releasumclassify="<% out.print(list.get("classifyid")); %>"></td>
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd hh:mm:ss" ></td>-->
                            
                            <td>
		            <span class="ys handle" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold;">处理方式</span>
                             | <span class="ys export" id="<% out.print(list.get("id")); %>" style="color:purple;font-weight: bold;">导出</span> 
                             | <span class="ys view" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold;">查看内容</span>       

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
              ﻿$(".export").click(function(){
                  let id = $(this).attr("id");
                  location.href = "/leavis/persontd/companylist.jsp?relationid=" + id;
              })
          });

          $(function(){
              ﻿$(".handle").click(function(){
                  let id = $(this).attr("id");
                  popuplayer.display("/leavis/persontd/handle.jsp?id=" + id + "&TB_iframe=true", '处理方式', {width: 660, height: 240 });
              })
          });

          $(function(){
              ﻿$(".view").click(function(){
                  let id = $(this).attr("id");
                  popuplayer.display("/leavis/butview.jsp?id=" + id + "&TB_iframe=true", '查看内容', {width: 1248, height: 740 });
              })
          });

      </script> 
        

    </body>
</html>