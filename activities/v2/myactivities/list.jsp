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
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">查询</button>
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th>编号</th>
                            <th>标题</th>
                            <th>履职类型</th>
                            <th>发布时间</th>
                            <th>开始时间</th>
                            <th>结束时间</th>
                            <th>状态</th>
                            <th>关闭原因</th>
                            <th>是否签到</th>
                            <th>操作</th>

                            <!--<th>活动内容</th>-->
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            CookieHelper cookie = new CookieHelper(request, response);
                            RssListView list = new RssListView(pageContext, "activities_userlist");
                            HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
                            list.request();
                            if (!list.get("pagesize").isEmpty()) {
                                list.pagesize = Integer.valueOf(list.get("pagesize"));
                            } else {
                                list.pagesize = 30;
                            }
                            int a = 1;
                            String sql = "title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and name like '%" + URLDecoder.decode(list.get("name"), "utf-8") + "%' and department like '%" + URLDecoder.decode(list.get("department"), "utf-8") + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and userid =" + UserList.MyID(request);
                            if (req.get("classifytype").equals("2")) {
                                sql += " and classify=7";
                            } else if (req.get("classifytype").equals("1")) {
                                sql += " and classify<>7";
                            }
                            list.select().where(sql).get_page_desc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbcflclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><% out.print(list.get("realid")); %></td>
                            <td><% list.write("title"); %></td>
                            <td activitiestypeclassify="<%list.write("classify");%>"></td>
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd" ></td>
                            <td rssdate="<% out.print(list.get("beginshijian")); %>,yyyy-MM-dd" ></td>
                            <td rssdate="<% out.print(list.get("finishshijian")); %>,yyyy-MM-dd" ></td>
                            <td activitiesstate="<%list.write("state");%>"></td>
                            <td><% out.print(list.get("closenote")); %></td>
                            <td activitiesattendancetype="<% out.print(list.get("attendancetype"));%>"> </td>
                            <td>
                                <%
                                    String html = "";
                                    if (list.get("state").equals("1")) {//1为开启状态，2为关闭状态
                                        if (list.get("attendancetype").equals("2")) {//2为已签到，1为未签到
                                            html += "<a style=' text-decoration: none; color:#B0B0B0;' href='javascript:void(0);'>已签到</a>";
                                            html += "&nbsp;&nbsp;|&nbsp;&nbsp;<a style=' text-decoration: none;' href='javascript:addXdth(" + list.get("id") + ",\"" + list.get("title") + "\")'>心得</a> ";
                                            html += "&nbsp;&nbsp;|&nbsp;&nbsp;<a style=' text-decoration: none;' href='javascript:seeXdth(" + list.get("id") + ")'>查看心得</a> ";

                                        } else {
                                            html += "<a style='text-decoration:none;' href='javascript:addLzhd(" + list.get("activitiesid") + "," + list.get("beginshijian") + "," + list.get("finishshijian") + "," + list.get("id") + " )' >签到</a>";
                                            html += " &nbsp;&nbsp;|&nbsp;&nbsp;<a style=' text-decoration: none;' href='javascript:qdts()'>心得</a> ";
                                            html += " &nbsp;&nbsp;|&nbsp;&nbsp;<a style=' text-decoration: none;' href='javascript:qdts()'>查看心得</a> ";
                                        }

                                    } else {
                                        html += "<a style=' text-decoration: none; color:#B0B0B0;' href='javascript:void(0);'>签到</a>";
                                        html += " &nbsp;&nbsp;|&nbsp;&nbsp;<a style=' text-decoration: none;' href='javascript:gbts()'>心得</a> ";
                                        html += " &nbsp;&nbsp;|&nbsp;&nbsp;<a style=' text-decoration: none;' href='javascript:gbts()'>查看心得</a> ";
                                    }
                                    out.print(html);
                                %>
<!--                                <a style=" text-decoration: none;" href="javascript:addLzhd(<%list.write("activitiesid");%>,<%list.write("beginshijian");%>,<%list.write("finishshijian");%>,<%list.write("id");%>)">签到</a>
                                &nbsp;&nbsp;|&nbsp;&nbsp;<a style=" text-decoration: none;" href="javascript:addXdth(<%list.write("id");%>,'<%list.write("title");%>')">心得</a>
                                &nbsp;&nbsp;|&nbsp;&nbsp;<a style=" text-decoration: none;" href="javascript:qdts()">心得</a>-->
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
        <script src="controller.js"></script>
        <script>
                            //签到
                            function addLzhd(id, starttime, endtime, lzid) {
                                var myDate = new Date();
                                var startsj = new Date(starttime + ' 00:00:00');
                                var endsj = new Date(endtime + ' 23:59:59');
                                if (myDate < startsj) {
//                                    alert('提示', "还未到签到时间，不能签到", 'info');
                                    alert("还未到签到时间，不能签到");
                                    return;
                                }
                                if (myDate > endsj) {
//                                    alert('提示', "超过截止签到时间，不能签到", 'info');
                                    alert("超过截止签到时间，不能签到");
                                    return;
                                }
                                popuplayer.display("/activities/v2/myactivities/attendance.jsp?id=" + lzid + "&TB_iframe=true", '签到', {width: 300, height: 100});
                            }

                            //心得体会
                            function addXdth(lzid, title) {
                                popuplayer.display("/activities/v2/myactivities/matter.jsp?id=" + lzid + "&title=" + title + "&TB_iframe=true", '履职心得', {width: 600, height: 330});

                            }
                            //查看履职心得
                            function seeXdth(lzid) {
                                popuplayer.display("/activities/v2/myactivities/seematter.jsp?id=" + lzid + "&TB_iframe=true", '履职心得', {width: 600, height: 330});
                            }
                            //签到提示
                            function qdts() {
                                popuplayer.showError("请先签到!");
                            }
                            //关闭提示
                            function gbts() {
                                popuplayer.showError("已关闭!");
                            }
        </script>
    </body>
</html>