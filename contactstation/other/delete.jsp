<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssList entity = new RssList(pageContext, "userrole");
    RssList entity2 = new RssList(pageContext, "user");//added by jackie 
    entity.request();
    entity2.request();//added by jackie 
    
   
    //added by ding
    if (req.get("action").equals("delete")) {
        
        RssList entity3 = new RssList(pageContext, "user");//added by jackie 
        entity3.request();
        String[] account = req.get("relationid").split(",");
        for ( int i = 0 ;i < account.length; i ++  ) {
            entity3.select().where("myid=?", account[i] ).get_first_rows();
            entity.delete().where("account in ('" + entity3.get("account") + "') and state=2").submit();
           // entity2.delete().where("myid in ('" + req.get("relationid") + "')").submit();//added by jackie 
            entity2.delete().where("myid=" + account[i] ).submit();

        }



    
        ///entity.delete().where("account in ('" + req.get("account") + "') and state=2").submit(); //deleted by ding
        //entity2.delete().where("myid in ('" + req.get("relationid") + "')").submit();//added by jackie //deleted by ding
        
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
