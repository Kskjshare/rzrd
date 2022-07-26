<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page import="RssEasy.Core.CookieHelper"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    CookieHelper cookie = new CookieHelper(request, response);
    String powerid = cookie.Get("powergroupid");
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
            
         .ys{
                color: blue;
            }
            .delete{
                color: red;
            }
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                 <!--<button type="button" transadapter="quicksearch" select="false" class="quicksearch">查询</button>-->
                <%
                //if ( powerid.equals("7") )
                {                   
                %>
                <button type="button" transadapter="append" select="false" class="butadd">增加</button>
                <%
                }                
                %>
                <button type="button" transadapter="edit" class="butedit" powerid="430">编辑</button>
                <button type="button" transadapter="delete" class="butdelect" powerid="429">删除</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />            
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w60">序号</th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>名称</th>   
                            <th>站点ID</th>   
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        RssList list = new RssList(pageContext, "station_sub_id");
                        list.request();
                        int a = 1;
                        list.pagesize = 30;
                        list.select().where("name like '%" + URLDecoder.decode(list.get("name"), "utf-8") + "%' ").get_page_asc("myid");
                        while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbylclick();" contacttype="<% out.print(list.get("classify")); %>" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><% out.print(list.get("name")); %></td>
                            <td><% out.print(list.get("myid")); %></td>
                           <td>
  		            <%
                            
                            if ( ( powerid != null && ( ("7").equals( powerid ) )) || ( powerid != null && ( ("16").equals( powerid ) )) )
                            {
                            %>
                 	    <span class="ys chakan" style="font-weight:bold;" id="<% out.print(list.get("id")); %>" name="<% // out.print(list.get("name")); %>">查看</span> 
                            |<span class="delete delete" style="font-weight:bold;" id="<% out.print(list.get("id")); %>">删除</span> 
                            |<span class="ys edit" style="font-weight:bold;" id="<% out.print(list.get("id")); %>">编辑</span> 
                            <%
                            
                           }else{
                           %>
                           <!--<span class="ys chakan" style="font-weight:bold;" id="<% out.print(list.get("id")); %>" name="<%  out.print(list.get("name")); %>">查看</span>--> 
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
//             $(function(){
//                ﻿$(".chakan").click(function(){
//                    let id = $(this).attr("id");
//                    let name = $(this).attr("name");
////                popuplayer.display("/contactstation/substation/list_new.jsp?id=" + id + "&TB_iframe=true", '管理站点', {width: 980, height: 600});
//                popuplayer.display("/contactstation/substation/list_new.jsp?id=" + id + "&TB_iframe=true", name, {width: 980, height: 600});
//
//                })
//            });
             $(function(){
                ﻿$(".edit").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/contactstation/identity/edit.jsp?id=" + id + "&TB_iframe=true", '编辑', {width: 480, height: 160});
                })
            });
             $(function(){
                ﻿$(".delete").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/contactstation/identity/delete.jsp?id=" + id + "&TB_iframe=true", '删除', {width: 230, height: 80});
                })
            });
            
             $(function(){
                ﻿$(".append").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/contactstation/identity/append.jsp?id=" + id + "&TB_iframe=true", '新增联络站', {width: 640, height: 420});
                })
            });
            
        </script>
    </body>
</html>