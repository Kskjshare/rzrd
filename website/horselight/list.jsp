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
                            <th>创建时间</th>
                            <th>栏目名称</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssList list = new RssList(pageContext, "imagin_news");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and category=2").get_page_desc("shijian");
                            while (list.for_in_rows()) {
//                                user_delegation.select("company").where("myid in (" + list.get("organizationid") + ")").get_first_rows();
//                                list.keyvalue("userrolecompany", user_delegation.get("company"));
                        %>
                        <tr ondblclick="ck_dbAbTlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><% out.print(list.get("title")); %></td>
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd hh:mm:ss" ></td>  
                            <td><% out.print(list.get("channel")); %></td>

                            <td>
                                <span class="ys edit" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >编辑</span>
                            | <span class="ys delete" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >删除</span> 
                            | <span class="ys view" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >查看内容</span>
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
                popuplayer.display("/website/horselight/butview.jsp?id=" + id + "&TB_iframe=true", '查看内容', {width: 1248, height: 740});
                })
            });
             $(function(){
            ﻿$(".delete").click(function(){
                let id = $(this).attr("id");
             //popuplayer.display("/supervision/zhifajiancha/delete.jsp?id=" + id + "&TB_iframe=true", '删除', {width: 300, height: 80});
             popuplayer.display("/website/horselight/delete_1.jsp?id=" + id + "&TB_iframe=true", '删除', {width: 360, height: 120});
             
            })
            });
             $(function(){
                ﻿$(".edit").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/website/horselight/edit.jsp?id=" + id + "&TB_iframe=true", '编辑', {width: 1248, height: 740});
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