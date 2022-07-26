<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="javax.servlet.jsp.JspWriter"%>
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
                <button type="button" transadapter="edit">编辑用户</button>
                <button type="button" transadapter="repwd">重置密码</button>
                <button type="button" transadapter="delete">删除</button>
                <input type="hidden" id="transadapter" find="[name='myid']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor">
                    <thead>
                        <tr>
                            <th class="w30">选择</th>
                            <th class="w100">帐号</th>
                            <th class="w80">姓名</th>
                            <th>头像</th>
                            <th>账户类型</th>
                            <!--<th>等级</th>-->
                            <th class="w80">账户余额</th>
                            <th class="w120">注册时间</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            UserList list = new UserList(pageContext);
                            list.request();
                            list.select("myid,account,realname,avatar,nickname,sex,shijian,recharge,withdraw,frozencapital,classifyid,balance").get_page_desc("myid");
                            while (list.for_in_rows()) {
                        %>
                        <tr>
                            <td><input type="radio" name="myid" value="<%list.write("myid");%>"></td>
                            <td><% list.write("account"); %></td>
                            <td><% list.write("realname"); %></td>
                            <td popup="popup" href="/upfile/<% list.write("avatar"); %>"><% list.write("avatar"); %></td>
                            <td classifyid="<% list.write("classifyid"); %>"></td>
                            <td><% list.write("balance"); %></td>
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
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
    </body>
</html>
