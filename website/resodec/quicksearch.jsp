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
                    
                    <tr>
                        <td style="text-align: center;font-size:16px;font-weight: bold;letter-spacing:2px;">标题</td>
                        <td>
                            <input style="width:98%;line-height:24px;margin-top:-7px;font-size: 15px;" class="w200" name="title">
                        </td>
                    </tr>
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
                var str = "/website/resodec/list.jsp?typeid=<%req.write("typeid");%>&title=" + formfun("title");
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
