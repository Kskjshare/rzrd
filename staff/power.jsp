<%@page import="RssEasy.MySql.Staff.StaffPowerGroupList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PowerHelper"%>
<%@page import="RssEasy.Core.StringExtend"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();

    StaffList entity = new StaffList(pageContext);
    if (!req.get("action").isEmpty()) {
        entity.keyvalue("powerlist", PowerHelper.request(req.get("offsetid")));
        entity.update().where("myid=?", req.get("id")).submit();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select("powerlist").where("myid=?", req.get("id")).get_first_rows();

    StaffList my = new StaffList(pageContext);
    my.select("powerlist").where("myid=?", UserList.MyID(request)).get_first_rows();
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
    <style>
        .line{line-height: 24px;}
    </style>
    <body>
        <form method="post" class="popupwrap">
            <div>
                <ul class="lanmubankuai" levelhelper="power" idx="2" dict-key="offsetid" input="checkbox" powerlist="<% out.print(PowerHelper.getpowerlist(entity.get("powerlist")));%>" mypower="<% out.print(PowerHelper.getpowerlist(my.get("powerlist")));%>">
                </ul>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="update" />
                <button type="submit">设置</button>
            </div>
        </form>
        <script src="/data/staff.js"></script>
        <%@include  file="/inc/js.html" %>
        <script>
            $("#allclick").change(function () {
                if ($(this).is(":checked")) {
                    $("input[name='offsetid']").each(function () {
                        $(this).prop("checked", true)
                    })
                } else {
                    $("input[name='offsetid']").each(function () {
                        $(this).prop("checked", false)
                    })
                }
            })
        </script>
    </body>
</html>
