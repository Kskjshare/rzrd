<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <style>
        .w550 { width: 550px;height: 40px; }
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <!--                    <tr><td>来文编号</td><td><input class="w200" name="lwid"></td></tr>-->
                    <%
                        CookieHelper cookie = new CookieHelper(request, response);
                        if (!(cookie.Get("powergroupid").equals("5"))) {
                    %>
                    
                    <tr><td>信访编号</td><td><input class="w550" name="petition"></td></tr>
                    <%
                    }
                    %>

                </table>
            </div>
            <div class="footer">
                <button type="button" query>查询</button>
                <button type="button" reset>重置</button>
                <button type="button" cancel>取消</button>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <script src="/data/session.js"></script>
        <script src="/data/companytypeee.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
            var date = new Date;
            var year = date.getFullYear();
            var mydate = year.toString();
            $(".footer>[query]").click(function () {
                var str = "/leavis/letregtion/list.jsp?petition=" + formfun("petition");
                parent.quicksearch(str)
                popuplayer.close();
            })
            $(".footer>[reset]").click(function () {
                $("[name]").val("");
            })
            $(".footer>[cancel]").click(function () {
                popuplayer.close();
            })
            function formfun(name) {
                var val = $("[name='" + name + "']").val() == undefined ? "" : $("[name='" + name + "']").val()
                return val;
            }
        </script>
    </body>
</html>