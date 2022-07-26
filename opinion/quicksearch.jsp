<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <style>
            .cellbor{border: 0}
            .cellbor td{border: 0}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td style="text-align: center;font-size:16px;font-weight: bold;letter-spacing:2px;">标题</td>
                        <td>
                            <input style="width:98%;line-height:24px;margin-top:-7px;font-size: 15px;" class="w200" name="title">
                        </td>
                    </tr>
                    <!--<tr><td>主办单位</td><td><input class="w200" name="realcompanyname"></td></tr>-->
                </table>
            </div>
            <div class="footer">
                <button type="button" query>查询</button>
                <button type="button" reset>重置</button>
                <button type="button" cancel>取消</button>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
            $(".footer>[query]").click(function () {
                var str = "/opinion/table.jsp?consultation=<% out.print(req.get("consultation"));%>&lwstate=<% out.print(req.get("lwstate"));%>&resume=<% out.print(req.get("resume"));%>&title=" + formfun("title") + "&realcompanyname=" + formfun("realcompanyname")
                var urla = encodeURI(str)
                parent.quicksearch(urla)
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
