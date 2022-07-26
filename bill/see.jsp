<%-- 
    Document   : see
    Created on : 2018-5-14, 12:00:34
    Author     : Administrator
--%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Properties"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.Properties"%>
<%
    
     String meetingTime = "0";
    try {
        String propertiesFileName = this.getClass().getResource("/flowtype.properties").getPath();
        Properties properties = new Properties();
        InputStream is = new FileInputStream(propertiesFileName);
        properties.load(is);
        is.close();
        meetingTime = properties.get("meetingtime").toString();
    } catch (Exception e) {
        e.printStackTrace();
    }
    
    StaffList.IsLogin(request, response);
   
    CookieHelper cookie = new CookieHelper(request, response);
    RssListView list = new RssListView(pageContext, "sort");
    list.pagesize=10000000;
    
    //removed by ding
//    list.select().where("draft=1").get_page_desc("id");
//    RssListView list1 = new RssListView(pageContext, "sort");
//    list1.select().where("lwstate=1 and draft=2").get_page_desc("id");
//    RssListView list2 = new RssListView(pageContext, "sort");
//    list2.select().where("lwstate=2 and draft=2").get_page_desc("id");
    
//added by ding
    String suggestUrl = "";
    RssListView list1 = new RssListView(pageContext, "sort");
     //list1.pagesize=10000000;
             //list1.select().where("lwstate=1 and draft=2 and fsrID=" + cookie.Get("myid")).get_page_desc("id");
          
    if (meetingTime.equals("0")){
            list1.select().where("lwstate=1 and draft=2 and ismeet=0 and mission=" + cookie.Get("myid")).get_page_desc("id");
                suggestUrl = "lwstate=1 and draft=2 and ismeet=0 and mission=" + cookie.Get("myid");

    }
    else {
             list1.select().where("lwstate=1 and draft=2 and ismeet=1 and mission=" + cookie.Get("myid")).get_page_desc("id");
    }
   
    
    RssListView list2 = new RssListView(pageContext, "sort");
         
    if (meetingTime.equals("0")){
            list2.select().where("lwstate=2 and draft=2 and ismeet=0 and mission=" + cookie.Get("myid")).get_page_desc("id");
    }
    else {
             list2.select().where("lwstate=2 and draft=2 and ismeet=1 and mission=" + cookie.Get("myid")).get_page_desc("id");
    }
   

 RssListView list3 = new RssListView(pageContext, "sort");
 if (meetingTime.equals("0")){
            list3.select().where("lwstate=3 and draft=2 and ismeet=0 and mission=" + cookie.Get("myid")).get_page_desc("id");
    }
    else {
             list3.select().where("lwstate=3 and draft=2 and ismeet=1 and mission=" + cookie.Get("myid")).get_page_desc("id");
    }
 
  RssListView list4 = new RssListView(pageContext, "sort");
if (meetingTime.equals("0")){
            list4.select().where("lwstate=4 and draft=2 and ismeet=0 and mission=" + cookie.Get("myid")).get_page_desc("id");
    }
    else {
             list4.select().where("lwstate=4 and draft=2 and ismeet=1 and mission=" + cookie.Get("myid")).get_page_desc("id");
    }
 
 
  RssListView list5 = new RssListView(pageContext, "sort");
if (meetingTime.equals("0")){
            list5.select().where("lwstate=5 and draft=2 and ismeet=0 and mission=" + cookie.Get("myid")).get_page_desc("id");
    }
    else {
             list5.select().where("lwstate=5 and draft=2 and ismeet=1 and mission=" + cookie.Get("myid")).get_page_desc("id");
    }
 
//end
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <style>
            .tabheader{  font-size:20px;background: #82bee9;text-align: center; color: #fff;line-height: 30px}
            .cellbor>tbody>tr>td,.cellbor>tbody>tr>th{border: #6caddc solid thin;line-height: 20px;}
            .dce{background: #dce6f5;}
            .indent{text-indent: 10px}
            .red3{color:#c03e20}
        </style>
    </head>
    <body>
        <div>
            <table class="cellbor auto margintop">
                <tr>
                    <td colspan="5" class="tabheader">提交情况</td>
                </tr>
                <tr class="dce">
                    <th class="w100">项目</th>
                    <th colspan="2">说明</th>
                    <th class="w100">数目</th>
                    <th class="w100">操作</th>
                </tr>
                <!--
                <tr align="center">
                    <td>未提交</td>
                    <td align="left" colspan="2" class="indent">提出者尚未正式提交的议案建议</td>
                    <td><% out.print(list.totalrows); %></td>
                    <td><a href="list.jsp?draft=1" >查看</a></td>
                </tr>
                -->
                <tr align="center">
                    <td  style="font-size:18px;" rowspan="5">已提交</td>
                    <td class="w80">建议</td>
                    <td align="left" class="w300 indent">提出者已经正式提交的建议</td>
                    <td class="red3"><% out.print(list1.totalrows); %></td>
                    <td style="font-weight:bold;" ><a href=<%out.print("list_1.jsp?lwstate=1&draft=2");%>>查看</a></td>
                </tr>
                <tr align="center">
                    <td class="w80" colspan="1" >议案</td>
                    <td align="left" class="w300 indent">提出者已经正式提交的议案</td>
                    <td class="red3"><% out.print(list2.totalrows);%></td>
                    <td style="font-weight:bold;"><a href="list_2.jsp?lwstate=2&draft=2">查看</a></td>
                </tr>
                
               <tr align="center">
                    <td class="w80" colspan="1" >批评</td>
                    <td align="left" class="w300 indent">提出者已经正式提交的批评</td>
                    <td class="red3"><% out.print(list3.totalrows);%></td>
                    <td style="font-weight:bold;"><a href="list_3.jsp?lwstate=3&draft=2">查看</a></td>
                </tr>
                  <tr align="center">
                    <td class="w80" colspan="1" >意见</td>
                    <td align="left" class="w300 indent">提出者已经正式提交的意见</td>
                    <td class="red3"><% out.print(list4.totalrows);%></td>
                    <td style="font-weight:bold;"><a href="list_4.jsp?lwstate=4&draft=2">查看</a></td>
                </tr>
                 <tr align="center">
                    <td class="w80" colspan="1" >质询</td>
                    <td align="left" class="w300 indent">提出者已经正式提交的质询</td>
                    <td class="red3"><% out.print(list5.totalrows);%></td>
                    <td style="font-weight:bold;"><a href="list_5.jsp?lwstate=5&draft=2">查看</a></td>
                        
                </tr>
                
                
                
                <tr class="dce">
                    <td colspan="5"><button style="visibility: hidden;" class="submission" type="button" transadapter="append" select="false">提交议案建议</button></td>
                </tr>
            </table>
        </div>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
        <script>
        </script>
    </body>
</html>
