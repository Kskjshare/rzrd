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
                <button type="button" transadapter="butview" class="butview">详情</button>
                <button type="button" transadapter="toexamine" class="toexamine">审核</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>标题</th>
                            <th>分类</th>
                            <th>创建时间</th>
                            <th>是否发布</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssList list = new RssList(pageContext, "releasum");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and classifyid=2").get_page_desc("id");
                            while (list.for_in_rows()) {
//                                user_delegation.select("company").where("myid in (" + list.get("organizationid") + ")").get_first_rows();
//                                list.keyvalue("userrolecompany", user_delegation.get("company"));
                        %>
                        <tr ondblclick="ck_dbAbTlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><% out.print(list.get("title")); %></td>
                            <td releasumclassify="<% out.print(list.get("classifyid")); %>"></td>
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd hh:mm:ss" ></td>
                             <%
                            if ( list.get("state").equals("1")){
                            %>
                            <td style="color:red;font-weight: bold;" releasumstate="<% out.print(list.get("state")); %>"></td>
                            <%
                            }else if(list.get("state").equals("2")){
                            %>
                            <td style="color:green;font-weight: bold;" releasumstate="<% out.print(list.get("state")); %>"></td>
                            <%
                            };
                            %>
                            <td>
                                <span class="ys edit" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >编辑</span>
                            | <span class="ys delete" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >删除</span> 
                            | <span class="ys view" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >查看内容</span>
                              | <span class="ys toutiao" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >设为头条</span>
                            | <span class="ys horselight" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >设为图片新闻</span>
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
                ﻿$(".view").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/website/butview.jsp?id=" + id + "&TB_iframe=true", '查看内容', {width: 1248, height: 740});
                })
            });
             $(function(){
            ﻿$(".delete").click(function(){
                let id = $(this).attr("id");
//             popuplayer.display("/website/delete_1.jsp?id=" + id + "&TB_iframe=true", '删除', {width: 300, height: 80});
             popuplayer.display("/website/notice/delete.jsp?relationid=" + id + "&TB_iframe=true", '删除', {width: 300, height: 80});

             
            })
            });
             $(function(){
                ﻿$(".edit").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/website/notice/edit.jsp?id=" + id + "&TB_iframe=true", '编辑', {width: 1248, height: 740});
                })
            });
            
             $(function(){
            ﻿$(".toutiao").click(function(){
                let id = $(this).attr("id");
             //popuplayer.display("/supervision/zhifajiancha/delete.jsp?id=" + id + "&TB_iframe=true", '删除', {width: 300, height: 80});
             popuplayer.display("/website/notice/headline.jsp?id=" + id + "&TB_iframe=true", '设置头条新闻', {width: 400, height: 140});
             
            })
            });
            
            $(function(){
            ﻿$(".horselight").click(function(){
                let id = $(this).attr("id");
             //popuplayer.display("/supervision/zhifajiancha/delete.jsp?id=" + id + "&TB_iframe=true", '删除', {width: 300, height: 80});
             popuplayer.display("/website/notice/horselight.jsp?id=" + id + "&TB_iframe=true", '设置图片新闻', {width: 360, height: 120});
             
            })
            });
            
            if(<% out.print(UserList.MyID(request));%> == 1024){
                $(".toexamine").show()
            }else{
                $(".toexamine").hide()
            }
        </script>

    </body>
</html>