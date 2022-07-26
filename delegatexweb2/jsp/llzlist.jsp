<%-- 
    Document   : searchllz
    Created on : 2018-7-20, 17:52:38
    Author     : Administrator
--%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssListView list = new RssListView(pageContext, "contactstation");
    list.select().query();
%>
