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
            .w120{width: 178px;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
<!--                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">查询</button>-->
                <!--                <button type="button" transadapter="append" select="false" class="butadd" powerid="121">增加</button>-->
                <!--                <button type="button" transadapter="edit" class="butedit" powerid="122">编辑</button>
-->                                <button type="button" transadapter="delete" class="butdelect" powerid="123">删除</button><!--
                                <button type="button" transadapter="butview" class="butview" powerid="124">查看</button>-->
                <!--<button type="button" transadapter="transfer" class="butview">调动</button>-->
                <!--<button type="button" transadapter="butreports" class="butreports">报表</button>-->
                <!--<button type="button" transadapter="apd" select="false" class="butreports">导入</button>-->
                <!--                <button type="button" transadapter="apd" select="false" class="butreports" powerid="158">导入</button>
                                <button type="button" transadapter="export" class="butreports" powerid="125">导出</button>-->
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th class="w50">序号</th>
                            <th class="w120">标题</th>
                            <th>姓名</th>
                            <th>联系电话</th>
                            <th>反馈类型</th>
                            <th>反馈时间</th>
                            <th>反馈内容</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssListView list = new RssListView(pageContext, "feed_back");
                            list.request();
                            list.pagesize = 30;
                            int a = 1;
                            if (!list.get("curpage").isEmpty()) {
                                int cpage = 1;
                                int csixe = list.get("pagesize").isEmpty() ? 10 : Integer.valueOf(list.get("pagesize"));
                                cpage = Integer.valueOf(list.get("curpage")) - 1;
                                a = cpage * csixe + 1;
                            }
                            list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%'").get_page_asc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbtdblclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td class="w30"><% out.print(a);%></td>
                            <!--<td><%=list.get("daibiaotuanCode")%></td>-->
                            <td><% out.print(list.get("title")); %></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <td><% out.print(list.get("telphone")); %></td>
                            <td fbtype="<% out.print(list.get("classifyid")); %>"></td>
                            <td rssdate="<% list.write("shijian"); %>,yyyy-MM-dd"></td>
                            <td><% out.print(list.get("description")); %></td>
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
        <script src="../data/dictdata.js" type="text/javascript"></script>
        <script src="controller.js"></script>
        <script>
        </script>
    </body>
</html>