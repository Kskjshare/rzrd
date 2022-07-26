<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
                            RssList list = new RssList(pageContext, "petition");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <style>
           .b99{height:30px;width:99%;}
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
                    
                    <!--<tr><td>信访编号</td><td><input class="w200" name="petition"></td></tr>-->
                    <tr><td>姓名</td><td><input class="dec b99" name="petitioner"></td></tr>
                    <tr><td>证件号码</td><td><input class="dec b99" name="idcard"></td></tr>
                    <tr><td>信访形式</td><td><select class="dec b99 classify" name="petitionclassify" dict-select="petitionclassify" def="<% out.print(list.get("petitionclassify")); %>"></select></td></tr>
                    <tr><td>信访日期</td><td><input class="dec b99" name="datapetition"></td></tr>
                    <tr><td>问题属地</td><td><input class="dec b99" name="problemter"></td></tr>
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
                var str = "/leavis/simplque/list.jsp?petition=" + formfun("petition")+"&petitioner=" + formfun("petitioner")+"&idcard=" + formfun("idcard")+"&petitionclassify=" + formfun("petitionclassify")+"&datapetition=" + formfun("datapetition")+"&problemter=" + formfun("problemter");
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
