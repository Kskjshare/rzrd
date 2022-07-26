<%@page import="RssEasy.DAL.Pagination"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
//    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
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
                <!--                <button type="button" transadapter="append" select="false">增加</button>
                                <button type="button" transadapter="edit">编辑</button>-->
                <button type="button" transadapter="delete">删除</button>
                <!--                <button type="button" transadapter="power">权限</button>
                                <button type="button" transadapter="json" select="false">创建JSON</button>-->
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <!--                            <th>操作</th>
                                                        <th>主键编号</th>-->
                            <th>日志标题</th>
                            <th>信息分类</th>
                            <th>日志内容</th>
                            <th>ip地址</th>
                            <th>操作人员</th>
                            <th>操作日期</th>
                            <th>操作结果</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssListView list = new RssListView(pageContext, "user_log");
                            list.request();
                            list.pagesize = 30;
                            list.select().get_page_desc("id");
                            int a = 1;
                            while (list.for_in_rows()) {
                        %>
                        <tr>
                            <td>
                                <% out.print(a);%>
                            </td>
                            <td  class="w30"><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <!--                            <td transadapter="view">查看</td>
                                                        <td><% out.print(list.get("code")); %></td>-->
                            <td><% out.print(list.get("logtitle")); %></td>
                            <td logclass="<% out.print(list.get("logclass")); %>"></td>
                            <td><% out.print(list.get("matter")); %></td>
                            <td><% out.print(list.get("ip")); %></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd hh:mm:ss"></td>
                            <td logstate="<% list.write("state"); %>"></td>
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
        <script src="/data/staff.js"></script>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
        <script>
            $(".cellbor tr>td").eq(2).click(function () {
                $(this).parent().find("input").attr("checked", "checked")
            })
        </script>
    </body>
</html>
