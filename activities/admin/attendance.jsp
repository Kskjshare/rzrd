<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    CookieHelper cookie = new CookieHelper(request, response);
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
                            <th>打卡人</th>
                            <th>考勤时间</th>
                            <th>状态</th>
                            <%
                            if (cookie.Get("powergroupid").equals("7")) {
                            %>
                            <th>操作</th>
                            <%
                            }
                            %>
                          
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssListView list = new RssListView(pageContext, "activities_userlist");
                            list.request();
                            if (!list.get("pagesize").isEmpty()) {
                            list.pagesize = Integer.valueOf(list.get("pagesize"));       
                                }else{
                            list.pagesize =10;
                            }
                            int a = 1;
                            list.select().where("activitiesid="+list.get("id")+" and attendancetype=2").get_page_desc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr>
                            <td><% out.print(a);%></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <td  rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd hh:mm:ss" ></td>
                          
                     <%
                            if(list.get("attendancetype").equals("1")){
                            %>
                              <td>未打卡</td>
                            <%
                            }else{
                            %>
                            
                            <td>已打卡</td>
                            <%
                            }
                            %>
                            
                            
                             <%
                            if(list.get("auditState").equals("1")){
                            %>
                              <td>未审核</td>
                            <%
                            }else{
                            %>
                            
                            <td>已审核</td>
                            <%
                            }
                            %>
                            
                            
                            
                           <%
                            if (cookie.Get("powergroupid").equals("7")) {
                            %>
                            <td> 
                              <span class="ys view" id="<% out.print(list.get("id")); %>" style="color:blue">审核通过</span> 
                              | <span class="ys view" id="<% out.print(list.get("id")); %>" style="color:blue">审核不通过</span>
                            </td>
                            <%
                            }
                            %>
                           
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
    </body>
</html>
