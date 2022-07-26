<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssList process = new RssList(pageContext, "excel_process");
    if (req.get("state").equals("1")) {
        process.select().where("myid="+UserList.MyID(request)).get_first_rows();
        out.print("{\"allpage\":\"" + process.get("allpage") + "\",\"nowpage\":\"" + process.get("nowpage") + "\"}");
        }else{
        process.delete().where("myid="+UserList.MyID(request)).submit();
        out.print("{\"state\":\"ok\"}");
    }
%>
