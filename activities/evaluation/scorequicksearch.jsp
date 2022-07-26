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
            body{background: #dce6f5;}
            .dce{text-align: right;padding-right: 10px;}
            .cellbor td{padding: 0 6px}
            .cellbor{border:0;}
            .cellbor>tbody>tr>td{line-height: 34px;border: 0}
            .cellbor{width: 100%}
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;width: 200px;}
            .cellbor select{height: 28px;border: #d0d0d0 solid thin;width: 205px;}
            .popupwrap>div:first-child{height: 75%;padding: 10px 0;background: #fff;border: #6caddc solid thin;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr><td class="dce">代表姓名：</td><td><input name="name1"></td></tr>
                    <!--<tr><td class="dce">考核小组：</td><td><input name="name2"></td></tr>-->
                    <tr><td class="dce">乡镇街道：</td><td><input name="name3"></td></tr>
                    <tr><td class="dce">代表考核状态：</td><td><select name="state1"> <option value=""></option><option value="0">待评</option><option value="1">已评</option></select></td></tr>
                    <tr><td class="dce">小组考核状态：</td><td><select name="state2"> <option value=""></option><option value="0">待评</option><option value="1">已评</option></select></td></tr>
                    <tr><td class="dce">街道考核状态：</td><td><select name="state3"> <option value=""></option><option value="0">待评</option><option value="1">已评</option></select></td></tr>
                    <tr><td class="dce">部门考核状态：</td><td><select name="state4"> <option value=""></option><option value="0">待评</option><option value="1">已评</option></select></td></tr>
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
                parent.quicksearch("/activities/evaluation/score_list.jsp?batchid=<%req.write("batchid");%>&name1=" + formfun("name1")+"&name2=" + formfun("name1")+"&name3=" + formfun("name3")+"&state1=" + formfun("state1")+"&state2=" + formfun("state2")+"&state3=" + formfun("state3")+"&state4=" + formfun("state4") )
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
