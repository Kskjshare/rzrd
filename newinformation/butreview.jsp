<%-- 
    Document   : butreview
    Created on : 2021-3-27, 9:49:43
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
                color:blue;
            }
            .chakan{font-weight: bold;}
            .shenpi{font-weight:bold;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
<!--            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">快速查询</button>
                <button type="button" transadapter="append" select="false" class="butadd">增加</button>
                <button type="button" transadapter="edit" class="butedit">编辑</button>
                <button type="button" transadapter="delete" class="butdelect">删除</button>
                <button type="button" transadapter="butview" class="butview">详情</button>
                <button type="button" transadapter="toexamine" class="toexamine">审核</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>-->
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th width="20%">主题</th>
                            <th>地点</th>
                            <th>组织单位</th>
                            <th>开始时间</th>
                            <th>结束时间</th>
                            <th width="8%">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                          RssList list = new RssList(pageContext, "deputyActivity");
                            list.request();
                            int a = 1;
                            
                            list.pagesize = 30;
                            list.select().where("topic like '%" + 
                                    URLDecoder.decode(list.get("topic"), "utf-8") + "%' and content like '%" + 
                                    URLDecoder.decode(list.get("content"), "utf-8") +
                                    "%'and myid=1").get_page_desc("id");
                            while (list.for_in_rows()) {
                                 if (list.get("zhuangtai").equals("")){
//                                user_delegation.select("company").where("myid in (" + list.get("organizationid") + ")").get_first_rows();
//                                list.keyvalue("userrolecompany", user_delegation.get("company"));
                        %>
                        <tr ondblclick="ck_dbAbTlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><% out.print(list.get("topic")); %></td>
                            <td releasumclassify="<% out.print(list.get("place")); %>"></td>
                            <td releasumclassify="<% out.print(list.get("organization")); %>"></td>
                            <td><% out.print(list.get("starttime")); %></td>
                            <td releasumstate="<% out.print(list.get("endtime")); %>"></td>
                                  
                            <td>
                                <span class="ys chakan" id="<% out.print(list.get("id")); %>">查看</span> |   <span class="ys shenpi" id="<% out.print(list.get("id")); %>">审查</span>  </td>
                            
                        </tr>
                        <%
                                a++;
                                 }else{
                                   }
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
                ﻿$(".shenpi").click(function(){
                    let id = $(this).attr("id");
                    popuplayer.display("/newinformation/butreview_1.jsp?id=" + id + "&TB_iframe=true", '审查', {width: 900, height: 530});
                })
            });
             $(function(){
                ﻿$(".chakan").click(function(){
                    let id = $(this).attr("id");
                    popuplayer.display("/newinformation/chakan.jsp?id=" + id + "&TB_iframe=true", '查看', {width: 830, height: 330});
                })
            });
        </script>

    </body>
</html>