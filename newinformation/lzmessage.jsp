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
    RssListView entity = new RssListView(pageContext, "lzmessage_news");
    RssListView entity2 = new RssListView(pageContext, "lzmessage_news");
    CookieHelper cookie = new CookieHelper(request, response);
    String parentid = cookie.Get("parentid");
    if (!(cookie.Get("powergroupid").isEmpty()||UserList.MyID(request).isEmpty())) {
        entity.select().where("type =1 and (objid=" + parentid + " or objid=" + UserList.MyID(request) + " or groupid=" + cookie.Get("powergroupid") + " )").query();
        String str = "[";
        while (entity.for_in_rows()) {
            if (!entity.get("messageid").isEmpty()) {
                if (!entity2.select().where("type=2 and messageid=" + entity.get("messageid") + " and objid=" + UserList.MyID(request)).get_first_rows()) {
                    str += "{\"classify\":\"" + entity.get("classify") + "\",\"key\":\"" + entity.get("realid") + "\",\"messageid\":\"" + entity.get("messageid") + "\"},";
                }
            }
        }
        str = str.substring(0, str.length() - 1);
        str += "]";
        out.print(str);
    }else{
        out.print("<script>location.href='loginout.jsp';</script>");
//        out.print("<a href='loginout.jsp'></a>");
        
    }
%>