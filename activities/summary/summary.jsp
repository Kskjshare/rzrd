<%-- 
    Document   : summary
    Created on : 2018-6-25, 17:56:09
    Author     : Administrator
--%>

<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    RssList entity2 = new RssList(pageContext, "activities");
    HttpRequestHelper req=new HttpRequestHelper(pageContext).request();
    String str = req.get("action");
    entity2.keyvalue(str, req.get(str));
    entity2.update().where("id=" + req.get("id")).submit();
    out.print("{\"state\":\"ok\"}");


%>