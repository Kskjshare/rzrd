<%-- 
    Document   : delegationapi
    Created on : 2018-8-13, 20:46:33
    Author     : Administrator
--%>

<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssList user = new RssList(pageContext, "user");
    user.delete().where("myid in ("+req.get("myid")+")").submit();
    out.print("ok");
%>