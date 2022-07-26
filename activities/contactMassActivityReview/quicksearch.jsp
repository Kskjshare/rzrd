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
                    <tr><td class="dce">标题：</td><td><input name="title"></td></tr>
                    <tr><td class="dce">代表：</td><td><input name="inputname"></td></tr>
                    <tr>
                        <td class="dce">审核状态：</td>
                        <td><input type="checkbox" name="state" value="1" />待审核
                        <input type="checkbox" name="state" value="2" />通过
                        <input type="checkbox" name="state" value="3" />驳回</td>
                       
                    </tr>
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
                getstate();
//                parent.quicksearch("/activities/contactMassActivityReview/list.jsp?classify=<%req.write("classify");%>&title=" + formfun("title") + "&realname=" + + formfun("realname"));
//                popuplayer.close();
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
            function getstate(){
                var tid=[],rid="";
                 $("[name='state']").each(function () {
                    if ($(this).is(":checked")) {
                      tid.push($(this).attr("value"));
                      console.log($(this).attr("idState"),"00000");
                    }
                });
                rid=tid.join(",");
//                alert(rid);
                parent.quicksearch("/activities/contactMassActivityReview/list.jsp?classify=<%req.write("classify");%>&title=" + formfun("title") + "&rid=" + rid + "&inputname=" + formfun("inputname"));
//                parent.quicksearch("/activities/contactMassActivityReview/list.jsp?classify=<%req.write("classify");%>&title=" + formfun("title") + "&realname=" + formfun("realname") + "&stateid=" + rid );
                popuplayer.close();
            }
        </script>
    </body>
</html>
