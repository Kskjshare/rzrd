<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssList entity = new RssList(pageContext, "releasum");
    entity.request();
    entity.select().where("id=?", entity.get("id")).get_first_rows();
    
    RssList entity2 = new RssList(pageContext, "imagin_news");
    entity2.request();

    if (!entity.get("action").isEmpty()) {
      switch (entity.get("action")) {
          case "append":
              //entity2.timestamp();
              entity2.keyvalue( "title" , entity.get("title") );
              entity2.keyvalue( "source" , entity.get("source") );
              entity2.keyvalue( "ico" , entity.get("ico") );
              entity2.keyvalue( "origin" , entity.get("origin") );
              entity2.keyvalue( "matter" , entity.get("matter") );
              entity2.keyvalue( "shijian" , entity.get("shijian") );
              entity2.keyvalue( "category" ,2 );         
              entity2.keyvalue( "channel" , "人大要闻" );
              if ( entity.get("newsid").equals("2") ) {
                   entity2.keyvalue( "channel" , "时政新闻" );
              }

              entity2.append().submit();
              break;
  
      }
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
                 确认设置为图片新闻？
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="append" />
                <button type="submit">确认</button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
