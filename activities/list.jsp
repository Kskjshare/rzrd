<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.Core.CookieHelper"%>
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
            /*.cellbor tbody>.sel>td{background: #dce6f5}*/
            /*             .cellbor thead,.w30{background:#f0f0f0 }
                       .cellbor tbody tr>td:first-child{display: none}
                       .cellbor td, .cellbor th { border: solid 1px #cbcbcb; padding: 8px 2px; }*/
            tbody tr:hover{background-color: gainsboro;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">查询</button>
                <button type="button" transadapter="edit" class="butadd">手动考勤</button>
                <!--
                <button type="button" transadapter="edit" class="butedit">编辑</button>
                <button type="button" transadapter="delete" class="butdelect" powerid="199">删除</button>
                -->
                <button type="button" transadapter="butview" class="butview">查看</button>
                <!--<button type="button" transadapter="export" class="butreports">导出</button>-->
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w50">序号</th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>活动主题</th>
                            <th>活动类型</th>
                            <th>组织部门</th>
                             <th>发起日期</th>
                            <th>报名截止日</th>
                            <th>开始时间</th>
                             <th>结束时间</th>
                            <th>活动地点</th>
                            <!--
                            <th>召集人</th>
                            -->
                           
                            <th>操作</th>
                            <!--<th>活动内容</th>-->
                        </tr>
                    </thead>
                    <tbody>
                        <%                            CookieHelper cookie = new CookieHelper(request, response);
                            RssListView list = new RssListView(pageContext, "activities");
                            list.request();
                            list.pagesize = 30;
                            if (!list.get("pagesize").isEmpty()) {
                                list.pagesize = Integer.valueOf(list.get("pagesize"));
                            } else {
                                list.pagesize = 10;
                            }
                            int a = 1;
//                            list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and name like '%" + URLDecoder.decode(list.get("name"), "utf-8") + "%' and department like '%" + URLDecoder.decode(list.get("department"), "utf-8") + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and finishshijian>=" + System.currentTimeMillis() / 1000 + " and beginshijian<=" + System.currentTimeMillis() / 1000).get_page_desc("id");
                            if (cookie.Get("powergroupid").equals("8") || cookie.Get("powergroupid").equals("16")) {
                                list = new RssListView(pageContext, "activitiesmy");
                                list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and name like '%" + URLDecoder.decode(list.get("name"), "utf-8") + "%' and department like '%" + URLDecoder.decode(list.get("department"), "utf-8") + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and finishshijian>=" + System.currentTimeMillis() / 1000 + " and beginshijian<=" + System.currentTimeMillis() / 1000).get_page_desc("id");
                            } else if (cookie.Get("powergroupid").equals("22")) {
                                list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and name like '%" + URLDecoder.decode(list.get("name"), "utf-8") + "%' and department like '%" + URLDecoder.decode(list.get("department"), "utf-8") + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and mission =" + UserList.MyID(request) + " and finishshijian>=" + System.currentTimeMillis() / 1000 + " and beginshijian<=" + System.currentTimeMillis() / 1000).get_page_desc("id");
                            } else {
                                list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and name like '%" + URLDecoder.decode(list.get("name"), "utf-8") + "%' and department like '%" + URLDecoder.decode(list.get("department"), "utf-8") + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and userid="+UserList.MyID(request)+" and finishshijian>=" + System.currentTimeMillis() / 1000 + " and beginshijian<=" + System.currentTimeMillis() / 1000).get_page_desc("id");

                            }

                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbcilclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><% out.print(list.get("title")); %></td>
                            <td><% out.print(list.get("name")); %></td>
                            <td><% out.print(list.get("department")); %></td>
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd" ></td>
                            <td rssdate="<% out.print(list.get("endshijian")); %>,yyyy-MM-dd" ></td>
                            <td rssdate="<% out.print(list.get("beginshijian")); %>,yyyy-MM-dd" ></td>
                            <td rssdate="<% out.print(list.get("finishshijian")); %>,yyyy-MM-dd" ></td>
                            <td><% out.print(list.get("place")); %></td>
                            
                            <td>                                              
                            <span class="ys chakan" id="<% out.print(list.get("id")); %>" style="color:blue">查看内容</span> |                    
                            <span class="ys kaoqin" id="<% out.print(list.get("id")); %>" style="color:blue">考勤</span> |
                            </td>
                            <!--
                            <%
                                if ((cookie.Get("powergroupid").equals("8") || cookie.Get("powergroupid").equals("16"))) {
                            %>
                            <td><% out.print(list.get("realname")); %></td>
                            <%
                            } else {
                            %>
                            <td><% out.print(list.get("myname")); %></td>
                            <%
                                }
                            %>
                            -->
                           
                            <!--<td><% out.print(list.get("note")); %></td>-->
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
    </body>
</html>