<%-- 
    Document   : searchllz
    Created on : 2018-7-20, 17:52:38
    Author     : Administrator
--%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    //梁小竹修改
    RssListView entity = new RssListView(pageContext, "contactstation_sub");
//    RssList entity = new RssList(pageContext, "contactstation");
//    String a = req.get("search");
//    System.out.println(a+"+++++++++++++++++++++++++++++++++++++++++++++++++++++");
//   if (entity.select().where("name = '"+URLDecoder.decode(req.get("search"), "utf-8")+"'").get_first_rows()) {
   if (entity.select().where("title = '"+req.get("search")+"' or name = '" + req.get("search")+"'").get_first_rows()) {
        out.print(entity.get("stationid"));
       }else{
        out.print("no");
   }
 
%>
