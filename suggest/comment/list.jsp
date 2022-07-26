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
                <button type="button" transadapter="append" class="butadd">增加点评</button>
                <button type="button" transadapter="butview" class="butview">查看点评</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>编号</th>
                            <th>标题</th>
                            <th>类型</th>
                            <th>领衔代表</th>
                            <th>查看数</th>
                            <th>点评数</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssListView list = new RssListView(pageContext, "sort");
                            RssList commen = new RssList(pageContext, "suggest_comment");
                            list.request();
                            int a = 1;
                            list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and reviewclass like '%" + URLDecoder.decode(list.get("reviewclass"), "utf-8") + "%' and draft=2 and lwstate=1").get_page_desc("id");
                            while (list.for_in_rows()) {
                                commen.query("SELECT COUNT(*) as num FROM suggest_comment_list WHERE suggestid=" + list.get("id"));

                        %>
                        <tr ondblclick="ck_dbAbDlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><% out.print(list.get("realid")); %></td>
                            <td><% out.print(list.get("title")); %></td>
                            <td reviewclass="<% out.print(list.get("reviewclass")); %>"></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <td>0</td>
                            <td><%
                                while (commen.for_in_rows()) {
                                    out.print(commen.get("num"));
                                }
                                %></td>
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
        </script>
    </body>
</html>