<%@page import="RssEasy.Core.ValidateCode"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    ValidateCode code=new ValidateCode("adminlogin", 6, response);
    code.Number();
    
%>