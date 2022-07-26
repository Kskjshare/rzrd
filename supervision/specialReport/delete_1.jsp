<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssList entity = new RssList(pageContext, "supervision_specialwork");
    entity.request();
    
    RssList userrole = new RssList(pageContext, "supervision_userrole_specialwork");
    userrole.request();
    
    if (req.get("action").equals("delete")) {
        
        //added by ding for removing records in table when removed related records in supervision_specialwork
        //userrole.select().where("iid=" + req.get("id") + " and myid=" + UserList.MyID(request)).get_page_desc("id");
        userrole.select().where("iid=" + req.get("id")).get_page_desc("id");    
        while (userrole.for_in_rows()) {     
          userrole.delete().where("iid=" + req.get("id")).submit();          
        }
        //end
        
        entity.delete().where("id=" + req.get("id")).submit();
        
        
       
        //userrole.delete().where("iid=" + req.get("id") + " and myid=" + UserList.MyID(request)).submit();
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <form method="post" class="popupwrap">
            <div class="infowrap">
                删除后不可恢复，请谨慎操作？
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="delete" />
                <button type="submit">确认</button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
