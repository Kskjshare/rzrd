<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssList entity = new RssList(pageContext, "leaveword");
    entity.request();
    if (req.get("action").equals("append")) {
        entity.remove("action");
        entity.remove("return");
        entity.keyvalue("returnobj",1);
        entity.keyvalue("buyBack", entity.get("buyBack"));
        entity.update().where("id="+entity.get("id")).submit();
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
        <style>
            .back{    width: 97%;
                      height: 56%;
                      margin-top: 5px;}
            </style>
        </head>
        <body>
            <form method="post" class="popupwrap">
            <div class="infowrap">
                <!--只有“撤案”的提案才能置回！-->
                <p>请输入不予接受的原由！</p>
                <textarea class="buyBack"></textarea>

            </div>

            <div class="footer">
                <input type="hidden" name="action" value="append" />
                <button type="submit">确认</button>
                <input type="hidden" name="buyBack"/>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
        <script>
            $(".footer>button").click(function () {
                $("input[name='buyBack']").val($("div .buyBack").val());
            })
        </script>
    </body>
</html>

