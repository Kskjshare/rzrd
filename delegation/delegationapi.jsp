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
    RssList delegation = new RssList(pageContext, "user");
    String sql = "state=2 and mission="+req.get("mission")+" and circleslist like '%"+req.get("circles")+"%'";
    if (req.get("mission").isEmpty()) {
         sql ="state=2 and circleslist like '%"+req.get("circles")+"%'";  
        }
    if (req.get("circles").isEmpty()) {
         sql ="state=2 and mission="+req.get("mission");  
        }
    if (req.get("circles").isEmpty()&&req.get("mission").isEmpty()) {
         sql ="state=2";  
        }
    delegation.query("select myid,realname,avatar from user_list where "+sql+" order by convert(realname using gbk) collate gbk_chinese_ci;");
    out.print(delegation.toKeyValue());
%>