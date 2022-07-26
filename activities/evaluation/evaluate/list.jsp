<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    RssListView list = new RssListView(pageContext, "evaluation_score");
    CookieHelper cookie = new CookieHelper(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    list.request();
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
            tbody tr:hover{background-color: gainsboro;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="Findsearch" select="false"  class="quicksearch">查询</button>
                <!--<button type="button" transadapter="butview" class="butview">查看</button>-->
                <!--<button type="button" transadapter="export" class="butreports">导出</button>-->
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <%
                        String usertype = "0";
                        if (cookie.Get("powergroupid").equals("5")) {
                            usertype = "1";
                        } else if (cookie.Get("powergroupid").equals("32")) {
                            usertype = "2";
                        } else if (cookie.Get("powergroupid").equals("22")) {
                            usertype = "3";
                        } else if (cookie.Get("powergroupid").equals("33")) {
                            usertype = "4";
                        }
                    %>
                    <thead>
                        <tr>
                            <th class="w40">序号</th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>姓名</th>
                            <th>考核小组</th>
                            <th>代表团</th>
                            <%if (!usertype.equals("0")) {%><th>考核状态</th><%}%>
                            <th>操作</th>
                            <!--<th>活动内容</th>-->
                        </tr>
                    </thead>
                    <tbody>
                        <%

                            if (!list.get("pagesize").isEmpty()) {
                                list.pagesize = Integer.valueOf(list.get("pagesize"));
                            } else {
                                list.pagesize = 30;
                            }
                            int a = 1;

                            //查询条件开始
                            String sql = "1=1";
                            if (req.get("batchid").equals("")) {
                                sql += " and batchstate=1";
                            } else {
                                sql += " and batchid=" + req.get("batchid");
                            }
                       
                            sql += " and realname like '%" + URLDecoder.decode(req.get("name1"), "utf-8") + "%'";
//                            sql += " and groupname like '%" + URLDecoder.decode(req.get("name2"), "utf-8") + "%'";
                            sql += " and allname like '%" + URLDecoder.decode(req.get("name3"), "utf-8") + "%'";
                            sql += " and scorestate1 like '%" + URLDecoder.decode(req.get("state1"), "utf-8") + "%'";
                            sql += " and scorestate2 like '%" + URLDecoder.decode(req.get("state2"), "utf-8") + "%'";
                            sql += " and scorestate3 like '%" + URLDecoder.decode(req.get("state3"), "utf-8") + "%'";
                            sql += " and scorestate4 like '%" + URLDecoder.decode(req.get("state4"), "utf-8") + "%'";
                            switch (usertype) {
                                case "0":
                                    sql += "";
                                    break;
                                case "2":
                                    sql += " and groupid=" + UserList.MyID(request);
                                    break;
                                case "3":
                                    sql += " and mission=" + UserList.MyID(request);
                                    break;
                                case "4":
                                    sql += "";
                                    break;
                                default:
                                    break;
                            }
                            list.select().where(sql).get_page_desc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><% list.write("realname"); %></td>
                            <td><% list.write("groupname"); %></td>
                            <td><% list.write("allname"); %></td>
                            <%if (!usertype.equals("0")) {%><td evaluationscorestate="<%list.write("scorestate" + usertype);%>"></td><%}%>
                            <td>
                                <%if ((!usertype.equals("0")&&list.get("scorestate"+usertype).equals("0"))||usertype.equals("4")) {%>
                                <a href="../score/list.jsp?scoreid=<%list.write("id");%>">考核</a>
                                <%} else {%>
                                <a href="../score/show.jsp?scoreid=<%list.write("id");%>">查看</a>
                                <%}%>
                            </td>
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
             var usertype=<%out.print(usertype);%>;
        </script>
        <script src="controller.js"></script>

    </body>
</html>