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
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">查询</button>
                <button type="button" transadapter="butview" class="butview">详情</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>标题</th>
                            <th>主办单位</th>
                            <th>创建时间</th>
                            <th>状态</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssList list = new RssList(pageContext, "supervision_inspection");
                            RssListView user_delegation = new RssListView(pageContext, "user_delegation");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            list.select().where("typeid=" + list.get("typeid") + " and title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and state=5 and (myid=" + UserList.MyID(request) + " or organizationid =" + UserList.MyID(request) + ")").get_page_desc("id");
                            while (list.for_in_rows()) {
                                user_delegation.select("company").where("myid in (" + list.get("organizationid") + ")").get_first_rows();
                                list.keyvalue("userrolecompany", user_delegation.get("company"));
                        %>
                        <tr ondblclick="ck_dbAbTlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><% out.print(list.get("title")); %></td>
                            <td><% list.write("userrolecompany"); %></td>
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd" ></td>
                            <td supervisioninspectionstate="<% out.print(list.get("state")); %>"></td>
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
        <script>
            var typeid =<%list.write("typeid");%>
        </script>
        <script src="controller.js"></script>

    </body>
</html>