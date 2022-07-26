<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssListView user = new RssListView(pageContext, "userrole");
    RssList user2 = new RssList(pageContext, "user");
    RssList user3 = new RssList(pageContext, "user");
    
    user3.request();
    if (!req.get("inid").isEmpty()) {
        user3.remove("inid","relationid","action","id");
         user3.update().where("myid in(" + req.get("inid") + ")").submit();
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
            .infowrap>div{float: left;width: 230px;margin:3px 5px;border: #e6e6e6 solid thin;border-radius: 5px;overflow: auto;max-height: 400px;}
            .infowrap table{width:229px;border-bottom:1px dashed #ccc;font-size: 12px}
            .infowrap thead tr{height:24px;background:url(../css/limg/td1px.png) repeat-x;border-bottom:1px solid #ddd;}
            .infowrap tbody tr:first-child{border-top:0;}
            .infowrap tbody tr:nth-child(even){background:#fafafa;}
            .infowrap tr td{border-left:1px dashed #ccc;border-top:1px dashed #ccc;padding: 2px 0;text-align: center;}
            .infowrap tr th{padding: 0;font-size: 12px;border-left:1px dashed #ccc;}
             .infowrap tr th:first-child{border-left:none;}
            h2{padding: 2px 6px;}
            .infowrap tr td:first-child{border-left:0;}
            h2>span{color: #fff;font-size: 12px;padding: 2px 15px;background: #186aa3;border-radius: 15px;margin: 0 5px;cursor: pointer;}
            #divleft{}
            #divright{}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">
            <div class="infowrap">
                <h2><span id="dr">调入</span><span id="yc">移出</span></h2>
                <div id="divleft">
                    <table>
                        <thead>
                            <tr><th colspan="3">其他代表</th></tr>
                            <tr><th><input type="checkbox" name="alla"></th><th>代表号</th><th>姓名</th></tr></thead>
                        <tbody>
                            <%
                                user.select().where("state=2 and mission<>?", req.get("relationid")).get_page_desc("myid");
                                while (user.for_in_rows()) {
                            %>
                            <tr><td><input type="checkbox" name="id" relid="<% out.print(user.get("myid"));%>"></td><td><% out.print(user.get("code"));%></td><td><% out.print(user.get("realname"));%></td></tr>
                                    <%
                                        };
                                    %>
                        </tbody>
                    </table>
                </div>
                <div id="divright">
                    <table>
                        <thead>
                            <tr><th colspan="3">团内代表</th></tr>
                            <tr><th class="w30">操作</th><th>代表号</th><th>姓名</th></tr></thead>
                        <tbody>
                            <%
                                user2.select().where("mission=?", req.get("relationid")).get_page_desc("myid");
                                while (user2.for_in_rows()) {
                            %>
                            <tr><td></td><td><% out.print(user2.get("code"));%></td><td><% out.print(user2.get("realname"));%></td></tr>

                            <%
                                };
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
            <input type="hidden" name="inid">
            <input type="hidden" name="mission" value="<% out.print(req.get("relationid")); %>" />
            <div class="footer">
                <input type="hidden" name="action" value="delete" />
                <button type="submit">确认</button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
        <script>
            $("[name='alla']").change(function () {
                if ($(this).is(":checked")) {
                    $(this).parents("table").find("input[name='id']").each(function () {
                        $(this).prop("checked", true)
                    })
                } else {
                    $(this).parents("table").find("input[name='id']").each(function () {
                        $(this).prop("checked", false)
                    })
                }
            })

            $("#dr").click(function () {
                $("#divleft").find("input[name='id']:checked").each(function () {
                    var html = $(this).parents("tr").clone();
                    $("#divright").find("tbody").append(html);
                    $(this).parents("tr").remove();
                })
            })
                  $("#yc").click(function() {
                   $("#divright").find("input[name='id']:checked").each(function () {
                      var html = $(this).parents("tr").clone();
                      $("#divleft").find("tbody").append(html);
                       $(this).parents("tr").remove();
                   })
})
            $(".footer>button").click(function () {
                var arry = [];
                $("#divright").find("input[name='id']").each(function () {
                    arry.push($(this).attr("relid"))
                })
                if (arry.length =="0") {
                    alert("请选择要调入的代表")
                     return false;
                }
                var inid = arry.join(",");
                $("[name='inid']").val(inid);
//                return false;
            })
        </script>
    </body>
</html>
