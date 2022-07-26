<%-- 
    Document   : list_1
    Created on : 2021-3-22, 18:27:09
    Author     : Administrator
--%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
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
    String powerid = cookie.Get("powergroupid");
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
            p.yanse{
                color: blue;
                font-size: 20px;
                font-weight: 1000;
            }       
            .ys{
                color: blue;
            }
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <!--<button type="button" transadapter="quicksearch" select="false" class="quicksearch">快速查询</button>-->

            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th width="20%">文件名</th>
                            <th>回复单位</th>                                                
                            <th width="20%">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssList list = new RssList(pageContext, "justice_reply");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            list.select().where("relationid=" + req.get("id") ).get_page_desc("id");
                            
                            RssList userlist = new RssList(pageContext, "user");
                            userlist.request();
                            
                          
                            while (list.for_in_rows()) {
                                
                                userlist.select().where("myid=" + list.get("replyid") ).get_first_rows();
                         %>
                        <tr ondblclick="ck_dbAbTlclick();" idd="<% out.print(list.get("uid")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><% out.print(list.get("filename")); %></td>
                            <td releasumclassify="<% out.print( userlist.get("realname")); %>"></td>
                           
                           <td>
                                 <span class="ys chakan" style="font-weight:bold;"  id="<% out.print(list.get("relationid")); %>">查看内容</span>                                                              
                                
                               | <span class="ys transferreply" style="font-weight:bold;" id="<% out.print(list.get("id")); %>">查看回复</span> 
                                 
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
            if(<% out.print(UserList.MyID(request));%> == 1024){
                $(".toexamine").show()
            }else{
                $(".toexamine").hide()
            }
             $(function(){
                ﻿$(".chakan").click(function(){
                    let id = $(this).attr("id");
                    popuplayer.display("/judicsuper/jfxwjba/butview.jsp?id=" + id + "&TB_iframe=true", '查看内容', {width: 900, height: 330});
                })
            });
             $(function(){
                ﻿$(".shenpi").click(function(){
                    let id = $(this).attr("id");
                    popuplayer.display("/judicsuper/jfxwjba/butreview.jsp?id=" + id + "&TB_iframe=true", '审查', {width: 900, height: 460 });
                })
            });
            
            
             $(function(){
                ﻿$(".transfer").click(function(){
                    let id = $(this).attr("id");
                    popuplayer.display("/judicsuper/jfxwjba/tranreview.jsp?id=" + id , '转办', {width: 900, height: 460});
                })
            });
            
             $(function(){
                ﻿$(".transferreply").click(function(){
                    let id = $(this).attr("id");
                    popuplayer.display("/judicsuper/jfxwjba/replyview.jsp?id=" + id , '查看回复', {width: 900, height: 460});
                })
            });
            
            
            
            
        </script>

    </body>
</html>