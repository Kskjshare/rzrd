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
                <!--<button type="button" transadapter="append" select="false" class="butadd" powerid="176">增加</button>-->
                <!--<button type="button" transadapter="edit" class="butedit" powerid="177">编辑</button>-->
                <button type="button" transadapter="delete" class="butdelect" powerid="178">删除</button>
                <!--<button type="button" transadapter="butview" class="butview" powerid="179">查看</button>-->
                <!--<button type="button" transadapter="butviewstate" class="butview" powerid="180">已读情况</button>-->
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>主题</th>
                            <th>地点</th>
                            <!--<th>类型</th>-->
                            <th>组织单位</th>
                            <th>类型</th>
                            <th>结果评定</th>
                            <th>操作</th>
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
                              
                        %>
                        <tr ondblclick="ck_dbcclclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td infotype="<% out.print(list.get("topic")); %>"></td>
                            <td><% out.print(list.get("place")); %></td>
                            <!--<td infotype="<% // out.print(list.get("infotype")); %>"></td>-->
                            <td><% out.print(list.get("organization")); %></td>
                            <td><% out.print(list.get("type")); %></td>
                            <!--<td rssdate="<% out.print(list.get("organization")); %>,yyyy-MM-dd" ></td>-->
                           
                                   <% 
                                    String handle = "";
                                    if (list.get("zhuangtai").equals("")) {
                                        handle = "<td class='handle no' style='color:#00cc33'>未审查</td>";
                                       
                                    }
                                    if (list.get("zhuangtai").equals("1")) {
                                        handle = "<td class='handle no' style='color:#cc0000'>满意</td>";
                                      
                                    }
                                    if (list.get("zhuangtai").equals("2")) {
                                        handle = "<td class='handle no'style='color:#EE7942' >比较满意</td>";
                                    }
                                    if (list.get("zhuangtai").equals("3")) {
                                        handle = "<td class='handle no' style='color:#999900'>不满意</td>";
                                    }
                                   
                                    out.print(handle);
                                %>
                                 
                                <td><span class="ys chakan" id="<% out.print(list.get("id")); %>" style="color:blue; cursor: pointer;font-weight:bold;">查看内容</span> </td>
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
                    popuplayer.display("./newinformation/chakan.jsp?id=" + id + "&TB_iframe=true", '查看内容', {width: 830, height: 500});
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
    popuplayer.display("/newinformation/delete_1.jsp?id=" + rid + "&TB_iframe=true", '删除', {width: 300, height: 80});
}
        </script>
    </body>
</html>