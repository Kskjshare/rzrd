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
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="append" select="false">增加</button>
                <button type="button" transadapter="edit">编辑</button>
                <button type="button" transadapter="classify">分类</button>
                <button type="button" transadapter="ico">标题图</button>
                <button type="button" transadapter="slide">展示图</button>
                <button type="button" transadapter="media">单音视频</button>
                <button type="button" transadapter="video">多视频</button>
                <button type="button" transadapter="audio">多音频</button>
                <button type="button" transadapter="delete">删除</button>
                <button type="button" transadapter="sell">出售</button>
                <button type="button" transadapter="audit">审核</button>
                <button type="button" transadapter="release">发布/停止</button>
                <button type="button" transadapter="hot">热门</button>
                <button type="button" transadapter="top">置顶</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor">
                    <thead>
                        <tr>
                            <th class="w30">选择</th>
                            <th class="w60">状态</th>
                            <th class="w80">分类</th>
                            <th>标题</th>
                            <th class="w200">图片</th>
                            <th class="w120">时间</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssList list = new RssList(pageContext, "rssframe");
                            list.request();
                            list.select().get_page_desc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr>
                            <td>
                                <input type="radio" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td artstate="<% list.write("state"); %>"></td>
                            <td rssframeclassify="<% list.write("classifyid"); %>"></td>
                            <td class="tl"><% out.print(list.get("title")); %></td>
                            <td popup="popup" href="/upfile/<% out.print(list.get("ico")); %>"><% out.print(list.get("ico")); %></td>
                            <td rssdate="<% list.write("shijian"); %>,yyyy-MM-dd HH:mm:ss"></td>
                        </tr>
                        <%
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
        <script src="/data/rssframe.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
    </body>
</html>
