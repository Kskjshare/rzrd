<%-- 
    Document   : lxdtest
    Created on : 2020-3-6, 12:17:15
    Author     : jackie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <button type="button" class="setup"><% out.print("myid:"+UserList.MyID(request)+"mission："+list.get("mission")+"str_test:"+str_test+"sql:"+sql); %></button>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
