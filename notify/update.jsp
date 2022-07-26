<%@page contentType="text/html" pageEncoding="UTF-8"%><%
    out.print(Integer.parseInt(request.getParameter("version").replace(".", "")) < 100 ? "http://sys.cailai.itemjia.com/notify/app.apk" : "0");
%>