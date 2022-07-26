

<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssList entity = new RssList(pageContext, "lzmessage_read");
    CookieHelper cookie = new CookieHelper(request, response);
    String str = req.get("messageid");
    String[] arry = str.split(",");
      for (int idx = 0; idx < arry.length; idx++) {
           entity.keyvalue("type",2);
//           entity.keyvalue("messageid",arry[idx]);
//           entity.keyvalue("objid",cookie.Get("myid"));
//           entity.append().submit();
             entity.update().where("objid=? and messageid=?", cookie.Get("myid"),arry[idx]).submit();
          }
%>