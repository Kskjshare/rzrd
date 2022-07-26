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
            .cellbor{width: 700px;}
            .cellbor span{color:#186aa3 ;cursor: default;}
            #section thead tr .w50{min-width: 50px}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">查询</button>
                <button type="button" transadapter="append" select="false" class="butadd">增加</button>
                <button type="button" transadapter="edit" class="butedit">编辑</button>
                <button type="button" transadapter="delete" class="butadd">删除</button>
                <button type="button" transadapter="json" select="false">创建JSON</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w50">序号</th>
                            <th class="w30"><input name="all" type="checkbox"></th>
                            <th class="w50">操作</th>
                            <th>届次编码</th>
                            <th>届次名称</th>
                            <th>对应年份</th>
                            <th>应用状态</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssList list = new RssList(pageContext, "session_classify");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            list.select().where("code like '%" + URLDecoder.decode(list.get("code"), "utf-8") + "%' and name like '%" + URLDecoder.decode(list.get("name"), "utf-8") + "%'").get_page_desc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr>
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><span style="font-weight:bold;" tid="<% out.print(list.get("id")); %>">编辑</span></td>
                            <td><% out.print(list.get("code")); %></td>
                            <td><% out.print(list.get("name")); %></td>
                            <td><em rssdate="<% out.print(list.get("year"));%>,yyyy-MM-dd"></em>&Tilde;<em rssdate="<% out.print(list.get("endyear"));%>,yyyy-MM-dd"></em></td>
                            <td enabled="<% out.print(list.get("state")); %>"></td>
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
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
        <script>
            $("span[tid]").click(function () {
                var tid = $(this).attr("tid")
                popuplayer.display("/setup/session/edit.jsp?relationid=" + tid + "&TB_iframe=true", '编辑', {width: 400, height: 250});
            })
        </script>
    </body>
</html>