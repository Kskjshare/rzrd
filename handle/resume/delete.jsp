<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssList entity = new RssList(pageContext, "suggest_company");
    RssList entity1 = new RssList(pageContext, "suggest_company");
    RssList entity2 = new RssList(pageContext, "user");
    RssList list = new RssList(pageContext, "suggest");
    RssList read = new RssList(pageContext, "lzmessage_read");
    RssList lzmessage = new RssList(pageContext, "lzmessage");
    CookieHelper cookie = new CookieHelper(request, response);
    entity.request();
    if (req.get("action").equals("delete")) {
        entity.select("count(*) as n").where("suggestid in(" + req.get("id") + ")").get_first_rows();
        if (Integer.parseInt(entity.get("n")) == 1) {
            list.keyvalue("handlestate", 4);
            list.keyvalue("deal", 0);
            list.keyvalue("examination", 2);
            list.update().where("id=?", entity.get("id")).submit();
        }
        lzmessage.keyvalue("realid", entity.get("id"));
        lzmessage.keyvalue("classify", 12);
        lzmessage.timestamp();
        lzmessage.append().submit();
        read.keyvalue("messageid", lzmessage.autoid);
        read.keyvalue("groupid",23);
//        read.keyvalue("objid", entity.get("fsrID"));
        read.keyvalue("type", 1);
        read.append().submit();
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
                驳回后需重新确认单位，请谨慎操作？
            </div>
            <div class="footer">
                <table>
                    <%
                        if (!(cookie.Get("powergroupid").equals("8") || cookie.Get("powergroupid").equals("25"))) {
                    %>
                    <tr>
                        <td colspan="2"><ul id="jyscr">
                                <%
                                    if (!entity.get("id").isEmpty()) {
                                        RssListView secondlist = new RssListView(pageContext, "scr_suggest");
    //                                       secondlist.select().where("id="+list.get("id")+" and fsrID="+list.get("")+" ").get_page_desc("myid");
                                        secondlist.select().where("suggestid=? ",req.get("id")).get_page_desc("myid");
                                        while (secondlist.for_in_rows()) {
                                %>
                                <input type="hidden" name="fsrID" value="<%out.print(secondlist.get("fsrID"));%>" />
                                <%
                                        }
                                    }
                                %>
                            </ul></td>
                    </tr>
                    <%
                        }
                    %>
                </table>
                <input type="hidden" name="action" value="delete" />

                <button type="submit">确认</button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
