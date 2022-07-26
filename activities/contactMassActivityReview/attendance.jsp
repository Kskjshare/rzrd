<%@page import="RssEasy.MySql.User.UserList"%>
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
        </style>
    </head>
    <body> 
        <!--        <div class="toolbar">
                        <button type="button" transadapter="quicksearch" select="false" class="butview">导出</button>
                </div>-->
        <div class="bodywrap">
            <table class="wp100 tc cellbor" id="section">
                <thead>
                    <tr>
                        <th>序号</th>
                        <th>签到人员</th>
                        <th>是否签到</th>
                        <th>签到时间</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        RssListView list = new RssListView(pageContext, "activities_userlist");
                        list.request();
                        if (!list.get("pagesize").isEmpty()) {
                            list.pagesize = Integer.valueOf(list.get("pagesize"));
                        } else {
                            list.pagesize = 10;
                        }
                        int a = 1;
                        list.select().where("activitiesid=" + list.get("id") + "").get_page_desc("id");
                        while (list.for_in_rows()) {
                    %>
                    <tr>
                        <td><% out.print(a);%></td>
                        <td><% out.print(list.get("realname")); %></td>
                        <td activitiesattendancetype="<%list.write("attendancetype");%>"></td>
                        <td rssdate="<% out.print(list.get("attshijian")); %>,yyyy-MM-dd hh:mm:ss" ></td>
                        <td>
                            <%
                                if (list.get("attendancetype").equals("1")) {
                            %>
                            <a style="text-decoration: none; color:#B0B0B0;" href="javascript:void(0);" >心得</a>
                            <%} else {%>
                            <a style="text-decoration: none;" href="javascript:seeXdth(<%list.write("id");%>)">心得</a>
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

        <!--<script src="/data/suggest.js" type="text/javascript"></script>-->
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
        <script>
            //查看履职心得
            function seeXdth(lzid) {
//                console.log(lzid)
                RssWin.open("/activities/v2/myactivities/seematter.jsp?id=" + lzid + "&TB_iframe=true", 600, 330);
            }
        </script>
    </body>
</html>
