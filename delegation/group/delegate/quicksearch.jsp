<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <style>
            body{background: #dce6f5;}
            .dce{text-align: right;padding-right: 10px;}
            .cellbor td{padding: 0 6px}
            .cellbor{border:0;}
            .cellbor>tbody>tr>td{line-height: 34px;border: 0}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;width: 200px;}
            .popupwrap>div:first-child{height: 75%;padding: 10px 0;background: #fff;border: #6caddc solid thin;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr><td class="dce">姓名：</td><td><input name="realname"></td></tr>
                    <tr><td class="dce">手机号码：</td><td><input name="telphone"></td></tr>
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
                var str = "/delegation/group/delegate/list.jsp?realname=" + formfun("realname") + "&telphone=" + formfun("telphone")+"&groupid=<%req.write("groupid");%>&dbtid=<%req.write("dbtid");%>"
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
