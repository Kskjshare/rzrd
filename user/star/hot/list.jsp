<%@page import="Model.User.UserHotListView"%>
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
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="edit">编辑</button>
                <button type="button" transadapter="delete">删除</button>
                <input type="hidden" id="transadapter" find="[name='myid']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor">
                    <thead>
                        <tr>
                            <th class="w30">选择</th>
                            <th>代码</th>
                            <th>姓名</th>
                            <th>类别</th>
                            <th>性别</th>
                            <th>流通时间</th>
                            <th>剩余时间</th>
                            <th>发行价</th>
                            <th>身价</th>
                            <th>最高价</th>
                            <th>最低价</th>
                            <th>成交量</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            UserHotListView list = new UserHotListView(pageContext);
                            list.request();
                            list.select().get_page_desc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr>
                            <td>
                                <input type="radio" name="myid" value="<% out.print(list.get("myid")); %>" /></td>
                            <td><% list.write("code"); %></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <td userclassify="<% out.print(list.get("classifyid")); %>"></td>
                            <td sex="<% out.print(list.get("sex")); %>"></td>
                            <td><% out.print(list.get("liutongshijian")); %></td>
                            <td><% out.print(list.get("shengyushijian")); %></td>
                            <td><% out.print(list.get("faxingjia")); %></td>
                            <td><% out.print(list.get("shenjia")); %></td>
                            <td><% out.print(list.get("zuigaojia")); %></td>
                            <td><% out.print(list.get("zuidijia")); %></td>
                            <td><% out.print(list.get("chengjiaoliang")); %></td>
                            <td><a href="/user/news/list.jsp?myid=<% out.print(list.get("myid")); %>">新闻</a> | <a href="/user/notice/list.jsp?myid=<% out.print(list.get("myid")); %>">公告</a></td>
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
        <script src="/data/user.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
    </body>
</html>
