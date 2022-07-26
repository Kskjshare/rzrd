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
            tbody tr:hover{background-color: gainsboro;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">查询</button>
                <button type="button" transadapter="butview" class="butview">查看</button>
                <!--<button type="button" transadapter="butreports" class="butreports">报表</button>-->
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30">序号</th>
                            <!--
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th class="w60">编号</th>
                            -->
                            <th class="w60">单位名称</th>
                            <th class="w60">单位类别</th>
                            <th class="w60">单位地址</th>
                            <!--
                            <th class="w60">单位邮编</th>
                            -->
                            <th class="w60">联系人</th>
                            <th class="w60">联系电话</th>
                            <!--<th class="w60">归口系统</th>
                            <th class="w60">单位排序</th>
                            -->
                            <th class="w60">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssListView list = new RssListView(pageContext, "userrole");
                            list.request();
                            int a = 1 ;
                            list.pagesize = 30;
                            list.select().where("code like '%"+list.get("code")+"%' and comtype like '%"+list.get("comtype")+"%' and allname like '%"+list.get("allname")+"%' and person like '%"+list.get("person")+"%' and returnxt like '%"+list.get("returnxt")+"%' and companysort like '%"+list.get("companysort")+"%' and sessionid like '%"+list.get("sessionid")+"%' and state like '%3%'").get_page_desc("myid");
//                            list.select().where("id like '%"+list.get("id")+"%'").get_page_desc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbAbalclick();" idd="<% out.print(list.get("myid")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <!--
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("myid")); %>" /></td>
                            <td><% out.print(list.get("code")); %></td>
                            -->
                            <td><% out.print(list.get("allname")); %></td>
                            <td companytypeclassify="<% out.print(list.get("comtype")); %>"></td>
                            <td><% out.print(list.get("workaddress")); %></td>
                            <!--
                            <td><% out.print(list.get("postcode")); %></td>
                            -->
                            <td><% out.print(list.get("linkman")); %></td>
                            <td><% out.print(list.get("telphone")); %></td>
                            <!--<td returnxt="<% out.print(list.get("returnxt")); %>"></td>
                            <td><% out.print(list.get("companysort")); %></td>
                            -->
                            <td style="color:blue">                        		                         
                            <span class="ys chakan" id="<% out.print(list.get("id")); %>">查看内容</span> 
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
        <script src="/data/session.js"></script>
        <script src="/data/companytype.js" type="text/javascript"></script>
        <script>
             $(function(){
                ﻿$(".chakan").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/company/butview.jsp?id=" + id , '查看内容', {width: 830, height: 560});
                })
            });  
        </script>
    </body>
</html>