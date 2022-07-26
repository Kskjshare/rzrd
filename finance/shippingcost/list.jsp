<%@page import="RssEasy.MySql.Fund.WithdrawListView"%>
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
        <style>
            .img{height:100px;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="audit">审核</button>
                <button type="button" transadapter="pay">支付</button>
                <!--<button type="button" transadapter="delete">删除</button>-->
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor">
                    <thead>
                        <tr>
                            <th class="w30">选择</th>
                            <th class="w120">申请时间</th>
                            <th class="w80">状态</th>
                            <th class="w80">账号</th>
                            <th class="w100">姓名</th>
                            <th class="w80">昵称</th>
                            <th class="w120">提现金额</th>
                            <th class="w100">提现操作人</th>
                            <th class="w120">时间</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%                            
                            WithdrawListView list = new WithdrawListView(pageContext);
                            list.request();
                            list.select().where("type=2").get_page_desc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr>
                            <td><input type="radio" name="id" value="<% list.write("id"); %>" /></td>
                            <td rssdate="<% list.write("shijian"); %>,yyyy-MM-dd HH:mm:ss"></td>
                            <td finstate="<% list.write("state"); %>"></td>
                            <td><% list.write("account"); %></td>
                            <td><% list.write("realname"); %></td>
                            <td><% list.write("nickname"); %></td>
                            <td><% list.write("fee"); %></td>
                            <td><% list.write("real"); %></td>
                            <td rssdate="<% list.write("shijian"); %>"></td>
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
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
    </body>
</html>
