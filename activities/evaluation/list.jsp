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
    RssList list = new RssList(pageContext, "evaluation_batch");
    RssList scores = new RssList(pageContext, "evaluation_score");
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
                <button type="button" transadapter="append" select="false" class="butadd">添加</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th>序号</th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>名称</th>
                            <th>考核人数</th>
                            <th>状态</th>
                            <th>开始时间</th>
                            <th>结束时间</th>
                            <th>操作</th>
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
                            String sql = "1=1";
                            sql += " and title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%'";
                            list.select().where(sql).get_page_desc("id");
                            while (list.for_in_rows()) {
                                scores.select("count(*) as num").where("batchid=" + list.get("id")).get_first_rows();
                        %>
                        <tr idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><% out.print(list.get("title")); %></td>

                            <td><% scores.write("num"); %>人</td>
                            <td evaluationstate="<%list.write("state");%>"></td>
                            <td rssdate="<% out.print(list.get("beginshijian")); %>,yyyy-MM-dd HH:mm:ss" ></td>
                            <td rssdate="<% out.print(list.get("finishshijian")); %>,yyyy-MM-dd HH:mm:ss" ></td>
                            <td>
                                <%
                                    String html = "";
                                    if (list.get("state").equals("0")) {
                                        html += "<a style='text-decoration: none;' href='javascript:start(\"" + list.get("id") + "\")'>手动开始</a>&nbsp;&nbsp;|&nbsp;&nbsp;";
                                    }else if (list.get("state").equals("1")) {
                                        html += "<a style='text-decoration: none;' href='javascript:close(\"" + list.get("id") + "\")'>手动结束</a>&nbsp;&nbsp;|&nbsp;&nbsp;";
                                    } else {
                                        html+="";
                                    }
//                                    html += "&nbsp;|&nbsp;<a style=' text-decoration: none;' href='javascript:flowStepRecord(\"" + list.get("id") + "\");'>日志</a>";
                                    out.print(html);
                                %>
                                <a style="font-weight: bold;" href="score_list.jsp?batchid=<%list.write("id");%>">查看考核情况</a>
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
        </script>
        <script src="controller.js"></script>
        <script>
            function start(id) {
                popuplayer.display("/activities/evaluation/start.jsp?id=" + id + "&TB_iframe=true", '手动开始', {width: 300, height: 100});
            }
            function close(id) {
                popuplayer.display("/activities/evaluation/close.jsp?id=" + id + "&TB_iframe=true", '手动结束', {width: 300, height: 100});
            }
        </script>
    </body>
</html>