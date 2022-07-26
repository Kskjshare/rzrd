<%-- 
    Document   : list_2
    Created on : 2021-3-22, 18:27:17
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
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar"><!--
-->                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">快速查询</button><!--
                <button type="button" transadapter="append" select="false" class="butadd">增加</button>
                <button type="button" transadapter="edit" class="butedit">编辑</button>
                <button type="button" transadapter="delete" class="butdelect">删除</button>
                <button type="button" transadapter="butview" class="butview">详情</button>
                <button type="button" transadapter="toexamine" class="toexamine">审核</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
-->            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th width="20%">文件名</th>
                            <th>报备单位</th>
                            <th>文号</th>
                            <th>报送人</th>
                            <th>印发时间</th>
                            <th>备案时间</th>
                            <th>驳回时间</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            
                            String powerid = cookie.Get("powergroupid");
                            String filter = " and zhuangtai=4 and myid=" + UserList.MyID(request);
                            if (  powerid.equals("16") ) {
                                filter = " and zhuangtai=4";
                            }
                            RssList list = new RssList(pageContext, "shenchadengji");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                                  list.select().where("filename like '%" + 
                                            URLDecoder.decode(req.get("filename"), "utf-8") 
                                         + "%' and organizer like '%" + 
                                            URLDecoder.decode(req.get("organizer"), "utf-8") 
                                         + "%' and Titanic like '%" + 
                                            URLDecoder.decode(req.get("Titanic"), "utf-8") 
                                         + "%' and name like '%" + 
                                            URLDecoder.decode(req.get("name"), "utf-8") 
                                         + "%' and telephone like '%" + 
                                            URLDecoder.decode(req.get("telephone"), "utf-8") 
                                         + "%' and yfdate like '%" + 
                                            URLDecoder.decode(req.get("yfdate"), "utf-8") 
                                         + "%' and beiandate like '%" + 
                                            URLDecoder.decode(req.get("beiandate"), "utf-8") 
                                         + "%' and year like '%" 
//                                            URLDecoder.decode(req.get("year"), "utf-8") 
//                                         + "%' and realid like '%" + 
//                                            URLDecoder.decode(req.get("realid"), "utf-8") 
//                                         + "%' and meetingnum like '%" + 
//                                            URLDecoder.decode(req.get("meetingnum"), "utf-8") 
                                         + "%'  " + filter ).get_page_desc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbAbTlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><% out.print(list.get("filename")); %></td>
                            <td releasumclassify="<% out.print(list.get("organizer")); %>"></td>
                            <td><% out.print(list.get("Titanic")); %></td>
                            <td releasumstate="<% out.print(list.get("name")); %>"></td>
                            <td><% out.print(list.get("yfdate")); %></td>
                             <td><% out.print(list.get("beiandate")); %></td>
                             <td><% out.print(list.get("scdate")); %></td>
                             <td style="color:blue;">
                                 <span class="ys chakan" style="font-weight:bold;" id="<% out.print(list.get("id")); %>">查看</span>
                              | <span class="ys shanchu" style="font-weight:bold;" id="<% out.print(list.get("id")); %>">删除</span> 
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
                    popuplayer.display("/judicsuper/jfxwjba/butview_1.jsp?id=" + id + "&TB_iframe=true", '查看', {width: 900, height: 330});
                })
            });
            $(function(){
                ﻿$(".shanchu").click(function(){
                    let id = $(this).attr("id");
                    popuplayer.display("/judicsuper/jfxwjba/delete.jsp?id=" + id + "&TB_iframe=true", '删除', {width: 300, height: 80});
            })
            });
              transadapter["delete"] = function (t)
{
    var tid = [], rid = "";
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    rid = tid.join(",");
    popuplayer.display("/judicsuper/jfxwjba/delete.jsp?id=" + rid + "&TB_iframe=true", '删除', {width: 300, height: 80});
}
            
        </script>

    </body>
</html>