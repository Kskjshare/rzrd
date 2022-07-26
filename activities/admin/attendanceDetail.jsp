<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%
    StaffList.IsLogin(request, response);
    CookieHelper cookie = new CookieHelper(request, response);
    
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssList userlist = new RssList(pageContext, "activities_userlist");
    //userlist.select().where("activitiesid="+req.get("id")+ " and userid=" + UserList.MyID(request)).get_first_rows();
    userlist.select().where("activitiesid="+ req.get("id")).get_first_rows();
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
                            <th>考勤人</th>
                            <%
                            if ( userlist.get("attendancetype").equals("2") ) {
                            %>
                            <th>考勤时间</th>
                            <%
                            }
                            %>
                           
                            
                            <th>考勤状态</th>
                            
                             <%
                            if ( userlist.get("auditState").equals("2") || userlist.get("auditState").equals("3") ) {
                            %>
                            <th>审核时间</th>
                            <%
                            }
                            %>
                            
                            <th>审核状态</th>
                            
                             <%
                            if (cookie.Get("powergroupid").equals("5")) {
                            %>
                            
                            <%
                            }else{
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
                            //list.select().where("activitiesid="+list.get("id")+" and attendancetype=2").get_page_desc("id");
                            if (cookie.Get("powergroupid").equals("5")) {
//                              list.select().where("activitiesid="+  req.get("id") + " and jointype=2" ).get_page_desc("id"); 
                             
                               list.select().where("activitiesid="+ req.get("id") + " and userid=" + UserList.MyID(request)).get_page_desc("id");
                            }
                            else {
                                list.select().where("activitiesid="+  req.get("id") ).get_page_desc("id");   
                            }
                            
                            
                            while (list.for_in_rows()) {
                        %>
                        <tr>
                            <td><% out.print(a);%></td>
                            <td><% out.print(list.get("realname")); %></td>
                            
                             <%
                            if( userlist.get("attendancetype").equals("2")  ){
                            %>
                            <td  
                               
                                rssdate="<% out.print(list.get("attshijian")); %>,yyyy-MM-dd hh:mm:ss" >       
                                
                            </td>
                             <%
                             }
                             %>
                          
                            <%
                            if(list.get("attendancetype").equals("1")){
                            %>
                              <td style="color:#999900">未考勤</td>
                            <%
                            }else{
                            %>
                            
                            <td style="color:#00cc33">已考勤</td>
                            <%
                            }
                            %>
                            
                            <%
                            if(userlist.get("auditState").equals("2") || userlist.get("auditState").equals("3") ){
                            %>
                            <td      
                               rssdate="<% out.print(list.get("auditshijian")); %>,yyyy-MM-dd hh:mm:ss" >   
                            </td>
                            <%
                            }
                            %>
                            
                             <%
                            if( list.get("auditState").equals("2") ){
                            %>
                            <td style="color:#00cc33">已审核</td>
                            <%
                            }
                            else if (list.get("auditState").equals("3") ){
                            %>
                            <td style="color:#cc0033">审核未通过</td>
                            <%
                            }else{
                            %>
                            
                            <td style="color:#999900">未审核</td>
                            <%
                            }
                            %>
                            
                            
                            
                            <%
                            if (cookie.Get("powergroupid").equals("5")) {
                            %>
                            
                            <%
                            }else{
                            %>
                            <td> 
                              <%
                              if( list.get("auditState").equals("2") ){
                              %>
                              <span class="ys unapproved" id="<% out.print(list.get("activitiesid")); %>" >审核</span>  
                              
                              <%
                              }else {
                              %>
                              <span class="ys approved" userid="<% out.print(list.get("userid")); %>" id="<% out.print(list.get("activitiesid")); %>" style="color:blue;cursor:pointer;font-weight: bold;">审核</span>  
                              <%
                              }
                              %>
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
        
         <script>
         $(function(){
                ﻿$(".approved").click(function(){
                    let id = $(this).attr("id");
                    let userid = $(this).attr("userid");
                    
//                    alert("审核通过")
                     popuplayer.display("/activities/admin/attendanceAudit.jsp?id=" + id + "&userid="+ userid, '考勤审核', {width: 520, height: 400});
//                    RssList entity2 = new RssList(pageContext, "activities");
//                    RssList user = new RssList(pageContext, "activities_userlist");
//                    RssList user2 = new RssList(pageContext, "activities_userlist");
//                    RssListView entity = new RssListView(pageContext, "activities");
//                    entity.request();
//                    entity2.request();
//                    
//                    String str = entity2.get("userid");
//                    user.keyvalue("auditState", "2");
//          
//            
//            
//                    long systemTime = System.currentTimeMillis()/1000;   
//                    user.keyvalue("auditshijian", systemTime);
//                    user.update().where("activitiesid=" + entity.get("id") + " and userid="+ UserList.MyID(request)  ).submit();
                    
                })
            });
            
             $(function(){
                ﻿$(".unapproved").click(function(){
                    //alert("审核不通过")
                })
            });
           
           
           
      
           
            </script>
        
    </body>
</html>
