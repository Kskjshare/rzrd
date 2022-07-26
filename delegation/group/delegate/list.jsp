<%@page import="RssEasy.Core.HttpRequestHelper"%>
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
            .res{float: right;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" class="res">返回上一级</button>
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">查询</button>
                <button type="button" transadapter="append" select="false" class="butadd">增加</button>
                <button type="button" transadapter="delete" class="butdelect" >删除</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th class="w30">序号</th>
                            <th>姓名</th>
                            <th>性别</th>
                            <th>手机号码</th>
                            <th>代表团</th>
                            <th>职务</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssListView list = new RssListView(pageContext, "user_group");
                            HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
                            list.request();
                            int a = 1;
                            if (!list.get("pagesize").isEmpty()) {
                                list.pagesize = Integer.valueOf(list.get("pagesize"));
                            } else {
                                list.pagesize = 30;
                            }
                            if (!list.get("curpage").isEmpty()) {
                                int cpage = 1;
                                int csixe = list.get("pagesize").isEmpty() ? 10 : Integer.valueOf(list.get("pagesize"));
                                cpage = Integer.valueOf(list.get("curpage")) - 1;
                                a = cpage * csixe + 1;
                            }
                            String sql = "1=1";
                            sql += " and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and telphone like '%" + URLDecoder.decode(list.get("telphone"), "utf-8") + "%' and groupid=" + req.get("groupid");
                            list.select().where(sql).get_page_asc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td class="w30"><% out.print(a);%></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <td sex="<% out.print(list.get("sex")); %>"></td>
                            <td><% out.print(list.get("telphone")); %></td>
                            <td><% out.print(list.get("dbtname")); %></td>
                            <td class="tdleft"><% out.print(list.get("daibiaoDWjob")); %></td>


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
            var groupid=<%req.write("groupid");%>
            var dbtid=<%req.write("dbtid");%>
        </script>
        <script src="controller.js"></script>
        <script>
            $(".res").click(function () {
                history.go(-1);
            });
        </script>
    </body>
</html>