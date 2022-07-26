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
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <!--<button type="button" transadapter="quicksearch" select="false" class="quicksearch">查询</button>-->
                <!--<button type="button" transadapter="append" select="false" class="butadd">增加</button>-->
                <button type="button" transadapter="edit" class="butedit">编辑</button>
                <!--<button type="button" transadapter="delete" class="butdelect">删除</button>-->
                <button type="button" transadapter="butview" class="butview">查看</button>
                <button type="button" transadapter="json" select="false">创建JSON</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>编码</th>
                            <th>名称</th>
                            <th>基础分</th>
                            <th>最高分</th>
                            <th>考勤加分</th>
                            <th>最低分</th>
                            <th>缺勤扣分</th>
                            <!--<th>请假扣分</th>-->
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssList list = new RssList(pageContext, "activitiestype_classify");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            list.select().get_page_asc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr>
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><% out.print(list.get("code")); %></td>
                            <td><% out.print(list.get("name")); %></td>
                            <td><% out.print(list.get("basescore")); %></td>
                            <td><% out.print(list.get("maxscore")); %></td>
                            <td><% out.print(list.get("speakscore")); %></td>
                            <td><% out.print(list.get("minscore")); %></td>
                            <td>-<% out.print(list.get("absence")); %></td>
                            <!--<td>-<% out.print(list.get("leavescore")); %></td>-->
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
        <script src="/data/activitiestype.js" type="text/javascript"></script>
        <script>
        </script>
    </body>
</html>