<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    if (req.get("action").equals("append")) {
        PoPupHelper.adapter(out).iframereload();
//        PoPupHelper.adapter(out).showSucceed();
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
        <style>
            tbody tr:hover{background-color: gainsboro;}
            table th{
                font-weight: normal;
            }
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">
            <div>
                <table class="wp100 tollbor">
                    <tr>
                        <td class="dec">成功提交！</td>
                    </tr>

                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="append" />
                <button type="submit">确定</button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>


    </body>
</html>