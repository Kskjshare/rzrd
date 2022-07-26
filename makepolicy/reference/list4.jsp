<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
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
            /*            #blockul{height: 100%; overflow: auto;}
                        #blockul>li{display: inline-block;width: 290px;height: 400px;background: #dce6f5;border: #eee solid thin;margin: 5px;vertical-align: top;}
                        #blockul>.sel{border: #6caddc solid thin;}
                        #blockul>li>img{margin: 5px auto;max-width: 150px;max-height: 170px;display: block;}
                        #blockul>li>h1{text-align: center;margin: 0 auto;font-size: 16px;width: 256px;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;line-height: 34px;font-weight: 600;}
                        #blockul>li>p{font-size: 14px;width: 256px;margin: 0 auto;color: #186aa3;}
                        #blockul>li>p{position: relative; line-height: 20px; max-height: 170px;overflow: hidden;display: -webkit-box;-webkit-box-orient: vertical;-webkit-line-clamp: 8;}
                        .disnone{display: none}*/
            tbody tr:hover{background-color: gainsboro;}
        </style>
    </head>
    <body>
        <!--        <div class="toolbar">
                    <button type="button" transadapter="append" select="false" class="butadd">增加</button>
                    <button type="button" transadapter="edit" class="butedit">编辑</button>
                    <button type="button" transadapter="delete" class="butdelect">删除</button>
                    <button type="button" transadapter="butview" class="butview">查看</button>
                    <input type="hidden" id="transadapter" find="[name='id']:checked" />
                </div>-->
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">查询</button>
                <button type="button" transadapter="append" select="false" class="butadd" powerid="200">增加</button>
                <!--<button type="button" transadapter="edit" class="butedit" powerid="202">编辑</button>-->
                <button type="button" transadapter="delete" class="butdelect" powerid="201">删除</button>
                <!--<button type="button" transadapter="butview" class="butview" powerid="203">查看</button>-->
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>标题</th>
                            <!--<th>发布人</th>-->
                            <th>发布时间</th>
                            <!--<th>参加时间</th>-->
                            <!--<th>附件</th>-->
                            <th>操作</th>

                        </tr>
                    </thead>
                    <tbody>
                       
                        
                         <%
                            RssList list = new RssList(pageContext, "policy_decision");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            list.select().where("category=6 and classify=5").get_page_desc("shijian");
                            while (list.for_in_rows()) {
                        %>
                        
                        
                        <tr ondblclick="ck_dbAbFlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><% out.print(list.get("title"));%></td>
                            <!--<td><% // out.print(list.get("realname"));%></td>-->
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd" ></td>
                            <!--<td rssdate="<% out.print(list.get("joinshijian")); %>,yyyy-MM-dd" ></td>-->
                            <!--<td><%out.print(list.get("enclosure"));%></td>-->
                            
                            <td>
		            <span class="ys view" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold;">查看内容</span>  
                            | <span class="ys edit" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold;">编辑</span> 
                            | <span class="ys delete" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold;">删除</span> 
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
            $("#blockul>li").click(function () {
                $(this).addClass("sel").siblings().removeClass("sel");
                $(this).find("input").prop("checked", true);
            })
                            
                            
            $(function(){
                ﻿$(".view").click(function(){
                    let id = $(this).attr("id");
                     popuplayer.display("/makepolicy/reference/butview.jsp?id=" + id + "&TB_iframe=true", '查看内容', {width: 1248, height: 740});
                })
            });
            
            $(function(){
                ﻿$(".edit").click(function(){
                    let id = $(this).attr("id");
                     popuplayer.display("/makepolicy/reference/edit.jsp?id=" + id + "&TB_iframe=true", '编辑', {width:1248, height: 740});
                })
            });
            $(function(){
                ﻿$(".delete").click(function(){
                    let id = $(this).attr("id");
                    popuplayer.display("/makepolicy/reference/delete.jsp?id=" + id + "&TB_iframe=true", '删除', {width: 300, height: 80});
                })
            });
                                      
        </script>
    </body>
</html>